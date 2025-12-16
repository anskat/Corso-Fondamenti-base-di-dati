## Il modello relazionale

- La **tabella** è la **struttura dati fondamentale** di un database relazionale; 
- Con le tabelle si rappresentano le **entità** e le **relazioni** del modello concettuale[^1];
- La tabella è composta da campi (colonne o **attributi**) e da record (righe o **tuple**);
- Ogni **campo** rappresenta un **attributo** dell’entità/ relazione;
- Per ogni campo viene individuato un suo **dominio** (*tipo di dati*): alfanumerico, numerico, data…
- Ogni **record** rappresenta una *istanza* (o occorrenza o *tupla*) dell’entità/relazione;
- Garantisce **l’integrità referenziale**;

[^1]: **Modello concettuale**: trasformazione di specifiche in linguaggio naturale (che definiscono la realtà descritta dal DB) in uno schema grafico chiamato *Diagramma E-R* che utilizza due concetti fondamentali: **Entità** e **Associazione/Relazione**.

## Progettazione Database Corsi

### Esempio

**Database per una applicazione web che gestisce l’acquisto/iscrizione dei/ai corsi.**

Disegnare una base dati per la gestione dell'acquisto di corsi offerti da una piattaforma web.

- Gli utenti/studenti devono essere registrati sulla piattaforma, per registrarsi occorre nome, cognome ed email. Viene memorizzata anche la data di registrazione.

- Gli studenti/utenti possono acquistare molti corsi. I corsi sono quindi a pagamento. Viene memorizzata anche la data di acquisto.

- Il prezzo del corso può variare nel tempo.

- I corsi si riferiscono a svariate materie quali: Java, Base di programmazione, Html, CSS, CMS, Javascript, React, PHP…

- Ogni corso viene tenuto da un docente. Un docente può insegnare in molti corsi.

---

### Modello Concettuale

**Definizione**: rappresenta i dati e le loro relazioni a un livello astratto, senza preoccuparsi di dettagli tecnici o implementativi.

#### Diagramma Entity-Relationship

![diagrammaE-R](/assets/images/diagrammaE-R.png)

---

#### Modello logico

**Definizione**: traduce il modello concettuale in una struttura più dettagliata e aderente alle regole di un particolare tipo di database (es. relazionale).

![diagrammaE-R](/assets/images/modello-logico.png)

---

#### Modello fisico

**Definizione**: rappresenta la struttura effettiva del database come verrà implementata su un determinato DBMS.

In questo caso RDBMS MySQL

Codice MySQL di esempio (per una comprensione completa vedere la sezione SQL - DDL e Tipi di Dati)

    ```sql
    CREATE TABLE IF NOT EXISTS Docenti (
        id int AUTO_INCREMENT,
        nome varchar(50) NOT NULL,
        cognome varchar(50) NOT NULL,
        email varchar(100) NOT NULL,
        PRIMARY KEY (id),
        UNIQUE KEY email (email)
    );

    CREATE TABLE IF NOT EXISTS Corsi (
        id int AUTO_INCREMENT,
        titolo varchar(100) NOT NULL,
        prezzo decimal(6,2) NOT NULL,
        docente_id tinyint unsigned,
        PRIMARY KEY (id)
    );

    CREATE TABLE IF NOT EXISTS Studenti (
        id int AUTO_INCREMENT,
        nome varchar(50) NOT NULL,
        cognome varchar(50) NOT NULL,
        genere enum('m','f', 'nb'),
        indirizzo varchar(100),
        citta varchar(30),
        provincia char(2) DEFAULT 'To',
        regione varchar(30) DEFAULT 'Piemonte',
        email varchar(100) NOT NULL UNIQUE,
        data_nascita date,
        data_reg timestamp NULL DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (id)
    );

    CREATE TABLE IF NOT EXISTS Iscrizioni (
        studente_id int NOT NULL,
        corso_id int NOT NULL,
        prezzo decimal(6,2) NOT NULL,
        data_isc timestamp NULL DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (studente_id, corso_id)
    );
    ```