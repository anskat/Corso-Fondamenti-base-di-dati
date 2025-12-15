## DBMS
### database management system

- È il software per la creazione e la manipolazione di un database.
È un **software di tipo server** (client-server) avente il compito di gestire uno o più database; questo vuol dire che il DBMS deve intervenire, **in qualità di intermediario**, in ogni operazione svolta sui database dai software che ne fanno utilizzo.

- **Definisce** gli **utenti** e gli **amministratori** di un database.

- Fornisce **meccanismi di sicurezza**, **protezione** e controllo **dell’integrità dei dati**.

---

### Cosa fa un DBMS?

| Funzione      | Descrizione |
| ----------- | ----------- |
| Gestione dati      | Crea, legge, modifica, elimina       |
| Sicurezza   | Controllo accessi, permessi        |
| Integrità   | Regole sui dati, relazioni        |
| Concorrenza   | Accessi simultanei        |
| Persistenza   | Salvataggio stabile nel tempo        |
| Architettura   | Funziona come server in ambienti client-server        |

Il DBMS è l’intermediario tra i programmi e i dati, garantendo coerenza, sicurezza e prestazioni.

---

### Componenti principali di un DBMS

**Motore di archiviazione** → gestisce come i dati sono salvati (es. InnoDB, MyISAM)
**Motore delle query** → interpreta ed esegue le istruzioni SQL
**Gestore delle transazioni** → garantisce che i dati siano consistenti
**Controllo degli accessi** → gestisce utenti, ruoli e permessi
**Catalogo (metadati)** → contiene le informazioni sulla struttura del database

---

## RDBMS
### relational database management system

- MySQL è un software appartenente alla famiglia dei DBMS. All'interno di questo gruppo di software è possibile identificare dei sotto-insiemi più specifici tra cui, ad esempio, quello dei DBMS NoSQL (MongoDB) e quello dei RDBMS a cui appartiene tra gli altri, appunto, MySQL.

- Gli RDBMS non sono altro che dei sistemi di gestione delle banche dati che operano in aderenza alla teoria relazionale secondo la quale il sistema deve operare sui dati mediante relazioni tra le diverse tabelle in cui questi vengono suddivisi e ordinati. 

- Nel modello relazionale, infatti, i dati all'interno di un database sono organizzati in differenti tabelle le quali sono in relazione tra loro.

---

## Storage Engine

Gli storage engine rappresentano delle librerie che determinano il modo in cui i dati di una tabella saranno salvati su disco.

Ciò sarà determinante per valutare le prestazioni, l’affidabilità, le funzionalità offerte dalla tabella stessa, rendendola più o meno adatta a particolari utilizzi.

In pratica, scegliere un particolare storage engine significa scegliere il modo in cui i dati vengono gestiti.

### MyISAM

Si tratta di un motore di memorizzazione veloce. Non supporta le transazioni. Non utilizza meccanismi di integrità referenziale.

- Adatto per le **ricerche full-text**;
- È **più veloce** poiché non è necessario tenere conto delle varie relazioni tra le tabelle;
esegue il **lock sull’intera tabella**;
- ottimo se le tabelle vengono utilizzate principalmente in fase di lettura oppure **se il database è relativamente poco complesso**.

A partire dalla versione 5.5 di MySQL, *InnoDB è lo Storage Engine di default*.
Prima era MyISAM.

### InnoDB

Lo scopo di InnoDB è quello di associare maggiore sicurezza (intesa soprattutto come consistenza ed integrità dei dati) a performance elevate.
Funzionalità peculiari:

- **Transizioni**: per transazione si intende la possibilità di un DBMS di svolgere più operazioni di modifica dei dati, facendo sì che i risultati diventino persistenti nel database solo in caso di successo di ogni singola operazione. In caso contrario, verranno annullate tutte le modifiche apportate;

- **Integrità referenziale**: conferiscono la possibilità di creare una relazione logica tra i dati di due tabelle, in modo da impedire modifiche all’una che renderebbero inconsistenti i dati dell’altra;

- Esegue il **lock a livello di riga**;

- **Ricerche full-text** *a partire da MySql 5.6*.

---

## Charset e Collation

I **character set** (insiemi di caratteri) sono i diversi sistemi attraverso i quali i caratteri alfanumerici, i segni di punteggiatura e tutti i simboli rappresentabili su un computer vengono memorizzati in un valore binario.In ogni set di caratteri, ad un valore binario corrisponde un carattere ben preciso.

Con MySQL, a partire dalla versione 4.1, possiamo gestire i set di caratteri a livello di server, database, tabella e singola colonna, nonché di client e di connessione. 

Ad ogni set di caratteri sono associate una o più **collation**, che rappresentano i modi possibili di confrontare le stringhe di caratteri facenti parte di quel character set.

In MySQL 8 il set di caratteri consigliato e predefinito è **utf8mb4** (UTF-8 vero (4 byte), oggi default).

La collation consigliata è **utf8mb4_0900_ai_ci** (accent-insensitive e case-insensitive)...

### Esempio

Supponiamo di avere un alfabeto di quattro lettere: *A*, *B*, *a*, *b*.

Assegnamo ad ogni lettera un numero: A = 0, B = 1, a = 2, b = 3.

*La lettera A è un simbolo*, il *numero 0* è la *codifica per A*, e **la combinazione di tutte e quattro le lettere e la loro codifica è il character set**.

Supponiamo che vogliamo confrontare due valori di stringa, A e B.

Il modo più semplice per farlo è quello di guardare le codifiche: 0 per A e 1 per B.
Poiché 0 è minore di 1, diciamo A è inferiore a B.
Quello che abbiamo appena fatto è applicare un metodo di confronto per il nostro set di caratteri.

La **collation** è un insieme di regole (una sola regola in questo caso): "Confronta le codifiche".