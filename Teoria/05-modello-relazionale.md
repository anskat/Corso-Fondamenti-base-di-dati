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

#### Diagramma Entity-Relationship

![diagrammaE-R](/assets/images/diagrammaE-R.png)

---

#### Modello logico

![diagrammaE-R](/assets/images/modello-logico.png)