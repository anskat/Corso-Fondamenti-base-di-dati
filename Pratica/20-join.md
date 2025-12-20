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

#### Nota pratica sulle JOIN

**Nell’esempio:**

```sql
SELECT titolo AS corso
FROM docenti d
RIGHT JOIN corsi c
ON d.id = c.docente_id
WHERE d.id IS NULL;
```

l’obiettivo è ottenere **tutti i corsi che non hanno un docente assegnato**.

Tuttavia, se la colonna `docente_id` nella tabella *corsi* può assumere valori `NULL`, è possibile ottenere lo stesso risultato con una query molto più semplice:

```sql
SELECT titolo
FROM corsi
WHERE docente_id IS NULL;
```

Questo evita la `JOIN` e semplifica l’istruzione, risparmiando risorse e migliorando la leggibilità.

Avvertenza: se nella struttura della tabella *corsi* il campo docente_id è definito `NOT NULL`, allora non esisteranno corsi senza docente.

In tal caso, la query con `WHERE docente_id IS NULL` restituirebbe sempre zero righe, e la `JOIN` sarebbe inutile.

A volte **conoscere bene il modello dei dati** permette di semplificare le query e risparmiare join inutili.

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

---

### Non EQUI-JOIN

Una non equi-join è un tipo di JOIN che utilizza una condizione diversa dall’uguaglianza (ad esempio <, <=, >, >=, !=, BETWEEN) per combinare righe provenienti da due tabelle.

Vediamo un esempio utilizzando le tabelle: *studenti* e *generazioni*.

La tabella *generazioni* è da creare e popolare:

```sql
CREATE TABLE IF NOT EXISTS generazioni(
    id TINYINT NOT NULL PRIMARY KEY,
    generazione VARCHAR(30) NOT NULL,
    dal DATE,
    al DATE
)
```

```sql
INSERT INTO generazioni(id, generazione, dal, al)
VALUES
(1,'Boomers','1946-01-01','1964-12-31'),
(2,'Generazione X','1965-01-01','1980-12-31'),
(3,'Millennial','1981-01-01','1996-12-31'),
(4,'Generazione Z','1997-01-01','2012-12-31');
```

definisce gli intervalli di anni che identificano una specifica generazione

- Boomers (dal 1946-01-01 al 1964-12-31)

- Generazione X (dal 1965-01-01 al 1980-12-31)

- Millennial (dal 1981-01-01 al 1996-12-31)

- Generazione Z (dal 1997-01-01 al 2012-12-31)

Questa tabella è un esempio di *tabella di lookup*.

Una *tabella di lookup* è una tabella che contiene valori di riferimento utilizzati per:

- classificare o categorizzare dati presenti in altre tabelle;

- ridurre la ridondanza dei dati (normalizzazione);

- centralizzare e standardizzare valori ricorrenti;

- rendere le query più chiare e manutenibili.

Vogliamo associare ogni studente alla propria generazione in base alla data di nascita.

Poiché il collegamento non avviene tramite uguaglianza tra due campi, ma tramite un intervallo di valori, è necessario utilizzare una non equi-join.

Di seguito due esempi equivalenti che utilizzano operatori diversi (il primo è generalmente più leggibile):

```sql
SELECT s.cognome, s.nome, s.data_nascita, g.generazione
FROM studenti s
JOIN generazioni g
ON s.data_nascita BETWEEN g.dal AND g.al
ORDER BY s.data_nascita;
```

```sql
SELECT s.cognome, s.nome, s.data_nascita, g.generazione
FROM studenti s
JOIN generazioni g
ON s.data_nascita >= g.anno_inizio
AND s.data_nascita <= g.anno_fine
ORDER BY s.data_nascita;
```

Altro esempio utilizzando il database dei corsi.

Vogliamo estrarre l’elenco degli studenti iscritti a partire da una certa data.

```sql
SELECT nome, cognome, data_isc
FROM studenti s
JOIN iscrizioni i
ON i.studente_id = s.id
AND i.data_isc >= '2025-03-01';
-- WHERE i.data_isc >= '2025-03-01';
```

La query utilizza una `INNER JOIN` per collegare le tabelle *studenti* e *iscrizioni* sulla base della relazione tra le chiavi.

`AND` filtra il risultato finale selezionando solo gli studenti la cui data di iscrizione è successiva alla data indicata.

Nel caso delle `INNER JOIN`, le condizioni di filtro possono essere scritte sia nella clausola `ON` sia nella clausola `WHERE` senza modificare il risultato finale.

**MySQL internamente ottimizza la query**, quindi non c’è differenza significativa in termini di performance rispetto al mettere la condizione nel `WHERE`.

La differenza diventa rilevante solo con le `OUTER JOIN`, dove spostare una condizione da `ON` a `WHERE` può cambiare il numero di righe restituite.

**Esempio**:

Vogliamo elencare tutti gli studenti, includendo anche quelli che non si sono iscritti ad alcun corso, ma mostrando solo le iscrizioni a partire dal 1° marzo 2025.

**Condizione nella clausola** `ON`:

```sql
SELECT s.nome, s.cognome, i.data_isc
FROM studenti s
LEFT JOIN iscrizioni i
ON s.id = i.studente_id
AND i.data_isc >= '2025-03-01';
```

*In questo caso*:

- vengono restituiti tutti gli studenti;

- per gli studenti senza iscrizioni, i campi della tabella iscrizioni saranno `NULL`;

- per gli studenti iscritti prima del 1° marzo 2025, l’iscrizione non viene associata, ma lo studente compare comunque nel risultato.

**Condizione nella clausola** `WHERE`:

```sql
SELECT s.nome, s.cognome, i.data_isc
FROM studenti s
LEFT JOIN iscrizioni i
ON s.id = i.studente_id
WHERE i.data_isc >= '2025-03-01';
```

*In questo caso*:

- il filtro nel WHERE elimina tutte le righe in cui *data_isc* è `NULL`;

- di fatto la `LEFT JOIN` si comporta come una `INNER JOIN`;

- gli studenti senza iscrizioni vengono esclusi dal risultato.

Conclusione:

nelle `OUTER JOIN`, le condizioni che riguardano la tabella “esterna” devono essere valutate attentamente;

una condizione nel `WHERE` può annullare l’effetto della `LEFT` o `RIGHT JOIN`;

quando si vuole preservare le righe senza corrispondenza, le condizioni vanno inserite nella clausola `ON`.

> Le *non equi-join* sono utili ogni volta che la relazione tra le tabelle non è basata su uguaglianza diretta, ma su **intervalli**, **range**, o altre condizioni logiche.