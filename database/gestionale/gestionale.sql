CREATE TABLE `clienti` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cognome` varchar(50) NOT NULL,
  `nome` varchar(40),
  `telefono` varchar(15),
  `email` varchar(100) NOT NULL,
  `indirizzo` varchar(100) NOT NULL,
  `citta` varchar(50) NOT NULL,
  `provincia` char(2) NOT NULL,
  `regione` varchar(30) NOT NULL,
  `credito` int DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
);

CREATE TABLE `ordini` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cliente_id` int NOT NULL,
  `data` date NOT NULL,
  `consegna` enum('consegnato','da spedire','spedito') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_ordini_clienti` (`cliente_id`),
  CONSTRAINT `fk_ordini_clienti` FOREIGN KEY (`cliente_id`) REFERENCES `clienti` (`id`) ON UPDATE CASCADE
);

CREATE TABLE `articoli` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descrizione` varchar(255),
  `prezzo` decimal(6,2),
  `categoria` enum('hardware','software'),
  `rimanenza` tinyint unsigned,
  PRIMARY KEY (`id`)
);

CREATE TABLE `ordini_dettaglio` (
  `ordine_id` int NOT NULL,
  `articolo_id` int NOT NULL,
  `quantita` tinyint unsigned,
  `prezzo` decimal(6,2),
  PRIMARY KEY (`ordine_id`,`articolo_id`),
  KEY `fk_od_articolo` (`articolo_id`),
  CONSTRAINT `fk_od_articolo` FOREIGN KEY (`articolo_id`) REFERENCES `articoli` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_od_ordine` FOREIGN KEY (`ordine_id`) REFERENCES `ordini` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `uffici` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(30),
  `telefono` varchar(30),
  `indirizzo` varchar(50),
  `citta` varchar(30),
  `regione` varchar(30),
  PRIMARY KEY (`id`)
);

CREATE TABLE `impiegati` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(50),
  `cognome` varchar(50),
  `ruolo` varchar(50),
  `rif_to` int,
  `stipendio` decimal(6,2),
  `ufficio_id` int,
  PRIMARY KEY (`id`),
  KEY `fk_impiegato_ufficio` (`ufficio_id`),
  CONSTRAINT `fk_impiegato_ufficio` FOREIGN KEY (`ufficio_id`) REFERENCES `uffici` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
);