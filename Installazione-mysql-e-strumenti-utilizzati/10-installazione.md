## Installazione MySQL 8.x

Dal sito di mysql scaricate il pacchetto relativo al vostro sistema operativo (Linux, Windows o MacOS).

https://dev.mysql.com/downloads/mysql/

Scarica la versione LTS (Long Term Support) di MySQL: è stabile e riceve aggiornamenti di sicurezza e correzioni di bug per lungo tempo.


# Download e installazione MySQL LTS
Il client mysql verrà installato nella cartella

| Sistema Operativo | Percorso client predefinito |
|------------------|-----------------------------|
| Windows          | `C:\Program Files\MySQL\MySQL Server 8.4\bin` |
| macOS            | `/usr/local/mysql-8.4.xx-macos10.xx-x86_64/bin` |
| Linux            | `/usr/bin/mysql` (se installato da pacchetto) |


### Avvio del servizio MySQL

MySQL viene eseguito come **servizio** (Windows) o come **daemon** (Linux/macOS).

Un servizio o daemon è un programma in esecuzione continua nel sistema operativo, che rimane in attesa di richieste per fornire specifiche funzionalità.

---

#### Linux / macOS (daemon)

- Il processo si chiama `mysqld`.
- Può avviarsi automaticamente all’avvio del sistema, a seconda della configurazione scelta durante l’installazione.
- Comandi principali:
  
Avviare il server:

```bash
sudo systemctl start mysql      # per sistemi con systemd
sudo service mysql start        # per sistemi con SysVinit
```

Fermare il server:

```bash
sudo systemctl stop mysql
sudo service mysql stop
```

Verificare lo stato del server:

```bash
mysqladmin -u root -p ping
```

Output atteso:

```bash
mysqld is alive
```

se invece non è attivo, verrà mostrato un errore di connessione.

```bash
mysqladmin: connect to server at 'localhost' failed
error: 'Can't connect to local MySQL server through socket '/tmp/mysql.sock' (2)'
Check that mysqld is running and that the socket: '/tmp/mysql.sock' exists!
```