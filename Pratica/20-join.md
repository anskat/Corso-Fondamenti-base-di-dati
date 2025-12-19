## EQUIJOIN o JOIN semplice

Per mostrare l'elenco dei corsi e relativo docente possiamo usare una JOIN basata sull'uguaglianza tra chiave primaria della tabella docenti e chiave esterna della tabella corsi. Questo tipo di JOIN è detto EQUIJOIN.

Esempio usando la sintassi tradizionale con WHERE:

```sql
SELECT
    corsi.id AS corso_id,
    corsi.titolo,
    corsi.prezzo,
    corsi.docente_id,
    docenti.id AS docente_id,
    docenti.nome,
    docenti.cognome,
    docenti.email
FROM docenti, corsi
WHERE docenti.id = corsi.docente_id;
```

|● id	| titolo	| prezzo	| docente_id	| ● id	| cognome	|nome	| email |
|---- |---- |---- |---- |---- |---- |---- |---- |
|1	|Php	| 200.00	| 4	| 4	|Bianchi	|Daniele	|bianchi.daniele@icloud.com |
|2	|Javascript	| 120.00	| 2	| 2	| Verdi	| Paola	| verdi.paola@gmail.com |
|3	|Java	|300.00	| 3	| 3	| Bruni	| Marco	| bruni.marco@gmail.com |

La query restituisce solo le righe per le quali esiste corrispondenza tra le tabelle. Se una riga non soddisfa la condizione, non verrà mostrata.

### Unire righe di tabelle:

Le `JOIN` permettono di combinare righe di due o più tabelle basandosi su chiavi comuni o altre condizioni.

`INNER JOIN`: restituisce solo le righe che hanno corrispondenza in tutte le tabelle coinvolte.

`LEFT` / `RIGHT JOIN`: restituisce tutte le righe di una tabella anche se non ci sono corrispondenze nella tabella collegata.

`CROSS JOIN` / `SELF JOIN` / Non-equi JOIN: altri modi di combinare righe.

Le `JOIN` operano riga per riga, a differenza di `UNION` che lavora su interi set di risultati.

`JOIN` è un costrutto standard SQL alternativo all'uso della sintassi con WHERE.

Lo scopo è unire le tabelle restituendo un risultato combinato sulla base di uno o più campi corrispondenti.

La relazione tra le tabelle viene stabilita mediante `INNER JOIN` e la clausola `ON`, che identifica i campi che devono essere uguali tra le tabelle.

Verranno estratti solo i valori che hanno corrispondenza.

---

#### INNER JOIN

Sintassi generale:

```sql
SELECT tabella1.campo1, tabella2.campo2
FROM tabella1
INNER JOIN tabella2
ON tabella1.key = tabella2.key;
```

**Join tra più tabelle**

Un `JOIN` tra **n** tabelle implica almeno **n-1 condizioni di join** per collegare le tabelle.

**Esempio: tra 3 tabelle a, b, c**

*Sintassi con* `WHERE`:

```sql
SELECT * FROM a, b, c
WHERE a.key = b.key
AND b.key = c.key;
```

*Sintassi con* `JOIN`:

```sql
SELECT * FROM a
INNER JOIN b ON a.key = b.key
INNER JOIN c ON b.key = c.key;
```

Nota: `INNER` è opzionale in MySQL, ma è consigliabile inserirlo per chiarezza e compatibilità con altri RDBMS.

---

#### Esempi pratici

Elenco dei corsi e relativo docente usando `INNER JOIN`:

```sql
SELECT
    titolo AS Corso,
    cognome AS Cognome,
    nome AS Nome, email
FROM docenti d
INNER JOIN corsi c
ON c.docente_id = d.id;
```

Elenco degli studenti e relativo corso usando `INNER JOIN`:

```sql
SELECT
    cognome AS Cognome,
    nome AS Nome,
    email,
    titolo AS Corso
FROM studenti s
INNER JOIN iscrizioni i ON s.id = i.studente_id
INNER JOIN corsi c ON c.id = i.corso_id;
```

![diagramma di Venn]