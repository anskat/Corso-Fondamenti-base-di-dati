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

#### Sintassi generale

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

Esempio di creazione di una tabella denominata *studenti*, con il campo `id` come chiave primaria.


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
---

#### Verificare le tabelle

- Mostrare le tabelle esistenti

```sql
SHOW TABLES;
```

#### Visualizzare la definizione della tabella

```sql
SHOW CREATE TABLE tableName;
```

- Per visualizzare come è stata creata una tabella:

#### Rinominare una tabella:
Due possibili sintassi:

```sql
ALTER TABLE tableName RENAME newtableName;
RENAME TABLE tableName TO newtableName;
```

---

#### Informazioni sulle colonne

Per conoscere la struttura della tabella con più o meno informazioni (valore dell'auto_increment, data di creazione, collation)

```sql
DESCRIBE tableName;
DESC tableName; -- equivalente a DESCRIBE
SHOW COLUMNS FROM tableName; -- equivalente a DESCRIBE
SHOW FULL COLUMNS FROM tableName; -- mostra anche commenti e privilegi
SHOW INDEX FROM tableName; -- mostra gli indici della tabella
```

---

#### Modificare le tabelle

L'istruzione `ALTER TABLE` viene utilizzata per aggiungere, eliminare o modificare le colonne di una tabella esistente.

**Aggiungere colonne:**

```sql
ALTER TABLE tableName
ADD fieldName [DATATYPE];
```

- Aggiungere una colonna in una posizione specifica:

```sql
ALTER TABLE tableName
ADD fieldName2 DATATYPE AFTER existingField;
```

- In prima posizione:

```sql
ALTER TABLE tableName
ADD fieldName2 DATATYPE FIRST;
```

**Modificare colonne:**

- Modificare **nome e datatype**:

```sql
ALTER TABLE tableName
CHANGE oldFieldName newFieldName [DATATYPE];
```

- Modificare **solo il datatype**:

```sql
ALTER TABLE tableName
MODIFY fieldName [DATATYPE];
```

- Modificare **solo il nome**:

```sql
ALTER TABLE tableName
RENAME COLUMN oldName TO newName;
```

**Eliminare colonne**

```sql
ALTER TABLE tableName
DROP fieldName;
```

**Combinare più operazioni**

```sql
ALTER TABLE tableName
CHANGE oldField newFieldName [DATATYPE],
ADD fieldName3 [DATATYPE] AFTER fieldName2,
DROP fieldName4;
```

**Spostare colonne**

- Spostare una colonna in una posizione specifica:

```sql
ALTER TABLE tableName
ADD fieldName2 [DATATYPE]
AFTER fieldName;
```

- Spostare una colonna in prima posizione:

```sql
ALTER TABLE tableName
MODIFY fieldName2 [DATATYPE]
FIRST;
```

Nota: se il campo è una **chiave primaria**, **non includere datatype duplicato o AUTO_INCREMENT già definito**, altrimenti MySQL genererà un errore.

---

#### Gestione della PRIMARY KEY

##### Aggiungere una PRIMARY KEY a una tabella esistente

Se la tabella **non ha ancora una chiave primaria**, è possibile aggiungerla a uno o più campi già esistenti:

```sql
ALTER TABLE tableName
ADD PRIMARY KEY (field1 [, field2, ...]);
```

> È possibile definire una chiave primaria composta specificando più campi.


##### Aggiungere una PRIMARY KEY creando un nuovo campo

È possibile aggiungere un nuovo campo dedicato (tipicamente id) e impostarlo come chiave primaria:

```sql
ALTER TABLE tableName
ADD id INT AUTO_INCREMENT PRIMARY KEY;
```

**Eliminare una PRIMARY KEY**

Per eliminare la chiave primaria da una tabella:

```sql
ALTER TABLE tableName
DROP PRIMARY KEY;
```

**Attenzione: PRIMARY KEY e AUTO_INCREMENT**

Se la chiave primaria è associata a un campo con attributo AUTO_INCREMENT, **prima di eliminare la PRIMARY KEY è necessario rimuovere l’attributo** `AUTO_INCREMENT` dal campo.

```sql
ALTER TABLE tableName
MODIFY id INT;
```

Solo dopo sarà possibile eliminare la chiave primaria:

```sql
ALTER TABLE tableName
DROP PRIMARY KEY;
```

--- 

### Duplicare tabelle

Se è necessario duplicare una tabella, è possibile utilizzare l’istruzione `CREATE TABLE` combinata con la clausola `LIKE`.

#### Duplicare la struttura di una tabella

```sql
CREATE TABLE tableNameCopy LIKE tableName;
```

Questa istruzione **duplica solo la struttura della tabella**
(campi, tipi di dato, indici), **ma non i dati** contenuti al suo interno.

#### Eliminare tabelle dal database MySQL

L’operazione inversa alla creazione di una tabella è la sua eliminazione.

Per eliminare una tabella si utilizza l’istruzione `DROP TABLE`:

```sql
DROP TABLE tableName;
```

Attenzione: l’eliminazione di una tabella è un’operazione irreversibile.
Tutti i dati contenuti nella tabella verranno persi definitivamente.

#### Eliminare più tabelle contemporaneamente

```sql
DROP TABLE tableName, tableName2, tableName3;
```

--- 

### Colonne generate (virtuali e persistenti / memorizzate)

Una **colonna generata** è una colonna il cui valore non può essere impostato manualmente tramite DML, ma viene calcolato automaticamente in base a un’espressione.

Questa espressione potrebbe generare il valore in base ai valori di altre colonne nella tabella oppure potrebbe generare il valore chiamando funzioni incorporate o funzioni definite dall'utente (UDF).

Esistono due tipi di colonne generate:

- PERSISTENT (STORED): il valore di questo tipo è effettivamente memorizzato nella tabella.
- VIRTUAL: Il valore di questo tipo non viene memorizzato affatto. Il valore viene invece generato dinamicamente quando viene eseguita una query sulla tabella. Questo tipo è l'impostazione predefinita.

Le colonne generate sono talvolta chiamate anche colonne calcolate o colonne virtuali.

Le colonne generate sono utili per derivare dati senza doverli memorizzare manualmente, evitando ridondanza.

#### Sintassi
```sql
column_name data_type  [GENERATED ALWAYS]  AS   ( <expression> )[VIRTUAL | STORED] [NOT NULL | NULL] [UNIQUE [KEY]] [PRIMARY KEY] [COMMENT <text>]
```

Esempio sulla tabella studente.
Creiamo un campo generato al volo che contenga il nome e il cognome dello studente:

```sql
ALTER TABLE studenti ADD fullName varchar(255) AS (concat(nome,' ',cognome))
AFTER cognome;
```

Esempio sulla tabella libro. Creiamo un campo generato al volo che calcoli il prezzo del libro compreso di IVA:

```sql
ALTER TABLE libri
ADD prezzo_iva decimal(6,2) GENERATED ALWAYS AS (prezzo * 1.10) STORED
AFTER prezzo;
```

[approfondimento](https://dev.mysql.com/doc/refman/8.0/en/create-table-generated-columns.html)

**Limiti nella scrittura dell'espressione**

- Sono consentiti valori letterali, funzioni integrate deterministiche e operatori.
Una funzione è deterministica se, dati gli stessi dati nelle tabelle, più invocazioni producono lo stesso risultato, indipendentemente dall'utente connesso.

Esempi di funzioni che non sono deterministiche e non soddisfano questa definizione: `CONNECTION_ID()`,  `CURRENT_USER()`,` NOW()`, `CURDATE()`…

- Non sono consentite subquery.

- Le colonne generate possono fare riferimento solo a colonne già definite nella tabella, comprese altre colonne generate definite precedentemente.

- L'attributo `AUTO_INCREMENT` non può essere utilizzato in una definizione di colonna generata.

- Non è possibile utilizzare una colonna `AUTO_INCREMENT` come colonna di base in una definizione di colonna generata.

- Se la valutazione dell'espressione provoca il troncamento o fornisce un input errato a una funzione, l'istruzione CREATE TABLE termina con un errore e l'operazione DDL viene rifiutata.

La maggior parte delle espressioni deterministiche legali che possono essere calcolate sono supportate nelle espressioni per le colonne generate.

La maggior parte delle funzioni integrate è supportata nelle espressioni per le colonne generate.

Tuttavia, alcune funzioni integrate non possono essere supportate per motivi tecnici.
Ad esempio, se si tenta di utilizzare una funzione non supportata in un'espressione, viene generato un errore simile al seguente:

```bash
ERROR 1901 (HY000): Function or expression 'dayname()' cannot be used in the GENERATED ALWAYS AS clause of `v`
```

Vediamo un esempio:

```sql
ALTER TABLE studenti
ADD eta TINYINT as (TIMESTAMPDIFF(YEAR,data_nascita,CURDATE())) virtual;
```

Non si può usare l’espressione, perché utilizza la funzione CURDATE() non deterministica.