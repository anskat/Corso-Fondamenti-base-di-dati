## Transazioni

Consideriamo il caso di un caricamento di un ordine nel gestionale.

Le operazioni da eseguire sono:

1. inserimento del record nella tabella *ordine*

2. inserimento dei dettagli nella tabella ordine_dettaglio.

**Ma se il sistema va in crash prima di eseguire la seconda query?**

```sql
INSERT INTO ordini …
```

```sql
INSERT INTO ordini_dettaglio …
```

L’*ordine* risulterà incompleto e il dato non si troverà in uno stato consistente.

**Le transazioni assicurano che le query che modificano valori in relazione tra loro ma appartenenti a più di una tabella del database siano eseguite come se si trattasse di un'unica query.**

Se una query termina in errore allora tutte le tabelle coinvolte nell'operazione verranno ripristinate allo stato antecedente l'inizio della transazione.

Diversamente le modifiche vengono registrate.

L'operazione di annullare le modifiche alle tabelle è detta `ROLLBACK`.

Si può richiamare il `ROLLBACK` di una transazione quando si trovano errori oppure in seguito a un’istruzione.

Altrimenti si esegue il `COMMIT`, e le modifiche verranno registrate in modo permanente.

---

### ACID

Si possono usare le transazioni solo se il motore delle tabelle è **InnoDB**

Le transazioni hanno le seguenti proprietà (ACID):

 - Atomicità: le transazioni sono operazioni indivisibili che riescono o falliscono nel loro insieme.

 - Consistenza: le tabelle del database si trovano in uno stato consistente sia prima che dopo le transazioni.

 - Isolamento: le transazioni avvengono separatamente tra loro. Le transazioni vengono eseguite in modo tale che le operazioni di una transazione non interferiscano con quelle delle altre. Ogni transazione lavora su una vista coerente dei dati, secondo il livello di isolamento impostato, evitando che modifiche parziali o non confermate di altre transazioni producano risultati incoerenti.

 - Durabilità: al termine completo della transazione i dati vengono memorizzati permanentemente nel database.

#### AUTO COMMIT

- Ogni volta che eseguiamo una query (`SELECT`, `INSERT`, `UPDATE` e `DELETE`) MySQL esegue il `COMMIT`, e le modifiche vengono registrate in modo permanente, a meno che non venga rilevato un errore.

- Ogni query è implicitamente racchiusa in una transazione con il commit implicito.

Questo comportamento di MySQL dipende da una variabile chiamata `AUTOCOMMIT`:

```sql
SHOW VARIABLES LIKE 'autocommit'; -- ON
```

Quindi quando si esegue una istruzione MySQL wrappa questa istruzione in una transaction ed esegue il commit a meno che non venga rilevato un errore.

---

`LAST_INSERT_ID()`

Questa funzione fa parte delle funzioni informative di mysql e restituisce il valore della colonna `AUTOINCREMENT` per l'ultimo `INSERT`:

```sql
INSERT INTO ordini_dettaglio
VALUES(LAST_INSERT_ID(),9,10,120.00);
```

> Nota: Se inserisci più righe utilizzando un'unica istruzione `INSERT`, `LAST_INSERT_ID()`  restituisce solo il valore generato per la prima riga inserita.

---

### Sintassi

```sql
START TRANSACTION;
{ blocco di istruzioni… }
COMMIT / ROLLBACK; 
```

Vediamo un esempio partendo dal caricamento di un ordine nel gestionale.

```sql
START TRANSACTION;

INSERT INTO ordini(cliente_id, `data`, consegna)
VALUES(7,'2022-05-03','da spedire');

INSERT INTO ordini_dettaglio
VALUES(LAST_INSERT_ID(),9,10,120.00);

COMMIT;
```

Una volta eseguito il `COMMIT`, le operazioni sono registrate in modo permanente.

Riproduciamo l’esempio caricando altro ordine nel gestionale.

Ora eseguiamo il codice riga per riga, e prima di eseguire la seconda query chiudiamo la connessione al database:

```sql
START TRANSACTION;

INSERT INTO ordini(cliente_id, `data`, consegna)
VALUES(7,'2022-05-03','da spedire');

-- SERVER CRASH
-- interruzione della connessione

INSERT INTO ordini_dettaglio
VALUES(LAST_INSERT_ID(),9,10,120.00);

COMMIT;
```

I dati non sono stati modificati in modo permanente, il crash ha causato il `ROLLBACK`.

---

### Operazioni concorrenti

Di solito molti user interagiscono contemporaneamente con la nostra applicazione e di conseguenza con i nostri dati.

La CONCORRENZA (Concurrency) può diventare un problema quando un utente modifica i dati che altri utenti stanno cercando di recuperare o modificare.

Vediamo come MySQL gestisce la concorrenza per impostazione predefinita:

Attiviamo due connessioni (due shell, o due istanze di workbench) e creiamo due `TRANSACTION`

1. connessione 1

```sql
START TRANSACTION;

UPDATE clienti
SET credito = credito + 100
WHERE id = 1;

COMMIT;
```

Eseguiamo riga per riga le istruzioni senza eseguire il commit.

2. connessione 2

```sql
START TRANSACTION;

UPDATE clienti
SET credito = credito + 100
WHERE id = 1;

COMMIT;
```

*La seconda* `TRANSACTION` *viene messa in attesa della conclusione della prima* `TRANSACTION`, MySQL blocca le righe interessate sino a conclusione dell’operazione o in seguito ad un time-out.

---

### Livelli di isolamento

InnoDB offre 4 livelli di isolamento*:

`READ UNCOMMITTED`: una transazione può vedere modifiche alle righe fatte da un'altra transazione persino prima che sia avvenuto il commit.

`READ COMMITTED`: una transazione può vedere solo dati già sottoposti a commit. Durante l'esecuzione della transazione, ogni istruzione può vedere modifiche
apportate da altre transazioni che hanno completato il commit anche dopo l'inizio della transazione corrente.

`REPEATABLE READ` (default): non considera nessuna delle modifiche prodotte da altre transazioni a prescindere dal fatto che queste ultime siano state terminate con il commit. Se una transazione esegue un'istruzione di selezione due volte, viene restituito lo stesso risultato in entrambi i casi, purché la transazione non modifiche essa stessa i dati.

`SERIALIZABLE`: questo livello di isolamento è simile a `REPEATABLE READ` ma isola le transazioni. Le righe che devono essere viste da una transazione non sono visibili da un'altra transazione fino a quando la transazione è completa.

```sql
SHOW VARIABLES LIKE 'transaction_isolation';
```

> Nota: per un approfondimento vedere la documentazione ufficiale mysql: https://dev.mysql.com/doc/refman/5.7/en/innodb-transaction-isolation-levels.html
> Consultare il paragrafo 5 di questo pdf: http://users.dimi.uniud.it/~angelo.montanari/SQL-Transazioni.pdf

---

### Problemi di concorrenza gestiti dai diversi livelli di isolamento:

| isolation level |aggiornamenti persi	| letture sporche	| letture non ripetute	| letture fantasma |
| ----            | ----                | ----              | ----                  | ----             |
| READ UNCOMMITTED|  si                 | si                | si                    | si               |				
| READ COMMITTED  |  si                 | no                | si                    | si               |				
| REPEATABLE READ |  no                 | no                | no                    | si               |				
| SERIALIZABLE	  |  no                 | no                | no                    | no               |

Nota: il comportamento dei phantom read (letture fantasma) può variare a seconda del motore e del tipo di query.

L'isolamento di default di InnoDB è `REPEATABLE READ`.

Il livello di isolamento può essere impostato.

È possibile impostare le caratteristiche della transazione a livello globale, per la sessione corrente o solo per la transazione successiva:

```sql
SET TRANSACTION ISOLATION LEVEL nuovo_livello
```

Per usare efficacemente le transazioni bisogna inserirle in un programma in cui data una condizione viene eseguito il `COMMIT` altrimenti il `ROLLBACK`.

- Senza l'istruzione `SESSION` o `GLOBAL` l'impostazione si applica solo alla successiva transazione eseguita all'interno della sessione;

- se aggiungiamo `SESSION` dopo l'istruzione `SET` il livello di isolamento resterà impostato a tutte le transazioni successive eseguite nella sessione corrente;

**Esempio**:

```sql
 SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
```

- se aggiungiamo `GLOBAL` dopo l'istruzione `SET` il livello di isolamento riguarderà il server e verrà applicato a tutte le connessioni successive.

```sql
 SET GLOBAL TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
```

> Nota: dipende dai privilegi assegnati, le impostazioni a livello di server dipendono dal DBA.

---

#### Esempi:

**LETTURE SPORCHE**

```sql
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
```

Per ogni shell create una transazione:

```sql
START TRANSACTION;
```

Nella prima shell effettuate l'aggiornamento del credito del cliente con id = 1, senza eseguire il `COMMIT`

```sql
UPDATE clienti SET credito = 200 WHERE id = 1;
```

Nella seconda shell effettuate una `SELECT` sulla tabella *cliente*

```sql
SELECT credito FROM clienti WHERE id = 1;
```

Si crea una lettura sporca della seconda transazione se la prima transazione fallisce.

**Il livello di isolamento** `READ COMMITTED` **risolve questo problema**;

**LETTURE RIPETUTE**

```sql
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
```

Per ogni shell create una transazione:

```sql
START TRANSACTION;
```

Nella prima shell effettuate una prima `SELECT` del credito del cliente con id = 1

```sql
SELECT credito FROM clienti WHERE id = 1;
```

Nella seconda shell effettuate l'aggiornamento del credito del cliente con id = 1 ed eseguite il `COMMIT`

```sql
UPDATE clienti SET credito = 20 WHERE id = 1;
COMMIT;
```

Nella prima shell effettuate una seconda `SELECT` del credito del cliente con id = 1

```sql
SELECT credito FROM clienti WHERE id = 1;
```

La seconda lettura è inconsistente.

**Il livello di isolamento** `REPEATABLE READ` **risolve questo problema**;

**LETTURE FANTASMA**

```sql
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
```

Per ogni shell create una transazione:

```sql
START TRANSACTION;
```

Nella prima shell effettuate una prima `SELECT`

```sql
SELECT * FROM clienti WHERE provincia = 'mi';
```

Nella seconda shell effettuate l'aggiornamento della provincia del cliente con id = 1

```sql
UPDATE clienti SET provincia = 'mi' WHERE id = 1;
```

Nella prima shell effettuate una seconda `SELECT`

```sql
SELECT * FROM clienti WHERE provincia = 'mi';
```

La seconda lettura non tiene conto (indipendentemente dal commit) del cambiamento della seconda transazione, provocando una lettura fantasma.

**Il livello di isolamento** `SERIALIZABLE` **risolve questo problema**;

```sql
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
```

Per ogni shell create una transazione:

```sql
START TRANSACTION;
```

Nella prima shell effettuate l'aggiornamento della provincia del cliente con id = 1

```sql
UPDATE clienti SET provincia = 'mi' WHERE id = 1;
```

Nella seconda shell effettuate una prima SELECT

```sql
SELECT * FROM clienti WHERE provincia = 'mi';
```

La seconda lettura rimane in attesa che la prima transazione si concluda, prevenendo la lettura fantasma.

Il livello di isolamento `SERIALIZABLE` esegue ogni transazione una alla volta, isolando le transazioni.

---

#### Savepoint

I `SAVEPOINT` nelle transazioni, **sono posizioni a cui il** `ROLLBACK` *si arresterà*.

Le operazioni precedenti al *savepoint* non vengono annullate se si esegue un `ROLLBACK TO SAVEPOINT`, ma vengono comunque annullate se si esegue un `ROLLBACK` completo.

```sql
START TRANSACTION;
-- primo blocco di istruzioni...

SAVEPOINT sp1;
-- secondo blocco di istruzioni...

ROLLBACK TO SAVEPOINT sp1;

-- terzo blocco di istruzioni...

COMMIT;
```

In questo caso, dopo avere avviato la transazione abbiamo eseguito un primo blocco di aggiornamenti, seguito dalla creazione del savepoint col nome 'sp1' ;

in seguito abbiamo eseguito un secondo blocco di aggiornamenti;

l’istruzione `ROLLBACK TO SAVEPOINT sp1` fa sì che “ritorniamo” alla situazione esistente quando abbiamo creato il savepoint: in pratica solo il secondo blocco di aggiornamenti viene annullato, e la transazione rimane aperta;

una semplice ROLLBACK invece avrebbe annullato tutto e chiuso la transazione.

Il `COMMIT` effettuato dopo il terzo blocco consolida gli aggiornamenti effettuati nel primo e nel terzo blocco.

---

### Da considerare

1. `TRANSACTION` vs `DDL`

Le istruzioni `DDL` (`CREATE TABLE`, `ALTER TABLE`, `DROP TABLE`) eseguono un **COMMIT implicito** e non sono rollbackabili in MySQL.

2. COMMIT implicito

Alcune istruzioni provocano un **COMMIT implicito** anche se una transazione è aperta.

3. `START TRANSACTION` vs `BEGIN`

    `START TRANSACTION`;
    `BEGIN`;

MySQL li tratta come sinonimi, ma **START TRANSACTION è SQL standard**.