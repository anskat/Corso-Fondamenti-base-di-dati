## DDL  
*Data Definition Language – Parte 2*

### Creare le tabelle

Per creare una tabella si utilizza l’istruzione `CREATE TABLE`.

Quando si crea una tabella è necessario definire:
- il **nome della tabella**
- i **campi (colonne)** che la compongono
- per ciascun campo, il **tipo di dato** (dominio)
- eventuali **vincoli e attributi** (`NOT NULL`, `PRIMARY KEY`, `AUTO_INCREMENT`, ecc.)

---

### Sintassi generale

```sql
CREATE TABLE [IF NOT EXISTS] nome_tabella (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fieldName1 VARCHAR(60) NOT NULL,
    fieldName2 DATE,
    fieldName3 TINYINT
)
[ENGINE = InnoDB
 CHARACTER SET utf8mb4
 COLLATE utf8mb4_0900_ai_ci];
```

`ENGINE`, `CHARACTER SET` e `COLLATE` indicati sono quelli di **default in MySQL 8.x**, se non diversamente configurato.

#### Modificare charset e collation

È possibile specificare un charset e una collation differenti in fase di creazione della tabella.

Per visualizzare l’elenco dei *charset* disponibili e le relative *collation*:

```sql
SHOW CHARACTER SET;
```

#### Sintassi completa

**Documentazione ufficiale MySQL** 

https://dev.mysql.com/doc/refman/8.4/en/create-table.html

---

Esempio di creazione di una tabella denominata *studente*, con il campo `id` come chiave primaria.


```sql
CREATE TABLE IF NOT EXISTS studenti(    
    id INT AUTO_INCREMENT,
    nome VARCHAR(20),
    cognome VARCHAR(30) NOT NULL,
    genere ENUM('m','f'),
    indirizzo VARCHAR(100),
    citta VARCHAR(30),
    provincia CHAR(2) DEFAULT 'To',
    regione VARCHAR(30) DEFAULT 'Piemonte',
    email VARCHAR(100) NOT NULL UNIQUE,
    data_nascita date,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY(id)
);
```

