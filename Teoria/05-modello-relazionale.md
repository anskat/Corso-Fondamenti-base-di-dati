## Il modello relazionale

- La **tabella** è la **struttura dati fondamentale** di un database relazionale; 
- Con le tabelle si rappresentano le **entità** e le **relazioni** del modello concettuale[^1];
- La tabella è composta da campi (colonne o **attributi**) e da record (righe o **tuple**);
- Ogni **campo** rappresenta un **attributo** dell’entità/ relazione;
- Per ogni campo viene individuato un suo **dominio** (*tipo di dati*): alfanumerico, numerico, data…
- Ogni **record** rappresenta una *istanza* (o occorrenza o *tupla*) dell’entità/relazione;
- Garantisce **l’integrità referenziale**;

[^1]: **Modello concettuale**: trasformazione di specifiche in linguaggio naturale (che definiscono la realtà descritta dal DB) in uno schema grafico chiamato *Diagramma E-R* che utilizza due concetti fondamentali: **Entità** e **Associazione/Relazione**.

## Progettazione: modello relazionale

### Diagramma E-R, simboli

#### Entità

Concetto fondamentale, generale, per la realtà che si sta modellando.

Rappresenta **classi di oggetti** (fatti, cose, persone, ...) che hanno **proprietà comuni** ed **esistenza autonoma** ai fini dell'applicazione di interesse.

Identificata da un rettangolo

| STUDENTE      |
| :----:        |