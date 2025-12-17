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

Supponiamo di voler popolare la tabella amici copiando i dati già presenti nella tabella studenti:

```sql
INSERT INTO amici (nome, cognome)
SELECT nome, cognome
FROM studenti;
```

Note importanti:

- La tabella di destinazione (amici) deve già esistere.
- I tipi di dato dei campi selezionati devono essere compatibili con quelli della tabella di destinazione.
- L’ordine dei campi nel SELECT deve corrispondere all’ordine dei campi specificati in INSERT.