## VIEW (Viste)

Una vista è una tabella logica basata su una o più query `SELECT`.

Non contiene dati propri, ma espone il risultato di una query definita su:

- tabelle fisiche (dette base table),

- oppure altre viste.

**Vantaggi delle viste**

- Limitano l’accesso ai dati sensibili: puoi mostrare solo alcune colonne o righe di una tabella.

- Mascherano la complessità del database: l’utente non deve conoscere i dettagli delle join o dei filtri.

- Riduzione dell’impatto dei cambiamenti: se cambia la struttura delle tabelle, puoi aggiornare solo la vista.

- Semplificano le query: permettono di ottenere risultati complessi usando una SELECT semplice.

Esempio: una vista può fornire i dati da più tabelle collegate, senza che l’utente sappia come scrivere il JOIN.

**Nota: Le VIEW non migliorano le prestazioni di per sé: sono uno strumento logico, non fisico.**

---

Vantaggi (sintesi)

- Semplificano le query
- Riducono l’impatto dei cambiamenti
- Limitano accesso ai dati

---
### Creare la VIEW

**Sintassi**

```sql
CREATE VIEW nome_vista AS
SELECT nome_campi
FROM nome_tabella
WHERE condizioni;
```

Crea una vista basata su una query.

Se la vista esiste già, il comando produce un errore.

Le viste si comportano come tabelle virtuali, ma non memorizzano dati: ogni accesso esegue la query definita.

Creare una vista equivale a salvare una query con un nome, che può poi essere richiamata come una tabella.


*Le viste create possono essere*

- semplici:
    - deriva da una sola tabella;
    - non contiene funzioni di aggregazione; 

- complesse:
    - deriva da più tabelle in join;
    - può contenere funzioni di aggregazione;

#### VISTA semplice

```sql
CREATE VIEW studenti_contatto AS
SELECT id, nome, cognome, email
FROM studenti;
```

#### VISTA complessa

```sql
CREATE VIEW iscritti AS
SELECT cognome, nome, email, titolo AS corso, i.prezzo, data_isc
FROM studenti s
JOIN iscrizioni i ON s.id = i.studente_id
JOIN corsi c ON c.id = i.corso_id;
```

È possibile definire un `ORDER BY` all’interno di una **VIEW**, ma questo ordinamento non è garantito quando si seleziona dalla vista tramite una query esterna, che può avere un proprio `ORDER BY`.

Per assicurare un ordine specifico, applicare sempre `ORDER BY` nella `SELECT` esterna che richiama la vista.

NOTA: MySQL ignora ORDER BY all’interno della definizione di una vista, salvo che sia usato insieme a LIMIT.

---

### Modificare una view

**Sintassi**

`CREATE OR REPLACE VIEW` sovrascrive la vista se esiste ricreandola da capo.

```sql
CREATE OR REPLACE VIEW nome_vista AS
SELECT nome_campi
FROM nome_tabella
WHERE condizioni;
```

`ALTER VIEW` modifica la vista.

```sql
ALTER VIEW nome_vista AS
SELECT nome_campi
FROM nome_tabella
WHERE condizioni;
```

---

### Rinominare una VIEW

Per rinominare la view, modificarne solo il nome, potete scrivere:

**Sintassi**

```sql
RENAME TABLE nome_vista TO nuovo_nome_vista;
```

---

### Interrogare una view

Accedere ad una vista è semplicissimo: funzionando quest'ultima esattamente come una comune tabella, sarà sufficiente effettuare una `SELECT`.

```sql
SELECT * from nome_vista ORDER BY colonna;
```

Per elencare le tabelle e verificare quali tra queste sono in realtà viste:

```sql
SHOW FULL TABLES WHERE Table_type = 'VIEW';
```

Potete interrogare anche information_schema (che è una vista) per ottenere l'elenco delle vostre tabelle con l'indicazione del tipo: base table o view:

```sql
SELECT table_name, table_type
FROM information_schema.tables
WHERE table_schema = 'nome_db'
ORDER BY table_name;
```

---

### Eliminare una view

```sql
DROP VIEW nome_vista [,nome vista];
```

- L’istruzione DROP rimuove la definizione della vista dal database;

- cancellando la vista non ci sono effetti sulla base table;

- viste o altre applicazioni basate sulla vista cancellata diventano invalide;

---

### Mostrare il codice della view

```sql
SHOW CREATE VIEW nome_vista;
```

---

### Viste aggiornabili e non aggiornabili

Una **VIEW** si dice aggiornabile quando consente di modificare i dati nella tabella sottostante.

Per essere aggiornabile la Vista deve possedere un rapporto uno ad uno con la tabella sottostante, quindi la SELECT che genera la View… :

- NON può utilizzare `DISTINCT`;

- NON può far ricorso a funzioni di aggregazione `SUM()`, `MIN()`, `MAX()` …;

- NON può utilizzare `GROUP BY` / `HAVING`;

- NON può contenere `UNION`;

- NON può contenere *sottoquery nella SELECT*

In MySQL, una vista con `JOIN` è aggiornabile solo se:

- l’UPDATE riguarda una sola tabella;

- la tabella aggiornata non è sul lato “molti”;

- non ci sono ambiguità nella chiave primaria;

---

### Vantaggi delle VIEW

#### Semplificano le query

```sql
CREATE VIEW iscritti AS
SELECT
    cognome,
    nome,
    email,
    titolo AS `Corso`,
    i.prezzo AS `Prezzo pagato`,
    data_isc AS `Data iscrizione`
FROM studenti s
JOIN iscrizioni i
ON s.id = i.studente_id
JOIN corsi c
ON c.id = i.corso_id;
```

Ora basta una query semplice:

```sql
SELECT * FROM iscritti; -- e aggiungere eventuali filtri con il WHERE, o GROUP BY...
```

Nota: Semplifica molto le interrogazioni frequenti ed evita ripetizioni.

---

#### Riducono l’impatto dei cambiamenti

Immagina di voler rinominare una colonna (c.titolo → c.nome_corso) e cambiare il nome di una tabella (es. Corsi → CatalogoCorsi): o uno dei due casi.

Tutte le query esistenti che usano nella SELECT la colonna titolo e il nome tabella Corsi non funzionerebbero più, perché la struttura del database è cambiata.

Se le query sono scritte ovunque nel codice, dovrai modificare tutte le query manualmente.

Ma se usi una vista intermedia, puoi semplicemente aggiornare solo la definizione della vista:

```sql
ALTER VIEW VistaCorsi AS
SELECT id, nome_corso AS titolo, prezzo, docente_id
FROM CatalogoCorsi;
```

E tutte le query che puntano a *VistaCorsi* continueranno a funzionare anche se la tabella cambia.

NOTA: Le viste fanno da “strato di astrazione” e isolano il codice dai cambiamenti nella struttura sottostante.

---

#### Limitano l'accesso ai dati

Supponiamo che un assistente didattico debba vedere solo le iscrizioni con nome e corso degli studenti, ma non i prezzi o le email degli studenti.

Puoi creare una vista sicura:

```sql
CREATE VIEW VistaIscrizioniLimitata AS
SELECT
  s.nome,
  s.cognome,
  c.titolo AS corso,
  i.data_isc
FROM Iscrizioni i
JOIN Studenti s ON i.studente_id = s.id
JOIN Corsi c ON i.corso_id = c.id;
```

Il DBA può condere poi i permessi di lettura solo su questa vista:

```sql
GRANT SELECT ON VistaIscrizioniLimitata TO assistente_didattico;
```

---

### VIEW con WITH CHECK OPTION

```sql
CREATE VIEW studenti_v AS
SELECT id, nome, cognome, email, provincia
FROM studenti
WHERE provincia = 'to'
WITH CHECK OPTION;
```

Specifica che **solo le righe accessibili dalla vista possono essere inserite o modificate**.

Quindi `INSERT` e `UPDATE` effettuate sulla la vista, non possono creare o modificare i dati di cui la vista non ha visibilità.

```sql
UPDATE studenti_v
SET provincia = 'cn'
WHERE id = 1; -- studente che ha provincia uguale a 'TO'
```

```sql
INSERT INTO studenti_v(nome, cognome, email, provincia)
VALUES('paolo','picchio','ppicchio89@msn.com','al');
```

L'update e l'insert restituiscono l'errore:

```bash
ERROR 1369 (HY000): CHECK OPTION failed 'studente_v'
```

Il `CHECK OPTION` è utile per garantire che gli utenti non possano 'uscire' dal perimetro della vista.

È possibile eliminare il check option ridefinendo la vista con ALTER VIEW.

---

Con `WITH CHECK OPTION`, una vista diventa **self-consistent**: non puoi inserire o modificare dati tramite la vista in modo da farli uscire dal filtro definito nella SELECT.

`WITH CHECK OPTION` non è standard SQL completo, ma fa parte dello standard SQL:1999 per le viste aggiornabili.

MySQL la supporta pienamente.

Anche altri RDBMS la implementano (PostgreSQL, SQL Server, Oracle hanno implementazioni simili, talvolta con sintassi diversa).