-- --------------------------------------------------------------------------
-- Ardi Ndreu - 7161575
-- Rayan Hakam Taleb Moh’d - 7157792
-- Swaran Singh - 7159864
-- --------------------------------------------------------------------------
-- --------------------------------------------------------------------------
-- Ambiente:
-- Windows 11
-- MySQL Server 8.0
-- MySQL Workbench 8.0.43
-- --------------------------------------------------------------------------
-- --------------------------------------------------------------------------
-- eserguire questo file con il pulsante execute everything (fulmine senza cursore)
-- --------------------------------------------------------------------------


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
    tipo enum('Magazzino', 'Laboratorio', 'Scena del Crimine', 'Archivio', 'Ufficio', "Altro") not null,
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
    esito text not null,
    
    id_reperto int not null,
    id_analista int not null,
    
    data_inizio datetime not null,
    data_esito datetime not null,
    
    foreign key (id_reperto) references reperto(id) on delete no action,
    foreign key (id_analista) references persona(id)
);


-- --------------------------------------------------------------------------
-- procedure
-- --------------------------------------------------------------------------


delimiter $$

-- 1. risali_albero_reperti: risale l'albero dei reperti e ritorna la lista dei padri
create procedure risali_albero_reperti(in id_reperto int)
begin
	with recursive albero as (
		select id, id_reperto_padre, codice, categoria, descrizione, 0 as livello
        from reperto
        where id = id_reperto
        
        union all
        
        select padre.id, padre.id_reperto_padre, padre.codice, padre.categoria, padre.descrizione, figlio.livello - 1
        from reperto padre
		join albero figlio on padre.id = figlio.id_reperto_padre
    )
    select * from albero;
end $$

-- 1.2 trova_tutti_discendenti
create procedure trova_tutti_discendenti(in id_reperto int)
begin
	with recursive albero as (
		select id, id_reperto_padre, codice, categoria, descrizione, 0 as livello
        from reperto
        where id = id_reperto_padre
        
        union all
        
        select figlio.id, figlio.id_reperto_padre, figlio.codice, figlio.categoria, figlio.descrizione, livello + 1
        from reperto figlio
		join albero padre on figlio.id_reperto_padre = padre.id
    )
    select * from albero;
end $$

-- 2. sposta reperto
create procedure registra_movimento_reperto(
	in in_id_reperto int,
    in in_id_agente int,
    in in_id_luogo int,
    in in_motivo text
)
begin
	insert into catena_custodia (id_reperto, id_agente_responsabile, id_luogo, descrizione)
    values (in_id_reperto, in_id_agente, in_id_luogo, in_motivo);
end $$

-- 3 crea sotto reperto
create procedure crea_reperto_figlio (
	in in_id_reperto_padre int,
    in in_codice varchar(32),
    in in_descrizione text,
    in in_categoria enum ('Biologico', 'Chimico', 'Traccia', 'Balistico', 'Informatico', 'Documentale', 'Generico'),
    in in_agente_operante int
)
begin
	declare t_id_fascicolo int;
    declare t_id_luogo int;
    declare t_id_reperto int;
    
    select id_fascicolo, id_luogo_corrente into t_id_fascicolo, t_id_luogo
    from reperto
    where id = in_id_reperto_padre;
    
    insert into reperto (codice, descrizione, categoria, id_reperto_padre, id_fascicolo, id_luogo_corrente)
    values (in_codice, in_descrizione, in_categoria, in_id_reperto_padre, t_id_fascicolo, t_id_luogo);
    
    set t_id_reperto = last_insert_id();
    
    insert into catena_custodia (descrizione, id_reperto, id_agente_responsabile, id_luogo)
    values (concat('Estrazione campione da reperto id: ', in_id_reperto_padre), t_id_reperto, in_agente_operante, t_id_luogo);
end $$


delimiter ;


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

-- 2. non si puo creare un fascicolo chiuso o  archiviato
create trigger no_insert_fascicolo_chiuso_archiviato
before insert on fascicolo
for each row
begin
	if(new.stato != 'Aperto') then
		signal sqlstate '45000'
        set message_text = 'errore: imposssibile creare fascicolo archiviato o chiuso';
	end if;
end$$

-- 3. non ci può creare un reperto figlio con id_fascicolo non coerente
create trigger no_insert_reperto_figlio_fascicolo_diverso
before insert on reperto
for each row
begin
	if exists(
		select *
        from reperto
        where id = new.id_reperto_padre
        and id_fascicolo != new.id_fascicolo
    )then
		signal sqlstate '45000'
        set message_text = 'errore: un reperto figlio non può appartenere ad un fascicolo diverso';
	end if;
end $$

-- 4. sicurezza (insert): non è accettata l'analisi se l'analista è coinvolto
-- nel caso del reperto su cui ha laborato
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

-- 4.1 conflitto interessi: l'agente non può essere scelto se è già coinvolto
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

-- 4.2 conflitto interessi: non posso aggiungere l'agente resabile nei coinvolti
-- devo prima sollevarlo dall'incarico, per non creare incongruenze.
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

-- 4.3 conflitto interessi: un agente non può essere responsabile di un reperto se coinvolto nel caso.
create trigger check_inseret_conflitto_agente_catena_custodia
before insert on catena_custodia
for each row
begin
	declare id_fascicolo_reperto int;
    
    select id_fascicolo into id_fascicolo_reperto
    from reperto
    where new.id_reperto = id;
    
	if exists (
		select *
        from coinvolgimento
        where new.id_agente_responsabile = id_persona
        and id_fascicolo_reperto = id_fascicolo
	)then
		signal sqlstate '45000'
        set message_text = 'errore: questo agente non può custodire questo reperto';
	end if;
end $$

-- 5. blocco fascicolo chiuso (insert): reperti
create trigger check_no_insert_reperto_caso_chiuso_archiviato
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

-- 5.1 blocco fascicolo chiuso (update): reperti
create trigger check_no_update_reperto_caso_chiuso_archiviato
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


-- 5.2 blocco fascicolo chiuso (insert): persone coinvolte
create trigger check_no_insert_coinvolgimento_caso_chiuso_archiviato
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

-- 5.3 blocco fascicolo chiuso (update): persone coinvolte
create trigger check_no_update_coinvolgimento_caso_chiuso_archiviato
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


-- 5.4 blocco fascicolo chiuso (insert): analisi
create trigger check_no_insert_analisi_caso_chiuso_archiviato
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

-- 5.5 blocco fascicolo chiuso (update): analisi
create trigger check_no_update_analisi_caso_chiuso_archiviato
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

-- 5.6 un fascicolo chiuso non può essere modificato, e l'unica modifica
-- consentita su un fascicolo archiviato è la riapertura
create trigger check_modifiche_fascicolo_chiuso_archiviato
before update on fascicolo
for each row
begin
	declare stato_corrente varchar(32);
    
    select stato into stato_corrente
    from fascicolo
    where id = new.id;
    
    if stato_corrente in ('Chiuso') then
		signal sqlstate '45000'
        set message_text = 'errore: impossibile modificare un fascicolo chiuso';
	end if;
    if stato_corrente in ('Archiviato')
    and new.stato not in ('Aperto') then
		signal sqlstate '45000'
        set message_text = 'errore: impossibile modificare un fascicolo archiviato';
	end if;
end $$

-- 6 accettare solo modifiche consentite

-- 6.1 categoria reato
create trigger strict_update_categoria_reato
before update on categoria_reato
for each row
begin
    signal sqlstate '45000'
    set message_text = 'errore: le categorie di reato sono non modificabili.';
end $$

-- 6.2 luogo
-- un luogo fisico non cambia indirizzo.
create trigger strict_update_luogo
before update on luogo
for each row
begin
    signal sqlstate '45000'
    set message_text = 'errore: i luoghi registrati non possono essere alterati per garantire la coerenza storica.';
end $$

-- 6.3 categoria fascicolo
create trigger strict_update_categoria_fascicolo
before update on categoria_fascicolo
for each row
begin
    signal sqlstate '45000'
    set message_text = 'errore: non è possibile modificare questa tabella';
end $$

-- 6.4 coinvolgimento
create trigger strict_update_coinvolgimento
before update on coinvolgimento
for each row
begin
    signal sqlstate '45000'
    set message_text = 'errore: reinserire il soggetto con il nuovo ruolo.';
end $$

-- 6.5 catena custodia (log storico)
create trigger strict_update_catena_custodia
before update on catena_custodia
for each row
begin
    signal sqlstate '45000'
    set message_text = 'errore: non è possibile modificare i log';
end $$

-- 6.6 persona
create trigger strict_update_persona
before update on persona
for each row
begin
	signal sqlstate '45000'
	set message_text = 'errore: di una persona è consentito cambiare solo nome o cognome';
end $$

-- 6.7 agente
-- consentito: grado (promozione), dipartimento (trasferimento)
create trigger strict_update_agente
before update on agente
for each row
begin
    if new.id <> old.id or
    new.matricola <> old.matricola then
        signal sqlstate '45000'
        set message_text = 'errore: impossibile modificare matricola';
    end if;
end $$

-- 6.8 fascicolo
-- consentito: stato (chiudere/archiviare), priorità, agente responsabile
create trigger strict_update_fascicolo
before update on fascicolo
for each row
begin
    if new.id <> old.id or 
       new.codice <> old.codice or 
       new.data_apertura <> old.data_apertura then
        signal sqlstate '45000'
        set message_text = 'errore: i dati codice e data sono immutabili';
    end if;
end $$

-- 6.9 reperto
-- consentito: descrizione (dettagli), id_luogo_corrente (automatico)
create trigger strict_update_reperto
before update on reperto
for each row
begin
    -- nota: id_luogo_corrente è escluso dal controllo perché deve essere aggiornato dal sistema.
    if new.id <> old.id or 
       new.codice <> old.codice or 
       new.categoria <> old.categoria or 
       new.id_reperto_padre <> old.id_reperto_padre or
       new.id_fascicolo <> old.id_fascicolo or
       new.data_inserimento <> old.data_inserimento then
        signal sqlstate '45000'
        set message_text = 'errore: il reperto è immutabile (eccetto descrizione e spostamenti)';
    end if;
end $$

-- 6.10 analisi laboratorio
create trigger strict_update_analisi_laboratorio
before update on analisi_laboratorio
for each row
begin
	signal sqlstate '45000'
	set message_text = 'errore: non è possibile aggiornare un analisi gia fatta';
end $$

delimiter ;


-- --------------------------------------------------------------------------
-- Viste
-- --------------------------------------------------------------------------


-- 1. dettagli legati ad ai reperti
create or replace view dettagli_reperti as
	select
		r.codice as codice_reperto, r.descrizione, r.categoria, r.data_inserimento,
		f.codice as codice_fascicolo, f.stato as stato_fascicolo,
		l.nome as luogo_corrente,
		a.esito as analisi
	from reperto r
	join fascicolo f on r.id_fascicolo = f.id 
	join luogo l on r.id_luogo_corrente = l.id
	join analisi_laboratorio a on r.id = a.id_reperto;

-- 2. storico spostamenti
create or replace view storico_spostamenti as
	select
		r.codice as codice_reperto,
		cc.data_movimento,
		l.nome as luogo_destinazione,
		concat(p.nome, ' ', p.cognome) as agente_responsabile,
		cc.descrizione as motivo_spostamento
	from catena_custodia cc
	join reperto r on cc.id_reperto = r.id
	join luogo l on cc.id_luogo = l.id
	join persona p on cc.id_agente_responsabile = p.id
	join agente aa on p.id = aa.id
	order by cc.data_movimento desc;

-- 3. registro dei coinvolgimenti
create or replace view registro_coinvolgimenti as
	select
		f.codice as codice_fascicolo, f.stato as stato_fascicolo, f.priorita as priorita_fascicolo,
        concat(p.nome, ' ', p.cognome) as soggetto, 
        c.tipo, c.descrizione as note
    from coinvolgimento c
    join fascicolo f on f.id = c.id_fascicolo
    join persona p on p.id = c.id_persona;





