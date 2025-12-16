## Progettazione

### Modello Concettuale

**Definizione**: rappresenta i dati e le loro relazioni a un livello astratto, senza preoccuparsi di dettagli tecnici o implementativi.

**Obiettivo**: descrivere la struttura dei dati in modo comprensibile per utenti e analisti, senza vincoli tecnologici.

**Strumento tipico**: diagrammi Entity-Relationship (ER) o UML class diagrams (Unified modeling language).

**Indipendenza dal DBMS**: Questo modello non dipende dal database relazionale, NoSQL o altro.

---

### Modello Logico

**Definizione**: traduce il modello concettuale in una struttura più dettagliata e aderente alle regole di un particolare tipo di database (es. relazionale).

**Obiettivo**: definire tabelle, attributi, chiavi primarie e chiavi esterne, mantenendo ancora un livello di astrazione dalla tecnologia specifica.

**Strumento tipico**: Schema relazionale (tabelle, colonne, vincoli).

**Dipendenza dal tipo di database**: nel caso del modello relazionale, si definiscono relazioni tra tabelle con chiavi primarie e chiavi esterne.

---

### Modello Fisico

**Definizione**: rappresenta la struttura effettiva del database come verrà implementata su un determinato DBMS.

**Obiettivo**: ottimizzare il database per le prestazioni, definendo dettagli come tipi di dati specifici, indici, partizionamento, ecc.

**Strumento tipico**: DDL (Data Definition Language) SQL per creare tabelle, vincoli, indici.

**Dipendenza dal DBMS**: strettamente legato a un DBMS specifico (es. MySQL, PostgreSQL, Oracle).

---

## Fasi della progettazione

| 1. Modello CONCETTUALE                                       | 2. Modello LOGICO                                                | 3. Modello FISICO                                       |
|---------------------------------------------------------------|-----------------------------------------------------------------|---------------------------------------------------------|
| Rappresenta i dati e le loro relazioni a un livello astratto, senza preoccuparsi di dettagli tecnici o implementativi | Traduce il modello concettuale in una struttura più dettagliata e aderente alle regole di un particolare tipo di database. | Rappresenta la struttura effettiva del database come verrà implementata su un determinato DBMS |

---

## Progettazione: modello relazionale

### Diagramma E-R, simboli

#### Entità

Concetto fondamentale, generale, per la realtà che si sta modellando.

Rappresenta **classi di oggetti** (fatti, cose, persone, ...) che hanno **proprietà comuni** ed **esistenza autonoma** ai fini dell'applicazione di interesse.

- Identificata da un rettangolo

![entità](/assets/images/entita.png)

---

#### Attributo

**Caratteristiche specifiche di un’entità**, utili (o necessarie) nella realtà da modellare

- identificata da un cerchio collegato all’entità

![attributo](/assets/images/attributo.png)

---

L’insieme di attributi che garantisce **l’univocità** delle istanze di un’entità è detta:

**Chiave Primaria**

È indicata come: PRIMARY KEY o PK

- Identificata graficamente con un cerchio pieno, collegato all’entità e relativo nome attributo sottolineato

![chiave](/assets/images/chiave.png)

**Caratteristiche**

L’insieme dei campi i cui valori identificano univocamente un record all’interno di una tabella è detto Chiave Primaria.

Quando la chiave primaria è composta da un solo campo, si parla di campo chiave.

Quando non è possibile trovare un campo chiave tra gli attributi di una entità, si definisce un campo univoco di tipo numerico che si auto-incrementa (contatore): ID (identifier).

Esempi di campo chiave: *matricola*, *codice fiscale*, etc.

---

#### Istanze di un’Entità

Specifici dati, oggetti appartenenti ad un’entità.

- non sono rappresentate nel Diagramma E-Rma si intendono contenute in ogni entità:

- Carlo Rossi, via Verdi è *un’istanza* dell’**entità** *STUDENTE* (**attributi**: *Nome*, *Cognome*, *Indirizzo*) 

![istanza](/assets/images/istanza.png)

Possiamo considerare le entità come insiemi all’interno dei quali sono contenuti oggetti (le istanze) ciascuno con specifiche caratteristiche (valore degli attributi).

![istanza-insieme](/assets/images/istanza-insieme.png)

---

#### Relazioni (Associazioni)

Collegamenti logici che uniscono due o più entità nella realtà descritta dal database

- identificata da un rombo collegato alle due entità

![relazione](/assets/images/relazione.png)