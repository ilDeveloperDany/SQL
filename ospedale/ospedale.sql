-- CREAZIONE DATABASE E TABELLE

DROP DATABASE IF EXISTS ospedale;

CREATE DATABASE IF NOT EXISTS ospedale;
USE ospedale;


CREATE TABLE pazienti (
    idPaz CHAR(6) PRIMARY KEY,
    nomePaz VARCHAR(30) NOT NULL,
    cognomePaz VARCHAR(30) NOT NULL,
    telefonoPaz CHAR(10) NOT NULL UNIQUE,
    dataOperaz DATE,
    oraOperaz TIME,
    numeroSalaOperatoria SMALLINT UNSIGNED,
    dataRic DATE NOT NULL,
    dataDim DATE,
    idChir CHAR(6),
    numeroStanza SMALLINT UNSIGNED
);

CREATE TABLE chirurghi (
    idChir CHAR(6) PRIMARY KEY,
    nomeChir VARCHAR(30) NOT NULL,
    cognomeChir VARCHAR(30) NOT NULL
    -- idPaz CHAR(6),
    -- FOREIGN KEY(idPaz) 
    --     REFERENCES pazienti(idPaz)
    --     ON UPDATE CASCADE
);

CREATE TABLE stanze (
    numeroStanza SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    telefonoStanza BOOLEAN NOT NULL DEFAULT TRUE,
    ariaCondizionata BOOLEAN NOT NULL DEFAULT TRUE,
    televisore BOOLEAN NOT NULL DEFAULT TRUE,
    idPaz CHAR(6),
    FOREIGN KEY(idPaz)
        REFERENCES pazienti(idPaz)
        ON UPDATE CASCADE
);

-- ALTER TABLE pazienti
-- ADD FOREIGN KEY(idChir) 
--     REFERENCES chirurghi(idChir)
--     ON UPDATE CASCADE;

ALTER TABLE pazienti
ADD FOREIGN KEY(numeroStanza) 
    REFERENCES stanze(numeroStanza)
    ON UPDATE CASCADE;


-- INSERIMENTO DATI

INSERT INTO chirurghi (idChir, nomeChir, cognomeChir) VALUES
('SBALRT','Alberto','Saba'),
('ADDVLR','Valeria','Anedda'),
('DSSPAL','Paolo','Dessì'),
('ATZMTT','Matteo','Atzeni');

INSERT INTO stanze (telefonoStanza, ariaCondizionata, televisore) VALUES
(TRUE, TRUE, TRUE), (TRUE, TRUE, TRUE), (TRUE, TRUE, TRUE), (TRUE, TRUE, TRUE),
(TRUE, TRUE, TRUE), (TRUE, TRUE, TRUE), (TRUE, TRUE, TRUE), (TRUE, TRUE, TRUE),
(TRUE, FALSE, TRUE), (TRUE, FALSE, TRUE), (TRUE, FALSE, TRUE), (TRUE, FALSE, TRUE),
(TRUE, FALSE, TRUE), (TRUE, FALSE, TRUE), (TRUE, FALSE, TRUE), (TRUE, FALSE, TRUE),
(TRUE, FALSE, FALSE), (TRUE, FALSE, FALSE), (TRUE, FALSE, FALSE), (TRUE, FALSE, FALSE),
(TRUE, FALSE, FALSE), (TRUE, FALSE, FALSE), (TRUE, FALSE, FALSE), (TRUE, FALSE, FALSE);

INSERT INTO pazienti (idPaz, nomePaz, cognomePaz, telefonoPaz, dataRic, dataDim, dataOperaz, oraOperaz, numeroSalaOperatoria, numeroStanza, idChir) VALUES
('DNTSND','Sandro', 'Dentoni', '32915', '2023-09-23', '2023-09-30', '2023-09-27', '10:15', 1, 1, 'SBALRT'),
('AMBCR', 'Carlo', 'Ambu', '34715', '2023-06-13', '2023-06-19', '2023-06-16', '12:25', 2, 3, 'ADDVLR'),
('DINVLT', 'Valentina', 'Deiana', '33915', '2023-08-11', '2023-08-21', '2023-08-15', '11:56', 2, 3, 'DSSPAL'),
('CSUASS', 'Alessandro', 'Casu', '33923', '2023-11-22', NULL, NULL, NULL, NULL, 5, NULL),
('CNGNCL', 'Nicolò', 'Congiu', '33945', '2023-11-20', NULL, NULL, NULL, NULL, 6, NULL),
('BOISMN', 'Simone', 'Boi', '328589', '2023-10-20', '2023-10-28', '2023-10-22', '08:00', 2, 12, 'ADDVLR');

/* 

QUERIES

1. #conoscere l’elenco dei pazienti (nome, cognome, stanza, dataRic) attualmente
ricoverati
2. #conoscere l'elenco dei pazienti ricoverati (nome, cognome, stanza, dataRic) in
attesa di essere operati
3. #Sapere se un paziente si trova attualmente ricoverato
4. #Sapere se un paziente di cui è fornito il nome e cognome è stato operato
5. #nome e cognome del chirurgo che ha operato un paziente di cui si conosce il
nome e il cognome
6. #Elenco dei pazienti operati da un certo medico di cui è fornito nome e
cognome
7. #Conoscere la data in cui un paziente di cui è fornito nome e cognome è stato
operato
8. #Elenco dei chirurghi (nome e cognome) e del numero di operazioni effettuate
da ciascuno di loro in ordine crescente di operazioni
9. #Numero delle stanze attualmente occupate
10. #numero di pazienti operati da un certo medico di cui è fornito nome e
cognome
11. #Elenco dei chirurghi (nome e cognome) e del numero di operazioni effettuate
da ciascuno di loro in ordine decrescente di operazioni
12. #Verificare il numero delle stanze attualmente libere
13. #conoscere il numero di stanze libere con ariaCondizionata

*/

-- 1 (la data di dimissione dev'essere maggiore della data attuale, ciò vorrebbe dire che il paziente attualmente non è stato ancora dimesso, oppure dev'essere NULL)
SELECT nomePaz, cognomePaz, numeroStanza, dataRic FROM pazienti WHERE dataDim > CURDATE() || dataDim IS NULL;

--2 (lo stesso ragionamento, ma con dataOperaz)
SELECT nomePaz, cognomePaz FROM pazienti WHERE dataOperaz IS NULL || dataOperaz > CURDATE();

--3 
SELECT nomePaz, cognomePaz, dataRic AS dataRicovero, dataDim AS dataDimissioni, CURDATE() AS dataAttuale FROM pazienti WHERE nomePaz = "Carlo" && cognomePaz = "Ambu";

--4 
SELECT nomePaz, cognomePaz, dataOperaz AS dataOperazione, CURDATE() AS dataAttuale FROM pazienti WHERE nomePaz = "Nicolò" && cognomePaz = "Congiu";

--5
SELECT nomeChir AS nomeChirurgo, cognomeChir AS cognomeChiurgo, nomePaz AS nomePaziente, cognomePaz AS cognomePaziente FROM chirurghi NATURAL JOIN pazienti WHERE nomePaz = "Valentina" && cognomePaz = "Deiana" ;

--6
SELECT nomePaz, cognomePaz, nomeChir, cognomeChir FROM pazienti NATURAL JOIN chirurghi WHERE nomeChir = "Valeria" && cognomeChir = "Anedda";

--7
SELECT nomePaz, cognomePaz, dataOperaz FROM chirurghi NATURAL JOIN pazienti WHERE nomePaz = "Simone" && cognomePaz = "Boi";

-- 8
SELECT nomeChir, cognomeChir, COUNT(dataOperaz) AS pazientiOperati 
FROM chirurghi NATURAL JOIN pazienti 
GROUP BY nomeChir
ORDER BY COUNT(dataOperaz) DESC;

-- 9 
SELECT COUNT(stanze.numeroStanza) AS "Numero stanze attualmente occupate"
FROM stanze JOIN pazienti ON (stanze.numeroStanza = pazienti.numeroStanza)
WHERE dataDim IS NULL || dataDim > CURDATE();

-- Faccio la prova:
SELECT stanze.numeroStanza, nomePaz, cognomePaz, dataRic, dataDim
FROM stanze JOIN pazienti ON (stanze.numeroStanza = pazienti.numeroStanza)
WHERE dataDim IS NULL || dataDim > CURDATE();

-- 10 
SELECT nomeChir, cognomeChir, COUNT(nomePaz) AS "Numero pazienti operati"
FROM pazienti NATURAL JOIN chirurghi 
WHERE nomeChir = "Alberto" && cognomeChir = "Saba";

-- 11 
SELECT nomeChir, cognomeChir, COUNT(nomePaz) AS "Numero pazienti operati"
FROM chirurghi NATURAL JOIN pazienti
GROUP BY nomeChir;

-- 12 
SELECT COUNT(stanze.numeroStanza) 
FROM stanze JOIN pazienti ON (stanze.numeroStanza = pazienti.numeroStanza)
WHERE dataDim < CURDATE();

-- 13 
SELECT COUNT(stanze.numeroStanza) 
FROM stanze JOIN pazienti ON (stanze.numeroStanza = pazienti.numeroStanza)
WHERE dataDim < CURDATE() && ariaCondizionata = TRUE;