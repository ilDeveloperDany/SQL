/* 
Dato il seguente schema relazionale 
versamenti (codVers, dataVers, importo, matricola) matricola → dipendenti.matricola
aziende (codAz, denominazione, settore, via, numCivico, città)
dipendenti (matricola, nome, cognome, dataN, professione, numFamiliari, redditoL,  trattenute, codAz) codAz → aziende.codAz

con i seguenti vincoli
V1: redditoL > 0
V2: trattenute > 0
V3: trattenute minori del 30% del reddito lordo
V4: Non si può cancellare un dipendente inserito che abbia fatto dei versamenti. Se si aggiorna la sua matricola si aggiornano anche tutti i versamenti che ha fatto
V5: Non si può cancellare un’azienda che abbia dei dipendenti. Se si aggiorna il codAz si aggiornano anche tutti i dipendenti che lavorano per tale azienda

Scrivere in un file di testo le istruzioni per creare il database aziende / contabilita, con tutti i vincoli indicati. Popolare il database con i seguenti dati.

1, Alberto, Saba, 08-08-1970, docente, 1, 30000, 4500, MIM
2, Pinco, Pallino, 07-05-2000, impiegato, 0, 25000, 3000, AZM1
3, Mario, Zoroddu, 03-02-1960, Docente, 0, 32000, 4700, MIM
4, Franco, Rossi, 03-07-1986, Developer, 2, 40000, 6500, SOFTC

MIM, Ministero Istruzione e Merito, Istruzione, Via Milano, 124, Roma
AZM1, Tessile & co, Manufatturiero, Via Bologna, 12, Prato
SOFTC, Sistemi Software ERP, Sviluppo Software,Via Garibaldi, 36, Cagliari

V1, 12-04-2023, 200, 1
V2, 03-08-2023, 300, 2
V3, 02-06-2023, 187, 3
V4, 09-08-2022, 213.80, 2
V5,  23-12-2022, 199.45, 3
V6, 16-08-2022, 235.80, 1

*/

CREATE DATABASE contabilita;
USE contabilita;

CREATE TABLE aziende (
    codAz CHAR(10) PRIMARY KEY,
    denominazione VARCHAR(60) NOT NULL,
    settore VARCHAR(30) NOT NULL,
    via VARCHAR(30) NOT NULL,
    numCivico VARCHAR(10) NOT NULL,
    citta VARCHAR(30) NOT NULL
);

CREATE TABLE dipendenti (
    matricola INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(30) NOT NULL,
    cognome VARCHAR(30) NOT NULL,
    dataN DATE NOT NULL,
    professione VARCHAR(30) NOT NULL,
    numFamiliari INT UNSIGNED NOT NULL,
    redditoL INT UNSIGNED NOT NULL CHECK(redditoL > 0),
    trattenute INT UNSIGNED NOT NULL CHECK(trattenute > 0 && trattenute < redditoL/100*30),
    codAz CHAR(10),
    FOREIGN KEY (codAz) 
        REFERENCES aziende(codAz)
        ON UPDATE CASCADE
);

CREATE TABLE versamenti (
    codVers CHAR(10) PRIMARY KEY,
    dataVers date,
    importo FLOAT UNSIGNED,
    matricola INT UNSIGNED AUTO_INCREMENT,
    FOREIGN KEY (matricola) 
        REFERENCES dipendenti(matricola)
        ON UPDATE CASCADE
);

INSERT INTO aziende VALUES 
('MIM', 'Ministero Istruzione e Merito', 'Istruzione', 'Via Milano', 124, 'Roma'),
('AZM1', 'Tessile & co', 'Manufatturiero', 'Via Bologna', 12, 'Prato'),
('SOFTC', 'Sistemi Software ERP', 'Sviluppo Software', 'Via Garibaldi', 36, 'Cagliari');

INSERT INTO dipendenti VALUES 
(1, 'Alberto', 'Saba', '1970-08-08', 'docente', 1, 30000, 4500, 'MIM'),
(2, 'Pinco', 'Pallino','2000-07-05 ', 'impiegato', 0, 25000, 3000, 'AZM1'),
(3, 'Mario', 'Zoroddu','1960-03-02', 'docente', 0, 32000, 4700, 'MIM'),
(4, 'Franco', 'Rossi', '1986-03-07', 'developer', 2, 40000, 6500, 'SOFTC');

INSERT INTO versamenti VALUES 
('V1', '2023-12-04', 200, 1),
('V2', '2023-03-08', 300, 2),
('V3', '2023-02-06', 187, 3),
('V4', '2022-09-08', 213.80, 2),
('V5', '2022-12-23', 199.45, 3),
('V6', '2022-08-16', 235.80, 1);

/* 
Query da fare:
1 Elenco dei dipendenti con matricola, cognome, nome, professione e reddito lordo
2 Denominazione e indirizzo delle aziende avente un codice prefissato
3 Cognome e nome dei dipendenti che hanno un reddito superiore a una cifra prefissata
4 Denominazione e indirizzo delle aziende che hanno sede in un comune prefissato
5 Cognome e nome dei dipendenti di una determinata azienda che svolgono una professione prefissata (a seconda di come la si interpreta c’è una join: anzi interpretatela in questi due modi 1) si conosce il codice dell’azienda, 2) si conosce SOLO la denominazione dell’azienda). Il caso 2 risolvetelo con NATURAL JOIN e con EQUI JOIN
6 Lista delle differenti professioni presenti in un’azienda di cui si conosce il codice
7 Lista delle professioni, con eliminazione dei duplicati, per le quali i redditi sono superiori ad un limite prefissato (CLAUSOLA per ottenere righe tutte diverse) 
8 Elenco dei versamenti, con data e importo, effettuati dai dipendenti di una determinata azienda  (a seconda di come la si interpreta c’è una join: anzi interpretatela in questi due modi 1) si conosce il codice dell’azienda, 2) si conosce SOLO la denominazione dell’azienda). Il caso 2 risolvetelo con NATURAL JOIN e con EQUI JOIN
9 Ammontare dell’imposta lorda (IRPEF) calcolata sul reddito al netto delle trattenute secondo una percentuale prefissata, per tutti i dipendenti che svolgono una determinata professione.

*/

-- 1
SELECT matricola, cognome, nome, professione, redditoL FROM dipendenti;

-- 2
SELECT denominazione, citta, via, numCivico FROM aziende WHERE codAz = "MIM";

-- 3 
SELECT cognome, nome FROM dipendenti WHERE redditoL > 1000;

-- 4 
SELECT denominazione, citta, via, numCivico FROM aziende WHERE citta = "Cagliari";

-- 5
SELECT cognome, nome FROM dipendenti WHERE codAz = "SOFTC" && professione = "developer";
SELECT cognome, nome FROM dipendenti NATURAL JOIN aziende WHERE denominazione = "Sistemi Software ERP" && professione = "developer";

-- 6
SELECT professione FROM dipendenti NATURAL JOIN aziende WHERE codAz = "AZM1";

-- 7
SELECT DISTINCT professione FROM dipendenti WHERE redditoL > 1200;

-- 8
SELECT dataVers, importo FROM versamenti NATURAL JOIN dipendenti WHERE codAz = "MIM";
-- per comodità visiva ho aggiunto anche nome e cognome dei dipendenti che hanno effettuato i versamenti
SELECT nome, cognome, dataVers, importo FROM versamenti NATURAL JOIN dipendenti NATURAL JOIN aziende WHERE denominazione = "ministero istruzione e merito";

-- 9
SELECT "10%" AS IRPEF, (redditoL - trattenute) AS "Stipendio vecchio", (redditoL - trattenute)*0.90 AS "Stipendio con IRPEF" FROM dipendenti WHERE professione = "docente";