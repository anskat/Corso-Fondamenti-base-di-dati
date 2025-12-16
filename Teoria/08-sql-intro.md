## SQL - Structured Query Language - introduzione

SQL - Structured Query Language, è il linguaggio che permette di effettuare le operazioni per estrarre e manipolare i dati da un database.

E’ lo standard tra i sistemi relazionali: viene usato in tutti i prodotti DBMS come set di comandi per l’utente della base di dati

### Tipi di istruzioni SQL

- DCL (Data control language): permette di gestire il controllo degli accessi e i permessi per gli utenti 
- DDL (Data Definition Language): permette di definire la struttura del database
- DML (Data manipulation language): permette di modificare i dati contenuti nel db, con le operazioni di inserimento, variazione e cancellazione
- TCL (Transaction Control Language): istruzioni per gestire le transazioni nel database
- Query Language: permette di porre interrogazioni al db

--- 

#### DCL

Gestire il controllo degli accessi e i permessi per gli utenti.

Creazione utente:

```sql
CREATE USER 'user'@'host' IDENTIFIED BY 'password';
```

Concessione privilegi:

```sql
GRANT ALL
ON nomedb.*
TO 'user'@'host';
```

---

#### DDL

Permette di definire il databse e creare o modificare altre strutture come tabelle, indici...
```sql
-- crea un nuovo database
CREATE DATABASE databaseName;
``` 

```sql
-- cancella il database
DROP DATABASE databaseName;
``` 

```sql
-- crea una nuova tabella nel DB
CREATE TABLE studenti(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(30),
    cognome VARCHAR(30),
    eta TINYINT UNSIGNED CHECK(eta >= 18),
    data_iscrizione DATE COMMENT 'Data di iscrizione',
    INDEX idx_cognome(cognome)
);
```

```sql
-- modifica la struttura di una tabella
-- nello specifico aumenta la dimesione del VARCHAR, modifica del tipo
ALTER TABLE studenti
MODIFY cognome VARCHAR(50);
```

```sql
-- cancella una tabella dal DB
DROP TABLE studenti;
```

```sql
-- crea successivamente un indice su una tabella già creata
CREATE INDEX idx_cognome ON studenti(cognome); 
```

```sql
-- elimina l’indice specificato 
ALTER TABLE studenti DROP INDEX idx_cognome;
```

---

#### DML

Permette di modificare i dati contenuti nel db, con le operazioni di inserimento, variazione e cancellazione

```sql
-- inserimento 
INSERT INTO tableName(field1, field2, …)
VALUES ('value1', 'value2', '…');
```

```sql
-- aggiornamento 
UPDATE tableName
SET column_name = new_value
WHERE column_name = some_value;
```

```sql
-- eliminazione 
DELETE FROM tableName
WHERE column_name = some_value;
```

#### TCL

Gestiscono le transazioni nel database


```sql
-- rende definitive le operazioni sul database 
COMMIT;
```

```sql
-- ripristina i dati eliminando le modifiche temporanee
ROLLBACK;
```

```sql
-- crea un punto di salvataggio
SAVEPOINT save_point_name; 
```

Esempio:
```sql
START TRANSACTION;

INSERT INTO studenti (nome, cognome) VALUES ('Mario', 'Rossi');

SAVEPOINT save1;  -- punto di salvataggio

UPDATE studenti SET eta = 20 WHERE id = 1;

-- se vuoi annullare fino al savepoint
ROLLBACK TO SAVEPOINT save1;

COMMIT;
```


### Query Language

Permette di porre interrogazioni al database

```sql
SELECT field(s)
FROM table(s)
WHERE condition(s);
```

Attraverso ```SELECT``` vengono selezionati dei campi (attributi) da una o più tabelle e restituiti all'utente sotto forma di una *nuova tabella* (resultset)

Attraverso la clausola ```WHERE``` è possibile filtrare il resultset sulla base di alcune regole.