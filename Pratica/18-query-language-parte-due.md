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

**Interrogazione con più tabelle nel FROM**

Possiamo interrogare entrambe le tabelle nello stesso momento scrivendo:

```sql
SELECT nome, cognome, email, titolo
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