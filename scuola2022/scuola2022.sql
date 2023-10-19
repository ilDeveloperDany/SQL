create database if not exists scuola2022;
use scuola2022;

-- eseguo il file di script docenti.sql
source docenti.sql;

select * from docenti;

source classi.sql;

source insegna.sql;

-- SCHEMA LOGICO TABELLE
-- docenti(codiceDocente char PR, cognome char, nome char)
-- classi(codiceClasse char PR, numero int, sezione char)
-- insegna(codiceDocente char PR, codiceClasse char PR)

-- QUERY 1: Elenco delle classi in cui insegna SABAALBE
select codiceClasse, numero, sezione from classi natural join insegna where codiceDocente = "SABAALBE";
select codiceClasse, numero, sezione from classi join insegna on classi.codiceClasse = insegna.codiceClasse where codiceDocente = "SABAALBE";

-- QUERY 2: Tutti i docenti che insegnano in "4AIN"
select nome, cognome from docenti natural join insegna where codiceClasse = "4AIN";