-- --------------------------------------------------------------------------
-- Ardi Ndreu - 
-- Rayan Moh'd -
-- Swaran Singh - 7159864
-- --------------------------------------------------------------------------
-- --------------------------------------------------------------------------
-- Ambiente:
-- Windows 11
-- MySQL Server 8.0
-- MySQL Workbench 8.0.43
-- --------------------------------------------------------------------------
-- --------------------------------------------------------------------------
-- per la crezione del database eseguire il file setup.sql
-- il presente codice per il popolamento è stato, in parte, scritto con l'utilizzo di strumenti esterni.
-- --------------------------------------------------------------------------


USE prove_forense;

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE analisi_laboratorio;
TRUNCATE TABLE catena_custodia;
TRUNCATE TABLE reperto;
TRUNCATE TABLE coinvolgimento;
TRUNCATE TABLE categoria_fascicolo;
TRUNCATE TABLE fascicolo;
TRUNCATE TABLE agente;
TRUNCATE TABLE persona;
TRUNCATE TABLE luogo;
TRUNCATE TABLE categoria_reato;

SET FOREIGN_KEY_CHECKS = 1;

-- ============================================================
-- 1. DATI STATICI (Categorie, Luoghi, Persone)
-- ============================================================

-- Categorie Reato (12)
INSERT INTO categoria_reato (nome, descrizione) VALUES 
('Omicidio Doloso', 'Uccisione volontaria'),
('Omicidio Colposo', 'Negligenza fatale'),
('Traffico Stupefacenti', 'Spaccio droga'),
('Rapina a Mano Armata', 'Rapina con armi'),
('Furto con Scasso', 'Effrazione'),
('Cybercrime - Phishing', 'Frode online'),
('Cybercrime - Ransomware', 'Estorsione digitale'),
('Stalking', 'Atti persecutori'),
('Corruzione', 'Reati PA'),
('Riciclaggio', 'Money Laundering'),
('Violenza Domestica', 'Abusi in famiglia'),
('Terrorismo', 'Atti eversivi');

-- Luoghi (15) - ID previsti 1..15
INSERT INTO luogo (nome, tipo, indirizzo, descrizione) VALUES 
('Ufficio Reperti', 'Ufficio', 'Questura Centrale', 'Accettazione'), -- ID 1
('Lab Balistica', 'Laboratorio', 'Via Scienze', 'Analisi Armi'),      -- ID 2
('Lab Genetica', 'Laboratorio', 'Via Scienze', 'DNA'),               -- ID 3
('Lab Informatico', 'Laboratorio', 'Via Bit', 'Cyber Security'),     -- ID 4
('Lab Chimico', 'Laboratorio', 'Via Scienze', 'Droghe'),             -- ID 5
('Magazzino A (Generico)', 'Magazzino', 'Piano -1', 'Generico'),     -- ID 6
('Magazzino B (Armi)', 'Magazzino', 'Piano -2', 'Blindato'),         -- ID 7
('Magazzino C (Freddo)', 'Magazzino', 'Piano -1', 'Frigoriferi'),    -- ID 8
('Archivio Cartaceo', 'Archivio', 'Piano Terra', 'Documenti'),       -- ID 9
('Scena Crimine (Villa Rossi)', 'Scena del Crimine', 'Via Lusso 1', 'Omicidio'), -- ID 10
('Scena Crimine (Banca)', 'Scena del Crimine', 'Piazza Affari', 'Rapina'),       -- ID 11
('Scena Crimine (Covo)', 'Scena del Crimine', 'Periferia', 'Droga'),             -- ID 12
('Scena Crimine (Azienda)', 'Scena del Crimine', 'Zona Ind.', 'Server'),         -- ID 13
('Abitazione Sospettato', 'Scena del Crimine', 'Via Cupa', 'Perquisizione'),     -- ID 14
('Ospedale Maggiore', 'Altro', 'Centro', 'Referti medici');                      -- ID 15

-- Persone (30) - ID previsti 1..30
INSERT INTO persona (codice_fiscale, nome, cognome, data_nascita) VALUES 
-- Agenti (ID 1-10)
('RSSMRA80A01H501U', 'Mario', 'Rossi', '1980-01-01'),
('VRDLGI85B02H501O', 'Luigi', 'Verdi', '1985-05-05'),
('BNCMRA90C03H501P', 'Maria', 'Bianchi', '1990-03-20'),
('GLLGPP75D04H501L', 'Giuseppe', 'Gialli', '1975-11-10'),
('NROLCA82E05H501Q', 'Luca', 'Neri', '1982-07-22'),
('ARCLRA95F06H501S', 'Laura', 'Arancio', '1995-09-09'),
('VLTMTT88G07H501X', 'Matteo', 'Viola', '1988-12-01'),
('RSAFBA79H08H501Z', 'Fabio', 'Rosa', '1979-02-14'),
('GRGMRT92I09H501J', 'Marta', 'Grigi', '1992-06-30'),
('MRRCRC84L10H501K', 'Carlo', 'Marrone', '1984-08-15'),
-- Analisti (ID 11-15)
('SCNSFA70M11H501A', 'Sofia', 'Scienza', '1970-11-11'), -- Balistica
('TCNMRC88N12H501B', 'Marco', 'Tecnico', '1988-12-12'), -- Informatico
('BIOELN91O13H501C', 'Elena', 'Biologi', '1991-01-13'), -- Genetica
('CHMALS77P14H501D', 'Alessia', 'Chimici', '1977-02-14'), -- Chimica
('DOCGNN60Q15H501E', 'Giovanni', 'Dottori', '1960-03-15'), -- Medico Legale
-- Civili (ID 16-30)
('CIVUNO99R16H501F', 'Denzel', 'Washington', '1999-01-01'), -- Sospettato
('CIVDUE88S17H501G', 'Meryl', 'Streep', '1988-02-02'),      -- Vittima
('CIVTRE77T18H501H', 'Tom', 'Hanks', '1977-03-03'),         -- Testimone
('CIVQUA66U19H501I', 'Brad', 'Pitt', '1966-04-04'),         -- Sospettato
('CIVCIN55V20H501L', 'Angelina', 'Jolie', '1955-05-05'),    -- Vittima
('CIVSEI44Z21H501M', 'Leonardo', 'DiCaprio', '1944-06-06'), -- Sospettato
('CIVSET33X22H501N', 'Johnny', 'Depp', '1983-07-07'),       -- Sospettato
('CIVOTT22Y23H501O', 'Scarlett', 'Johansson', '1992-08-08'),-- Vittima
('CIVNOV11K24H501P', 'Robert', 'DeNiro', '1951-09-09'),     -- Boss
('CIVDIE00J25H501Q', 'Al', 'Pacino', '1940-10-10'),         -- Boss
('CIVUND99H26H501R', 'Julia', 'Roberts', '1999-11-11'),
('CIVDOD88G27H501S', 'George', 'Clooney', '1988-12-12'),
('CIVTRE77F28H501T', 'Sandra', 'Bullock', '1977-01-13'),
('CIVQUA66D29H501U', 'Matt', 'Damon', '1966-02-14'),
('CIVCIN55S30H501V', 'Ben', 'Affleck', '1955-03-15');

-- Agenti collegati (10)
INSERT INTO agente (id, matricola, grado, dipartimento) VALUES 
(1, 'POL-001', 'Commissario', 'Polizia Scientifica'),
(2, 'POL-002', 'Ispettore', 'Polizia Postale'),
(3, 'CAR-001', 'Questore', 'Carabinieri'),
(4, 'GDF-001', 'Sovrintendente', 'Guardia di Finanza'),
(5, 'POL-003', 'Agente', 'Servizi Antidroga'),
(6, 'CAR-002', 'Ispettore', 'Carabinieri'),
(7, 'POL-004', 'Agente', 'Polizia Scientifica'),
(8, 'GDF-002', 'Agente', 'Guardia di Finanza'),
(9, 'POL-005', 'Sovrintendente', 'Polizia Postale'),
(10, 'POL-006', 'Commissario', 'Servizi Antidroga');

-- Fascicoli (10) - Tutti APERTI inizialmente
INSERT INTO fascicolo (codice, stato, priorita, id_agente_responsabile) VALUES 
('FASC-01', 'Aperto', 5, 1), -- Omicidio (Resp: Rossi)
('FASC-02', 'Aperto', 4, 2), -- Cyber (Resp: Verdi)
('FASC-03', 'Aperto', 5, 5), -- Droga (Resp: Neri)
('FASC-04', 'Aperto', 3, 3), -- Rapina (Resp: Bianchi)
('FASC-05', 'Aperto', 2, 4), -- Frode (Resp: Gialli)
('FASC-06', 'Aperto', 1, 1), -- Furto (Resp: Rossi)
('FASC-07', 'Aperto', 4, 10),-- Traffico armi (Resp: Marrone)
('FASC-08', 'Aperto', 3, 2), -- Stalking (Resp: Verdi)
('FASC-09', 'Aperto', 5, 6), -- Omicidio 2 (Resp: Arancio)
('FASC-10', 'Aperto', 2, 9); -- Truffa online (Resp: Grigi)
-- creazione di un fascicolo aperto nel 2024
INSERT INTO fascicolo (codice, stato, priorita, id_agente_responsabile, data_apertura) VALUES
('FASC-11', 'Aperto', 2, 9, '2024-01-08 19:20:01');

-- Categorie Fascicolo
INSERT INTO categoria_fascicolo VALUES 
(1,1), (2,6), (3,3), (4,4), (5,9), (6,5), (7,12), (8,8), (9,1), (10,6), (11,1);

-- coinvolgimenti
INSERT INTO coinvolgimento (id_fascicolo, id_persona, tipo, descrizione) VALUES 
-- Caso 1: Omicidio (FASC-01)
(1, 16, 'Sospettato', 'Marito della vittima, alibi non confermato'),
(1, 17, 'Vittima', 'Trovata deceduta nel salotto'),
(1, 18, 'Testimone', 'Vicino di casa, ha sentito urla alle 22:00'),
(1, 19, 'Testimone', 'Portinaia dello stabile'),
-- Caso 2: Cybercrime (FASC-02)
(2, 20, 'Sospettato', 'Hacker noto col nickname "ZeroCool"'),
(2, 21, 'Vittima', 'CEO della azienda "TechCorp" colpita'),
(2, 22, 'Testimone', 'Responsabile IT che ha notato l\'intrusione'),
-- Caso 3: Traffico Stupefacenti (FASC-03)
(3, 16, 'Sospettato', 'Visto frequentare il luogo dello scambio (Recidivo)'),
(3, 23, 'Sospettato', 'Presunto capo piazza'),
(3, 24, 'Sospettato', 'Corriere fermato con la merce'),
(3, 25, 'Testimone', 'Passante che ha segnalato movimenti sospetti'),
-- Caso 4: Rapina a Mano Armata (FASC-04)
(4, 26, 'Sospettato', 'Identificato dalle telecamere, volto coperto parzialmente'),
(4, 27, 'Vittima', 'Cassiera della banca minacciata'),
(4, 28, 'Vittima', 'Cliente ferito col calcio della pistola'),
(4, 29, 'Testimone', 'Guardia giurata disarmata dai malviventi'),
-- Caso 5: Frode (FASC-05)
(5, 30, 'Sospettato', 'Amministratore delegato, falsificazione bilanci'),
(5, 15, 'Testimone', 'Revisore dei conti (Nota: ID 15 è il medico legale, qui agisce da civile/consulente)'),
-- Caso 6: Furto con scasso (FASC-06)
(6, 24, 'Sospettato', 'Trovata refurtiva a casa sua (Collegato al caso droga)'),
(6, 17, 'Vittima', 'Appartamento svaligiato (Nota: La vittima del caso 1 era stata derubata prima di morire?)'),
-- Caso 7: Traffico Armi (FASC-07)
(7, 26, 'Sospettato', 'Acquirente del carico d\'armi'),
(7, 23, 'Sospettato', 'Venditore (Collegato al caso droga)'),
-- Caso 8: Stalking (FASC-08)
(8, 21, 'Vittima', 'CEO TechCorp (Già vittima cybercrime, perseguitata)'),
(8, 20, 'Sospettato', 'Ex dipendente licenziato (Lo stesso hacker del caso 2)'),
-- Caso 9: Omicidio 2 (FASC-09)
(9, 28, 'Sospettato', 'Rivale in affari'),
(9, 29, 'Vittima', 'Guardia giurata (Vittima collaterale)'),
(9, 18, 'Testimone', 'Ha visto l\'auto fuggire'),
-- Caso 10: Truffa Online (FASC-10)
(10, 22, 'Sospettato', 'Gestore sito fake'),
(10, 30, 'Vittima', 'Ha perso 50.000 euro in investimenti falsi');


-- ============================================================
-- 2. INSERIMENTO REPERTI "PADRE" (ROOT) 
-- ============================================================
-- Questi devono essere inseriti manualmente perché sono i capostipiti.
-- Inseriamo 20 reperti iniziali in vari luoghi.

INSERT INTO reperto (codice, descrizione, categoria, id_fascicolo, id_luogo_corrente) VALUES 
-- FASC-01 (Omicidio)
('REP-01-A', 'Pistola Beretta', 'Balistico', 1, 10),     -- ID 1 (Scena crimine)
('REP-01-B', 'Bossolo', 'Balistico', 1, 10),             -- ID 2
('REP-01-C', 'Maglietta sporca', 'Biologico', 1, 10),    -- ID 3
-- FASC-02 (Cyber)
('REP-02-A', 'Server Dell', 'Informatico', 2, 13),       -- ID 4
('REP-02-B', 'Smartphone Samsung', 'Informatico', 2, 14),-- ID 5
-- FASC-03 (Droga)
('REP-03-A', 'Panetto 1kg Bianca', 'Chimico', 3, 12),    -- ID 6
('REP-03-B', 'Bilancino', 'Generico', 3, 12),            -- ID 7
('REP-03-C', 'Busta contanti', 'Generico', 3, 12),       -- ID 8
-- FASC-04 (Rapina)
('REP-04-A', 'Fucile a pompa', 'Balistico', 4, 11),      -- ID 9
('REP-04-B', 'Passamontagna', 'Biologico', 4, 11),       -- ID 10
-- FASC-07 (Armi)
('REP-07-A', 'Mitraglietta UZI', 'Balistico', 7, 14),    -- ID 11
('REP-07-B', 'Cassa munizioni', 'Generico', 7, 14),      -- ID 12
-- FASC-09 (Omicidio 2)
('REP-09-A', 'Coltello caccia', 'Traccia', 9, 10),       -- ID 13
('REP-09-B', 'Bicchiere vetro', 'Traccia', 9, 10),       -- ID 14
-- Altri sparsi
('REP-05-A', 'Libro Mastro', 'Documentale', 5, 1),       -- ID 15
('REP-06-A', 'Piede di porco', 'Traccia', 6, 10),        -- ID 16
('REP-08-A', 'Lettere minatorie', 'Documentale', 8, 1),  -- ID 17
('REP-10-A', 'Hard Disk esterno', 'Informatico', 10, 14),-- ID 18
('REP-03-D', 'Pillole blu', 'Chimico', 3, 12),           -- ID 19
('REP-01-D', 'Impronta rilevata', 'Traccia', 1, 10);     -- ID 20

-- IMPORTANTE: Per i reperti "Padre" appena inseriti, dobbiamo registrare 
-- il PRIMO movimento (il ritrovamento) usando la procedura, per popolare la catena di custodia.
-- Sintassi: CALL registra_movimento_reperto(id_reperto, id_agente, id_luogo, motivo)

CALL registra_movimento_reperto(1, 1, 10, 'Ritrovamento sulla scena del crimine');
CALL registra_movimento_reperto(2, 1, 10, 'Ritrovamento a terra');
CALL registra_movimento_reperto(3, 1, 10, 'Sequestro indumento');
CALL registra_movimento_reperto(4, 2, 13, 'Sequestro server aziendale');
CALL registra_movimento_reperto(5, 2, 14, 'Sequestro a domicilio');
CALL registra_movimento_reperto(6, 5, 12, 'Sequestro sostanza stupefacente');
CALL registra_movimento_reperto(7, 5, 12, 'Sequestro strumentazione');
CALL registra_movimento_reperto(8, 5, 12, 'Sequestro valori');
CALL registra_movimento_reperto(9, 3, 11, 'Ritrovamento arma rapina');
CALL registra_movimento_reperto(10, 3, 11, 'Ritrovamento indumento sospetto');
CALL registra_movimento_reperto(11, 10, 14, 'Sequestro arsenale');
CALL registra_movimento_reperto(12, 10, 14, 'Sequestro munizioni');
CALL registra_movimento_reperto(13, 6, 10, 'Ritrovamento arma delitto');
CALL registra_movimento_reperto(14, 6, 10, 'Repertazione bicchiere usato');
CALL registra_movimento_reperto(15, 4, 1, 'Acquisizione documenti contabili');
CALL registra_movimento_reperto(16, 1, 10, 'Ritrovamento arnese scasso');
CALL registra_movimento_reperto(17, 2, 1, 'Consegna lettere in questura');
CALL registra_movimento_reperto(18, 9, 14, 'Sequestro supporto informatico');
CALL registra_movimento_reperto(19, 5, 12, 'Sequestro pillole');
CALL registra_movimento_reperto(20, 1, 10, 'Rilevamento impronta digitale');


-- ============================================================
-- 3. CREAZIONE SOTTO-REPERTI (Tramite Procedura Dedicata)
-- ============================================================
-- Usiamo la procedura `crea_reperto_figlio` per simulare estrazioni in laboratorio.
-- Sintassi: CALL crea_reperto_figlio(id_padre, codice, descrizione, categoria, id_agente_operante);
-- La procedura creerà il reperto e inserirà automaticamente la riga in catena_custodia.

-- Estrazione Proiettile dalla Pistola (ID 1 -> Crea ID 21)
CALL crea_reperto_figlio(1, 'REP-01-A-1', 'Proiettile estratto dalla canna', 'Balistico', 1);
-- Estrazione DNA dalla Maglietta (ID 3 -> Crea ID 22)
CALL crea_reperto_figlio(3, 'REP-01-C-1', 'Campione biologico (DNA)', 'Biologico', 7);
-- Copia Forense del Server (ID 4 -> Crea ID 23)
CALL crea_reperto_figlio(4, 'REP-02-A-1', 'Immagine bit-stream .E01', 'Informatico', 2);
-- Campionamento Droga per Analisi (ID 6 -> Crea ID 24)
CALL crea_reperto_figlio(6, 'REP-03-A-1', 'Campione 5g per analisi', 'Chimico', 5);
-- Estrazione Tampone dal Passamontagna (ID 10 -> Crea ID 25)
CALL crea_reperto_figlio(10, 'REP-04-B-1', 'Tampone salivare', 'Biologico', 3);
-- Sviluppo Impronta dal Bicchiere (ID 14 -> Crea ID 26)
CALL crea_reperto_figlio(14, 'REP-09-B-1', 'Impronta latente esaltata', 'Traccia', 6);
-- Estrazione File Log da Hard Disk (ID 18 -> Crea ID 27)
CALL crea_reperto_figlio(18, 'REP-10-A-1', 'Log connessioni', 'Documentale', 9);


-- ============================================================
-- 4. MOVIMENTAZIONE REPERTI (Tramite Procedura Dedicata)
-- ============================================================
-- Spostiamo i reperti dai luoghi di ritrovamento ai magazzini o laboratori.
-- Questo popolerà massicciamente la tabella `catena_custodia`.
-- Sintassi: CALL registra_movimento_reperto(id_reperto, id_agente, id_luogo, motivo)

-- Spostamento Armi al Lab Balistica
CALL registra_movimento_reperto(1, 1, 2, 'Invio pistola per test sparo');
CALL registra_movimento_reperto(2, 1, 2, 'Invio bossolo per comparazione');
CALL registra_movimento_reperto(9, 3, 2, 'Analisi meccanica fucile');
CALL registra_movimento_reperto(11, 10, 2, 'Verifica matricola abrasa');
CALL registra_movimento_reperto(21, 1, 2, 'Analisi striature proiettile estratto');
-- Spostamento Biologici al Lab Genetica
CALL registra_movimento_reperto(3, 7, 3, 'Invio maglia per ricerca tracce');
CALL registra_movimento_reperto(22, 7, 3, 'Processazione campione DNA');
CALL registra_movimento_reperto(10, 3, 3, 'Invio passamontagna per DNA');
CALL registra_movimento_reperto(25, 3, 3, 'Analisi tampone');
-- Spostamento Informatici al Lab Informatico
CALL registra_movimento_reperto(4, 2, 4, 'Analisi contenuto server');
CALL registra_movimento_reperto(5, 2, 4, 'Sblocco PIN smartphone');
CALL registra_movimento_reperto(18, 9, 4, 'Indicizzazione contenuti HDD');
CALL registra_movimento_reperto(23, 2, 4, 'Hashing e verifica immagine');
-- Spostamento Droga al Lab Chimico
CALL registra_movimento_reperto(6, 5, 5, 'Analisi qualitativa');
CALL registra_movimento_reperto(19, 5, 5, 'Composizione chimica pillole');
CALL registra_movimento_reperto(24, 5, 5, 'Analisi gascromatografica');
-- Stoccaggio in Magazzino (Post-Analisi o in attesa)
CALL registra_movimento_reperto(7, 5, 6, 'Stoccaggio bilancino'); -- Magazzino Generico
CALL registra_movimento_reperto(8, 5, 6, 'Stoccaggio valori in cassaforte');
CALL registra_movimento_reperto(12, 10, 7, 'Stoccaggio munizioni in sicurezza'); -- Mag Armi
CALL registra_movimento_reperto(15, 4, 9, 'Archiviazione documenti'); -- Archivio
CALL registra_movimento_reperto(16, 1, 6, 'Deposito corpo del reato');
CALL registra_movimento_reperto(13, 6, 6, 'Deposito coltello'); 
-- Movimenti successivi (Es. dal Lab al Magazzino dopo l'analisi)
CALL registra_movimento_reperto(1, 7, 7, 'Fine analisi, stoccaggio blindato'); -- Pistola -> Mag Armi
CALL registra_movimento_reperto(2, 7, 7, 'Fine analisi, stoccaggio blindato'); -- Bossolo -> Mag Armi
CALL registra_movimento_reperto(3, 7, 8, 'Conservazione reperto biologico'); -- Maglia -> Mag Freddo
CALL registra_movimento_reperto(6, 5, 6, 'Stoccaggio droga sigillata');

-- ============================================================
-- 5. ANALISI LABORATORIO (Inserimenti Finali)
-- ============================================================
-- Ora inseriamo i risultati delle analisi fatte nei laboratori

INSERT INTO analisi_laboratorio (descrizione, esito, id_reperto, id_analista, data_inizio, data_esito) VALUES 
-- Analisi Caso 1 (Omicidio)
('Comparazione Balistica', 'Pistola compatibile con bossolo', 1, 11, '2023-01-10 09:00:00', '2023-01-12 10:00:00'),
('Profilazione DNA Campione', 'Ignoto 1 (Maschio)', 22, 13, '2023-01-11 14:00:00', '2023-01-15 09:30:00'),
('Rilevamento Impronte', 'Negativo su manico pistola', 1, 11, '2023-01-10 11:00:00', '2023-01-10 18:00:00'),
-- Analisi Caso 2 (Cyber)
('Analisi Contenuto Server', 'Trovate email incriminanti e log accessi', 4, 12, '2023-02-16 08:00:00', '2023-02-20 17:00:00'),
('Analisi Smartphone', 'Chat Telegram esportate e decriptate', 5, 12, '2023-02-17 09:30:00', '2023-02-18 11:00:00'),
('Hashing e Verifica Immagine', 'Integrità confermata (MD5 match)', 23, 12, '2023-02-16 10:00:00', '2023-02-16 14:00:00'),
-- Analisi Caso 3 (Droga)
('Analisi Spettrometrica', 'Cocaina pura 90% con tracce levamisolo', 24, 14, '2023-03-21 10:00:00', '2023-03-23 15:45:00'),
('Analisi Tossicologica Pillole', 'MDMA ad alta concentrazione', 19, 14, '2023-03-22 12:00:00', '2023-03-24 09:00:00'),
-- Analisi Caso 4 (Rapina)
('Comparazione Balistica Fucile', 'Meccanismo inceppato, tracce polvere sparo', 9, 11, '2023-04-06 09:00:00', '2023-04-07 16:20:00'),
('Estrazione DNA Passamontagna', 'Profilo misto (Sospettato + Ignoto)', 25, 13, '2023-04-07 08:30:00', '2023-04-10 11:00:00'),
-- Analisi Caso 9 (Omicidio 2)
('Ealtazione Impronte Bicchiere', 'Positiva su Sospettato A (Match AFIS)', 26, 11, '2023-09-15 10:00:00', '2023-09-15 13:00:00'),
('Analisi Tracce Coltello', 'Sangue umano gruppo 0+', 13, 13, '2023-09-15 11:00:00', '2023-09-17 10:00:00'),
-- Analisi Caso 10 (Truffa)
('Decrittazione BitLocker HDD', 'Password recuperata da dizionario', 18, 12, '2023-10-06 09:00:00', '2023-10-08 19:00:00'),
('Analisi Log Connessioni', 'IP provenienza Nigeria identificato', 27, 12, '2023-10-09 08:00:00', '2023-10-10 14:30:00'),
-- Analisi Caso 7 (Armi)
('Verifica Matricola UZI', 'Matricola abrasa ripristinata chimicamente', 11, 11, '2023-07-23 09:00:00', '2023-07-24 12:00:00'),
('Conteggio Munizioni', 'Totale 500 cartucce NATO', 12, 11, '2023-07-23 14:00:00', '2023-07-23 16:00:00'),
-- Analisi Caso 5 (Frode)
('Analisi Calligrafica Libro Mastro', 'Scrittura compatibile con indagata', 15, 12, '2023-05-13 10:00:00', '2023-05-20 10:00:00');

-- ============================================================
-- 6. CHIUSURA FASCICOLI
-- ============================================================
-- Chiudiamo alcuni fascicoli per rendere i dati realistici.
-- Da questo momento non sarà più possibile aggiungere reperti a questi casi.

UPDATE fascicolo SET stato = 'Chiuso' WHERE codice = 'FASC-04'; -- Rapina risolta
UPDATE fascicolo SET stato = 'Archiviato' WHERE codice = 'FASC-06'; -- Furto (caso freddo)


-- ============================================================
-- Queries
-- ============================================================

-- Chiamiamo la procedura sull'ID 22 (Il campione di DNA estratto) per vedere da dove proviene
call risali_albero_reperti(22);

-- Chiamiamo la procedura sull'ID 3 (maglietta sporca) per vedere reperti reperti derivanti
call trova_tutti_discendenti(3);

-- Trovo reperti legati a al fascicolo con codice FASC-01
select * from dettagli_reperti
where codice_fascicolo = 'FASC-01';

-- Trovo tutte le persone coinvolte nel fascicolo con codice FASC-04
select * from registro_coinvolgimenti
where codice_fascicolo = 'FASC-04';

-- Trovo storico spostamenti del reperto con codice 'REP-01-B'
select * from storico_spostamenti
where codice_reperto = 'REP-01-B';

-- Elenco di agenti che sono stati responsabili della custodia dei reperti
SELECT agente_responsabile, count(*) AS numero_reperti_spostati
FROM storico_spostamenti
GROUP BY agente_responsabile;

-- Elenco di reperti ordinati per il loro numero di movimenti in ordine decrescente
SELECT codice_reperto, COUNT(*) as num_movimenti
FROM storico_spostamenti
GROUP BY codice_reperto
ORDER BY num_movimenti DESC;

-- Numero totale di reperti per ogni categoria di reperto e per ogni stato del fascicolo
SELECT categoria, stato_fascicolo,
    COUNT(*) as num_reperti
FROM dettagli_reperti
GROUP BY categoria, stato_fascicolo
ORDER BY num_reperti DESC;

-- Elenco di fascicoli che sono stati aperti da un anno o piu' e non ancora chiusi o archiviati
SELECT  codice, data_apertura, DATEDIFF(CURDATE(), data_apertura) as giorni_apertura
FROM fascicolo
WHERE stato = 'Aperto'
AND DATEDIFF(CURDATE(), data_apertura) > 365
ORDER BY giorni_apertura DESC;

-- Elenco di categorie di reato con la media dell'eta' delle persone coinvolte a quella categoria di reato
SELECT  cr.nome as tipo_di_reato, ROUND(AVG(YEAR(CURDATE()) - YEAR(p.data_nascita))) as eta_media
FROM categoria_reato cr
JOIN categoria_fascicolo cf ON cr.id = cf.id_categoria_reato
JOIN coinvolgimento c ON cf.id_fascicolo = c.id_fascicolo
JOIN persona p ON c.id_persona = p.id
GROUP BY tipo_di_reato;

