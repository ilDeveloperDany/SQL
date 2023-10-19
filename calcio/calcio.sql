create database if not exists calcio;

use calcio;

create table if not exists squadre (
    nome char(20) primary key,
    citta char(30) not null,
    campionato char(20) not null
);

create table if not exists giocatori (
    nome char(30) not null,
    cognome char(30) not null,
    dataN date,
    nomeSquadra char(20),
    primary key(nome, cognome),
    foreign key(nomeSquadra) references squadre(nome)
    on delete cascade
    on update set null
);

insert into squadre values 
("cagliari", "cagliari", "serie A"),
("milan", "milano", "serie A"),
("napoli", "napoli", "serie A"),
("inter", "milano", "serie A"),
("ascoli", "ascoli piceno", "serie B");

insert into giocatori values 
("zito", "luvumbo", null, "cagliari"),
("gianluca", "lapadula", null, "cagliari"),
("antoine", "makoumbou", null, "cagliari"),
("alberto", "dossena", null, "cagliari"),
("simone", "aresti", null, "cagliari"),
("juan", "cuadrado", null, "inter"),
("nicolò", "barella", null, "inter"),
("theo", "hernàndez", null, "milan"),
("mattia", "caldara", null, "milan"),
("victor", "osimhen", null, "napoli"),
("pedro", "mendes", null, "ascoli");

update giocatori set dataN = "2002-03-09" where nome = "zito" && cognome = "luvumbo";
update giocatori set dataN = "1998-10-13" where nome = "alberto" && cognome = "dossena";
update giocatori set dataN = "1986-03-15" where nome = "simone" && cognome = "aresti";
update giocatori set dataN = "1998-07-18" where nome = "antoine" && cognome = "makoumbou";
update giocatori set dataN = "1990-02-07" where nome = "gianluca" && cognome = "lapadula";