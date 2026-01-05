## CONSTRAINTS

I vincoli `CONSTRAINTS` impongono **regole sui dati** che possono essere inseriti in una tabella.

**Servono a garantire l'integrità dei dati direttamente a livello di database**, evitando di delegare tutto il controllo all'applicazione.

Quando un'istruzione viola un vincolo, MySQL genera un errore e impedisce l'esecuzione.

---

Tipi principali di vincoli:

- **PRIMARY KEY**

Identifica univocamente ogni riga della tabella. I valori devono essere unici e non nulli.

- **FOREIGN KEY**

Impone che i valori di una colonna (o gruppo di colonne) corrispondano ai valori di una chiave primaria in un'altra tabella, garantendo l’integrità referenziale.

- **UNIQUE**

Richiede che i valori in una colonna (o combinazione di colonne) non si ripetano all’interno della tabella.

- **CHECK**

Valida che i valori inseriti soddisfino una condizione specifica (es: CHECK (età >= 18)).

Se la condizione è falsa, l'inserimento viene bloccato.

---

### CHECK MySQL

A partire da *MySQL 8.0.16* vengono applicati i CHECK.

Prima di MySQL 8.0.16 le espressioni di vincolo erano accettate nella sintassi ma ignorate.

#### In MYSQL puoi definire i vincoli in 2 modi diversi:

 [CONSTRAINT [constraint_name]] `CHECK (expression)` dato come parte di una definizione di colonna;

 [CONSTRAINT [constraint_name]] `CHECK (expression)` come vincolo di tabella (può riferirsi a più colonne).

- Prima che una riga venga inserita o aggiornata, tutti i vincoli CHECK vengono valutati.

- Se un'espressione di vincolo restituisce false, la riga non verrà inserita o aggiornata.

- È possibile utilizzare espressioni deterministiche nei vincoli CHECK.

- Non sono ammessi riferimenti a colonne di altre tabelle, subquery o funzioni non deterministiche.

- Se non dai un nome al vincolo, il vincolo riceverà un nome generato automaticamente. In modo da poter successivamente eliminare il vincolo con:

```sql
ALTER TABLE nome_tabella DROP constraint nome_vincolo;
```

In MySQL i `CHECK` vengono trattati come constraint di tabella e possono essere rimossi con `DROP CONSTRAINT` a partire da *MySQL 8.0.19*.

---

#### Uso CHECK alla creazione della tabella

```sql
CREATE TABLE libri2 (
  id int AUTO_INCREMENT,
  titolo varchar(255),
  prezzo decimal(6,2) NOT NULL,
  pagine smallint unsigned CHECK (pagine > 0) /* CONSTRAINT chk_pagine CHECK (pagine > 0) */,
  editore_id int,
  PRIMARY KEY (id),
/* CHECK su due colonne */
  CONSTRAINT chk_prezzo_pagine CHECK ((prezzo > 0) AND (pagine > 0))
);
```

Aggiunta `CHECK` su tabella esistente con nome definito dall’utente:

```sql
ALTER TABLE studenti
ADD CONSTRAINT ck_eta CHECK(eta >= 18);
```

```sql
ALTER TABLE libri
ADD CONSTRAINT ck_prezzo CHECK(prezzo > 0);
```

Aggiunta CHECK su tabella esistente con nome definito dal motore ([nome_tabella]_chk_[numero sequenziale 1,2,…])

```sql
ALTER TABLE studenti
ADD CHECK(eta >= 18);
```

```sql
ALTER TABLE libri
ADD CHECK(prezzo > 0);
```

---

#### Visualizzare le CONSTRAINT CHECK

Visualizzare le CONSTRAINT CHECK (nome e vincolo) di una tabella con:

```sql
SHOW CREATE TABLE nome_tabella
```

```sql
SHOW CREATE TABLE libri2;
```

Visualizzare elenco CONSTRAINT CHECK di una tabella interrogando *information_schema*:

```sql
SELECT * 
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE CONSTRAINT_TYPE = 'CHECK' 
  AND TABLE_NAME = 'libri';
```

Visualizzare elenco CONSTRAINT CHECK con definizione del vincolo di un database interrogando *information_schema*:

```sql
SELECT cc.CONSTRAINT_NAME, cc.CHECK_CLAUSE, tc.TABLE_NAME
FROM INFORMATION_SCHEMA.CHECK_CONSTRAINTS cc
JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
  ON cc.CONSTRAINT_NAME = tc.CONSTRAINT_NAME
WHERE tc.CONSTRAINT_TYPE = 'CHECK'
  AND tc.CONSTRAINT_SCHEMA = 'nome_database';
```

> Attenzione!
> I vincoli CHECK:
> - non sostituiscono la validazione applicativa, ma rappresentano l’ultima linea di difesa del database;
> - garantiscono che dati non validi non possano esistere, indipendentemente dall’applicazione che li inserisce.