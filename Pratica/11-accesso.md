## Primo accesso

### Accesso al DBMS

*Amministratore del servizio (DBA - DataBase Administrator)*

Da terminale accedere a MySql:

```bash
mysql -u root -p
```

Vi verrà chiesto di inserire la password di amministratore( è quella creata in fase di installazione)

Se tutto ok, vedrete il monitor di MySQL

```bash
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 16
Server version: 8.0.23 MySQL Community Server - GPL

Copyright (c) 2000, 2021, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> 
```

Visualizzate elenco database disponibili:

```bash
mysql> SHOW DATABASES;
```

Essendo una prima installazione dovreste vedere i seguenti db:

```bash
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
4 rows in set (0.01 sec)

mysql>
```

I database elencati sono funzionali al servizio, sono disponibili solo all’amministratore del sistema;

*information_schema* e *performance_schema* sono disponibili anche all’utente per ottenere informazioni sul proprio database e sulle prestazioni delle query.