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

```CREATE USER 'user'@'host' IDENTIFIED BY 'password';```

Concessione privilegi:

```GRANT ALL```

```ON nomedb.*```

```TO 'user'@'host';```
