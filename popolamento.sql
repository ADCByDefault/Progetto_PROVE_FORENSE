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
-- il presente codice è stato, in parte, scritto con l'utilizzo di strumenti esterni.
-- --------------------------------------------------------------------------


use prove_forense;

-- 1. Categoria Reato
INSERT INTO categoria_reato (nome, descrizione) VALUES
('Furto', 'Sottrazione illecita di beni mobili'),
('Omicidio', 'Uccisione di una persona'),
('Truffa', 'Inganno per ottenere vantaggi illeciti'),
('Violenza Sessuale', 'Violenza o costrizione in ambito sessuale'),
('Rapina', 'Furto con violenza o minaccia'),
('Riciclaggio', 'Reimpiego di denaro di provenienza illecita'),
('Spaccio di Droga', 'Traffico di sostanze stupefacenti'),
('Cybercrime', 'Reati commessi attraverso mezzi informatici'),
('Estorsione', 'Costrizione a fare o non fare qualcosa'),
('Associazione a delinquere', 'Associazione finalizzata a commettere reati'),
('Corruzione', 'Abuso di potere per ottenere vantaggi'),
('Frode Fiscale', 'Evasione o elusione fiscale'),
('Usura', 'Prestito di denaro a tassi eccessivi'),
('Stalking', 'Comportamenti persecutori'),
('Incendio Doloso', 'Incendio appiccato intenzionalmente'),
('Sequestro di Persona', 'Privazione della libertà personale'),
('Diffamazione', 'Offesa alla reputazione di una persona'),
('Violazione Diritto d\'Autore', 'Uso non autorizzato di opere protette'),
('Maltrattamenti in Famiglia', 'Violenze in ambito domestico'),
('Guida in Stato di Ebbrezza', 'Guida sotto l\'effetto di alcol'),
('Falso in Bilancio', 'Alterazione di documenti contabili'),
('Abuso d\'Ufficio', 'Uso illegittimo di poteri pubblici'),
('Inquinamento Ambientale', 'Danno all\'ambiente'),
('Finanziamento al Terrorismo', 'Fornitura di fondi a gruppi terroristici');

-- 2. Luogo
INSERT INTO luogo (nome, tipo, indirizzo, descrizione) VALUES
('Magazzino Centrale Polizia', 'Magazzino', 'Via Roma 15, Roma', 'Magazzino centrale per la custodia di reperti'),
('Laboratorio Scientifico Roma', 'Laboratorio', 'Via Milano 23, Roma', 'Laboratorio analisi forensi'),
('Scena Delitto Via Appia', 'Scena del Crimine', 'Via Appia Antica 45, Roma', 'Appartamento al terzo piano'),
('Archivio Fascicoli Nord', 'Archivio', 'Corso Francia 12, Milano', 'Archivio fascicoli attivi'),
('Ufficio Commissariato Centro', 'Ufficio', 'Piazza Venezia 3, Roma', 'Ufficio del commissario responsabile'),
('Laboratorio Tossicologico', 'Laboratorio', 'Via delle Acacie 8, Napoli', 'Analisi sostanze stupefacenti'),
('Scena Rapina Banca', 'Scena del Crimine', 'Piazza Duomo 1, Milano', 'Banca centrale Milano'),
('Magazzino Reperti Biologici', 'Magazzino', 'Via San Paolo 34, Torino', 'Magazzino refrigerato'),
('Ufficio Polizia Postale', 'Ufficio', 'Via Nazionale 67, Roma', 'Ufficio cybercrime'),
('Laboratorio Balistico', 'Laboratorio', 'Via della Vittoria 89, Bologna', 'Analisi armi e proiettili'),
('Scena Incidente Stradale', 'Scena del Crimine', 'Autostrada A1, km 125', 'Incidente con due veicoli'),
('Archivio Casellario', 'Archivio', 'Via dei Mille 56, Palermo', 'Archivio storico giudiziario'),
('Magazzino Documentale', 'Magazzino', 'Corso Umberto 22, Napoli', 'Custodia documenti cartacei'),
('Ufficio Guardia di Finanza', 'Ufficio', 'Piazza della Libertà 11, Firenze', 'Ufficio indagini finanziarie'),
('Laboratorio DNA', 'Laboratorio', 'Via Darwin 7, Roma', 'Analisi del DNA e tracce biologiche'),
('Scena Furto in Villa', 'Scena del Crimine', 'Via Collina 120, Siena', 'Villa isolata in campagna'),
('Magazzino Armi', 'Magazzino', 'Via Armate 33, Verona', 'Custodia armi sequestrate'),
('Ufficio Narcotici', 'Ufficio', 'Via della Droga 5, Catania', 'Ufficio servizi antidroga'),
('Laboratorio Informatico', 'Laboratorio', 'Via Silicon 18, Milano', 'Analisi dispositivi digitali'),
('Scena Aggressione', 'Scena del Crimine', 'Piazza Garibaldi 9, Genova', 'Parco pubblico durante la notte');

-- 3. Persona
INSERT INTO persona (codice_fiscale, nome, cognome, data_nascita) VALUES
('RSSMRA80A01H501A', 'Mario', 'Rossi', '1980-01-01'),
('BNCLGU81B02H501B', 'Luigi', 'Bianchi', '1981-02-02'),
('VRDGPP82C03H501C', 'Giuseppe', 'Verdi', '1982-03-03'),
('ESPMRA83D04H501D', 'Maria', 'Esposito', '1983-04-04'),
('RSSGPP84E05H501E', 'Giuseppe', 'Russo', '1984-05-05'),
('FRRGNN85F06H501F', 'Giovanni', 'Ferrari', '1985-06-06'),
('GLIGLL87H08H501H', 'Giulio', 'Galli', '1987-08-08'),
('CNTMRA88I09H501I', 'Maria', 'Conti', '1988-09-09'),
('MNTFRN90L12H501L', 'Francesco', 'Monti', '1990-12-12'),
('RNZCRL91M13H501M', 'Carlo', 'Renzetti', '1991-01-13'),
('SCZALB92N14H501N', 'Alberto', 'Scozzari', '1992-02-14'),
('LMBMRC93P16H501P', 'Marco', 'Lombardi', '1993-04-16'),
('FRZCRL94R18H501R', 'Carlo', 'Frizzi', '1994-06-18'),
('PLTSRG95S19H501S', 'Sergio', 'Politi', '1995-07-19'),
('GRZSNT96T20H501T', 'Santo', 'Graziano', '1996-08-20'),
('PTRGLN97U21H501U', 'Giuliana', 'Petrarca', '1997-09-21'),
('CRLSFN98V22H501V', 'Stefano', 'Carli', '1998-10-22'),
('RMLNDR99W23H501W', 'Andrea', 'Romano', '1999-11-23'),
('MNTTNZ00X24H501X', 'Antonio', 'Mantovani', '2000-12-24'),
('VRDCHR01Y25H501Y', 'Chiara', 'Verdone', '2001-01-25'),
('BNCCST02Z26H501Z', 'Cristina', 'Bianco', '2002-02-26'),
('RSSLCA03A27H502A', 'Lucia', 'Rossini', '2003-03-27'),
('FRRMRT04B28H502B', 'Martina', 'Ferri', '2004-04-28'),
('ESPPOL05C29H502C', 'Paolo', 'Esposti', '2005-05-29'),
('GRZFRC06D30H502D', 'Federico', 'Grazioli', '2006-06-30'),
('CNTGLN07E01H502E', 'Giuliana', 'Contini', '2007-07-01'),
('RSSDNL08F02H502F', 'Daniele', 'Rossetti', '2008-08-02'),
('VRDMNL09G03H502G', 'Manuela', 'Verdini', '2009-09-03'),
('FRRSNT10H04H502H', 'Sante', 'Ferrero', '2010-10-04'),
('BNCTMS11I05H502I', 'Tommaso', 'Bianchini', '2011-11-05');

-- 4. Agente (basato sulle prime 10 persone)
INSERT INTO agente (id, matricola, grado, dipartimento) VALUES
(1, 'POL001234', 'Commissario', 'Polizia Scientifica'),
(2, 'CAR005678', 'Ispettore', 'Carabinieri'),
(3, 'POL009876', 'Agente', 'Polizia Postale'),
(4, 'GDF002345', 'Sovrintendente', 'Guardia di Finanza'),
(5, 'POL003456', 'Agente', 'Polizia Scientifica'),
(6, 'CAR007890', 'Commissario', 'Carabinieri'),
(7, 'POL004567', 'Ispettore', 'Servizi Antidroga'),
(8, 'GDF008901', 'Questore', 'Guardia di Finanza'),
(9, 'POL005678', 'Agente', 'Polizia Postale'),
(10, 'CAR009012', 'Sovrintendente', 'Carabinieri');

-- 5. Fascicolo
INSERT INTO fascicolo (codice, priorita, id_agente_responsabile, data_apertura) VALUES
('FUR/2023/001', 3, 1, '2023-01-15 09:30:00'),
('OMI/2023/002', 1, 2, '2023-02-20 14:15:00'),
('TRU/2023/003', 2, 3, '2023-03-10 11:00:00'),
('RAP/2023/004', 4, 4, '2023-04-05 16:45:00'),
('SPA/2023/005', 1, 5, '2023-05-12 10:20:00'),
('CYB/2023/006', 5, 6, '2023-06-18 13:10:00'),
('EST/2023/007', 3, 7, '2023-07-22 09:45:00'),
('FAL/2023/008', 2, 8, '2023-08-30 15:30:00'),
('MAL/2023/009', 4, 9, '2023-09-14 11:50:00'),
('INQ/2023/010', 3, 10, '2023-10-25 08:15:00'),
('FUR/2023/011', 2, 1, '2023-11-05 14:40:00'),
('TRU/2023/012', 1, 2, '2023-12-10 10:05:00'),
('RAP/2023/013', 5, 3, '2024-01-08 16:20:00'),
('SPA/2024/001', 3, 4, '2024-02-14 09:10:00'),
('CYB/2024/002', 4, 5, '2024-03-20 13:55:00'),
('EST/2024/003', 2, 6, '2024-04-02 11:30:00'),
('FAL/2024/004', 3, 7, '2024-05-18 15:15:00'),
('MAL/2024/005', 1, 8, '2024-06-22 08:45:00'),
('INQ/2024/006', 4, 9, '2024-07-30 14:25:00'),
('FUR/2024/007', 2, 10, '2024-08-12 10:50:00');

-- 6. Coinvolgimento
INSERT INTO coinvolgimento (id_fascicolo, id_persona, tipo, descrizione) VALUES
(1, 11, 'Sospettato', 'Vicino di casa della vittima, precedenti per furto'),
(1, 12, 'Vittima', 'Proprietario dell\'appartamento svaligiato'),
(1, 13, 'Testimone', 'Portinaio che ha visto uno sconosciuto'),
(2, 14, 'Sospettato', 'Ex compagno della vittima'),
(2, 15, 'Vittima', 'Trovata senza vita in casa'),
(2, 16, 'Testimone', 'Amica che ha sentito urla'),
(3, 17, 'Sospettato', 'Truffatore seriale, già noto alle forze dell\'ordine'),
(3, 18, 'Vittima', 'Anziana truffata con falso premio'),
(4, 19, 'Sospettato', 'Rapinatore identificato dalle telecamere'),
(4, 20, 'Vittima', 'Cassiere della banca rapinata'),
(5, 21, 'Sospettato', 'Spacciatore arrestato con 2 kg di cocaina'),
(5, 22, 'Testimone', 'Cliente abituale dello spacciatore'),
(6, 23, 'Sospettato', 'Hacker che ha violato il sistema bancario'),
(6, 24, 'Vittima', 'Banca derubata di 500.000 euro'),
(7, 25, 'Sospettato', 'Estorsore che minacciava il commerciante'),
(7, 26, 'Vittima', 'Commerciante costretto a pagare il pizzo'),
(8, 27, 'Sospettato', 'Falsario di opere d\'arte'),
(8, 28, 'Vittima', 'Galleria d\'arte che ha acquistato falsi'),
(9, 29, 'Sospettato', 'Marito accusato di maltrattamenti'),
(9, 30, 'Vittima', 'Moglie che ha denunciato le violenze'),
(10, 11, 'Sospettato', 'Industriale accusato di sversamenti illegali'),
(10, 12, 'Testimone', 'Dipendente della fabbrica'),
(11, 13, 'Sospettato', 'Ladro di appartamenti nel quartiere'),
(11, 14, 'Vittima', 'Nuovo furto in appartamento'),
(12, 15, 'Sospettato', 'Truffatore che vendeva prodotti fake'),
(12, 16, 'Vittima', 'Acquirente truffato'),
(13, 17, 'Sospettato', 'Rapinatore di farmacie'),
(13, 18, 'Vittima', 'Farmacista rapinato'),
(14, 19, 'Sospettato', 'Spacciatore in zona scuole'),
(14, 20, 'Testimone', 'Insegnante che ha segnalato'),
(15, 21, 'Sospettato', 'Hacker che ha violato dati sanitari'),
(15, 22, 'Vittima', 'Ospedale vittima del data breach');

-- 7. Categoria Fascicolo
INSERT INTO categoria_fascicolo (id_fascicolo, id_categoria_reato) VALUES
(1, 1),  -- Furto
(2, 2),  -- Omicidio
(3, 3),  -- Truffa
(4, 5),  -- Rapina
(5, 7),  -- Spaccio di droga
(6, 8),  -- Cybercrime
(7, 9),  -- Estorsione
(8, 21), -- Falso in bilancio
(9, 19), -- Maltrattamenti in famiglia
(10, 24), -- Inquinamento ambientale
(11, 1), -- Furto
(12, 3), -- Truffa
(13, 5), -- Rapina
(14, 7), -- Spaccio di droga
(15, 8), -- Cybercrime
(16, 9), -- Estorsione
(17, 12), -- Frode fiscale
(18, 19), -- Maltrattamenti in famiglia
(19, 24), -- Inquinamento ambientale
(20, 1);  -- Furto

-- 8. Reperto
INSERT INTO reperto (codice, descrizione, categoria, id_reperto_padre, id_fascicolo, id_luogo_corrente, data_inserimento) VALUES
('R001', 'Guanti in lattice trovati sulla scena', 'Biologico', NULL, 1, 3, '2023-01-15 10:00:00'),
('R002', 'Coltello con tracce ematiche', 'Biologico', NULL, 2, 7, '2023-02-20 15:00:00'),
('R003', 'Documenti falsificati', 'Documentale', NULL, 3, 12, '2023-03-10 12:00:00'),
('R004', 'Pistola rubata', 'Balistico', NULL, 13, 11, '2023-04-05 17:00:00'),
('R005', 'Sostanza bianca in bustine', 'Chimico', NULL, 14, 6, '2023-05-12 11:00:00'),
('R006', 'Hard disk sequestrato', 'Informatico', NULL, 15, 19, '2023-06-18 14:00:00'),
('R007', 'Lettere di minaccia', 'Documentale', NULL, 7, 16, '2023-07-22 10:00:00'),
('R008', 'Quadro falso', 'Generico', NULL, 20, 13, '2023-08-30 16:00:00'),
('R009', 'Videocamera di sicurezza', 'Informatico', NULL, 9, 20, '2023-09-14 12:00:00'),
('R010', 'Campioni di acqua inquinata', 'Chimico', NULL, 19, 10, '2023-10-25 09:00:00'),
('R011', 'Grimaldelli', 'Generico', NULL, 11, 3, '2023-01-16 09:00:00'),
('R012', 'Proiettile rinvenuto', 'Balistico', 4, 13, 10, '2023-02-21 10:00:00'),
('R013', 'Cellulare del truffatore', 'Informatico', NULL, 12, 19, '2023-03-11 11:00:00'),
('R014', 'Passamontagna', 'Traccia', NULL, 4, 7, '2023-04-06 12:00:00'),
('R015', 'Bilancia di precisione', 'Generico', NULL, 5, 1, '2023-05-13 13:00:00'),
('R016', 'Server sequestrato', 'Informatico', NULL, 6, 19, '2023-06-19 14:00:00'),
('R017', 'Registrazioni telefoniche', 'Documentale', NULL, 7, 12, '2023-07-23 15:00:00'),
('R018', 'Pennelli e colori', 'Generico', NULL, 8, 13, '2023-08-31 16:00:00'),
('R019', 'Fotografie lesioni', 'Documentale', NULL, 9, 12, '2023-09-15 17:00:00'),
('R020', 'Campioni di terreno', 'Chimico', NULL, 10, 6, '2023-10-26 18:00:00'),
('R021', 'Foto suggestive', 'Documentale', NULL, 16, 12, '2023-07-22 10:00:00'),
('R022', 'Transazioni fiscali', 'Documentale', NULL, 17, 4, '2023-07-22 10:00:00'),
('R023', 'Registrazione vocale', 'Informatico', NULL, 18, 19, '2023-07-22 10:00:00'),
('R024', 'Campione di sangue prelevato dai guanti', 'Biologico', 1, 1, 2, '2023-01-16 11:30:00'),
('R025', 'Impronta digitale sul coltello', 'Traccia', 2, 2, 2, '2023-02-21 09:45:00'),
('R026', 'Firma falsificata estratta dai documenti', 'Documentale', 3, 3, 4, '2023-03-11 14:20:00'),
('R027', 'Cartuccia sparata dalla pistola', 'Balistico', 4, 13, 10, '2023-04-06 10:15:00'),
('R028', 'Campione per analisi di purezza', 'Chimico', 5, 14, 6, '2023-05-13 15:30:00'),
('R029', 'File di log estratti dall\'hard disk', 'Informatico', 6, 15, 19, '2023-06-19 16:45:00'),
('R030', 'Fibra tessile dal passamontagna', 'Traccia', 14, 4, 2, '2023-04-07 11:20:00');

-- 9. Catena Custodia
INSERT INTO catena_custodia (descrizione, id_reperto, id_agente_responsabile, id_luogo, data_movimento) VALUES
('Prelievo dalla scena del crimine', 1, 1, 3, '2023-01-15 10:30:00'),
('Trasferimento al laboratorio', 1, 2, 2, '2023-01-15 14:00:00'),
('Prelievo dalla scena del crimine', 2, 2, 7, '2023-02-20 16:00:00'),
('Trasferimento al laboratorio balistico', 2, 3, 10, '2023-02-21 09:00:00'),
('Sequestro documenti', 3, 3, 9, '2023-03-10 13:00:00'),
('Archiviazione documenti', 3, 4, 4, '2023-03-11 10:00:00'),
('Sequestro arma', 4, 4, 7, '2023-04-05 18:00:00'),
('Trasferimento al magazzino armi', 4, 5, 17, '2023-04-06 09:00:00'),
('Sequestro droga', 5, 5, 6, '2023-05-12 12:00:00'),
('Trasferimento al laboratorio tossicologico', 5, 6, 6, '2023-05-13 10:00:00'),
('Sequestro hardware', 6, 6, 9, '2023-06-18 15:00:00'),
('Trasferimento al laboratorio informatico', 6, 7, 19, '2023-06-19 11:00:00'),
('Prelievo lettere minatorie', 7, 7, 4, '2023-07-22 11:00:00'),
('Sequestro opera d\'arte', 8, 8, 13, '2023-08-30 17:00:00'),
('Prelievo videocamera', 9, 9, 9, '2023-09-14 13:00:00'),
('Prelievo campioni acqua', 10, 10, 16, '2023-10-25 10:00:00'),
('Trasferimento al laboratorio chimico', 10, 1, 6, '2023-10-26 09:00:00'),
('Prelievo strumenti scasso', 11, 1, 3, '2023-01-16 10:00:00'),
('Prelievo proiettile', 12, 2, 7, '2023-02-21 11:00:00'),
('Sequestro cellulare', 13, 3, 9, '2023-03-11 12:00:00');

-- 10. Analisi Laboratorio
INSERT INTO analisi_laboratorio (descrizione, esito, id_reperto, id_analista, data_inizio, data_esito) VALUES
('Analisi DNA sui guanti', 'DNA corrisponde al sospettato Rossi', 1, 21, '2023-01-16 09:00:00', '2023-01-20 16:00:00'),
('Analisi ematica sul coltello', 'Gruppo sanguigno corrisponde alla vittima', 2, 22, '2023-02-22 10:00:00', '2023-02-25 14:00:00'),
('Verifica autenticità documenti', 'Documenti falsificati professionalmente', 3, 23, '2023-03-12 11:00:00', '2023-03-15 17:00:00'),
('Balistica comparativa', 'Arma corrisponde a precedenti reati', 4, 24, '2023-04-07 09:00:00', '2023-04-10 15:00:00'),
('Analisi chimica sostanza', 'Cocaina pura al 85%', 5, 25, '2023-05-14 10:00:00', '2023-05-18 12:00:00'),
('Forensica digitale hard disk', 'Trovati schemi di attacco bancario', 6, 26, '2023-06-20 11:00:00', '2023-06-25 16:00:00'),
('Analisi grafologica lettere', 'Scrittura corrisponde al sospettato', 7, 27, '2023-07-24 09:00:00', '2023-07-28 14:00:00'),
('Analisi chimica acque', 'Presenza di metalli pesanti oltre i limiti', 10, 30, '2023-10-27 09:00:00', '2023-10-31 14:00:00'),
('Analisi impronte su forbici', 'Impronte corrispondono a sospettato', 11, 21, '2023-01-17 10:00:00', '2023-01-21 15:00:00'),
('Balistica proiettile', 'Proiettile compatibile con arma sequestrata', 12, 22, '2023-02-22 11:00:00', '2023-02-26 16:00:00'),
('Forensica cellulare', 'Trovate chat di pianificazione truffe', 13, 23, '2023-03-12 12:00:00', '2023-03-16 17:00:00'),
('Analisi tessuti passamontagna', 'Fibre corrispondono a maglione del sospettato', 14, 24, '2023-04-08 10:00:00', '2023-04-12 15:00:00'),
('Analisi residui bilancia', 'Tracce di cocaina e altre sostanze', 15, 25, '2023-05-15 11:00:00', '2023-05-19 16:00:00');

-- Fascicoli di estorsione risolti
UPDATE fascicolo SET stato = 'Chiuso' WHERE codice = 'EST/2023/007'; -- ID 7
UPDATE fascicolo SET stato = 'Chiuso' WHERE codice = 'EST/2024/003'; -- ID 16

-- Fascicoli di maltrattamenti risolti
UPDATE fascicolo SET stato = 'Chiuso' WHERE codice = 'MAL/2023/009'; -- ID 9

-- Fascicoli di falso risolti
UPDATE fascicolo SET stato = 'Chiuso' WHERE codice = 'FAL/2024/004'; -- ID 17

-- Fascicoli di cybercrime risolti e archiviati
UPDATE fascicolo SET stato = 'Chiuso' WHERE codice = 'CYB/2023/006'; -- ID 6
UPDATE fascicolo SET stato = 'Archiviato' WHERE codice = 'CYB/2024/002'; -- ID 15


-- --------------------------------------------------------------------------
-- Esempi di query
-- --------------------------------------------------------------------------

-- 1. dettagli dei reperti del fascicolo con codice OMI/2023/002
select *
from dettagli_reperti
where codice_fascicolo = 'OMI/2023/002';














