## Interrogazione di più tabelle

*Il cuore del modello relazionale*

Fino ad ora abbiamo eseguito interrogazioni su una singola tabella, utilizzando come esempio la tabella *studenti*.

Questo approccio è utile per comprendere le basi del linguaggio SQL, ma non sfrutta ancora il vero punto di forza dei database relazionali: la possibilità di mettere in relazione più tabelle tra loro.

Useremo ora il [database corsi](../Database/corsi/corsi.sql), composto dalle seguenti tabelle:

- corsi
- docenti
- studenti
- iscrizioni

Queste tabelle sono collegate tra loro tramite relazioni, definite mediante [chiavi primarie e chiavi esterne](../Teoria/05-modello-relazionale.md).

---

Immaginiamo di voler ottenere l’*elenco dei corsi con il relativo docente assegnato*.

Le informazioni richieste si trovano in due tabelle:

- i dati del docente (nome, cognome, email) sono nella tabella *docenti*

- il titolo del corso è nella tabella *corsi*

Tra le due tabelle esiste una relazione uno-a-molti:

- un docente può insegnare più corsi

- ogni corso è insegnato da un solo docente

La tabella corsi contiene l’attributo docente_id, che rappresenta una chiave esterna e memorizza l’id del docente che insegna quel corso.

Questo campo è il collegamento logico tra le due tabelle.

---

### Interrogazione con più tabelle nel FROM

**Elenco dei docenti e corsi assegnati**

```sql
SELECT
    nome, 
    cognome,
    email,
    titolo
FROM docenti, corsi
WHERE docenti.id = corsi.docente_id;
```

In questa query:

- nel `FROM` indichiamo entrambe le tabelle

- nella clausola `WHERE` specifichiamo la condizione di collegamento tra di esse

- la condizione `docenti.id = corsi.docente_id` seleziona **solo le righe che hanno una corrispondenza valida**

Il risultato sarà un insieme di record che contiene solo i corsi per i quali esiste un docente associato, con le informazioni provenienti da entrambe le tabelle.


Questo tipo di interrogazione introduce **il concetto fondamentale di join logico tra tabelle**, anche se espresso tramite la clausola `WHERE`.

Nei prossimi esempi vedremo come questo stesso risultato possa (e debba) essere ottenuto utilizzando la sintassi esplicita JOIN, che rende le query:

- più leggibili

- meno soggette a errori

- più aderenti allo standard SQL moderno

---

**Elenco degli studenti e dei corsi a cui sono iscritti**

Immaginiamo di voler ottenere l’**elenco degli studenti con il relativo corso a cui risultano iscritti**.

Tra le tabelle studenti e corsi esiste una relazione **molti-a-molti**:

- uno studente può iscriversi a più corsi

- a ogni corso possono iscriversi più studenti

Nel modello relazionale questo tipo di relazione **non può essere rappresentato direttamente** e viene gestito tramite una **tabella associativa**.

**Tabelle coinvolte**

Le informazioni richieste sono distribuite su **tre tabelle**:

- i dati dello studente (nome, cognome, email) sono contenuti nella tabella studenti

- il titolo del corso è contenuto nella tabella corsi

- le iscrizioni degli studenti ai corsi sono memorizzate nella tabella associativa iscrizioni

La tabella **iscrizioni** ha il compito di collegare logicamente studenti e corsi e contiene i seguenti attributi:

- `studente_id`: chiave esterna che memorizza l’id dello studente iscritto

- `corso_id`: chiave esterna che memorizza l’id del corso a cui lo studente è iscritto

Questi campi rappresentano i **collegamenti logici** tra le tre tabelle e consentono di ricostruire l’informazione completa.

Per ottenere l’elenco degli studenti con i corsi a cui sono iscritti, possiamo interrogare contemporaneamente le tre tabelle e collegarle tramite le rispettive chiavi:


```sql
SELECT
    nome,
    cognome,
    email,
    titolo
FROM studenti, iscrizioni, corsi
WHERE studenti.id = iscrizioni.studente_id
AND corsi.id = iscrizioni.corso_id;
```

In questa query:

- nel FROM indichiamo tutte le tabelle coinvolte

- nella clausola WHERE specifichiamo le condizioni che mettono in relazione le tabelle

- vengono selezionati solo i record per i quali esiste una corrispondenza valida tra studenti, iscrizioni e corsi

Il risultato è un insieme di righe che mostra **ogni studente associato ai corsi a cui è iscritto**.

---

**Elenco completo delle informazioni sui corsi**

Vogliamo estrarre tutte le informazioni relative ai corsi, includendo:

- i dati degli studenti iscritti

- il corso frequentato

- il docente che tiene il corso

Le informazioni richieste sono distribuite su quattro tabelle del database corsi:

- *studenti*: contiene i dati anagrafici degli studenti

- *corsi*: contiene le informazioni sui corsi

- *docenti*: contiene i dati dei docenti

- *iscrizioni*: tabella associativa che collega studenti e corsi

**Relazioni tra le tabelle**

- *studenti* è collegata a *iscrizioni* tramite `studenti.id = iscrizioni.studente_id`

- *corsi* è collegata a *iscrizioni* tramite `corsi.id = iscrizioni.corso_id`

- *docenti* è collegata a *corsi* tramite `docenti.id = corsi.docente_id`

Queste relazioni permettono di ricostruire l’informazione completa combinando i dati provenienti da tutte le tabelle coinvolte.

Per ottenere il risultato desiderato, possiamo interrogare contemporaneamente le quattro tabelle e specificare le condizioni di collegamento nella clausola WHERE:

```sql
SELECT
    studenti.nome,
    studenti.cognome,
    studenti.email,
    titolo,
    docenti.cognome,
    docenti.nome
FROM studenti, iscrizioni, corsi, docenti
WHERE studenti.id = iscrizioni.studente_id
AND corsi.id = iscrizioni.corso_id
AND docenti.id = corsi.docente_id;
```

**Risultato della query**

La query restituisce solo i record che hanno una corrispondenza valida in tutte le tabelle coinvolte.

- verranno mostrati solo gli studenti effettivamente iscritti a un corso

- verranno mostrati solo i corsi che hanno studenti iscritti

- verranno mostrati solo i corsi a cui è associato un docente

---

**Unione di più tabelle e uso degli operatori**

Una volta collegate più tabelle tramite le rispettive relazioni, è possibile raffinare ulteriormente il risultato applicando condizioni aggiuntive nella clausola `WHERE`.

In questo modo possiamo combinare:

- le condizioni di collegamento tra le tabelle

- gli operatori di confronto e logici
per ottenere risultati sempre più specifici.

- Filtrare per uno specifico corso

Ad esempio, possiamo estrarre gli studenti iscritti a un determinato corso, filtrando sul titolo del corso:

```sql
SELECT
    nome,
    cognome,
    email,
    titolo
FROM studenti, iscrizioni, corsi
WHERE studenti.id = iscrizioni.studente_id
AND corsi.id = iscrizioni.corso_id
AND titolo = 'Basi di dati';
```

In questo caso:

- le prime due condizioni servono a collegare le tabelle

- l’ultima condizione filtra i risultati in base al corso richiesto

**Aggiungere ulteriori condizioni**

Possiamo rendere la query più selettiva aggiungendo operatori logici e di confronto.

Ad esempio, estrarre gli studenti iscritti a uno specifico corso provenienti da una determinata provincia:

```sql
SELECT
    nome,
    cognome,
    email,
    titolo
FROM studenti, iscrizioni, corsi
WHERE studenti.id = iscrizioni.studente_id
AND corsi.id = iscrizioni.corso_id
AND titolo = 'Basi di dati'
AND provincia = 'TO';
```

**Combinare più filtri**

È possibile combinare più condizioni contemporaneamente per ottenere risultati ancora più mirati.

Ad esempio, **estrarre gli studenti iscritti a un corso specifico**, **provenienti da una determinata provincia** e **nati in un certo periodo**:

```sql
SELECT
    nome,
    cognome,
    email,
    titolo
FROM studenti, iscrizioni, corsi
WHERE studenti.id = iscrizioni.studente_id
AND corsi.id = iscrizioni.corso_id
AND titolo = 'Basi di dati'
AND provincia = 'TO'
AND data_nascita >= '2004-01-01';
```

Questo insieme di esempi mostra come:

- l’unione di più tabelle consenta di ricostruire informazioni distribuite nel database

- gli operatori nella clausola `WHERE` permettano di filtrare i risultati in modo preciso e flessibile

---

### Alias

Gli alias sono utilizzati per rinominare temporaneamente una tabella o una colonna **nel risultato della query**.

Si usa l’istruzione AS quando si crea un alias(1).

- Alias per le colonne:

è possibile utilizzare l'alias con GROUP BY, ORDER BY o HAVING per riferirsi alla colonna (vedremo in seguito l'uso di GROUP BY e HAVING).

```sql
SELECT data_nascita AS `Data di nascita`
FROM studente;
```

```sql
SELECT (campo1 - campo2) AS risultato
FROM nome_tabella
[WHERE condizione];
```

nota: `AS` si può anche omettere in MySQL;

```sql
SELECT data_nascita `Data di nascita`
FROM studente;
```

1) se il nome alias è un nome composto (es: `Data di nascita`) o ha lettera accentata (es: `Età`) usate i *backtick* ` (apice retroverso) per avvolgere il testo così da non avere risultati inattesi.

Approfondimento: https://dev.mysql.com/doc/refman/8.0/en/problems-with-alias.html

- Alias per le tabelle

Gli *alias per le tabelle* permettono di abbreviare i nomi delle tabelle, **rendendo le query più concise e leggibili**.

SELECT
    d.nome,
    d.cognome,
    d.email,
    c.titolo AS `Titolo Corso`
FROM docenti AS d, corsi AS c
WHERE d.id = c.docente_id
ORDER BY `Titolo Corso`;

- Una volta assegnato un alias a una tabella, in tutta la query deve essere usato solo l'alias, non il nome originale della tabella.

- Per migliorare la leggibilità, è consigliato sempre specificare l’alias della tabella davanti ai nomi delle colonne, anche quando non ci sono ambiguità.

- Nel caso di colonne con lo stesso nome in più tabelle, l’uso dell’alias scelto (se non definito uso del nome originario della tabella) è obbligatorio per evitare errori e specificare chiaramente da quale tabella proviene il dato.

**Vediamo la query che estrae l’elenco completo delle informazioni sui corsi con l’uso degli alias.**

Le informazioni richieste si trovano in quattro tabelle:

- studenti
- docenti
- corsi
- iscrizioni

Vediamo la query:

```sql
SELECT
    s.nome AS `Nome studente`,
    s.cognome AS `Cognome studente`,
    s.email AS `Contatto studente`,
    c.titolo AS `Iscritto a`,
    d.cognome AS `Cognome docente`,
    d.nome AS `Nome docente`
FROM studenti AS s, corsi AS c, iscrizioni AS i, docenti AS d
WHERE s.id = i.studente_id
AND c.id = i.corso_id
AND d.id = c.docente_id; 
```