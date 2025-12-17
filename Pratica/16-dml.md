## DML  
**Data Manipulation Language**

La **DML (Data Manipulation Language)** comprende le istruzioni utilizzate per la **creazione, lettura, aggiornamento ed eliminazione dei record** (*CRUD*).

Una volta creata la struttura del nostro database, ci ritroveremo ovviamente con una serie di **tabelle vuote**.

Le istruzioni DML permettono di **inserire, leggere, modificare ed eliminare i dati** contenuti nelle tabelle.

---

### Inserimento dei dati: regole generali

Prima di aggiungere record a una tabella è necessario conoscere:
- il **tipo di dati** previsto per ogni campo
- quali campi **non possono avere valore NULL**
- quali campi prevedono **AUTO_INCREMENT**
- eventuali **vincoli di consistenza**

Regole da rispettare:
- i dati di tipo **stringa** (compresa la **data**) vanno inseriti tra **apici singoli**
- i dati **numerici** non richiedono apici
- **non si inseriscono valori** per i campi definiti con `AUTO_INCREMENT`

---

### Consistenza dei dati

La **consistenza dei dati** è una proprietà fondamentale nei database che garantisce che i dati rispettino **regole e vincoli predefiniti**, mantenendo il database in uno stato valido e coerente.

In altre parole, i dati devono essere sempre **corretti** e rispettare le regole definite dal database.

#### Esempio di vincolo di consistenza

```sql
CREATE TABLE studenti (
    id INT PRIMARY KEY,
    nome VARCHAR(50),
    eta TINYINT UNSIGNED CHECK (eta >= 18) -- vincolo di consistenza
);
```

La consistenza è una delle proprietà **ACID**:

- **Atomicità**
- **Consistenza**
- **Isolamento**
- **Durabilità**

Queste proprietà sono fondamentali per garantire la corretta esecuzione delle transazioni nei database relazionali.

---

### INSERT INTO

L’istruzione `INSERT INTO` viene utilizzata per inserire **nuovi record** in una tabella.

È composta da due parti principali:

- `INSERT INTO` seleziona la tabella e i campi per i quali effettuare l’inserimento
- `VALUES` (o `VALUE`) elenca i valori dei campi da inserire

---

#### Inserimento specificando i campi

```sql
INSERT INTO tableName (field1, field3)
VALUES (value1, value3);
```

#### Inserire più record con un solo comando

È possibile inserire più record separando l’elenco dei valori di ogni record con una virgola:

```sql
INSERT INTO tableName (field1, field2, field3)
VALUES
(r1_value1, r1_value2, r1_value3),
(r2_value1, r2_value2, r2_value3);
```

*Sintassi alternativa per singolo record con SET*

```sql
INSERT INTO tableName
SET
field1 = 'value1',
field2 = 'value2',
field3 = 'value3';
```

#### INSERT senza indicare i nomi dei campi

È possibile usare `INSERT INTO` senza indicare i nomi dei campi solo se si inserisce un record rispettando l’ordine dei campi della tabella:


```sql
INSERT INTO tableName
VALUES (value1, value2, value3);
```

In questo caso:

- devono essere inseriti i valori di tutti i campi
- per i campi AUTO_INCREMENT o TIMESTAMP è necessario passare DEFAULT
- per i campi che accettano valori nulli si può passare NULL

Esempio completo:

```sql
INSERT INTO studente
VALUES (DEFAULT, 'fabio', 'rossi', 'fbr@gmail.com', NULL, DEFAULT);
```

---

### INSERT INTO ... SELECT

L’istruzione `INSERT INTO ... SELECT` consente di **inserire automaticamente dati in una tabella copiandoli da un'altra tabella**.

### Sintassi generale

```sql
INSERT INTO tableDestinazione (campo1, campo2, ...)
SELECT campo1, campo2, ...
FROM tableOrigine;
```

**Esempio pratico**

Supponiamo di voler popolare la tabella *amici* copiando i dati già presenti nella tabella *studenti*:

```sql
INSERT INTO amici (nome, cognome)
SELECT nome, cognome
FROM studenti;
```

Note importanti:

- La tabella di destinazione (amici) deve già esistere.
- I tipi di dato dei campi selezionati devono essere compatibili con quelli della tabella di destinazione.
- L’ordine dei campi nel `SELECT` deve corrispondere all’ordine dei campi specificati in `INSERT`.

---

#### Duplicare tabelle e contenuti

Se è necessario **copiare il contenuto di una tabella in un’altra tabella**, è possibile combinare `CREATE TABLE` con `LIKE` e `INSERT ... SELECT`.

#### Duplicare struttura e dati mantenendo indici e chiavi

Per duplicare **esattamente una tabella**, inclusi indici e chiavi primarie/esterne, bisogna usare due istruzioni separate:

```sql
CREATE TABLE studenti_bk LIKE studenti;
INSERT INTO studenti_bk
SELECT * FROM studenti;
```

`CREATE TABLE ... LIKE` duplica solo la struttura, quindi per copiare anche i dati serve l’ `INSERT ... SELECT`.

**Duplicare struttura e dati con un’unica istruzione**

È possibile usare un’unica istruzione `CREATE TABLE ... AS SELECT`:

```sql
CREATE TABLE studenti_bk2 AS
SELECT * FROM studenti;
```

Nota: in questo caso gli indici e le chiavi non vengono copiati.

La tabella di destinazione conterrà i dati, ma la struttura (indici, vincoli) sarà diversa.

---

### Aggiornamento dei dati

#### UPDATE

L’istruzione `UPDATE` viene utilizzata per **modificare i record** in una tabella esistente.  
Permette di aggiornare i valori di una o più colonne di uno o più record.

La sintassi generale è:

```sql
UPDATE tableName
SET field1 = value1, field2 = value2
WHERE field3 = value3;
```

- Dopo `UPDATE` si indica la tabella interessata
- Con `SET` si specificano le colonne da modificare e i valori da assegnare
- Con `WHERE` (opzionale) si stabiliscono le condizioni per selezionare i record da aggiornare

ATTENZIONE: se `WHERE` viene omesso, tutti i record della tabella saranno aggiornati per le colonne indicate.

- Per aggiornare più campi simultaneamente, separare le coppie colonna = valore con una virgola.

- Quando si inseriscono i dati in una tabella rammentate sempre come sono state definite le colonne per evitare errori di inserimento.

Se si inserisce un valore troppo lungo, o non compreso dalla definizione della colonna, MySQL restituisce un errore e non effettua alcuna modifica.

```sql
UPDATE studenti
SET genere = 's'
WHERE id = 1;
```

Se il campo genere è definito come:

`ENUM('f','m','nb')`

accetta quindi solo i valori f , m o nb.

MySQL restituirà un errore, perché 's' non è un valore ammesso:

```bash
ERROR 1265 (01000): Data truncated for column 'genere' at row 1
```

Questo comportamento dipende dalla modalità SQL in uso `@@sql_mode`.

Di default MySQL lavora in strict mode.

#### SQL Mode: STRICT MODE

Il server MySQL può funzionare in diverse modalità SQL, configurabili tramite la variabile di sistema `sql_mode`.

- I DBA possono impostare la modalità globale per il server
- Ogni applicazione può impostare la modalità della sessione per rispettare requisiti specifici

Le modalità SQL influenzano:

- la sintassi supportata
- i controlli di convalida dei dati eseguiti da MySQL

**Verificare la modalità SQL attuale**

```sql
SELECT @@SQL_MODE;
```

```bash
+-----------------------------------------------------+
| @@SQL_MODE                                          |
+-----------------------------------------------------+
| NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION |
+-----------------------------------------------------+
```

**Impostare la modalità SQL in STRICT MODE**

Per attivare controlli più rigorosi sulla validità dei dati, ad esempio per forzare l’uso dei vincoli dei campi, si può impostare la modalità SQL all’inizio della sessione:

```sql
SET SQL_MODE = 'TRADITIONAL';
```

https://dev.mysql.com/doc/refman/8.4/en/sql-mode.html

---

### Eliminazione dei record da una tabella

#### DELETE

L'istruzione `DELETE` viene utilizzata per **rimuovere record** da una tabella.

È necessario utilizzare la parola chiave condizionale `WHERE` per specificare quali record eliminare; **se viene omesso, tutti i record della tabella verranno cancellati**.

Sintassi di base:

```sql
DELETE
FROM tableName
WHERE field = value;
```

esempio:

```sql
DELETE
FROM studenti
WHERE genere = 'm';
```

ATTENZIONE: se `WHERE` viene omesso, **tutti i record della tabella saranno elimiati**.

#### Eliminare tutti i record della tabella

Per svuotare una tabella si usa l’istruzione `TRUNCATE`

```sql
TRUNCATE [TABLE] tableName;
```

- Questa operazione è molto veloce perché ricrea la tabella vuota, azzerando eventuali campi AUTO_INCREMENT.

- `TRUNCATE` fa parte delle istruzioni DDL.

Se si utilizza `DELETE` senza `WHERE`, tutti i record vengono eliminati uno per uno:

```sql
DELETE FROM tableName;
```

- Questo metodo è meno efficiente su tabelle grandi perché dipende dal numero di righe.
- Inoltre, usando `DELETE`, il valore di eventuali campi `AUTO_INCREMENT` non viene azzerato.

Per azzerare manualmente un campo `AUTO_INCREMENT`:
 
```sql
ALTER TABLE tableName AUTO_INCREMENT = 1;
```