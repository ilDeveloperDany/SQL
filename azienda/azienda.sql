create database if not exists azienda;
use azienda;
create table if not exists impiegati (
    matricola int auto_increment primary key,
    nome char(30) not null,
    cognome char(30) not null,
    residenza char(25),
    stipendio decimal(9,2),
    codDip char(5)
);
create table if not exists dipartimenti (
    codice char(5) primary key,
    nomeDip char(35) not null,
    sede char(35),
    dirigente int,
    foreign key(dirigente) references impiegati(matricola)
);
alter table impiegati add foreign key (codDip) references dipartimenti(codice) on delete set null on update cascade; 