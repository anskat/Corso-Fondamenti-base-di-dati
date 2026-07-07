CREATE TABLE `clienti` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cognome` varchar(50) NOT NULL,
  `nome` varchar(40) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `indirizzo` varchar(100) NOT NULL,
  `citta` varchar(50) NOT NULL,
  `provincia` char(2) NOT NULL,
  `regione` varchar(30) NOT NULL,
  `credito` int DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
);

CREATE TABLE `categorie` (
  `id` int NOT NULL AUTO_INCREMENT,
  `categoria` varchar(50) DEFAULT NULL,
  `descrizione` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `articoli` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descrizione` varchar(255) DEFAULT NULL,
  `prezzo` decimal(6,2) DEFAULT NULL,
  `rimanenza` tinyint unsigned DEFAULT NULL,
  `categoria_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `categoria_id` (`categoria_id`),
  CONSTRAINT `articoli_ibfk_1` FOREIGN KEY (`categoria_id`) REFERENCES `categorie` (`id`)
);

CREATE TABLE `uffici` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(30) DEFAULT NULL,
  `telefono` varchar(30) DEFAULT NULL,
  `indirizzo` varchar(50) DEFAULT NULL,
  `citta` varchar(30) DEFAULT NULL,
  `regione` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `impiegati` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) DEFAULT NULL,
  `cognome` varchar(50) DEFAULT NULL,
  `ruolo` varchar(50) DEFAULT NULL,
  `responsabile_id` int DEFAULT NULL,
  `stipendio` decimal(6,2) DEFAULT NULL,
  `ufficio_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_impiegato_ufficio` (`ufficio_id`),
  CONSTRAINT `impiegati_ibfk_1` FOREIGN KEY (`ufficio_id`) REFERENCES `uffici` (`id`)
);

CREATE TABLE `ordini` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cliente_id` int DEFAULT NULL,
  `impiegato_id` int DEFAULT NULL,
  `data_ordine` date DEFAULT NULL,
  `indirizzo_spedizione` varchar(100) DEFAULT NULL,
  `stato_consegna` enum('consegnato','da spedire','spedito') DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_ordini_clienti` (`cliente_id`),
  KEY `impiegato_id` (`impiegato_id`),
  CONSTRAINT `ordini_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clienti` (`id`),
  CONSTRAINT `ordini_ibfk_2` FOREIGN KEY (`impiegato_id`) REFERENCES `impiegati` (`id`)
);

CREATE TABLE `ordini_dettaglio` (
  `ordine_id` int NOT NULL,
  `articolo_id` int NOT NULL,
  `quantita` tinyint unsigned DEFAULT NULL,
  `prezzo` decimal(6,2) DEFAULT NULL,
  PRIMARY KEY (`ordine_id`,`articolo_id`),
  KEY `fk_od_articolo` (`articolo_id`),
  CONSTRAINT `ordini_dettaglio_ibfk_1` FOREIGN KEY (`ordine_id`) REFERENCES `ordini` (`id`),
  CONSTRAINT `ordini_dettaglio_ibfk_2` FOREIGN KEY (`articolo_id`) REFERENCES `articoli` (`id`)
);