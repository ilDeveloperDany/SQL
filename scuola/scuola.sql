DROP DATABASE IF EXISTS scuola;
CREATE DATABASE scuola;

USE scuola;

DROP TABLE IF EXISTS classi;
DROP TABLE IF EXISTS materie;
DROP TABLE IF EXISTS docenti;
DROP TABLE IF EXISTS insegna;

CREATE TABLE classi(
    idCl CHAR(5) PRIMARY KEY,
    indirizzoCl ENUM("inf","tel","ca", "tl", "mme", "it") NOT NULL,
    sezCl CHAR(1) NOT NULL,
    numCl SMALLINT UNSIGNED NOT NULL CHECK(numCl>0 && numCl<6)
);

CREATE TABLE docenti(
    idD CHAR(3) PRIMARY KEY,
    nomeD VARCHAR(30) NOT NULL,
    cognomeD VARCHAR(30) NOT NULL
);

CREATE TABLE materie(
    idM CHAR(5) PRIMARY KEY,
    nomeM VARCHAR(100) NOT NULL
);

CREATE TABLE insegna (
    idD CHAR(3) NOT NULL,
    idCl CHAR(5) NOT NULL,
    idM CHAR(5) NOT NULL,
    dataInizio DATE DEFAULT "2023-09-1",
    dataFine DATE DEFAULT "2024-06-10",
    FOREIGN KEY (idD)
        REFERENCES docenti(idD)
        ON UPDATE CASCADE,
    FOREIGN KEY (idM)
        REFERENCES materie(idM)
        ON UPDATE CASCADE,
    FOREIGN KEY (idCl)
	    REFERENCES classi(idCl)
	    ON UPDATE CASCADE,
    PRIMARY KEY(
        idD,
        idM,
        idCl
    )
);

INSERT INTO docenti VALUES
("as", "Alberto", "Saba"),
("va", "Valeria", "Anedda"),
("mz", "Mario", "Zoroddu"),
("pd", "Paolo", "Dessì"),
("as1", "Alessandra", "Sulis"),
("ac", "Alessio", "Cabriolu"),
("ma", "Massimo", "Argiolas");

INSERT INTO classi VALUES 
("2git", "it", "g", 2),
("2hit", "it", "h", 2),
("3ainf", "inf", "a", 3),
("3btel", "tel", "b", 3),
("4ainf", "inf", "a", 4),
("5ainf", "inf", "a", 5),
("3cinf", "inf", "c", 3),
("4cinf", "inf", "c", 4),
("5cinf", "inf", "c", 5),
("1git", "it", "g", 1);

INSERT INTO materie VALUES
("inf","Informatica"),
("ing","Inglese"),
("sis","Sistemi e reti"),
("tps","Tecnologie e progettazione di sistemi informatici e telecomunicazioni"),
("gpo","Gestione, progetto e organizzazione impresa"),
("it", "Italiano"),
("st","Storia"),
("linf", "Lab. Informatica"),
("lsis", "Lab. Sistemi e reti"),
("ltps", "Lab. Tecnologie e progettazione di sistemi informatici e telecomunicazioni"),
("lgpo", "Lab. Gestione, progetto e organizzazione impresa"),
("mat", "Matematica"),
("chi", "Chimica"),
("fis", "Fisica");

INSERT INTO insegna (idD, idCl, idM) VALUES 
("as","2git","inf"),
("as","2hit","inf"),
("as","3ainf","tps"),
("as","3btel","inf"),
("as","4ainf","tps"),
("as","5ainf","inf"),

("va","3cinf","ing"),
("va","3ainf","ing"),
("va","4ainf","ing"),
("va","4cinf","ing"),
("va","5ainf","ing"),
("va","5cinf","ing"),

("mz","4ainf","linf"),
("mz","4ainf","ltps"),
("mz","5ainf","linf"),
("mz","5ainf","ltps"),
("mz","5ainf","lgpo"),
("mz","5ainf","lsis"),
("mz","5cinf","lsis"),
("mz","5cinf","lgpo"),

("pd","3ainf","it"),
("pd","3ainf","st"),
("pd","4ainf","it"),
("pd","4ainf","st"),
("pd","5ainf","it"),
("pd","5ainf","st");

INSERT INTO insegna VALUES

("as1", "3cinf", "sis", "2023-11-20", "2024-06-10"),
("as1", "4cinf", "sis", "2023-11-20", "2024-06-10"),
("as1", "5ainf", "sis", "2023-11-20", "2024-06-10"),
("as1", "5cinf", "sis", "2023-11-20", "2024-06-10"),

("ac", "3cinf", "sis", "2023-09-1", "2023-10-12"),
("ac", "4cinf", "sis", "2023-09-1", "2023-10-12"),
("ac", "5ainf", "sis", "2023-09-1", "2023-10-12"),
("ac", "5cinf", "sis", "2023-09-1", "2023-10-12");

-- QUERIES 

-- Dato il cognome di un docente indicare le classi in cui insegna

SELECT nomeD, cognomeD, idCl FROM insegna NATURAL JOIN docenti WHERE cognomeD = "Anedda";

-- Elencare i docenti il cui nome inizia con “Al”

SELECT nomeD, cognomeD FROM docenti WHERE nomeD LIKE "al%";

-- Numero di classi in cui insegna un docente di cui viene fornito il cognome

SELECT COUNT(idCl) AS "Numero classi" FROM insegna NATURAL JOIN docenti WHERE cognomeD = "Sulis";

-- Elenco dei docenti che insegnano in una data classe di cui è dato numCl sezCl e indirizzoCl senza ripetizioni

SELECT DISTINCT nomeD, cognomeD FROM docenti NATURAL JOIN insegna NATURAL JOIN classi WHERE numCl = "4" && sezCl = "A" && indirizzoCl = "inf";

-- Numero di classi dell’indirizzo di cui è data la descrizione

SELECT COUNT(idCl) AS "Numero classi" FROM classi WHERE indirizzoCl = "it";

-- Elenco dei docenti che non insegnano in alcuna classe

SELECT DISTINCT nomeD, cognomeD FROM docenti NATURAL JOIN insegna WHERE dataFine < CURRENT_TIMESTAMP;
SELECT DISTINCT nomeD, cognomeD FROM docenti LEFT JOIN insegna ON(insegna.idD = docenti.idD) WHERE idCl IS NULL;

-- Elenco delle classi senza docenti

SELECT DISTINCT classi.idCl FROM classi LEFT JOIN insegna ON (classi.idCl = insegna.idCl) WHERE idD IS NULL;
