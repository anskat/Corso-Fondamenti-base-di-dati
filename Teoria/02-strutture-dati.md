# Strutture Dati e Modelli di Database

Le strutture dati rappresentano **il modo in cui le informazioni vengono organizzate e memorizzate** per facilitarne il recupero e la gestione.

Ogni struttura ha caratteristiche specifiche che la rendono più o meno adatta a determinati scenari applicativi.

Nei sistemi di basi di dati, queste strutture vengono implementate attraverso diversi modelli di database, ognuno progettato per rispondere a esigenze specifiche di utilizzo, performance e scalabilità.

---

## Modelli di database più diffusi

### Relazionale (RDBMS - Relational Database Management System)

In questo modello, i dati sono organizzati in tabelle (o relazioni), che possono essere pensate come fogli di calcolo.

Ogni tabella ha delle colonne (campi) e delle righe (record), dove le righe rappresentano entità specifiche e le colonne descrivono attributi delle entità.

- Organizza i dati in tabelle (righe e colonne).
- Relazioni tra le tabelle tramite chiavi primarie ed esterne.
- Ogni tabella ha colonne (campi) e righe (record):
    - righe = entità specifiche
    - colonne = attributi delle entità

Esempi: *MySQL*, *PostgreSQL*, *Oracle*, *SQL Server*

I database relazionali sono ottimi quando i dati sono strutturati e con relazioni definite, come in applicazioni aziendali, siti web o sistemi di gestione.

---

### Time Series Database

Le serie temporali sono una struttura in cui i dati vengono organizzati in base a un intervallo di tempo. Vengono utilizzate per tracciare cambiamenti e osservare tendenze nel tempo.

- Ottimizzato per la memorizzazione di dati temporali.
- Formato: Timestamp + Valore.

I Time Series Database sono progettati per memorizzare e interrogare grandi quantità di dati temporali: il punto chiave è l’ottimizzazione per timestamp e query su intervalli di tempo.


Esempi: *InfluxDB*, Time*scaleDB, Open*TSDB.

Esempio: sensori di temperatura che registrano la temperatura ogni ora:

```json
    {
        timestamp: "2025-02-21T12:00:00Z",
        temperatura: 22.5
    }
```

---

### Database Colonnare

- Memorizza i dati per colonne anziché per righe.

- Vantaggioso per analisi su grandi volumi di dati.

Esempi

- **Database colonnari analitici**: Amazon Redshift: ottimizzati per query su grandi dataset

Analisi di vendite con colonne separate per ogni mese:

Dati di partenza

| Prodotto | Data        | Vendite |
| ---      | ---         | ---     |
| A        | Gennaio     | 100     |
| A        | Febbraio    | 110     |
| B        | Gennaio     | 130     |
| B        | Febbraio    | 140     |

Analisi (risultato)

| Mese     | Vendite totali |
| ---      | ---            |
| Gennaio  | 230            |
| Febbraio | 250            |

Il risultato è una tabella di analisi ottenuta dai dati originali

---

### NoSQL (Not Only SQL)
- Pensato per scalabilità e flessibilità.

- Tipologie:
    - **Document-oriented**: Archivia dati in documenti JSON o BSON (es. MongoDB, CouchDB).

    - **Key-Value Store**: Struttura chiave-valore (es. Redis, DynamoDB). I Key-Value Store sono database NoSQL semplici e veloci, in cui ogni dato è identificato da una chiave unica. Sono ottimizzati per accesso diretto e scalabilità, ma non per query complesse o relazioni tra dati.

    - **Wide-Column Store**: Variante del database colonnare. Apache Cassandra, Google Bigtable: privilegiano scalabilità e distribuzione più che analisi complesse.
    Ogni riga può avere molte colonne, anche diverse da riga a riga. Ottimizzati per accesso rapido a sottoinsiemi di dati.

    - **Graph Database**: Gestisce dati con nodi e connessioni (es. Neo4j). I database a grafo sono ottimi per rappresentare e interrogare relazioni complesse tra oggetti, come reti sociali o connessioni tra entità.

Esempio: database documentale MongoDB che memorizza profili utente:

```json
    {
        "nome": "Mario",
        "cognome": "Rossi",
        "email": "mario.rossi@example.com"
    }
```

NoSQL non indica un singolo modello, ma una famiglia di database con caratteristiche diverse.

---

### Database a Grafo

- Memorizzano dati come nodi (oggetti) e archi (relazioni).

- I nodi possono rappresentare utenti, pagine, post, commenti;gli archi definiscono connessioni come “segue”, “amico di”, “ha scritto”.

- Nodi e archi possono avere attributi (es. nome, età, data, testo): Gli attributi dei nodi descrivono l’entità, quelli degli archi descrivono la relazione, come ad esempio quando è iniziata o il tipo di connessione

- Ideali per rappresentare relazioni complesse e interrogazioni su reti di connessioni.

Esempi: Neo4j, ArangoDB, Amazon Neptune.

Esempio di Arco: `[Utente A] ---segue---> [Utente B]`

Rappresentazione in grafo:

```json
{
  "nodo": "Utente A",
  "relazione": "segue",
  "destinazione": "Utente B",
  "data_inizio": "2025-01-10", 
  "tipo": "amico stretto"
}
```

---

### Database Vettoriali (Vector Database)

I database vettoriali **memorizzano i dati sotto forma di vettori numerici**, cioè liste di numeri che rappresentano informazioni complesse. Sono utilizzati soprattutto per:

- ricerca semantica: permette di trovare risultati in base al significato e non solo alle parole esatte usate;

- intelligenza artificiale: permettono di confrontare informazioni complesse come testi, immagini o suoni;

- machine learning: dati vengono trasformati in vettori numerici, che i database vettoriali memorizzano e confrontano in modo efficiente;

- sistemi di raccomandazione: suggeriscono contenuti simili a quelli già apprezzati dall’utente.

Invece di cercare corrispondenze esatte, permettono di trovare dati simili.

Esempio di utilizzo:

- ricerca di testi simili

- riconoscimento di immagini

- chatbot e sistemi basati su AI

Esempio concettuale:Un testo viene trasformato in un vettore:
```bash
[0.12, 0.87, 0.34, 0.56, ...]
```

Il database confronta questi vettori per trovare quelli più simili.

Ideale per applicazioni moderne basate su AI.

---

### Vantaggi e Svantaggi dei Diversi Modelli di Database

| Modello     | Vantaggi                                  | Svantaggi                              |
| ----        | ----                                      | ----                                   |
| Relazionale | Strutturato, sicuro, supporta transazioni | Scalabilità limitata                   |
| Time Series | Ottimizzato per dati temporali            | Meno flessibile per altri tipi di dati |
| Colonnare   | Performance su grandi dataset             | Non adatto a transazioni complesse     |
| Grafo       | Ottimo per dati relazionali complessi     | Più difficile da modellare             |
| NoSQL       | Scalabilità, flessibilità                 | Minore supporto per transazioni ACID   |