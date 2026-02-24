/*
Usate l'utente root, amministratore
Create un database chiamato Corsi
Assegnate all'utente appjava tutti i privilegi sul database appena creato
*/

/*
Collegatevi come utente appjava, usate il database Corsi e create le tabelle seguenti:
Corsi, Docenti, Iscrizioni, Studenti
le tabelle fanno riferimento alla struttura del database Corsi descritto nelle slide
l'elenco delle tabelle e rispettive colonne è elencato di seguito:
*/

/*
tabella Docenti
  id tipo intero che si auto incrementa, chiave primaria
  nome tipo stringa max 50 caratteri, obbligatorio
  cognome tipo stringa max 50 caratteri, obbligatorio
  email tipo stringa max 100 caratteri, unico, obbligatorio
*/

/*
tabella Corsi
  id tipo intero che si auto incrementa, chiave primaria
  titolo tipo stringa max 100 caratteri, obbligatorio
  prezzo tipo decimal 6 cifre di cui 2 decimali, obbligatorio
  docente_id tipo intero positivo, bastano 255 valori, può essere nullo
*/

/*
tabella Studenti
  id tipo intero che si auto incrementa, chiave primaria
  nome tipo stringa max 50 caratteri, obbligatorio
  cognome tipo stringa max 50 caratteri, obbligatorio
  genere tipo stringa: elenco di stringhe possibili 'f','m','nb',
  indirizzo tipo stringa max 100 caratteri,
  citta tipo stringa max 30 caratteri,
  provincia tipo stringa fissa di 2 caratteri, valore di default: 'To',
  regione tipo stringa max 30 caratteri, valore di default: 'Piemonte',
  email tipo stringa max 100 caratteri, unico, obbligatorio
  data_nascita tipo data,
  data_registrazione il valore di default deve essere current_timestamp,
*/

/*
tabella Iscrizioni
  id tipo intero che si auto incrementa, chiave primaria
  studente_id tipo intero obbligatorio
  corso_id tipo intero obbligatorio
  prezzo tipo decimal 6 cifre di cui 2 decimali, obbligatorio
  data_iscrizione, il valore di default deve essere current_timestamp
*/