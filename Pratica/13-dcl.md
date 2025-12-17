## DCL

*Data Control Language*

Il DCL (Data Control Language) permette di **gestire il controllo degli accessi e i permessi** per gli utenti del DBMS.

In questa sezione vengono illustrate le **istruzioni fondamentali** per creare un **utente applicativo** MySQL, ovvero un utente dedicato all’accesso a uno specifico database da parte di un’applicazione.

L’utente applicativo potrà:
- accedere **solo al database assegnato**
- operare esclusivamente sugli oggetti presenti in tale database  
  (tabelle, viste, indici, ecc.)

Non avrà visibilità né permessi sugli altri database del sistema.

---

### Perché usare un utente applicativo

Questa configurazione rappresenta una **buona pratica standard** nell’utilizzo dei database, poiché:
- applica il **principio dei privilegi minimi**
- riduce il rischio di accessi o modifiche accidentali ad altri database
- migliora la **sicurezza** e l’**isolamento** dei dati

---

### Informazioni necessarie

Per configurare correttamente l’accesso sono necessari:

- **Nome del database**  
  a cui l’utente è autorizzato ad accedere

- **Nome dell’utente**  
  che verrà utilizzato dall’applicazione

- **Password associata all’utente**  
  utilizzata per l’autenticazione

- **Host (macchina di origine)**  
  da cui l’utente è autorizzato a connettersi al DBMS

---

### Istruzione `CREATE USER`

Consente di creare un nuovo utente e di assegnargli una password.

```sql
CREATE USER 'nomeuser'@'localhost' IDENTIFIED BY 'passwordscelta';
```

Significato dei parametri

*nomeuser*
È il nome dell’utente che si desidera creare.

*host* (localhost)
Specifica da quale host (macchina) l’utente può connettersi al database.

- localhost → l’utente può connettersi solo dalla macchina locale

- % → l’utente può connettersi da qualsiasi host

- 192.168.1.10 → l’utente può connettersi solo da un host specifico

Nelle installazioni locali, durante le esercitazioni, si utilizza normalmente localhost.

*passwordscelta*
È la password associata all’utente che stiamo creando.

⚠️ La password va scritta in chiaro nel comando SQL, ma MySQL la memorizza in forma crittografata.

---

### Istruzione `GRANT``

Assegna i permessi e/o privilegi a un utente.

```sql
GRANT [istruzioni consentite]
ON namedatabase.*
TO 'nameuser'@'host';
```

Istruzioni_consentite.
Elenco delle operazioni che l’utente è autorizzato a eseguire

```CREATE, SELECT, UPDATE, DELETE, ALTER, DROP,…```

Per dare all'utente permessi completi utilizzare la parola chiave

```sql
GRANT ALL
```

**Specifica del database e delle tabelle**

- namedatabase.*
→ indica il database sul quale l’utente può eseguire le istruzioni consentite su tutte le tabelle

- namedatabase.tabella
→ indica una singola tabella

- *.*
→ assegna i permessi su tutti i database

**Specifica dell’utente**

- nameuser: nome dell’utente al quale si vogliono assegnare i permessi.

- host: specifica da quali host (macchine) è ammessa la connessione:

   - localhost → solo dalla macchina locale

   - % → da qualsiasi host

   - 130.192.200.% → da tutti gli host della sottorete indicata

Esempio:

```sql
GRANT SELECT, INSERT
ON namedatabase.*
TO 'nameuser'@'130.192.200.%';
```
---

### Istruzione `REVOKE`

Rimuove permessi e/o privilegi precedentemente assegnati a un utente.

```sql
REVOKE istruzioni_revocate
ON databaseName.*
FROM 'user'@'host';
```

Per REVOKE valgono le stesse regole viste per GRANT riguardo:

- database e tabelle (database.*, database.tabella, *.*)

- utente e host ('user'@'host')

**Revoca di tutti i privilegi**

Per eliminare tutti i privilegi assegnati a un utente:

```sql
REVOKE ALL PRIVILEGES, GRANT OPTION
FROM 'user'@'host';
```

Questa istruzione rimuove:

- tutti i privilegi sull’accesso ai database

- la possibilità di concedere permessi ad altri utenti (GRANT OPTION)

La revoca ha effetto immediato sulle nuove connessioni.
Le sessioni già aperte potrebbero richiedere una riconnessione.

---

### Cambiare/aggiornare la password MySQL degli utenti

Per cambiare una normale password utente devi digitare:

```sql
-- Cambia password per l’utente (da root):
ALTER USER 'userName'@'host' IDENTIFIED BY 'newpass';
```

```sql
-- Cambiare la propria password:
ALTER USER USER() IDENTIFIED BY 'newpass';
```
---

### Verificare i permessi utente

*Verificare i privilegi di uno specifico utente*

```sql
SHOW GRANTS FOR 'user'@'localhost';
```

*Verificare i privilegi dell'utente attualmente loggato a MySQL*

```sql
SHOW GRANTS FOR CURRENT_USER;
```

*Eliminare un utente da MySQL*

```sql
DROP USER 'user'@'localhost';
```
questo comando rimuove l'utente e i suoi permessi.

*Visualizzare elenco utenti mysql (solo utente root)*

```sql
SELECT user, host FROM mysql.user;
```