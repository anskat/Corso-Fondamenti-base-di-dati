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

nomeuser
È il nome dell’utente che si desidera creare.

host (localhost)
Specifica da quale host (macchina) l’utente può connettersi al database.

- localhost → l’utente può connettersi solo dalla macchina locale

- % → l’utente può connettersi da qualsiasi host

- 192.168.1.10 → l’utente può connettersi solo da un host specifico

Nelle installazioni locali, durante le esercitazioni, si utilizza normalmente localhost.

passwordscelta
È la password associata all’utente che stiamo creando.

⚠️ La password va scritta in chiaro nel comando SQL, ma MySQL la memorizza in forma crittografata.