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
