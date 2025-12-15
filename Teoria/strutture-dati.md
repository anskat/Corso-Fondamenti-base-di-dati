# Strutture Dati e Modelli di Database

Le strutture dati rappresentano **il modo in cui le informazioni vengono organizzate e memorizzate** per facilitarne il recupero e la gestione.

Ogni struttura ha caratteristiche specifiche che la rendono più o meno adatta a determinati scenari applicativi.

Nei database, le strutture dati vengono implementate attraverso diversi modelli di organizzazione, ognuno pensato per esigenze specifiche.

---

## Modelli di database più diffusi

# Relazionale (RDBMS - Relational Database Management System)

- Organizza i dati in tabelle (righe e colonne).
- Relazioni tra le tabelle tramite chiavi primarie ed esterne.

In questo modello, i dati sono organizzati in tabelle (o relazioni), che possono essere pensate come fogli di calcolo.

Ogni tabella ha delle colonne (campi) e delle righe (record), dove le righe rappresentano entità specifiche e le colonne descrivono attributi delle entità.

Esempi: *MySQL*, *PostgreSQL*, *Oracle*, *SQL Server*

---

# Time Series Database

Le serie temporali sono una struttura in cui i dati vengono organizzati in base a un intervallo di tempo. Vengono utilizzate per tracciare cambiamenti e osservare tendenze nel tempo.

- Ottimizzato per la memorizzazione di dati temporali.
- Formato: Timestamp + Valore.

Esempi: *InfluxDB*, Time*scaleDB, Open*TSDB.

Esempio: sensori di temperatura che registrano la temperatura ogni ora:

    {
        timestamp: "2025-02-21T12:00:00Z",
        temperatura: 22.5
    }