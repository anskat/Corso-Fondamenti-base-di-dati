## Subquery

Una subquery è un'istruzione SELECT all'interno di un'altra istruzione SQL( SELECT , INSERT , UPDATE , DELETE …).

Una subquery MySQL può essere nidificata all'interno di un’altra subquery.

Una subquery viene in genere aggiunta all'interno della condizione WHERE di un'altra istruzione SELECT.

È possibile utilizzare gli operatori di confronto, come > , < , = …

L'operatore di confronto può anche essere un operatore a più righe, ad esempio

IN , NOT IN , ANY , SOME o ALL .

La subquery è anche chiamata query interna, mentre la query che contiene la subquery si chiama query esterna.

La subquery (query interna) viene eseguita prima della query esterna, a meno che non sia una subquery correlata.

### Tipi di subquery:

- subquery scalare

- subquery con operatori di confronto

- subquery con operatori di confronto avanzato ALL , ANY , IN , NOT IN

- row subquery con costruttore di righe, istruzione ROW()

- subquery correlate

- subquery con EXISTS o NOT EXISTS

- subquery nella clausola FROM

**vantaggi**:

- Consentono query strutturate in modo che sia possibile isolare ogni parte di una dichiarazione.

- Forniscono metodi alternativi per eseguire operazioni che altrimenti richiederebbero UNION e JOIN complesse.

- Molti trovano le subquery più leggibili rispetto a UNION o JOIN complesse.


**Vediamo un esempio di sintassi**:

```sql
SELECT elenco_campi
FROM tabella
WHERE espressione operatore (SELECT elenco_campi FROM tabella);
```

Una subquery può restituire un risultato scalare (un singolo valore), una singola riga, una singola colonna o una
tabella (una o più righe di una o più colonne).

Queste sono chiamate subquery scalari, a colonne, a righe e a tabelle.

---

#### Subquery scalare

**Esempio**: vogliamo l'elenco degli impiegati, pagati più del impiegato "Barba" il cui id è 6;

Possiamo ottenere l'elenco in due passaggi:

```sql
SELECT stipendio FROM impiegati WHERE id = 6; --[ r:1500.00 ]
```

```sql
SELECT nome, cognome, stipendio
FROM impiegati
WHERE stipendio > 1500.00
ORDER BY cognome;
```

Oppure unire le due query nidificandone una nell'altra:

```sql
SELECT nome, cognome, stipendio
FROM impiegati
WHERE stipendio >
(SELECT stipendio FROM impiegati WHERE id = 6)
ORDER BY stipendio;
```

Abbiamo utilizzato l'*id* dell'impiegato perché la sub query deve restituire una sola riga, il risultato della
condizione è un valore solo (subquery scalare);

Se avessimo utilizzato il cognome saremmo potuti incorrere nell'errore come da esempio seguente, dal
momento che di impiegati con cognome uguale a *Barba* ce n'è più d'uno:

```sql
SELECT nome, cognome, stipendio
FROM impiegati
WHERE stipendio > (SELECT stipendio FROM impiegati WHERE cognome = 'Barba')
ORDER BY cognome;
```

```bash
ERROR 1242 (21000): Subquery returns more than 1 row
```

**Altro esempio**:

Selezioniamo dalla tabella corsi, i corsi il cui prezzo è maggiore del prezzo medio del nostro
catalogo corsi.

```sql
SELECT titolo, prezzo
FROM corsi
WHERE prezzo > (SELECT AVG(prezzo) FROM corsi)
ORDER BY prezzo DESC;
```

Notate la `SELECT` utilizzata per ottenere il valore del prezzo medio come valore di confronto
nella condizione `WHERE`.

La seguente query non ha senso:

```sql
SELECT prezzo FROM corsi WHERE prezzo > AVG(prezzo);
```

```bash
ERROR 1111 (HY000): Invalid use of group function
```

**Altro esempio**:

Selezioniamo dalla tabella corsi, i corsi che costano di più nel nostro
catalogo.

```sql
SELECT titolo, prezzo
FROM corsi
WHERE prezzo = (SELECT max(prezzo) FROM corsi)
ORDER BY prezzo DESC;
```

Notate la `SELECT` utilizzata per ottenere il valore del prezzo massimo come valore di confronto nella condizione `WHERE`.

**Altro esempio**:

Selezioniamo le info del cliente che ha eseguito l’ultimo ordine.

```sql
SELECT c.cognome, c.nome, c.email
FROM clienti c
JOIN ordini o
ON c.id=o.cliente_id
WHERE o.id = (SELECT MAX(id) FROM ordini);
```

Selezioniamo le info del cliente che ha eseguito l’ultimo ordine con più query nidificate (senza join)

```sql
SELECT cognome, nome, email
FROM clienti
WHERE id = (
    SELECT cliente_id
    FROM ordini
    WHERE id = (
        SELECT MAX(id)
        FROM ordini
        )
);
```

---

#### Subquery con operatori di confronto.

Una Subquery può essere utilizzata insieme a uno qualsiasi degli operatori di confronto.

La Subquery può restituire al massimo un valore. Il valore può essere il risultato di un'espressione
aritmetica o di una funzione di colonna.

SQL confronta quindi il valore risultante dalla subquery con il valore sull'altro lato dell'operatore di
confronto.

**Vediamo due esempi**:

```sql
SELECT nome, cognome, stipendio
FROM impiegati
WHERE stipendio < (SELECT AVG(stipendio) FROM impiegati)
ORDER BY stipendio DESC;
```

```sql
SELECT titolo, prezzo
FROM corsi
WHERE prezzo > (SELECT AVG(prezzo) FROM corsi);
```

---

#### Subquery con: ALL

È possibile utilizzare dopo un operatore di confronto, l'operatore di confronto avanzato:

ALL, ANY[SOME] prima della subquery.

L'operatore ALL confronta ogni valore restituito dalla subquery.

Pertanto, l'operatore ALL (che deve seguire un operatore di confronto: =, >, < …) restituisce VERO se il confronto è VERO per TUTTI i valori nella colonna restituiti dalla subquery.

La seguente query seleziona i corsi con più iscritti.

La subquery conta gli studenti raggruppati per ciascun corso, quindi la query principale seleziona tra questi i corsi con più iscritti.

```sql
SELECT c.titolo, COUNT(i.corso_id) AS `quanti`
FROM corsi c
JOIN iscrizioni i ON c.id = i.corso_id
GROUP BY c.id, c.titolo
HAVING quanti >= ALL (SELECT COUNT(studente_id) FROM iscrizioni GROUP BY corso_id)
ORDER BY `quanti` DESC;
```

Nota: qui è stata utilizzata la parola chiave ALL per questa subquery poiché l'ufficio selezionato dalla query deve avere uno stipendio medio superiore o uguale
allo stipendio medio degli altri uffici.

La seguente query seleziona l'ufficio i cui impiegati hanno il salario medio più alto.

La subquery trova lo stipendio medio per ciascun ufficio, quindi la query principale seleziona l'ufficio con lo stipendio medio più alto.

```sql
SELECT u.nome, AVG(stipendio) `Stipendio medio`
FROM impiegati i
JOIN uffici u
ON u.id = i.ufficio_id
GROUP BY i.ufficio_id
HAVING `Stipendio medio` >= ALL
( SELECT AVG( stipendio ) FROM impiegati GROUP BY
ufficio_id );
```

Nota: qui è stata utilizzata la parola chiave ALL per questa subquery poiché l'ufficio selezionato dalla query deve avere uno stipendio medio superiore o uguale allo stipendio medio degli altri uffici.

---

#### Subquery con: ANY(SOME)

Le subquery che usano la parola chiave ANY[SOME] restituiscono TRUE se la comparazione restituisce TRUE per almeno una delle righe restituite dalla subquery.

Se utilizzato con una subquery, la parola IN è un alias per = ANY .

Quindi, queste due istruzioni sono uguali.

La seguente query seleziona gli impiegati che lavorano in una data regione, es: 'piemonte'.

La subquery trova l'ID degli uffici che si trovano in 'piemonte', quindi la query principale seleziona gli impiegati che lavorano in uno
di questi uffici.

```sql
SELECT cognome, nome
FROM impiegati
WHERE ufficio_id = ANY
(SELECT id FROM uffici WHERE regione = 'piemonte');
```

abbiamo utilizzato la parola chiave ANY in questa query perché è probabile che la subquery troverà più di un ufficio nella regione
Piemonte.

Se si utilizza la parola chiave ALL anziché la parola chiave ANY, nessun dato viene selezionato perché nessun dipendente lavora in
tutti gli uffici che si trovano in Piemonte.

Posso contare gli impiegati che lavorano in una data regione

```sql
SELECT 'Piemonte', COUNT(*)
FROM impiegati
WHERE ufficio_id = ANY -- IN
(SELECT id FROM uffici WHERE regione = 'piemonte');
```

Otteniamo la stessa cosa con la JOIN

```sql
SELECT regione, COUNT(*)
FROM impiegati JOIN uffici
ON impiegati.ufficio_id = uffici.id
AND regione = 'piemonte';
```

---

#### Subquery con: IN (= ANY)

Se una subquery restituisce più di un valore si possono effettuare confronti utilizzando, all'interno della clausola WHERE gli operatori avanzati: IN, NOT IN.

Vediamo l'esempio con IN: selezioniamo i docenti che hanno corsi.

```sql
SELECT cognome, nome, email
FROM docenti
WHERE id IN (SELECT docente_id FROM corsi); -- WHERE ID = ANY
```

di seguito lo stesso esempio con una JOIN.

```sql
SELECT DISTINCT cognome, nome, email
FROM docenti d
JOIN corsi c
ON d.id = c.docente_id;
```

Vediamo l'esempio con IN: selezioniamo i clienti che hanno
effettuato ordini.

```sql
SELECT cognome, telefono, citta
FROM clienti
WHERE id IN (SELECT DISTINCT cliente_id FROM ordini); -- WHERE ID = ANY
```

di seguito lo stesso esempio con una JOIN.

```sql
SELECT DISTINCT cognome, telefono, citta
FROM clienti
INNER JOIN ordini ON clienti.id=ordini.cliente_id;
```

---

#### Subquery con: NOT IN
Vediamo un esempio con NOT IN: selezioniamo i docenti che non hanno corsi.

```sql
SELECT cognome, nome, email
FROM docenti
WHERE id NOT IN (SELECT docente_id FROM corsi); -- equivalente a ID <> ALL
```

Alternativa più sicura e robusta con LEFT JOIN:

```sql
SELECT cognome, nome, email
FROM docenti d
LEFT JOIN corsi c ON d.id=c.docente_id
WHERE c.id IS NULL;
```

**Attenzione: NOT IN è sensibile ai valori NULL**.

Se la subquery restituisce anche un solo valore NULL, il confronto fallisce e nessuna riga viene restituita.

È più sicuro usare la JOIN con IS NULL, che non soffre di questo problema. Nel nostro caso ci possono essere
docente_id = NULL, diversamente potremmo usare tranquillamente NOT IN.

Oppure aggiungere alla subquery: WHERE docente_id IS NOT NULL

Vediamo un esempio funzionante con NOT IN: selezioniamo i clienti che non hanno
effettuato ordini.

```sql
SELECT cognome, telefono, citta
FROM clienti
WHERE id NOT IN (SELECT DISTINCT cliente_id FROM ordini); -- equivalente a ID <> ALL
```

In questo caso sappiamo che cliente_id non può essere NULL quindi la query funziona anche con NOT IN.

Alternativa con LEFT JOIN:

```sql
SELECT cognome, telefono, citta
FROM clienti c
LEFT JOIN ordini o ON c.id=o.cliente_id
WHERE o.id IS NULL;
```

Vediamo altro esempio funzionante con NOT IN: selezioniamo gli articoli che non sono
presenti negli ordini.

```sql
SELECT descrizione
FROM articoli a
WHERE a.id NOT IN (SELECT DISTINCT articolo_id FROM ordini_dettaglio);
```

In questo caso sappiamo che articolo_id non può essere NULL quindi la query funziona anche con NOT IN.

Alternativa con LEFT JOIN:

```sql
SELECT descrizione
FROM articoli a
LEFT JOIN ordini_dettaglio od ON a.id=od.articolo_id
WHERE od.articolo_id IS NULL;
```

---

#### Row subquery: ROW( field1, field2, [field3],… )

Una subquery di riga è una subquery che restituisce una singola riga e più di un valore di colonna.

Quando una subquery restituisce una singola riga, può essere usata per fare confronti attraverso i costruttori di righe:

L’espressione ROW(nome, cognome) è un costruttore di riga, che può essere espresso anche come (nome, cognome).

**Vediamo un esempio**:

```sql
SELECT * FROM amici
WHERE ROW( nome, cognome ) = ( SELECT nome, cognome FROM studenti WHERE id = 4 );
```

Questa query confronta le righe dalla tabella amici per i campi nome e cognome con la riga estratta nella subquery finché non trova una corrispondenza.

```sql
SELECT * FROM amici
WHERE ROW( nome, cognome ) = ('[nome]','[cognome]');
```

Questa query confronta le righe dalla tabella amici per i campi nome e cognome con la riga specificata, finché non trova una
corrispondenza.

```sql
SELECT * FROM amici
WHERE (cognome, nome) IN (SELECT cognome, nome FROM parenti);
```

Questa query risponde alla richiesta *trova tutte le righe nella tabella amici che esistono anche nella tabella parenti*.

documentazione: https://dev.mysql.com/doc/refman/8.0/en/row-subqueries.html

--- 

#### Subquery correlate

Le subquery correlate contengono un riferimento ad una delle tabelle che fanno parte della query esterna, quindi non sono indipendenti:

**Vediamo esempio**:

```sql
UPDATE articoli a
SET rimanenza = 100 -
    (SELECT SUM(quantita)
    FROM ordini_dettaglio od
    WHERE od.articolo_id = a.id
    );
```

Questa query aggiorna la tabella articoli sulla base degli ordini effettuati.

Notare che se un articolo non è mai stato ordinato la rimanenza verrà impostata a NULL; di conseguenza dovremmo aggiornare tutti i valori NULL al valore del magazzino = 100.

```sql
UPDATE articoli SET rimanenza = 100 WHERE rimanenza IS NULL;
```

**IFNULL**

Riprendendo l’esempio precedente relativo all’aggiornamento del magazzino, grazie alla funzione IFNULL tutto si può scrivere in una sola query (IFNULL non è standard SQL, è funzione di MySQL):

```sql
UPDATE articoli a
SET rimanenza = 100 -
IFNULL(
    (
    SELECT SUM(quantita)
    FROM ordini_dettaglio od
    WHERE od.articolo_id = a.id
    )
    ,
    0
);
```

> NOTA: L’efficienza delle subquery correlate dipende dal numero di righe e dagli indici disponibili. È quindi da valutare caso per caso.

Su dataset piccoli o medi è efficiente e chiara, ma su dati molto grandi conviene valutare query con JOIN e aggregazioni per migliorare le prestazioni. Vedi slide “subquery nella clausola FROM”.

**COALESCE - standard SQL**

Subquery per aggiornare il credito di tutti i clienti:

```sql
UPDATE clienti c
SET credito = COALESCE(
                    (
                    SELECT SUM(od.prezzo * od.quantita)
                    FROM ordini o
                    JOIN ordini_dettaglio od ON o.id = od.ordine_id
                    WHERE o.cliente_id = c.id
                    ),
                    0
);
```

Subquery per aggiornare il credito di un cliente:

```sql
UPDATE clienti c
SET credito = COALESCE(
                    (
                    SELECT SUM(od.prezzo * od.quantita)
                    FROM ordini o
                    JOIN ordini_dettaglio od ON o.id = od.ordine_id
                    WHERE o.cliente_id = c.id
                    ),
                    0
)
WHERE c.id = 3;
```

---

Subquery nel SELECT (colonne calcolate)

Una subquery può essere utilizzata anche all’interno della clausola SELECT, come se fosse una colonna calcolata.

In questo caso, la subquery viene eseguita per ogni riga restituita dalla query principale e il valore ottenuto viene mostrato come una colonna aggiuntiva nel risultato.

La subquery nel SELECT è quasi sempre una subquery correlata, perché fa riferimento a una colonna della query esterna.

```sql
SELECT
    nome
    ( SELECT COUNT(*)
    FROM ordini o
    WHERE o.cliente_id = c.id) AS num_ordini
FROM clienti c;
```

La query principale seleziona tutti i clienti dalla tabella clienti.

Per ogni cliente, la subquery viene eseguita una volta.

La subquery conta (COUNT(*)) il numero di ordini associati al cliente corrente, utilizzando la condizione o.cliente_id = c.id.

Il risultato della subquery è un valore scalare (un singolo numero), che viene restituito come colonna calcolata con alias num_ordini.

Il risultato finale mostra, per ogni cliente, il suo nome e il numero totale di ordini effettuati.

> Nota importante: poiché la subquery viene eseguita una volta per ogni riga della query esterna, su tabelle di grandi dimensioni questa soluzione può essere meno efficiente rispetto a una JOIN con aggregazione.

Una subquery nel SELECT è efficace e appropriata quando:

- il dataset è piccolo o medio
- serve una colonna calcolata leggibile
- il valore calcolato è logicamente legato a una singola riga
- l’obiettivo principale è la chiarezza, non la massima ottimizzazione
- non serve filtrare o ordinare sul valore calcolato

In questi casi la subquery nel SELECT è assolutamente corretta e spesso più comprensibile di una JOIN con GROUP BY.

```sql
SELECT
    c.nome,
    c.cognome,
    COUNT(o.id) AS num_ordini
FROM clienti c
LEFT JOIN ordini o
    ON o.cliente_id = c.id
GROUP BY c.id, c.nome, c.cognome;
```

La subquery nel SELECT non è sbagliata. È una soluzione chiara e corretta. La JOIN è una ottimizzazione, non una correzione.

---

#### Subquery con EXISTS o NOT EXISTS

L'operatore EXISTS verifica l'esistenza di righe nel set di risultati della subquery.

Se viene trovato un valore di riga, la subquery EXISTS è TRUE e in questo caso la subquery NON EXISTS è FALSE

Questa query estrae i nomi dei docenti che hanno almeno un corso assegnato nella tabella corsi.

```sql
SELECT cognome, nome
FROM docenti d
WHERE EXISTS (
            SELECT 1 -- la subquery non usa i valori
            FROM corsi c
            WHERE c.docente_id = d.id
);
```

Vediamo la stessa cosa con una JOIN

```sql
SELECT DISTINCT cognome, nome
FROM docenti d
JOIN corsi c ON c.docente_id = d.id;
```

NOTA: La subquery non ci serve per sapere quale docente, ma solo se ce n’è almeno uno.

Per questo scriviamo SELECT 1: è una convenzione per dire "non mi interessa il contenuto, mi interessa solo l’esistenza di righe".

Questa query estrae i nomi dei docenti che non hanno corsi assegnati nella tabella corsi.

```sql
SELECT cognome, nome
FROM docenti d
WHERE NOT EXISTS (
                SELECT 1
                FROM corsi c
                WHERE c.docente_id = d.id
);
```

Vediamo la stessa cosa con una OUTER JOIN

```sql
SELECT cognome, nome
FROM docenti d
LEFT JOIN corsi c
ON d.id = c.docente_id
WHERE c.id IS NULL;
```

Questa query estrae i nomi dei clienti che hanno almeno un ordine registrato nella tabella ordini.

```sql
SELECT cognome, nome
FROM clienti c
WHERE EXISTS
(SELECT 1 FROM ordini o WHERE o.cliente_id = c.id);
```

Vediamo la stessa cosa con una JOIN

```sql
SELECT DISTINCT cognome, nome
FROM clienti c
INNER JOIN ordini o
ON c.id = o.cliente_id;
```

NOTA: La subquery non ci serve per sapere quale ordine, ma solo se ce n’è almeno uno.

Per questo scriviamo SELECT 1: è una convenzione per dire 'non mi interessa il contenuto, mi interessa solo l’esistenza di righe'."

Questa query estrae i nomi dei clienti che non hanno ordini registrati nella tabella ordini.

```sql
SELECT cognome, nome
FROM clienti c
WHERE NOT EXISTS
(SELECT 1 FROM ordini o
WHERE o.cliente_id = c.id);
```

Vediamo la stessa cosa con una OUTER JOIN

```sql
SELECT cognome, nome
FROM clienti c
LEFT JOIN ordini o
ON c.id = o.cliente_id
WHERE o.id IS NULL;
```

---

#### Subquery nella clausola FROM

Le subquery possono essere inserite anche nella istruzione FROM.

Ricordiamoci delle viste, che sono i realtà query memorizzate nel database!

Consideriamo la vista studenti_giovani in cui mostriamo gli studenti che hanno meno di 31 anni.

```sql
CREATE OR REPLACE VIEW studenti_giovani AS
SELECT cognome, nome, email, timestampdiff(YEAR, data_nascita, curdate()) `età`
FROM studenti
WHERE timestampdiff(YEAR, data_nascita, curdate()) <= 30;
```

Quando interroghiamo la vista la SELECT è la seguente:

```sql
SELECT * FROM studenti_giovani;
```

Siccome la vista è una query memorizzata è come se scrivessimo:

```sql
SELECT * FROM (
            SELECT cognome, nome, email, timestampdiff(YEAR, data_nascita, curdate()) `età`
            FROM studenti
            WHERE timestampdiff(YEAR, data_nascita, curdate()) <= 30
            ) AS tbl
ORDER BY `età` DESC;
```

NOTA: Ogni tabella derivata deve avere un suo nome (alias)

ATTENZIONE: verificate sempre la subquery quando questo è possibile, cioè in caso di subquery indipendente.

Prendiamo in considerazione la query che aggiorna le quantità in magazzino sulla base degli articoli ordinati.

```sql
UPDATE articoli a
SET rimanenza = 100 -
IFNULL(
        (
        SELECT SUM(quantita)
        FROM ordini_dettaglio od
        WHERE od.articolo_id = a.id
        )
        ,
        0
);
```

Questa query esegue il calcolo della subquery per ogni riga della tabella articoli.

Se ci sono 1000 articoli la subquery viene eseguita 1000 volte!

Possiamo tentare di ottimizzare la query facendo il JOIN tra la tabella articoli e una tabella temporanea aggregata:

```sql
UPDATE articoli a
LEFT JOIN (
        SELECT articolo_id, SUM(quantita) AS totale
        FROM ordini_dettaglio
        GROUP BY articolo_id
        ) AS od_sum
ON a.id = od_sum.articolo_id
SET a.rimanenza = 100 - IFNULL(od_sum.totale, 0);
```

Prendiamo in considerazione la query che aggiorna il credito dei clienti sulla base degli ordini eseguiti.

```sql
UPDATE clienti c
SET credito = COALESCE(
                    (SELECT SUM(od.prezzo * od.quantita)
                    FROM ordini o
                    JOIN ordini_dettaglio od ON o.id = od.ordine_id
                    WHERE o.cliente_id = c.id
                    )
                    ,
                    0
);
```

Questa query esegue il calcolo della subquery per ogni riga della tabella clienti.

Se ci sono 1000 clienti la subquery viene eseguita 1000 volte!

Possiamo tentare di ottimizzare la query facendo il JOIN tra la tabella clienti e una tabella temporanea aggregata:

```sql
UPDATE clienti c
LEFT JOIN (
        SELECT o.cliente_id, SUM(od.prezzo * od.quantita) AS totale
        FROM ordini o
        JOIN ordini_dettaglio od ON o.id = od.ordine_id
        GROUP BY o.cliente_id
        ) AS totali ON c.id = totali.cliente_id
SET c.credito = COALESCE(totali.totale, 0);
```

Prendiamo in considerazione la tabella ordini_dettaglio:

Vogliamo ricavare il numero massimo, il numero minimo e la media di articoli venduti rispetto agli ordini:

```sql
SELECT
    MAX(q_articoli),
    MIN(q_articoli),
    ROUND(AVG(q_articoli))
FROM
    (
    SELECT /* ordine_id,*/ SUM(quantita) AS q_articoli
    FROM ordini_dettaglio
    GROUP BY ordine_id
    ) AS tbl;
```

In questo caso la subquery seleziona e somma:

`SUM(quantita)`

la quantità di articoli presenti in ciascun ordine:

`GROUP BY ordine_id`

e la passa alla query principale, sotto forma di tabella virtuale:

`... FROM (SELECT...) AS tbl;`

che ricava il numero massimo, il numero minimo e la media di articoli venduti.