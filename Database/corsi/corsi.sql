CREATE TABLE IF NOT EXISTS Docenti (
  id int AUTO_INCREMENT,
  nome varchar(50) NOT NULL,
  cognome varchar(50) NOT NULL,
  email varchar(100) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY email (email)
);

CREATE TABLE IF NOT EXISTS Corsi (
  id int AUTO_INCREMENT,
  titolo varchar(100) NOT NULL,
  prezzo decimal(6,2) NOT NULL,
  docente_id tinyint unsigned,
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS Studenti (
  id int AUTO_INCREMENT,
  nome varchar(50) NOT NULL,
  cognome varchar(50) NOT NULL,
  genere enum('m','f', 'nb'),
  indirizzo varchar(100),
  citta varchar(30),
  provincia char(2) DEFAULT 'To',
  regione varchar(30) DEFAULT 'Piemonte',
  email varchar(100) NOT NULL UNIQUE,
  data_nascita date,
  data_reg timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
);
 -- UNIQUE KEY per le chiavi esterne per garantire unicità dell'associazione studente, corso
 -- quando si voglia utilizzare un unico campo ID come chiave primaria
 -- Diversamente lasciare che la PK sia studente_id e corso_id
CREATE TABLE IF NOT EXISTS Iscrizioni (
  id int AUTO_INCREMENT,
  studente_id int NOT NULL,
  corso_id int NOT NULL,
  prezzo decimal(6,2) NOT NULL,
  data_isc timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `studente_corso` (`studente_id`,`corso_id`), -- 
  PRIMARY KEY (id)
);
-- alternativa con chiave primaria su due campi
-- CREATE TABLE IF NOT EXISTS Iscrizioni (
--   studente_id int NOT NULL,
--   corso_id int NOT NULL,
--   prezzo decimal(6,2) NOT NULL,
--   data_isc timestamp NULL DEFAULT CURRENT_TIMESTAMP,
--   PRIMARY KEY (studente_id, corso_id)
-- );