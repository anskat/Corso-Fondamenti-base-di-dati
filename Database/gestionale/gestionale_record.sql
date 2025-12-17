INSERT INTO `clienti` VALUES
(1,'rossi','paolo','0116702323','paolo25@gmail.com','Via Roma 25','torino','To','Piemonte',974),
(2,'mori','marco','0116704040','marco18@gmail.com','Via Torino 18','milano','Mi','Lombardia',0),
(3,'bianchi','luca','0116701010','luca2@gmail.com','Via Milano 2','bologna','Bo','Emilia-Romagna',7671),
(4,'verdi','mario','0116702020','mario128@gmail.com','Corso Francia 128','torino','To','Piemonte',0),
(5,'rosso','alberto','0116707070','alberto12@icloud.com','Corso Svizzera 12','milano','Mi','Lombardia',785),
(6,'esposito','franco','0119978812','francoe@icloud.com','Via Roma 3','Asti','At','Piemonte',3429),
(7,'bruni','carlo','0117778816','brunicarlo@icloud.com','Corso Stati Uniti 13','Torino','To','Piemonte',0);

INSERT INTO `ordini`
VALUES
(1,1,'2017-12-01','consegnato'),
(2,3,'2018-01-11','consegnato'),
(3,5,'2018-01-21','da spedire'),
(4,3,'2018-01-23','spedito'),
(5,6,'2018-02-03','consegnato'),
(7,6,'2018-02-13','da spedire'),
(12,3,'2018-02-28','spedito');

INSERT INTO `articoli` VALUES (1,'monitor',350.00,'hardware',87),(2,'chiavetta',38.50,'hardware',75),(3,'hard-disk',300.00,'hardware',94),(4,'smartwatch',400.00,'hardware',96),(5,'Photoshop',700.00,'software',98),(6,'Office',350.50,'software',95),(7,'Webcam',68.00,'hardware',94),(8,'Adobe CC',1200.00,'software',100),(9,'Office',120.00,'software',100);

INSERT INTO `ordini_dettaglio` VALUES (1,2,20,38.50),(1,7,3,68.00),(2,5,1,700.00),(2,6,5,350.50),(3,2,10,38.50),(3,4,1,400.00),(4,1,3,350.00),(4,3,2,300.00),(4,7,1,68.00),(5,3,2,300.00),(5,4,3,400.00),(5,5,1,700.00),(5,7,1,68.00),(7,2,5,38.50),(7,3,2,300.00),(7,7,1,68.00),(12,1,10,350.00);

INSERT INTO `uffici` VALUES (1,'IT','3332208666','via milano 31','torino','piemonte'),(2,'Amministrazione','3332208688','via torino 25','milano','lombardia'),(3,'Commerciale','3332207899','via milano 33','torino','piemonte'),(4,'Logistica','3332204366','via torino 27','milano','lombardia');

INSERT INTO `impiegati` VALUES (1,'Mario','Rossi','tecnico',NULL,2500.00,1),(2,'Marco','Bianchi','amministrativo',7,1600.00,2),(3,'Paolo','Verdi','amministrativo',7,1600.00,2),(4,'Enrico','Marrone','venditore',8,1300.00,3),(5,'Nicola','Testa','venditore',8,1300.00,3),(6,'Franco','Barba','tecnico',1,1500.00,1),(7,'Elena','Totti','amministrativo',NULL,2600.00,2),(8,'Paola','Capra','venditore',NULL,2300.00,3),(9,'Mauro','Barba','venditore',8,1300.00,3);