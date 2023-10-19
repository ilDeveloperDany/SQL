-- utilizzo il database verifica
use verifica;

-- creo la tabella classi (accertandomi che non esista già)
create table if not exists classi (
    codice enum('3AINF','4AINF','5AINF','3CINF','4CINF','5CINF','4AMME','4DMM','3CTLC','5CTL','5BTL','5BTLC', '3BCAT') primary key,
    numero smallint unsigned not null check(numero >= 1 && numero <= 5),
    sezione char(1) not null,
    indirizzo enum('informatica','telecomunicazioni','trasporti e logistica','meccanica','meccatronica','costruzioni ambiente e territorio') not null 
);

-- creo la tabella alunni (accertandomi che non esista già)
create table if not exists alunni (
    matricola int unsigned auto_increment primary key,
    nome char(30) not null,
    cognome char(40) not null,
    dataNascita date not null,
    RC enum('SI','NO'),
    codiceClasse enum('3AINF','4AINF','5AINF','3CINF','4CINF','5CINF','4AMME','4DMM','3CTLC','5CTL','5BTL','5BTLC', '3BCAT') not null,
    foreign key (codiceClasse) references classi(codice)
    on delete cascade
    on update cascade
);

-- inserisco una classe per indirizzo
insert into classi values 
('5AINF',5,'A','informatica'),
('3CTLC',3,'C','telecomunicazioni'),
('5BTL',5,'B','trasporti e logistica'),
('4DMM',4,'D','meccanica'),
('4AMME',4,'A','meccatronica'),
('3BCAT',3,'B','costruzioni ambiente e territorio');

-- inserisco 10 alunni in tutto
insert into alunni (nome, cognome, dataNascita, RC, codiceClasse) values
('Daniel','Loddo','2005-08-29','SI','5AINF'),
('Paul','Mallus','2004-03-13','SI','5BTL'),
('Mirko','Lai','2004-08-29','SI','4DMM'),
('Cosimo','Fini','2006-05-15','NO','4AMME'),
('Giorgio','Lacchittu','2007-11-03','SI','3BCAT'),
('Carlo','Ambu','2005-04-10','SI','5AINF'),
('Mattia','Palmas','2005-11-07','SI','5AINF'),
('Milo','Spada','2005-08-29',null,'5BTL'),
('Riccardo','Podda','2004-04-09',null,'3BCAT'),
('Francesco','Garau','2007-11-06',null,'3CTLC');

-- modifico il cognome dell'ultimo alunno da 'Garau' a 'Garau Sollai'
update alunni set cognome = 'Garau Sollai' where matricola = 10;

-- elimino l'alunno con numero di matricola 5
delete from alunni where matricola = 5;

-- elimino la classe con codice '3CTLC' (che contiene uno studente)
delete from classi where codice = '3CTLC';