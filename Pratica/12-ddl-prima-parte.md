## DDL  
*Data Definition Language – Parte 1*

In questa sezione vengono illustrate le **istruzioni fondamentali** per creare un **utente applicativo** MySQL, ovvero un utente dedicato all’accesso a uno specifico database da parte di un’applicazione.

L’utente applicativo potrà:
- accedere **solo al database assegnato**
- operare esclusivamente sugli oggetti presenti in tale database  
  (tabelle, viste, indici, ecc.)

Non avrà visibilità né permessi sugli altri database del sistema.

---

### Perché usare un utente applicativo

Questa configurazione rappresenta una **buona pratica standard** nell’utilizzo dei database, poiché:
- applica il **principio dei privilegi minimi**
- riduce il rischio di accessi o modifiche accidentali ad altri database
- migliora la **sicurezza** e l’**isolamento** dei dati

---

### Informazioni necessarie

Per configurare correttamente l’accesso sono necessari:

- **Nome del database**  
  a cui l’utente è autorizzato ad accedere

- **Nome dell’utente**  
  che verrà utilizzato dall’applicazione

- **Password associata all’utente**  
  utilizzata per l’autenticazione

- **Host (macchina di origine)**  
  da cui l’utente è autorizzato a connettersi al DBMS

### Creare un database

Una volta effettuato l'accesso possiamo eseguire l’istruzione CREATE DATABASE (CREATE SCHEMA) seguita dal nome del database da creare.

```sql
CREATE DATABASE databaseName;
```

Se il database è già presente mysql  ve lo segnala attraverso un messaggio di errore:

```bash
ERROR 1007 (HY000): Can't create database 'nomedatabase'; database exists
```

Usando la sintassi seguente

```sql
CREATE DATABASE IF NOT EXISTS databaseName;
```

mysql verifica l'esistenza del db: se non esiste lo crea, se esiste vi da ok ma segnala un warning.

```bash
Query OK, 1 row affected, 1 warning (0.01 sec)
```

In fase di creazione di un database con MySQL è anche possibile specificare charset e collation; ad esempio:

```sql
CREATE DATABASE IF NOT EXISTS databaseName
CHARACTER SET utf8
COLLATE utf8_general_ci;
```

Specificando questi valori è possibile "sovrascrivere" quelli impostati di default a livello server.

Per visualizzare come è stato creato il database

```sql
SHOW CREATE DATABASE databaseName;
```

Per elencare rispettivamente i set di caratteri disponibili e le "collezioni" disponibili.

```sql
SHOW CHARACTER SET;
```

```sql
SHOW COLLATION;
```

### Cancellare un database

Per eliminare un DB basta scrivere l’istruzione DROP DATABASE (DROP SCHEMA) seguita dal nome del database da rimuovere.

```sql
DROP DATABASE databaseName;
```

Se si usa l’istruzione opzionale IF EXISTS si evita di ricevere l’errore qualora il database sia già stato eliminato.

```sql
DROP DATABASE IF EXISTS databaseName;
```