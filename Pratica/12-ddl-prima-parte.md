## DDL  
*Data Definition Language – Parte 1*

### Creare un database

Una volta effettuato l’accesso al DBMS come amministratore, è possibile creare il **database che verrà successivamente utilizzato dall’utente applicativo**.

Il database viene creato **prima** della definizione dei permessi: l’assegnazione dei privilegi all’utente avverrà infatti tramite le istruzioni **DCL** (`GRANT`).

Per creare un nuovo database si utilizza l’istruzione `CREATE DATABASE` (o in alternativa `CREATE SCHEMA`) seguita dal nome del database:

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

> [Vai alla sezione successiva per la creazione dell'utente e l'assegnazione dei privilegi necessari.](13-dcl.md)