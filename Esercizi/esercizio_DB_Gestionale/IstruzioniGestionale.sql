
/*

Esercizio:
Gestione operativa shop ("Gestionale")

Requisiti necessari per strutturare il database gestionale per una attività di e-commerce.

- Anagrafica Clienti e Fidelizzazione
Vogliamo archiviare in modo preciso i dati di ogni cliente: nome, cognome e contatti (telefono ed email), residenza completa di indirizzo, città, provincia e regione.
Ogni cliente è associato a un credito accumulato, (1 punto per ogni euro speso), che ne definisce lo status nel programma fedeltà.

- Catalogo Prodotti e Magazzino
Il catalogo dei prodotti deve gestire articoli identificati da una descrizione e un prezzo di vendita.
Per ogni articolo monitoriamo la rimanenza a magazzino.
Ogni prodotto deve appartenere obbligatoriamente a una categoria predefinita (come Display, Storage, Software Ufficio, ecc.), della quale vogliamo conservare anche una descrizione estesa.

- Organizzazione del Personale
L'azienda è strutturata in Uffici geograficamente distribuiti (IT, Amministrazione, Vendita, ecc.), di cui censiamo contatti e ubicazione.
In questi uffici operano gli Impiegati.
Per ciascuno di essi, oltre ai dati anagrafici, dobbiamo registrare il ruolo professionale, lo stipendio e la struttura gerarchica (ovvero chi è il responsabile diretto di ogni dipendente).

- Ciclo di Vendita e Spedizioni
Ogni ordine deve contenere la data di emissione, l'indirizzo di spedizione e deve essere collegato sia al cliente che lo ha effettuato, sia all'impiegato che ha gestito la pratica.
Lo stato dell'ordine può variare esclusivamente tra: 'consegnato', 'da spedire' o 'spedito'.
Poiché un ordine può includere più prodotti in diverse quantità, è necessaria una gestione di Dettaglio.
In questa fase, dobbiamo registrare il prezzo unitario dell'articolo al momento della transazione, indipendentemente dal listino attuale nel catalogo articoli.

------------------------------------------------------------------------------------------------------------------------------------------------------------

Obiettivi del Progetto

-- FASE 1: Progettazione (Lavoro di Gruppo)
Creazione dei gruppi: in gruppo dovrete produrre la documentazione progettuale relativa allo schema concettuale e logico:
- Schema concettuale: realizzazione del diagramma Entità/Associazioni (E-R), definendo correttamente le cardinalità (1:1, 1:N, N:M) e gli attributi (strumento: draw.io).
- Schema logico: traduzione del modello E-R in tabelle, identificando le Chiavi Primarie (PK) e le Chiavi Esterne (FK).

-- FASE 2: Implementazione (Lavoro Individuale)
Singolarmente dovrete:
- Creare un nuovo database denominato: Gestionale. 
- Assegnare i privilegi di accesso totali all'utente attuale per questo database.
- Scrivere il codice SQL per la creazione delle tabelle.

Vincoli Tecnici:
Utilizzate i tipi di dato appropriati (es. DECIMAL per valori monetari, ENUM per gli stati ordine, interi per quantità e rimanenze).
Definite correttamente i vincoli di FOREIGN KEY per garantire la consistenza dei dati tra le tabelle correlate.