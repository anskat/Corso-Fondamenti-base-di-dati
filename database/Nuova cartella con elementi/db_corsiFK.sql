CREATE TABLE IF NOT EXISTS Docenti (
  id tinyint unsigned AUTO_INCREMENT,
  nome varchar(50) NOT NULL,
  cognome varchar(50) NOT NULL,
  email varchar(100) UNIQUE NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS Corsi (
  id int AUTO_INCREMENT,
  titolo varchar(100) NOT NULL,
  prezzo decimal(6,2) NOT NULL,
  docente_id tinyint unsigned,
  CONSTRAINT fk_corsi_docenti
  FOREIGN KEY(docente_id) references docenti(id)
  ON UPDATE CASCADE
  ON DELETE RESTRICT,
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS Studenti (
  id int AUTO_INCREMENT,
  nome varchar(50) NOT NULL,
  cognome varchar(50) NOT NULL,
  genere enum('f','m', 'nb'),
  indirizzo varchar(100),
  citta varchar(30),
  provincia char(2) DEFAULT 'To',
  regione varchar(30) DEFAULT 'Piemonte',
  email varchar(100) NOT NULL UNIQUE,
  data_nascita date,
  data_reg timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS Iscrizioni (
  id int AUTO_INCREMENT,
  studente_id int NOT NULL,
  corso_id int NOT NULL,
  prezzo decimal(6,2) NOT NULL,
  data_isc timestamp DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_iscrizioni_studenti
  FOREIGN KEY(studente_id) references studenti(id)
  ON UPDATE CASCADE
  ON DELETE RESTRICT,
  CONSTRAINT fk_iscrizioni_corsi
  FOREIGN KEY(corso_id) references corsi(id)
  ON UPDATE CASCADE
  ON DELETE RESTRICT,
  PRIMARY KEY (id)
);