## Tipi di dato

In una tabella per ciascuna colonna possiamo definire diversi tipi di dato (dominio):

- Numerics (numeri interi e a virgola mobile)
- String (stringa)
- Date , Time (data e ora)
- JSON

---

### Dati numerici: interi

| Tipo | Intervallo di valori | Solo se positivi (UNSIGNED) |
|------|----------------------|-----------------------------|
| BIT(M) | Da 1 a 64 | / |
| TINYINT (1 byte) | da -128 a +127 | da 0 a 255 |
| SMALLINT (2 byte) | da -32 768 a +32 767 | da 0 a 65 535 |
| MEDIUMINT (3 byte) | da -8 388 608 a +8 388 607 | da 0 a 16 777 215 |
| INT (4 byte) | da -2 147 483 648 a +2 147 483 647 | da 0 a 4 294 967 295 |
| BIGINT (8 byte) | da -9 223 372 036 854 775 808 a +9 223 372 036 854 775 807 | da 0 a 18 446 744 073 709 550 615 |

E' importante precisare che se all'interno di un campo di tipo numerico si cerca di inserire un valore maggiore di quanto ammesso dal tipo prescelto, MySQL produrrà un errore (nella configurazione di default del server).

---

### Tipi di numeri in virgola mobile (valore approssimativo)

| Tipo | Tipo (sintassi)1 | Tipo (sintassi deprecata)2 | Spazio |
|------|------------------|-----------------------------|--------|
| FLOAT | FLOAT[(p)], con p compreso tra 0 e 23 | FLOAT, FLOAT(M,D)* | 4 byte |
| DOUBLE | FLOAT[(p)], con p compreso tra 24 e 53 | DOUBLE, DOUBLE(M,D)* | 8 byte |
| DECIMAL | DECIMAL(M,D) |  | Dipende da M* |


Nel caso di FLOAT, puoi specificare opzionalmente la precisione, usando una sintassi tipo FLOAT(p), dove "p" è la precisione in bit.

Se la precisione è tra 0 e 23, la colonna sarà considerata di tipo FLOAT e userà 4 byte.

Se la precisione è tra 24 e 53, sarà considerata di tipo DOUBLE e userà 8 byte.

MySQL permette anche una sintassi non standard, del tipo FLOAT(M,D) (o DOUBLE(M,D)).

M è il numero totale di cifre che puoi memorizzare (prima e dopo il punto decimale).

D è il numero di cifre dopo il punto decimale.

Per esempio, se dichiari una colonna come FLOAT(7,4), puoi memorizzare fino a 7 cifre in totale, con 4 cifre dopo il punto decimale.

Quindi i numeri vanno da -999.9999 a 999.9999.

1 La sintassi FLOAT(p) è supportata ma ignorata: non influisce realmente sul tipo

2 https://dev.mysql.com/doc/refman/8.4/en/precision-math-decimal-characteristics.html