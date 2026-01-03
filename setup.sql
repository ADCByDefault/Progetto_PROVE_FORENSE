drop database if exists prove_forense;
create database prove_forense;
use prove_forense;



-- --------------------------------------------------------------------------
-- creazione tabelle
-- --------------------------------------------------------------------------


create table categoria_reato (
    id int auto_increment primary key,
    nome varchar(128) not null,
    descrizione text not null
);

create table luogo (
    id int auto_increment primary key,
    nome varchar(128) not null,
    tipo enum('Magazzino', 'Laboratorio', 'Scena del Crimine', 'Archivio', 'Ufficio') not null,
    indirizzo text not null,
    descrizione text
);

create table persona (
    id int auto_increment primary key,
    codice_fiscale varchar(16) not null unique,
    nome varchar(128) not null,
    cognome varchar(128) not null,
    data_nascita date not null
);

create table agente (
    id int primary key,
    matricola varchar(32) not null unique,
    grado enum('Agente', 'Ispettore', 'Commissario', 'Questore', 'Sovrintendente') not null,
    dipartimento enum('Polizia Postale', 'Carabinieri', 'Guardia di Finanza', 'Polizia Scientifica', 'Servizi Antidroga') not null,
    
    foreign key (id) references persona(id) on delete cascade
);

create table fascicolo (
    id int auto_increment primary key,
    codice varchar(32) not null unique,
    stato enum('Aperto', 'Chiuso', 'Archiviato') default 'Aperto' not null,
    priorita int check (priorita between 1 and 5) default 1,
    id_agente_responsabile int not null,
    data_apertura datetime default current_timestamp,
    
    foreign key (id_agente_responsabile) references agente(id)
);

create table coinvolgimento (
    id_fascicolo int not null,
    id_persona int not null,
    tipo enum('Sospettato', 'Vittima', 'Testimone') not null,
    descrizione text,
    
    primary key (id_fascicolo, id_persona),
    foreign key (id_fascicolo) references fascicolo(id) on delete cascade,
    foreign key (id_persona) references persona(id) on delete no action
);

create table categoria_fascicolo (
    id_fascicolo int not null,
    id_categoria_reato int not null,
    
    primary key (id_fascicolo, id_categoria_reato),
    foreign key (id_fascicolo) references fascicolo(id) on delete cascade,
    foreign key (id_categoria_reato) references categoria_reato(id) on delete no action
);

create table reperto (
    id int auto_increment primary key,
    codice varchar(32) not null unique,
    descrizione text not null,
    categoria enum('Biologico', 'Chimico', 'Traccia', 'Balistico', 'Informatico', 'Documentale', 'Generico') not null,
    
    id_reperto_padre int default null,
    id_fascicolo int not null,
    id_luogo_corrente int not null,
    
    data_inserimento timestamp default current_timestamp,
    
    foreign key (id_fascicolo) references fascicolo(id) on delete cascade,
    foreign key (id_reperto_padre) references reperto(id) on delete no action,
    foreign key (id_luogo_corrente) references luogo(id) on delete no action
);

create table catena_custodia (
    id int auto_increment primary key,
    descrizione text not null,
    
    id_reperto int not null,
    id_agente_responsabile int not null,
    id_luogo int not null,
    
    data_movimento datetime default current_timestamp,
    
    foreign key (id_reperto) references reperto(id) on delete cascade,
    foreign key (id_agente_responsabile) references agente(id),
    foreign key (id_luogo) references luogo(id)
);

create table analisi_laboratorio (
    id int auto_increment primary key,
    descrizione text not null,
    esito text,
    
    id_reperto int not null,
    id_analista int not null,
    
    data_inizio datetime default current_timestamp,
    data_esito datetime,
    
    foreign key (id_reperto) references reperto(id) on delete no action,
    foreign key (id_analista) references persona(id)
);



-- --------------------------------------------------------------------------
-- triggers
-- --------------------------------------------------------------------------


delimiter $$

-- 1. automazione: aggiorna luogo reperto dopo inserimento in catena custodia
create trigger update_posizione_reperto
after insert on catena_custodia
for each row
begin
    update reperto
    set id_luogo_corrente = new.id_luogo
    where id = new.id_reperto;
end $$


-- 2. sicurezza (insert): analista non può lavorare se coinvolto nel caso
create trigger check_insert_analista_integrita_caso
before insert on analisi_laboratorio
for each row
begin
    declare fascicolo_del_reperto int;

    select id_fascicolo into fascicolo_del_reperto
    from reperto
    where id = new.id_reperto;

    if exists (
        select *
        from coinvolgimento 
        where id_fascicolo = fascicolo_del_reperto
        and id_persona = new.id_analista 
    ) then
        signal sqlstate '45000'
        set message_text = 'errore: l\'analista non può lavorare sui casi in cui è coinvolto';
    end if;
end $$

-- 2.1. sicurezza (update): analista non può lavorare se coinvolto nel caso
create trigger check_update_analista_integrita_caso
before update on analisi_laboratorio
for each row
begin
    declare fascicolo_del_reperto int;
    
    select id_fascicolo into fascicolo_del_reperto
    from reperto
    where id = new.id_reperto;
    
    if exists(
        select *
        from coinvolgimento
        where id_fascicolo = fascicolo_del_reperto
        and id_persona = new.id_analista
    ) then
        signal sqlstate '45000'
        set message_text = 'errore: l\'analista non può lavorare sui casi in cui è coinvolto';
    end if;
end $$


-- 3. conflitto interessi (lato fascicolo): l'agente non può essere scelto se è già coinvolto
create trigger check_update_conflitto_interessi_agente_fascicolo
before update on fascicolo
for each row
begin
    if exists(
        select *
        from coinvolgimento
        where id_persona = new.id_agente_responsabile
        and id_fascicolo = new.id
    ) then
        signal sqlstate '45000'
        set message_text = 'errore: l\'agente non può essere responsabile di un caso in cui è coinvolto';
    end if;
end $$


-- 3.1 conflitto interessi (lato coinvolgimento): non posso aggiungere l'agente come sospettato
create trigger check_insert_conflitto_interessi_agente_coinvolgimento
before insert on coinvolgimento
for each row
begin
    declare responsabile_caso int;

    select id_agente_responsabile into responsabile_caso
    from fascicolo
    where id = new.id_fascicolo;

    if new.id_persona = responsabile_caso then
        signal sqlstate '45000'
        set message_text = 'errore: impossibile aggiungere il responsabile del caso come soggetto coinvolto.';
    end if;
end $$


-- 4. blocco fascicolo chiuso (insert): reperti
create trigger check_no_insert_reperto_caso_chiuso
before insert on reperto
for each row
begin
    declare stato_corrente varchar(32);

    select stato into stato_corrente
    from fascicolo
    where id = new.id_fascicolo;

    if stato_corrente in ('Chiuso', 'Archiviato') then
        signal sqlstate '45000'
        set message_text = 'errore: fascicolo chiuso. impossibile aggiungere nuovi reperti.';
    end if;
end $$

-- 4.1 blocco fascicolo chiuso (update): reperti
create trigger check_no_update_reperto_caso_chiuso
before update on reperto
for each row
begin
    declare stato_corrente varchar(32);
    
    select stato into stato_corrente
    from fascicolo
    where id = new.id_fascicolo;
    
    if stato_corrente in ('Chiuso', 'Archiviato') then
        signal sqlstate '45000'
        set message_text = 'errore: impossibile modificare reperto di un fascicolo chiuso';
    end if;
end $$


-- 5. blocco fascicolo chiuso (insert): persone
create trigger check_no_insert_coinvolgimento_caso_chiuso
before insert on coinvolgimento
for each row
begin
    declare stato_corrente varchar(32);

    select stato into stato_corrente
    from fascicolo
    where id = new.id_fascicolo;

    if stato_corrente in ('Chiuso', 'Archiviato') then
        signal sqlstate '45000'
        set message_text = 'errore: fascicolo chiuso. impossibile aggiungere nuovi soggetti.';
    end if;
end $$

-- 5.1 blocco fascicolo chiuso (update): persone
create trigger check_no_update_coinvolgimento_caso_chiuso
before update on coinvolgimento
for each row
begin
    declare stato_corrente varchar(32);
    
    select stato into stato_corrente
    from fascicolo
    where id = new.id_fascicolo;
    
    if stato_corrente in ('Archiviato', 'Chiuso') then
        signal sqlstate '45000'
        set message_text = 'errore: fascicolo chiuso. impossibile modificare soggetti';
    end if;
end $$


-- 6. blocco fascicolo chiuso (insert): analisi
create trigger check_no_insert_analisi_caso_chiuso
before insert on analisi_laboratorio
for each row
begin
    declare stato_fascicolo varchar(32);

    select f.stato into stato_fascicolo
    from reperto r
    join fascicolo f on r.id_fascicolo = f.id
    where r.id = new.id_reperto;

    if stato_fascicolo in ('Chiuso', 'Archiviato') then
        signal sqlstate '45000'
        set message_text = 'errore: fascicolo chiuso. impossibile richiedere nuove analisi.';
    end if;
end $$

-- 6.1 blocco fascicolo chiuso (update): analisi
create trigger check_no_update_analisi_caso_chiuso
before update on analisi_laboratorio
for each row
begin
    declare stato_corrente varchar(32);
    
    select f.stato into stato_corrente
    from reperto r
    join fascicolo f on f.id = r.id_fascicolo
    where r.id = new.id_reperto;
    
    if stato_corrente in ('Archiviato', 'Chiuso') then
        signal sqlstate '45000'
        set message_text = 'errore: fascicolo chiuso. impossibile modificare le analisi';
    end if;
end $$

delimiter ;