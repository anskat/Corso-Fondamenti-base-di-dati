## DCL

*Data Control Language*

Il DCL (Data Control Language) permette di **gestire il controllo degli accessi e i permessi** per gli utenti del DBMS.

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

```database.*``` : nome del database sul quale l'utente potrà eseguire le istruzioni consentite.

Per tutte le tabelle del db: .* .
Si può specificare il nome di una o più tabelle.
Per tutti i database: *.*  .

nameuser : specifica il nome dell'utente al quale vogliamo assegnare i permessi.

host : specifica il/gli host da cui è ammessa la connessione.

Se voglio indicare più IP devo usare la wild card %: 130.192.200.%