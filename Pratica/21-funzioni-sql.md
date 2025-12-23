## Funzioni SQL

Oltre a selezionare, filtrare e combinare dati, SQL mette a disposizione delle funzioni che permettono di elaborare i valori contenuti nelle tabelle.

Le funzioni SQL servono per:

- calcolare valori derivati dai dati (conteggi, somme, medie, ecc.);
- riassumere informazioni (ad esempio il numero di righe o il valore massimo);
- trasformare i dati (date, stringhe, numeri);
- rendere le query più espressive e potenti.

Le funzioni possono essere usate all’interno di una `SELECT`, spesso in combinazione con `WHERE`, `JOIN` e `GROUP BY`.

---

### Funzioni di aggregazione

Possiamo eseguire calcoli su un’intera colonna utilizzando le funzioni di aggregazione di SQL.

Questo ci permette di analizzare i dati nel loro insieme e ottenere calcoli come la media, il numero di valori, la somma totale dei valori e altro ancora.

#### AVG()

La funzione `AVG()` restituisce il valore medio (media) dell’intero set di dati.

`AVG()` non considera i valori **NULL**.

Sintassi:
```sql
SELECT AVG(campo)
FROM tabella;
```

Esempio:

```sql
SELECT AVG(prezzo) AS 'prezzo medio'
FROM corsi;
```

#### COUNT()

La funzione `COUNT()` restituisce il numero di record trovati.

`COUNT(*)` considera anche i record che contengono valori **NULL**.

`COUNT(colonna)` conta solo i record in cui la colonna specificata **NON è NULL**.

Sintassi:

```sql
SELECT COUNT(*)
FROM tabella;
```

Possiamo anche filtrare il conteggio: vengono contati solo i record che soddisfano la condizione indicata.

```sql
SELECT COUNT(*)
FROM tabella
WHERE condizione;
```

Esempio: contare il numero delle studentesse:

```sql
SELECT COUNT(*)
FROM studenti
WHERE genere = 'f';
```

Esempio: contare il numero di studenti a cui non è stato assegnato un valore per l’attributo *genere*:

```sql
SELECT COUNT(*)
FROM studenti
WHERE genere IS NULL;
```

#### MAX() e MIN()

Le funzioni `MAX()` e `MIN()` restituiscono rispettivamente il valore più alto e il valore più basso del campo indicato nella query.

`MAX()` e `MIN()` non considerano i valori NULL.

Sintassi:

```sql
SELECT MAX(campo), MIN(campo)
FROM tabella;
```

Esempio:

```sql
SELECT
    MAX(prezzo) AS 'più caro',
    MIN(prezzo) AS 'più economico'
FROM corsi;
```

#### SUM()

La funzione `SUM()` restituisce la somma dei valori di un dato campo numerico.

`SUM()` non considera i valori NULL.

Sintassi:

```sql
SELECT SUM(campo)
FROM tabella;
```

Esempio:

```sql
SELECT SUM(prezzo) AS 'valore corsi'
FROM corsi;
```

---

### Funzioni matematiche

#### FLOOR() e CEILING()

Le funzioni **FLOOR()** e **CEILING()** arrotondano i numeri decimali rispettivamente verso l’intero più basso e verso l’intero più alto.

- `FLOOR()` restituisce il più grande intero minore o uguale al valore dato.

- `CEILING()` restituisce il più piccolo intero maggiore o uguale al valore dato.

Sintassi generale:

```sql
SELECT FLOOR(campo), CEILING(campo)
FROM tabella;
```

Esempio:

```sql
SELECT FLOOR(prezzo), CEILING(prezzo)
FROM libri;
```

#### ROUND()

La funzione `ROUND()` esegue l’arrotondamento matematico del valore.

Accetta un secondo argomento che indica il numero di cifre decimali da mantenere dopo la virgola.

Sintassi:

```sql
SELECT ROUND(campo)
FROM tabella;
```

Esempio:


```sql
SELECT ROUND(prezzo, 2)
FROM libri;
```

---

### Funzioni sulle stringhe: 

### LENGTH() e CHAR_LENGTH()

`CHAR_LENGTH()` restituisce il numero di caratteri (visibili), inclusi gli spazi.

`LENGTH()` restituisce il numero di byte occupati dalla stringa.

- Il valore può differire da CHAR_LENGTH() in presenza di caratteri multibyte, come lettere accentate, caratteri Unicode, emoji o alfabeti non latini.

- Con stringhe composte esclusivamente da caratteri ASCII (ad esempio lettere inglesi non accentate), le due funzioni restituiscono lo stesso risultato.

Esempio:

```sql
SELECT
    nome,
    CHAR_LENGTH(nome) AS Numero caratteri,
    LENGTH(nome) AS Numero byte
FROM studenti;
```

#### CONCAT() e CONCAT_WS()

- `CONCAT()` unisce due o più stringhe in una sola, senza inserire separatori.

- `CONCAT_WS(separatore, str1, str2, ...)` concatena le stringhe inserendo automaticamente il separatore indicato

(WS = With Separator).

Esempio:

```sql
-- Concatena nome e cognome inserendo manualmente uno spazio
SELECT CONCAT(nome, ' ', cognome) AS Nome completo
FROM studenti;
```

```sql
-- CONCAT_WS evita di scrivere manualmente il separatore
SELECT CONCAT_WS(' ', nome, cognome) AS Nome completo
FROM studenti;
```

> Nota:
> `CONCAT_WS()` ignora automaticamente i valori NULL, mentre `CONCAT()` restituisce NULL se uno degli argomenti è NULL.

#### SUBSTRING()

La funzione `SUBSTRING()` estrae una porzione di stringa.

Sintassi:

```sql
SUBSTRING(str, pos, len)
```

oppure

```sql
SUBSTRING(str FROM pos FOR len)
```

Se non si specifica *len*, vengono restituiti tutti i caratteri a partire dalla posizione indicata.

Esempio su valore letterale:

```sql
SELECT SUBSTRING('Alessandro', 2, 3);
-- les
```
Esempio su colonna della tabella *studenti*:

```sql
SELECT nome, SUBSTRING(nome, 2, 3)
FROM studenti;
```

Nota: l’indice delle stringhe in SQL parte da 1, non da 0.

#### LEFT() e RIGHT()

Le funzioni `LEFT()` e `RIGHT()` restituiscono un numero specifico di caratteri a partire rispettivamente da sinistra o da destra della stringa.

Esempi:

```sql
SELECT nome, LEFT(nome, 1)
FROM studenti;
```

```sql
SELECT CONCAT(LEFT(nome, 1), '.', cognome)
FROM studenti;
```

#### Aggiornamento / sostituzione di testo REPLACE()

Per aggiornare o sostituire parte del contenuto di un campo in una tabella, possiamo utilizzare la funzione REPLACE().

Esempio di aggiornamento:

```sql
UPDATE studenti
SET email = REPLACE(email, '.com', '.it');
```

- Il primo argomento è il campo su cui effettuare la ricerca/sostituzione.

- Il secondo argomento è la stringa da sostituire (racchiusa tra apici).

- Il terzo argomento è la nuova stringa da inserire (racchiusa tra apici).

Possiamo usare REPLACE() anche in lettura, senza aggiornare i dati nella tabella:

```sql
SELECT email, REPLACE(email, '.com', '.it') AS email_modificata
FROM studenti;
```

> Nota:
> REPLACE() è case sensitive, cioè distingue tra maiuscole e minuscole: "Testo" ≠ "testo".

---

#### Uso di funzioni combinate

È possibile combinare più funzioni in una singola query per ottenere calcoli più complessi.

Esempio 1: **lunghezza media della stringa “nome + cognome”**

```sql
SELECT AVG(CHAR_LENGTH(nome) + CHAR_LENGTH(cognome))
FROM studenti;
```

Esempio 2: stessa operazione usando CONCAT()

```sql
SELECT AVG(CHAR_LENGTH(CONCAT(nome, cognome)))
FROM studenti;
```

Esempio 3: arrotondare il risultato medio a interi

```sql
SELECT FLOOR(AVG(CHAR_LENGTH(CONCAT(nome, cognome))))
FROM studenti;
```

```sql
SELECT CEILING(AVG(CHAR_LENGTH(CONCAT(nome, cognome))))
FROM studenti;
```

---

### Funzioni informative

#### LAST_INSERT_ID()

`LAST_INSERT_ID()` restituisce un valore BIGINT UNSIGNED che rappresenta l’ultimo valore generato automaticamente per una colonna AUTO_INCREMENT come risultato della ultima istruzione INSERT riuscita.

- Se nessuna riga viene inserita correttamente, il valore rimane invariato.

- Se si inseriscono più righe contemporaneamente, viene restituito il primo ID del gruppo.

Esempio:

```sql
INSERT INTO studenti(cognome, nome, email)
VALUES ('Rossi', 'Marco', 'marco.rossi@gmail.com');

SELECT LAST_INSERT_ID();
-- 28  -- esempio: valore dell'auto-increment generato
```

Riferimento:

Documentazione MySQL 8.4 – [Funzioni informative](https://dev.mysql.com/doc/refman/8.4/en/information-functions.html)

--- 

### Funzioni data e ora

Per ottenere informazioni temporali attuali in MySQL si possono usare le seguenti funzioni:

 - `NOW()` → restituisce data e ora correnti (tipo DATETIME). Sinonimi: `CURRENT_TIMESTAMP`, `CURRENT_TIMESTAMP()`.

 - `CURDATE()` → restituisce la data corrente (tipo DATE). Sinonimi: `CURRENT_DATE`, `CURRENT_DATE()`.

 - `CURTIME()` → restituisce l’orario corrente (tipo TIME). Sinonimi: `CURRENT_TIME`, `CURRENT_TIME()`.

Una volta ottenute le informazioni di data/ora, possiamo estrarre singoli elementi tramite funzioni dedicate:

**Giorni, mesi, anni**:

 - YEAR(data) → anno

 - MONTH(data) → mese

 - DAY(data) → giorno del mese

**Ore, minuti, secondi**:

 - HOUR(data) → ora

 - MINUTE(data) → minuti

 - SECOND(data) → secondi

**Giorno della settimana e giorno dell’anno**:

 - DAYOFWEEK(data) → numero del giorno della settimana (1 = domenica, 2 = lunedì … 7 = sabato)

 - DAYOFMONTH(data) → giorno del mese

 - DAYOFYEAR(data) → giorno dell’anno

 - WEEKOFYEAR(data) → numero della settimana nell’anno

**Nomi di giorni e mesi**:

 - DAYNAME(data) → nome del giorno della settimana (es. ‘lunedì’)

 - MONTHNAME(data) → nome del mese (es. ‘marzo’)

> Nota: per avere i nomi dei giorni e dei mesi in italiano è necessario impostare la variabile di sessione lc_time_names:

`SET lc_time_names = 'it_IT';`

Per verificare la lingua corrente:

`SELECT @@lc_time_names;`

Esempi:

```sql
SELECT YEAR(CURDATE());
SELECT MONTH(CURDATE());
SELECT DAY(CURDATE());

SELECT HOUR(CURTIME());
SELECT MINUTE(CURTIME());
SELECT SECOND(CURTIME());

SELECT DAYOFWEEK(CURDATE()); -- 1 = domenica, 2 = lunedì, ...
SELECT DAYOFMONTH(CURDATE());
SELECT DAYOFYEAR(CURDATE());
SELECT WEEKOFYEAR(CURDATE());

SELECT DAYNAME(CURDATE());
SELECT MONTHNAME(CURDATE());
```

Per avere i nomi in lingua bisogna impostare la lingua italiana (potreste non avere i privilegi):

```sql
SET lc_time_names = 'it_IT';
```

[Documentazione ufficiale](https://dev.mysql.com/doc/refman/8.4/en/locale-support.html)

Per conoscere la lingua utilizzata:

```sql
SELECT @@lc_time_names;
```

> Nota: `DAYOFWEEK()` restituisce sempre un numero secondo lo standard MySQL, indipendentemente dalla lingua impostata.
I nomi dei giorni e dei mesi invece dipendono dalla variabile *lc_time_names*.

---

### Formattare date e orari

#### DATE_FORMAT() e TIME_FORMAT()

La funzione `DATE_FORMAT()` permette di personalizzare il formato di una data usando appositi meta-caratteri:

| METACARATTERE	| DESCRIZIONE                                |
| ----      	| ----                                       |
| %d            | giorno del mese (01-31)                    |
| %D            | numerale ordinale del giorno (1st, 2nd…)   |
| %m            | mese in numero (01-12)                     |
| %M            | mese in lettere (gennaio, febbraio…)       |
| %y            | anno su due cifre (es. 21)                 |
| %Y            | anno su quattro cifre (es. 2021)           |
| %H            | ore (00-23)                                |
| %h            | ore (01-12)                                |
| %i            | minuti                                     |
| %s / %S       | secondi                                    |
| %p            | AM o PM                                    |

> Nota:
i meta-caratteri si applicano anche ad altre funzioni come STR_TO_DATE(), TIME_FORMAT(), UNIX_TIMESTAMP().
Elenco completo: https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_date-format

Esempi con DATE_FORMAT() e TIME_FORMAT():

```sql
SELECT DATE_FORMAT('2017-02-28','%d/%m/%Y'); -- 28/02/2017
SELECT DATE_FORMAT('2017-02-28','%d/%m/%y'); -- 28/02/17
SELECT DATE_FORMAT('2017-02-28','%d %M %Y'); -- 28 Febbraio 2017

SELECT TIME_FORMAT('17:25:34','%H-%i'); -- 17-25
SELECT TIME_FORMAT('17:25:34','%h:%i %p'); -- 05:25 PM
SELECT TIME_FORMAT(CURTIME(),'sono le %H e %i minuti') AS 'che ore sono?'; -- sono le 18 e 58 minuti
```

Se interrogate una tabella, la formattazione può essere applicata direttamente ai campi:

```sql
SELECT nome, cognome, DATE_FORMAT(data_nascita,'%d %M %Y') 
FROM studenti;
```

> Nota: il formato data va messo tra apici, quindi potete inserire anche del testo libero, come nell’esempio con TIME_FORMAT().

#### STR_TO_DATE(str, format)

`STR_TO_DATE()` prende una stringa (str, es. '01-01-2001') e un formato (format, es. '%d-%m-%Y').

- Restituisce un valore di tipo DATETIME se il formato contiene data e ora;

- Restituisce DATE o TIME se il formato contiene solo data o solo ora.

- Se il valore estratto è illegale, STR_TO_DATE() restituisce NULL e genera un warning.

Esempi di conversione:

```sql
INSERT INTO studenti (nome, cognome, email, data_nascita)
VALUES ('Marco','Allegri','marco.allegri@gmail.com', STR_TO_DATE('05,10,1969','%d,%m,%Y'));
```

```sql
INSERT INTO studenti (nome, cognome, email, data_nascita)
VALUES ('Marco','Allegri','marco.allegri@gmail.com', STR_TO_DATE('1 February 2017','%d %M %Y'));
```

```sql
SELECT STR_TO_DATE(CONCAT_WS(',', "05", "10", "1969"), '%d,%m,%Y');
```

> Nota:
`STR_TO_DATE()` è molto utile quando si importano dati esterni che contengono date in formati diversi dallo standard MySQL.

---

### Calcoli con date e orari

#### Per sommare un periodo di tempo a una data o a un orario si possono usare le funzioni `ADDDATE()` e `ADDTIME()`.

```sql
SELECT ADDDATE('2017-03-01', INTERVAL 5 DAY); -- 2017-03-06
SELECT ADDDATE('2017-03-01', 5);              -- 2017-03-06
```

Quando si usa ADDDATE(data, numero), il numero viene interpretato come giorni.

Per specificare mesi, anni o altri intervalli temporali, è necessario usare INTERVAL:

```sql
SELECT ADDDATE('2017-03-01', INTERVAL 5 YEAR); -- 2022-03-01
```

ADDTIME() funziona in modo analogo per ore, minuti e secondi:

```sql
SELECT ADDTIME('17:25','05:05');       -- 22:30:00
SELECT ADDTIME('17:25','00:05:05');    -- 17:30:05
```

**Sottrazione**

#### SUBDATE() / DATE_SUB() per sottrarre giorni da una data:

```sql
SELECT SUBDATE('2015-03-01', INTERVAL 5 DAY); -- 2015-02-24
```

`SUBTIME()` per sottrarre ore/minuti/secondi:

```sql
SELECT SUBTIME(CURTIME(),'03:03');
```

#### DATEDIFF()

Calcola il numero di giorni tra due date.

```sql
SELECT DATEDIFF('2017-03-01','2017-02-10');  -- 19
SELECT DATEDIFF('2017-01-01','2017-02-10');  -- -40
SELECT DATEDIFF(CURDATE(),'2020-04-10');
```

Per calcolare giorni trascorsi da una data in tabella:

```sql
SELECT DATEDIFF(CURDATE(), data) 
FROM nome_tabella
-- WHERE condizioni;
```

#### TIMESTAMPADD(unità, intervallo, espr_datetime)

Aggiunge un intervallo di tempo a una data o datetime.

Unità possibili: MICROSECOND, SECOND, MINUTE, HOUR, DAY, WEEK, MONTH, QUARTER, YEAR.

```sql
SELECT TIMESTAMPADD(MINUTE, 1, '2003-01-02 00:01:00');
SELECT TIMESTAMPADD(WEEK, 1, '2003-01-02');
```

#### TIMESTAMPDIFF(unità, espr1, espr2)

Calcola la differenza tra due date/datetime: espr2 - espr1.

Il risultato è un intero e l’unità di misura è quella specificata.

```sql
SELECT TIMESTAMPDIFF(MONTH, '2003-02-01','2003-05-01'); -- 3
SELECT TIMESTAMPDIFF(YEAR, '2002-05-01','2001-01-01');  -- -1
SELECT TIMESTAMPDIFF(MINUTE, '2003-02-01','2003-05-01 12:05:55');
```

**Calcolare l'età a prtira dalla data di nasicta**

```sql
SELECT
  nome,
  cognome,
  TIMESTAMPDIFF(YEAR, data_nascita, CURDATE()) AS Età
FROM studenti;
```

Esempi di aggiornamento o inserimento con calcolo dell’età:

```sql
UPDATE studenti
SET eta = TIMESTAMPDIFF(YEAR, data_nascita, CURDATE());

INSERT INTO studenti(nome, cognome, genere, data_nascita, email, eta)
VALUES ('Paperina', 'Duck', 'f', '1999-01-01', 'paperina_d@gmail.com',
        TIMESTAMPDIFF(YEAR, data_nascita, CURDATE()));
```

**Giorni al compleanno**

```sql
SELECT
  nome,
  cognome,
  DAYOFYEAR(CURDATE())-DAYOFYEAR(data_nascita) AS Giorni
FROM studenti
ORDER BY Giorni;
```

**Per selezionare solo chi compie gli anni nel prossimo mese**:

```sql
SELECT nome, cognome, data_nascita, DAYOFYEAR(CURDATE())-DAYOFYEAR(data_nascita) AS Giorni
FROM studenti
WHERE (DAYOFYEAR(CURDATE())-DAYOFYEAR(data_nascita)) BETWEEN -31 AND 0;
```

> Nota: in `WHERE` non si può usare l’alias *Giorni*.

```sql
SELECT
  nome,
  cognome,
  (DAYOFYEAR(CURDATE())-DAYOFYEAR(data_nascita)) AS Giorni
FROM studenti
WHERE (DAYOFYEAR(CURDATE())-DAYOFYEAR(data_nascita)) BETWEEN -31 AND 0
ORDER BY Giorni;
```

**HAVING vs WHERE**

- `WHERE` filtra i dati sulle tabelle originali.

- `HAVING` filtra i dati sui risultati della query, incluso l’uso di aggregati e alias.

```sql
SELECT
  nome,
  cognome,
  (DAYOFYEAR(CURDATE())-DAYOFYEAR(data_nascita)) AS Giorni
FROM studenti
HAVING Giorni BETWEEN -31 AND 0
ORDER BY Giorni;
```

HAVING è particolarmente utile per filtrare su valori aggregati o calcolati all’interno della query.

---

### Funzioni JSON in MySQL

MySQL supporta il tipo di dato JSON, che permette di memorizzare oggetti strutturati e array direttamente in una colonna.
Un campo JSON può contenere:

- oggetti { "chiave": "valore" }

- array [val1, val2, ...]

- valori scalari (stringhe, numeri, booleani, null)

Esempio di inserimento di un oggetto JSON in una colonna specifiche:

```sql
INSERT INTO articoli(descrizione, specifiche)
VALUES(
    'TV SAMSUNG 32" SMART TV',
    '{
        "marca": "SAMSUNG",
        "pesoKg": "5.12",
        "schermo": "LCD",
        "pollici": 32,
        "uscite": ["HDMI", "USB"]
    }'
);
```

Funzioni principali

1. JSON_OBJECT()

Crea un oggetto JSON da coppie chiave/valore.

Errore se il numero di argomenti è dispari o una chiave è NULL.

```sql
INSERT INTO articoli(descrizione, specifiche)
VALUES(
    'TV SONY 32" SMART TV',
    JSON_OBJECT("marca","SONY","pesoKg",6.5,"schermo","LED","pollici",32,"uscite","HDMI")
);
```

2. JSON_ARRAY()

Crea un array JSON dai valori forniti, di tipi misti (stringhe, numeri, booleani, null).

```sql
INSERT INTO articoli(descrizione, specifiche)
VALUES(
    'TV PHILIPS 55" SMART TV',
    JSON_OBJECT(
        "marca","PHILIPS",
        "pesoKg",9.5,
        "schermo","LED",
        "pollici",55,
        "uscite", JSON_ARRAY('HDMI','RCA','USB','COAXIAL','SCART')
    )
);
```

3. JSON_EXTRACT()

- Estrae valori da un documento JSON in base a un percorso (path).

- Restituisce NULL se il percorso non esiste o JSON non valido.

- Se più valori corrispondono, vengono restituiti in un array.

```sql
SELECT JSON_EXTRACT(specifiche,'$.uscite')
FROM articoli;
```

-- Alias più breve con ->
```sql
SELECT specifiche -> '$.uscite'
FROM articoli;
```

**Esempio con array annidati**:

```sql
SELECT JSON_EXTRACT('[10, 20, [30, 40]]', '$[2][1]'); -- 40
SELECT JSON_EXTRACT(specifiche,'$.uscite[2]') FROM articoli;
SELECT specifiche -> '$.uscite[2]' FROM articoli;
```

4. JSON_SET()

Sostituisce valori esistenti o aggiunge valori mancanti.

```sql
UPDATE articoli
SET specifiche = JSON_SET(specifiche,
    '$.marca','LG',
    '$.uscite', JSON_ARRAY('HDMI','SCART','S/PDIF'),
    '$.ingressi', JSON_ARRAY('ETHERNET','USB')
)
WHERE id = 1;
```

5. JSON_INSERT()

Inserisce valori solo se il path non esiste. Non sovrascrive valori esistenti.

```sql
UPDATE articoli
SET specifiche = JSON_INSERT(specifiche,'$.uscite[3]','RGB')
WHERE id = 1;
```

6. JSON_REPLACE()

Sostituisce solo valori esistenti, non aggiunge nuovi campi.

```sql
UPDATE articoli
SET specifiche = JSON_REPLACE(specifiche,'$.marca','SAMSUNG')
WHERE id = 1;
```

```sql
UPDATE articoli
SET specifiche = JSON_REPLACE(specifiche,'$.uscite[1]','HDMI2')
WHERE id = 1;
```

7. JSON_REMOVE()

Rimuove proprietà o elementi da un JSON. Se il path non esiste, non produce errore.

```sql
UPDATE articoli
SET specifiche = JSON_REMOVE(specifiche,'$.uscite[1]')
WHERE id = 1;
```

Introduzione a JSON: https://www.json.org/json-it.html

Documentazione ufficiale JSON functions: https://dev.mysql.com/doc/refman/8.0/en/json-function-reference.html

---

Funzioni di controllo di flusso (Control Flow Functions)

Le funzioni di controllo di flusso permettono di restituire valori diversi in base al risultato di una condizione.

1. IF(expr1, expr2, expr3)

expr1: condizione da valutare

expr2: valore restituito se expr1 è vera

expr3: valore restituito se expr1 è falsa

Esempi base:

SELECT IF(1 > 2, 0, 1);   -- restituisce 1
SELECT IF(1 < 2, 'yes', 'no'); -- restituisce 'yes'


Applicazione su tabella studenti:

SELECT cognome,
       IF(provincia = 'to', 'sede', 'fuori sede') AS sede
FROM studenti
ORDER BY sede DESC, cognome;


Gli studenti con provincia 'to' sono considerati “in sede”, gli altri “fuori sede”.

Approfondimento: MySQL Control Flow Functions

2. CASE
Sintassi 1: CASE su un valore
CASE value
  WHEN compare_value THEN result
  [WHEN compare_value THEN result ...]
  [ELSE result]
END

Sintassi 2: CASE su condizioni
CASE
  WHEN condition THEN result
  [WHEN condition THEN result ...]
  [ELSE result]
END


Esempi pratici:

Traduzione provincia in nome completo:

SELECT provincia,
       CASE provincia
         WHEN 'to' THEN 'Torino'
         WHEN 'at' THEN 'Asti'
         WHEN 'no' THEN 'Novara'
         WHEN 'al' THEN 'Alessandria'
         WHEN 'cn' THEN 'Cuneo'
         ELSE 'Vercelli'
       END AS `Provincia completa`
FROM studenti;


Classificazione prezzi libri:

SELECT titolo,
       prezzo,
       CASE
         WHEN prezzo < 5 THEN 'economico'
         WHEN prezzo >= 5 AND prezzo <= 10 THEN 'medio'
         WHEN prezzo > 10 THEN 'caro'
       END AS valutazione
FROM libri;


Determinazione genere:

SELECT cognome,
       CASE
         WHEN genere = 'f' THEN 'Donna'
         ELSE 'Uomo'
       END AS Genere
FROM studenti;


Assegnazione generazione basata sulla data di nascita:

SELECT cognome,
       data_nascita AS `Data di nascita`,
       CASE
         WHEN data_nascita IS NULL THEN 'Manca data nascita'
         WHEN YEAR(data_nascita) <= 1980 THEN 'X'
         WHEN YEAR(data_nascita) BETWEEN 1981 AND 1996 THEN 'Millennial'
         WHEN YEAR(data_nascita) >= 1997 THEN 'Z'
       END AS Generazione
FROM studenti
ORDER BY Generazione;


Permette di categorizzare gli studenti senza usare UNION o query multiple.