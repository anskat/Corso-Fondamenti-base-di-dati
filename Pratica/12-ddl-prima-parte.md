## DDL
*Data Definition Language (1parte)*

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