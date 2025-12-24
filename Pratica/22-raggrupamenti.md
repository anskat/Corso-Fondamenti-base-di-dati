## Raggruppamenti

Selezionare Valori Unici con `DISTINCT` in MySQL

Per visualizzare i risultati senza ripetizioni, possiamo usare l'istruzione `DISTINCT`.

---

### DISTINCT su una singola colonna

Se vogliamo ottenere un elenco di valori unici per una sola colonna, possiamo usare:

```sql
SELECT DISTINCT cognome
FROM studenti;
```

In questo caso verranno eliminate le righe duplicate in base al valore della colonna cognome.

Se due studenti hanno lo stesso cognome, questo comparirà una sola volta nel risultato.

### DISTINCT su più colonne

Quando si usa DISTINCT su più colonne, la funzione si applica all'intera combinazione dei valori.

Esempio:

```sql
SELECT DISTINCT cognome, nome
FROM studenti
ORDER BY cognome;
```

In questo caso, verranno eliminate solo le righe in cui sia cognome sia nome sono identici.

Se due studenti hanno lo stesso nome ma cognomi diversi, entrambe le righe saranno mantenute nel risultato.

### Utilizzo di WHERE con DISTINCT

Possiamo combinare `DISTINCT` con la clausola `WHERE` per filtrare i dati prima di rimuovere i duplicati:

```sql
SELECT DISTINCT cognome
FROM studenti
WHERE cognome LIKE 'V%'
ORDER BY cognome;
```

Questa query seleziona solo i cognomi che iniziano con la lettera “V”, elimina i duplicati e ordina il risultato in ordine alfabetico.

---

### GROUP BY

La clausola `GROUP BY` è un elemento opzionale che può essere utilizzato all’interno di una `SELECT`.

Il suo scopo è quello di raggruppare i dati in base ai valori di una o più colonne.

Se vogliamo raggruppare i record della tabella *studenti* in base al cognome, possiamo scrivere:

```sql
SELECT cognome
FROM studenti
GROUP BY cognome;
```

In questo caso il risultato è equivalente a una query con `DISTINCT`:

```sql
SELECT DISTINCT cognome
FROM studenti;
```

Entrambe le query restituiscono un elenco di cognomi univoci.

Tuttavia, `GROUP BY` viene tipicamente utilizzato in combinazione con funzioni di aggregazione:
- COUNT()
- SUM()
- AVG(), ecc. 

mentre `DISTINCT` serve solo per rimuovere duplicati.

#### Raggruppare i risultati di funzioni aggregate

Le potenzialità di GROUP BY emergono quando viene utilizzato insieme a funzioni di aggregazione quali

- COUNT()
- AVG()
- MAX()
- MIN()
- SUM()

**Per contare il numero di studenti raggruppati per genere**:

```sql
SELECT genere, COUNT(*) AS numero
FROM studenti
GROUP BY genere;
```

**Per contare il numero di corsi raggruppati per docente**:

```sql
SELECT cognome, nome, COUNT(*) AS quanti
FROM docenti d
JOIN corsi c
ON c.docente_id = d.id
GROUP BY d.id
ORDER BY quanti DESC;
```

**Per conoscere l’età media degli studenti raggruppati per genere**:

```sql
SELECT
    genere,
    FLOOR(AVG(TIMESTAMPDIFF(YEAR, data_nascita, CURDATE()))) AS età media
FROM studenti
GROUP BY genere;
```

**Per conoscere il valore complessivo dei corsi raggruppati per docente**:

```sql
SELECT
    cognome,
    nome,
    SUM(prezzo) AS valore
FROM docenti d
JOIN corsi c
ON d.id = c.docente_id
GROUP BY d.id
ORDER BY valore;
```

Per conoscere, per ciascuno studente:

- la spesa media per i corsi;

- il numero di corsi a cui è iscritto;

- la spesa totale;

- il costo minimo e massimo dei corsi frequentati;

```sql
SELECT
    cognome,
    nome,
    ROUND(AVG(i.prezzo), 2) AS Spesa media,
    COUNT(*) AS Iscrizioni,
    SUM(i.prezzo) AS Totale speso,
    MIN(i.prezzo) AS Minimo speso,
    MAX(i.prezzo) AS Massimo speso
FROM studenti s
JOIN iscrizioni i
ON s.id = i.studente_id
GROUP BY s.id;
```

---

### HAVING

`HAVING` viene utilizzato per filtrare i risultati dopo il raggruppamento.

```sql
SELECT
    cognome,
    nome,
    COUNT(*) AS quanti
FROM docenti d
JOIN corsi c
ON c.docente_id = d.id
GROUP BY d.id
HAVING quanti > 1
ORDER BY quanti DESC;
```
> Nota: MySQL consente l’uso degli alias in HAVING

```sql
SELECT cognome, COUNT(cognome) AS numero
FROM studenti
GROUP BY cognome
HAVING numero > 1
ORDER BY cognome;
```

Mediante questa query filtriamo il result set mostrando solo i cognomi che compaiono più di una volta nella tabella.

```sql
SELECT provincia, genere, COUNT(*) AS numero
FROM studenti
GROUP BY provincia, genere
HAVING numero > 1
ORDER BY provincia, genere;
```

Mediante questa query raggruppiamo gli studenti per provincia e genere, contandone il numero;

la clausola `HAVING` filtra ulteriormente i gruppi considerando solo quelli con più di un elemento.

```sql
SELECT provincia, genere, COUNT(cognome) AS numero
FROM studenti
WHERE provincia != 'to'
GROUP BY provincia, genere
HAVING numero > 1
ORDER BY provincia;
```

`WHERE` può essere usato per ridurre il set di righe prima del `GROUP BY`.

`HAVING` viene utilizzato per filtrare i risultati aggregati.

```sql
SELECT
    provincia,
    genere,
    FLOOR(AVG(TIMESTAMPDIFF(YEAR, data_nascita, CURDATE()))) AS età media,
    COUNT(*) AS numero
FROM studenti
GROUP BY provincia, genere
HAVING numero > 1
ORDER BY provincia, genere;
```
---

### GROUP BY … WITH ROLLUP - estensione non standard SQL (specifica MySQL)

```sql
SELECT
    provincia,
    COUNT(*) AS numero
FROM studenti
GROUP BY provincia WITH ROLLUP;
```

Questa query conta gli studenti divisi per provincia.

Con l’aggiunta di `WITH ROLLUP` viene prodotta una riga aggiuntiva con il totale complessivo.

```sql
SELECT provincia, genere, COUNT(*) AS numero
FROM studenti
GROUP BY provincia, genere WITH ROLLUP;
```

In questo caso vengono prodotti anche i subtotali per provincia e il totale generale.

#### GROUP BY … WITH ROLLUP e GROUPING

Con `WITH ROLLUP` vengono generate righe di superaggregazione in cui i campi assumono valore NULL.

Per distinguere le righe di dettaglio da quelle di totale possiamo usare la funzione `GROUPING()`.

```sql
SELECT
    provincia,
    COUNT(*) AS numero,
    GROUPING(provincia)
FROM studenti
GROUP BY provincia WITH ROLLUP;
```

`GROUPING` restituisce **0** *per le righe regolari* e **1** *per le righe di superaggregazione*.

Possiamo quindi usare la funzione `IF()` per assegnare un’etichetta leggibile al totale:

```sql
SELECT
    IF(GROUPING(provincia), 'tutte le province', provincia) AS provincia,
    COUNT(*) AS numero
FROM studenti
GROUP BY provincia WITH ROLLUP;
```

```sql
SELECT
    provincia,
    genere,
    COUNT(*) AS numero,
    GROUPING(provincia),
    GROUPING(genere)
FROM studenti
GROUP BY provincia, genere WITH ROLLUP;
```

```sql
SELECT
    IF(GROUPING(provincia), 'tutte', provincia) AS provincia,
    IF(GROUPING(genere), 'totale generi', genere) AS genere,
    COUNT(*) AS numero
FROM studenti
GROUP BY provincia, genere WITH ROLLUP;
```