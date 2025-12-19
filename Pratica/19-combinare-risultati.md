## Combinare risultati: UNION, INTERSECT e EXCEPT

Le operazioni `UNION`, `INTERSECT` e `EXCEPT` combinano insiemi di risultati provenienti da due o più query separate.

- `UNION` unisce righe di più query in un unico risultato.

- `INTERSECT` restituisce solo le righe comuni tra query.

- `EXCEPT` restituisce solo le righe della prima query non presenti nella seconda.

ATTENZIONE: MySQL supporta gli operatori `INTERSECT` ed `EXCEPT` a partire da MySQL 8.0.31.

UNION è supportato da tutte le versioni recenti.

---

### UNION

L'operatore `UNION` consente di combinare due o più set di risultati da più tabelle in un singolo set di risultati.

La sintassi è la seguente:

```sql
SELECT column1, column2 FROM table1
UNION [DISTINCT | ALL]
SELECT column1, column2 FROM table2
UNION [DISTINCT | ALL]
SELECT column1, column2 FROM table3;
```

Affinché una `UNION` funzioni correttamente è necessario che:

- il numero delle colonne selezionate sia uguale in ciascuna delle query

- i tipi di dato delle colonne siano compatibili e nello stesso ordine

Per impostazione predefinita, l'operatore `UNION` elimina le righe duplicate dal risultato anche se non si utilizza esplicitamente l'operatore `DISTINCT`.

Pertanto, si dice che la clausola `UNION` è la scorciatoia di `UNION DISTINCT`.

Se si utilizza `UNION ALL` esplicitamente, le righe duplicate, se presenti, vengono mostrate.

`UNION ALL` si esegue più velocemente di `UNION DISTINCT`.

---

**Esempo**:

```sql
SELECT stato, capitale FROM europa
UNION
SELECT stato, capitale FROM africa
UNION
SELECT stato, capitale FROM americhe
ORDER BY stato;
```

`ORDER BY` è sempre meglio usarlo alla fine per ordinare il result set complessivo, perché altrimenti potrebbe essere ignorato o risultare inutile.

**Altro esempio**:

```sql
SELECT *, 'parente' FROM parenti
UNION ALL
SELECT *, 'amico' FROM amici
ORDER BY cognome, nome;
```

Consideriamo le possibili generazioni di appartenenza degli studenti:

- Generazione X (dal 1965 al 1980)

- Millenials (dal 1981 al 1996)

- Generazione Z (dal 1997 al 2012)

Scriviamo una query che ci mostri per ogni studente la generazione di appartenenza e con l'operatore `UNION` creiamo un unico result set:

```sql
SELECT cognome, data_nascita, 'X' AS Generazione
FROM studenti
WHERE data_nascita <= '1980-12-31'

UNION ALL

SELECT cognome, data_nascita, 'Millenials'
FROM studenti
WHERE data_nascita BETWEEN '1981-01-01' AND '1996-12-31'

UNION ALL

SELECT cognome, data_nascita, 'Z'
FROM studenti
WHERE data_nascita >= '1997-01-01'

ORDER BY data_nascita;
```

L’intestazione di ciascuna colonna nel result set finale viene presa dalla prima query.

Se nella prima query viene usato un *alias*, questo diventa il nome della colonna per tutto il result set.

Se nella prima query non viene usato un alias, l’intestazione sarà generica (tipicamente il nome del campo o un nome derivato dall’espressione).

Gli *alias* nelle query successive non influenzano l’intestazione finale; contano solo i valori.

- L’alias `Generazione` nella prima `SELECT` definisce l’intestazione della terza colonna per tutto il result set.

- Le righe delle `SELECT` successive ereditano questo nome di colonna senza bisogno di ridefinire l’alias.

Regola pratica: mettere sempre l'alias nella prima query quando si usa un valore calcolato o costante, così l’intestazione del result set sarà chiara e consistente.

---

### INTERSECT
La query restituisce solo i valori comuni alle due tabelle:

```sql
SELECT nome, cognome FROM amici
INTERSECT
SELECT nome, cognome FROM parenti;
```

---

### EXCEPT
La query restituisce i valori della prima tabella che non sono presenti nella seconda:

```sql
SELECT nome, cognome FROM amici
EXCEPT
SELECT nome, cognome FROM parenti;
```

Per impostazione predefinita, `INTERSECT` e `EXCEPT` eliminano le righe duplicate dal risultato anche se non si utilizza esplicitamente `DISTINCT`.

Se si utilizza `INTERSECT ALL` o `EXCEPT ALL`, le righe duplicate, se presenti, vengono mostrate.

`INTERSECT ALL` e `EXCEPT ALL` si eseguono più velocemente di `INTERSECT [DISTINCT]` e `EXCEPT [DISTINCT]`.

Nota: anche per `INTERSECT` e `EXCEPT` è consigliabile usare `ORDER BY` alla fine per ordinare il result set complessivo, perché ordinare singole query prima della combinazione potrebbe essere ignorato o inutile.

---

**Sintassi alternativa con TABLE**:

```sql
TABLE europa
UNION ALL
SELECT id, stato, capitale FROM africa
UNION ALL
TABLE americhe
ORDER BY stato;
```

(Al posto della `SELECT` si può usare anche l'istruzione `TABLE` o un mix di `TABLE` e `SELECT`.)

Per la sintassi completa vedere la documentazione:

https://dev.mysql.com/doc/refman/8.4/en/set-operations.html