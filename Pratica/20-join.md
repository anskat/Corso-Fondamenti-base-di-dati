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

![diagramma di Venn](/assets/images/diagramma-venn.png)

---

#### OUTER JOIN

A differenza delle INNER JOIN, le OUTER JOIN selezionano i risultati anche in assenza di una corrispondenza su entrambe le tabelle.

In MySQL sono disponibili due tipi di OUTER JOIN::

- `LEFT JOIN`: estrae tutti i valori della tabella a sinistra anche se non hanno corrispondenza nella tabella a destra;

- `RIGHT JOIN`: estrae tutti i valori della tabella a destra anche se non hanno corrispondenza nella tabella di sinistra.

Tabella di sinistra e tabella di destra si riferiscono all’ordine con cui vengono richiamate le tabelle nella query.

#### Esempi

Usiamo `LEFT JOIN` per estrarre anche i record dalla tabella di sinistra (docenti -la prima che compare nella query) che non hanno corrispondenza con la tabella di destra (corsi).

Elenco docenti **considerando anche quelli a cui non è stato associato un corso**:

```sql
SELECT cognome, nome, email, titolo AS corso
FROM docenti d
LEFT JOIN corsi c
ON d.id = c.docente_id;
```

Usando `RIGHT JOIN` otteniamo anche i record della tabella di destra(corsi) che non hanno corrispondenza con la tabella di sinistra (docenti).

Elenco corsi **considerando anche quelli senza docente**:

```sql
SELECT titolo AS corso, cognome, nome, email
FROM docenti d
RIGHT JOIN corsi c
ON d.id = c.docente_id;
```

Usiamo sempre `LEFT JOIN` per estrarre i record dalla tabella di sinistra (docenti- la prima che compare nella query) che non hanno corrispondenza con la tabella di destra.

Tra questi selezioniamo solo quelli per cui il valore della chiave esterna della tabella B risulta NULL (vedi diagramma di Venn).

**Solo docenti senza corso**:

```sql
SELECT cognome, nome, email
FROM docenti d
LEFT JOIN corsi c
ON d.id = c.docente_id
WHERE c.id IS NULL;
```

Vogliamo estrarre l’elenco solo dei corsi a cui non è stato associato alcun docente.

**Solo corsi senza docente**:

```sql
SELECT titolo AS corso
FROM docenti d
RIGHT JOIN corsi c
ON d.id = c.docente_id
WHERE d.id IS NULL;
```

---

#### FULL OUTER JOIN

In MySQL non sono implementate le `FULL OUTER JOIN`, ma è possibile simulare il risultato con l’ `UNION` di `LEFT` e `RIGHT JOIN`:

```sql
SELECT cognome, nome, email, titolo AS corso
FROM docenti d
LEFT JOIN corsi c
ON d.id = c.docente_id

UNION

SELECT cognome, nome, email, titolo AS corso
FROM docenti d
RIGHT JOIN corsi c
ON d.id = c.docente_id

ORDER BY corso;
```

**solo gli esclusi**

```sql
SELECT cognome, nome, email, titolo AS corso
FROM docenti d
LEFT JOIN corsi c
ON d.id = c.docente_id
WHERE c.id IS NULL

UNION

SELECT cognome, nome, email, titolo AS corso
FROM docenti d
RIGHT JOIN corsi c
ON d.id = c.docente_id
WHERE d.id IS NULL

ORDER BY corso;
```

---

#### SELF JOIN

Immaginiamo di avere una tabella *impiegato* con gli attributi

- nome
- cognome
- ruolo 
- stipendio
- id_resp *(id del responsabile)*

Per ottenere l’elenco degli impiegati con i rispettivi responsabili possiamo usare una **SELF JOIN**, uniamo la tabella impiegati con se stessa grazie al meccanismo degli alias.

```sql
SELECT i.cognome, i.nome, i.ruolo, r.cognome Responsabile
FROM impiegati i
INNER JOIN impiegati r  
ON i.id_responsabile = r.id
ORDER BY ruolo;
```

Con `LEFT JOIN` per includere anche gli impiegati senza responsabile:

```sql
SELECT i.cognome, i.nome, i.ruolo, r.cognome Responsabile
FROM impiegati i
LEFT JOIN impiegati r  
ON i.id_responsabile = r.id
ORDER BY ruolo;
```

---

#### Scorciatoia JOIN con USING (1)

Se le colonne chiave(primaria ed esterna) hanno lo stesso nome in entrambe le tabelle (es. docente_id) possiamo usare `USING`:

```sql
SELECT cognome, nome, email, titolo AS corso
FROM docenti
JOIN corsi
USING (docente_id);
```

USING è una scorciatoia che specifica le colonne comuni.

1) La clausola nomina un elenco di colonne che devono esistere in entrambe le tabelle.

---

#### CROSS JOIN

La `CROSS JOIN` restituisce il prodotto cartesiano di due tabelle: ogni riga della prima tabella viene combinata con tutte le righe della seconda.

*Esempio con tabelle prodotti e colori*:

```sql
SELECT prodotto, colore
FROM prodotti
CROSS JOIN colori;
```

il risultato avrà **n × m righe**.

È possibile ottenere lo stesso risultato scrivendo:

```sql
SELECT prodotto, colore
FROM prodotti
INNER JOIN colori;
```

Usare `CROSS JOIN` in modo esplicito **rende il codice più chiaro e leggibile**, evitando l’ambiguità o l’idea che si sia dimenticata la condizione `ON`

---

#### UPDATE, DELETE

La sintassi `JOIN` può essere utilizzata anche per operazioni di aggiornamento e cancellazione dei dati, non solo per le query di selezione.

**Esempio di UPDATE con JOIN**

Vogliamo ridurre del 10% il prezzo dei corsi che non hanno studenti iscritti:

```sql
UPDATE Corsi c
LEFT JOIN Iscrizioni d ON c.id = iscrizioni.corso_id
SET c.prezzo = c.prezzo * 0.90
WHERE iscrizioni.corso_id IS NULL;
```

In questo caso:

- La `LEFT JOIN` consente di mantenere tutti i corsi, anche quelli senza corrispondenza in iscrizioni.

- La clausola `WHERE i.corso_id IS NULL` filtra solo i corsi senza iscritti.

- La colonna `c.prezzo` viene aggiornata direttamente.

---

**Esempio di DELETE con JOIN**

Vogliamo eliminare i docenti che non hanno corsi assegnati:

```sql
DELETE d FROM docenti d
LEFT JOIN corsi c
ON d.id = c.docente_id
WHERE c.id IS NULL;
```

In questo caso:

- La `LEFT JOIN` permette di individuare tutti i docenti, inclusi quelli senza corsi.

- La clausola `WHERE c.id IS NULL` seleziona solo i docenti senza corrispondenza nella tabella corsi.

- La `DELETE` agisce solo sui record della tabella docenti specificata prima della clausola `FROM`.