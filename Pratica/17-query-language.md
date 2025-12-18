## Query Language

**Interrogazione dei dati**

Le query indicate di seguito fanno riferimento alla tabella *studenti* il cui codice è presente nella sezione [DDL](../Pratica/15-ddl-seconda-parte.md),
i record sono allegati come file .sql nella sezione [Database](../Database/studenti_record.sql)

### SELECT

Mostrare i record di una tabella

`SELECT ... FROM`

È possibile visualizzare i record di una tabella utilizzando l’istruzione `SELECT`.

Per visualizzare tutti i record di una tabella si utilizza il carattere jolly `*`.

È necessario utilizzare anche l’istruzione `FROM` per identificare la tabella da interrogare:

```sql
SELECT * FROM tableName;
```

Nella pratica, **si visualizzano quasi sempre campi specifici**, piuttosto che l’intera tabella, **per migliorare leggibilità ed efficienza**.

Dopo l’istruzione `SELECT` si elencano i campi di interesse, separati da una virgola:

```sql
SELECT fieldName, fieldName2, fieldName3 FROM tableName;
```

---

### ORDER BY

Consente di ordinare i risultati di una query.

L’istruzione `ORDER BY` è seguita dal campo (o dai campi) su cui si basa l’ordinamento.

L’ordine predefinito è crescente: `ASC`.

```sql
SELECT *
FROM studenti
ORDER BY cognome;
```

Utilizzando la parola chiave `DESC` si ottiene un ordinamento decrescente:

```sql
SELECT *
FROM studenti
ORDER BY cognome DESC;
```

È possibile ordinare su più campi, specificando per ciascuno il tipo di ordinamento:

```sql
SELECT *
FROM studenti
ORDER BY cognome DESC, eta ASC;
```

---

### LIMIT

Consente di limitare il numero massimo di record restituiti da una query.

Accetta due argomenti:

- offset (opzionale): indica da quale riga iniziare

- row_count: indica il numero di record da visualizzare

Sintassi generale:

```sql
SELECT *
FROM tableName
ORDER BY field
LIMIT {[offset,] row_count | row_count OFFSET offset};
```

La query seguente mostra *i primi 10 record* della tabella studenti:

```sql
SELECT *
FROM studenti
ORDER BY cognome
LIMIT 10;
```

La query seguente *mostra 10 record a partire dall’undicesimo*.

Ricordate che l’indice parte da 0, quindi l’undicesimo record ha indice 10:

```sql
SELECT *
FROM studenti
ORDER BY cognome
LIMIT 10 , 10;
```

Forma alternativa, spesso più leggibile:

```sql
LIMIT 10 OFFSET 10;
```

---

### WHERE

**SELECT e WHERE**

L’istruzione `WHERE` consente di filtrare i risultati di una query, mostrando **solo i record che soddisfano una determinata condizione**.

Esempio, selezionare nome e cognome degli studenti di genere maschile:

```sql
SELECT nome, cognome
FROM studenti
WHERE genere = 'm';
```

---

### Operatori

Gli operatori vengono utilizzati nella clausola WHERE per filtrare le righe di una tabella in base a criteri specifici.

Esistono diversi tipi di operatori, a seconda del tipo di confronto o condizione che si vuole applicare.

#### Operatori di confronto

=, <>, !=, >, >=, <, <=

| Operatore	| Descrizione             |
| -----     | -------                 |
| =	        | Equal                   |
| <>	    | Not Equal               |
| !=	    | Not Equal               |
| >	        | Greater Than            |
| >=	    |  Greater Than or Equal  |
| <	        | Less Than               |
| <=	    | Less Than or Equal      |

Esempi:

```sql
SELECT nome, cognome, email, data_nascita
FROM studenti
WHERE genere = 'f'
ORDER BY cognome, nome;
```

```sql
SELECT nome, cognome, email, data_nascita
FROM studenti
WHERE citta <> 'torino'
ORDER BY cognome, nome;
```

```sql
SELECT nome, cognome, email, data_nascita
FROM studenti
WHERE data_nascita >= '1989-12-31'
ORDER BY data_nascita;
```

---

#### Operatori logici

*AND, OR, NOT*

**AND**

Quando si utilizza l’operatore `AND`, tutte le condizioni devono essere vere:

```sql
SELECT nome, cognome, email, data_nascita
FROM studenti
WHERE genere = 'm' AND provincia = 'to';
```

Vengono selezionati gli studenti maschi provenienti dalla provincia di Torino.

**OR**

Quando si utilizza l’operatore `OR`, è sufficiente che almeno una condizione sia vera:

```sql
SELECT nome, cognome, email, data_nascita
FROM studenti
WHERE genere = 'm' OR provincia = 'to';
```

Vengono selezionati:

- tutti gli studenti maschi

- tutti gli studenti provenienti dalla provincia di Torino
(inclusi eventuali studenti di genere femminile).

**Precedenza degli operatori**

L’operatore `AND` ha precedenza su `OR`.

Per evitare ambiguità è consigliabile utilizzare le parentesi.

Esempio potenzialmente ambiguo:

```sql
SELECT * FROM studenti
WHERE cognome = 'verdi' OR cognome = 'rossi'
AND provincia = 'to';
```
Versione più chiara:

```sql
SELECT * FROM studenti
WHERE cognome = 'verdi'
OR (cognome = 'rossi' AND provincia = 'to');
```

Esempio con più condizioni:

```sql
SELECT *
FROM studenti
WHERE (cognome = 'verdi' OR cognome = 'rossi')
AND (provincia = 'to' OR provincia = 'al');
```

**NOT**

L’operatore `NOT` nega una o più condizioni.

Esempio, studenti il cui genere non è m:

```sql
SELECT nome, cognome, email, data_nascita
FROM studenti
WHERE NOT genere = 'm';
```

Studenti il cui genere non è m e la provincia è to:

```sql
SELECT nome, cognome, email, data_nascita
FROM studenti
WHERE NOT genere = 'm' AND provincia = 'to';
```

Studenti il cui genere non è m e la provincia non è to:

```sql
SELECT nome, cognome, email, data_nascita
FROM studenti
WHERE NOT genere = 'm' AND NOT provincia = 'to';
```

In generale, per migliorare la leggibilità, è spesso preferibile usare gli operatori `<>` o `!=` al posto di `NOT`, soprattutto in condizioni complesse.

---

### Operatori di confronto avanzati

**IN, NOT IN**

L’operatore `IN` consente di selezionare i record il cui valore di un campo appartiene a un insieme di valori specificati.

Lo stesso risultato potrebbe essere ottenuto usando più operatori `OR`, ma l’uso di `IN` rende la query più leggibile e manutenibile, soprattutto quando i valori da confrontare sono numerosi.

Esempio, selezionare gli studenti che appartengono a determinate province:

```sql
SELECT nome, cognome, email, data_nascita, provincia
FROM studenti
WHERE provincia IN ('TO','CN','AT','NO');
```

L’operatore `NOT IN` funziona in modo analogo a `IN`, ma seleziona i record il cui valore **NON** appartiene all’insieme specificato.

La seguente query mostrerà tutti gli studenti che non appartengono alle province indicate:

```sql
SELECT nome, cognome, email, data_nascita, provincia
FROM studenti
WHERE provincia NOT IN ('TO','CN','AT','NO');
```

Attenzione!!!

`NOT IN` **non** restituisce i record con valore `NULL` nel campo confrontato.

Se si vogliono includere anche i record con valore NULL, è necessario aggiungere una condizione esplicita, ad esempio:

```sql
WHERE provincia NOT IN ('to','cn','at','no') OR provincia IS NULL;
```

---

**BETWEEN, NOT BETWEEN**

L’operatore `BETWEEN` consente di selezionare i record i cui valori rientrano in un intervallo compreso tra due estremi.

- I valori di inizio e fine sono inclusi

- L’intervallo può riguardare numeri, stringhe o date

Esempio con date:

```sql
SELECT nome, cognome, email, data_nascita
FROM studenti
WHERE data_nascita BETWEEN '1985-01-01' AND '1994-12-31';
```

L’operatore `NOT BETWEEN` seleziona invece i valori al di fuori dell’intervallo indicato.

Attenzione!!!
Come `NOT IN`, anche `NOT BETWEEN` non considera i valori `NULL`.

---

**IS NULL e IS NOT NULL**

L’operatore `IS NULL` viene utilizzato per selezionare i record che non hanno alcun valore assegnato in un determinato campo.

Viceversa, `IS NOT NULL` seleziona i record che presentano un valore nel campo specificato.

Esempio:

```sql
SELECT nome, cognome, email, data_nascita
FROM studenti
WHERE data_nascita IS NULL;
```

Questi operatori sono particolarmente utili per:

- individuare record incompleti

- trovare dati mancanti

- identificare informazioni che devono essere aggiornate o integrate

---

**LIKE, NOT LIKE**

L’operatore `LIKE` consente di effettuare ricerche testuali basate su pattern matching.

L’operatore `NOT LIKE` *seleziona i record che non corrispondono* al pattern indicato.

ATTENZIONE!!!
`NOT LIKE` non restituisce i valori `NULL`.

Se si vogliono includere anche i record con valore `NULL`, è necessario aggiungere una condizione esplicita con `IS NULL`.

Esempi di utilizzo:

```sql
SELECT * FROM studenti WHERE cognome LIKE 'v%';
SELECT * FROM studenti WHERE nome LIKE '%a';
SELECT * FROM studenti WHERE indirizzo LIKE 'via %';
SELECT * FROM studenti WHERE email LIKE '%gmail.com';
SELECT * FROM studenti WHERE nome LIKE 'paol_';
SELECT * FROM studenti WHERE nome LIKE '_a%';
```

La differenza tra i pattern è data dalla posizione dei caratteri jolly:

- il simbolo `%` indica zero o più caratteri

- il simbolo `_` indica esattamente un carattere

Ad esempio:

- 'v%' → tutte le stringhe che iniziano per v

- '%a' → tutte le stringhe che terminano per a

- 'paol_' → stringhe di 5 caratteri che iniziano per paol

Nota sulle prestazioni

Le ricerche che iniziano con un carattere jolly ('%test') sono le meno performanti, perché impediscono l’uso degli indici.

È consigliabile non abusare dei caratteri jolly, soprattutto in tabelle di grandi dimensioni.

Sensibilità a maiuscole/minuscole

Il comportamento di `LIKE` rispetto a maiuscole e minuscole dipende dalla collation del campo:

- collations *_ci → case insensitive

- collations *_cs → case sensitive

i criteri di ricerca che iniziano con caratteri jolly sono quelli con i tempi di elaborazione più lunghi.

| Wildcard	         | Descrizione                                     |
| ----               | ----                                            |
| %	                 | sostituisce zero o più caratteri                |
| _         	     | sostituisce un singolo carattere                |
| stringhe letterali più Wildcard | pattern di caratteri da trovare usando % e _  |