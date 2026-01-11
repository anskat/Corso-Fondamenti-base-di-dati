# Strutture Dati e Modelli di Database

Le strutture dati rappresentano **il modo in cui le informazioni vengono organizzate e memorizzate** per facilitarne il recupero e la gestione.

Ogni struttura ha caratteristiche specifiche che la rendono più o meno adatta a determinati scenari applicativi.

Nei sistemi di basi di dati, queste strutture vengono implementate attraverso diversi modelli di database, ognuno progettato per rispondere a esigenze specifiche di utilizzo, performance e scalabilità.

---

## Modelli di database più diffusi

### Relazionale (RDBMS - Relational Database Management System)

- Organizza i dati in tabelle (righe e colonne).
- Relazioni tra le tabelle tramite chiavi primarie ed esterne.

In questo modello, i dati sono organizzati in tabelle (o relazioni), che possono essere pensate come fogli di calcolo.

Ogni tabella ha delle colonne (campi) e delle righe (record), dove le righe rappresentano entità specifiche e le colonne descrivono attributi delle entità.

Esempi: *MySQL*, *PostgreSQL*, *Oracle*, *SQL Server*

---

### NoSQL (Not Only SQL)
- Pensato per scalabilità e flessibilità.
- Tipologie:
    - **Document-oriented**: Archivia dati in documenti JSON o BSON (es. MongoDB, CouchDB).
    - **Key-Value Store**: Struttura chiave-valore (es. Redis, DynamoDB).
    - **Wide-Column Store**: Variante del database colonnare (es. Apache HBase, ScyllaDB).
    - **Graph Database**: Gestisce dati con nodi e connessioni (es. Neo4j).

Esempio: database documentale MongoDB che memorizza profili utente:

```json
    {
        "nome": "Mario",
        "cognome": "Rossi",
        "email": "mario.rossi@example.com"
    }
```

---

### Time Series Database

Le serie temporali sono una struttura in cui i dati vengono organizzati in base a un intervallo di tempo. Vengono utilizzate per tracciare cambiamenti e osservare tendenze nel tempo.

- Ottimizzato per la memorizzazione di dati temporali.
- Formato: Timestamp + Valore.

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

- **Database colonnari analitici**: Amazon Redshift

- **Wide-column store**: Apache Cassandra, Google Bigtable

Analisi di vendite con colonne separate per ogni mese:
    
    Prodotto | Gennaio | Febbraio | Marzo

---

### Database a Grafo

- Struttura a nodi (rappresentano oggetti, come utenti, pagine, post, commenti) e archi (definiscono le relazioni tra i nodi, ad esempio "segue", "amico di", "ha scritto", "ha commentato").

- Ogni nodo e ogni arco può avere proprietà aggiuntive (es. nome, età, data di creazione, testo del post, ecc.).

Ottimo per rappresentare relazioni complesse.

Esempi: *Neo4j*, *ArangoDB*, *Amazon Neptune*.

Esempio di Arco: Nodo Utente A connesso da un arco segue a Utente B.

Rappresentazione in grafo:

```json
{
    "nodo": "Utente A",
    "relazione": "segue",
    "destinazione": "Utente B"
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