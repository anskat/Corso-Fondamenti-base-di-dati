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

