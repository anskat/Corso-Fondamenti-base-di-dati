## Normalizzazione del database

**Regole da rispettare nel definire le tabelle**

### La prima forma normale (1NF)

Si dice che una database è in 1NF (prima forma normale) se per ogni tabella/relazione contenuta nella base dati:

- non presenta gruppi di attributi che si ripetono (ossia ciascun attributo è definito su un dominio con valori atomici)
- tutti i valori di un attributo sono dello stesso tipo (appartengono allo stesso dominio)
- esiste una chiave primaria (ossia esiste un attributo o un insieme di attributi che identificano in modo univoco ogni tupla della relazione)
- l'ordine delle righe è irrilevante (non è portatore di informazioni)


| id   | Nome 	    | Corso              |
| ---- | ---------- | ---------------    |
| 1	   | Maria 	    | Matematica, Fisica |
| 2	   | Giovanni 	| Biologia           |

Questa tabella NON è in 1NF in quanto, ogni colonna deve assumere un solo valore, ovvero non può essere una matrice o un’array di valori.

| id   | Nome 	    | Corso              |
| ---- | ---------- | ---------------    |
| 1	   | Maria 	    | Matematica         |
| 1	   | Maria 	    | Fisica             |
| 2	   | Giovanni 	| Biologia           |

In questo caso la normalizzazione consiste nel riportare le celle che originariamente erano raggruppate in una unica colonna in più righe replicando gli altri valori 

---

### La seconda forma normale (2NF)

Perché una base dati possa essere in 2NF è necessario che:

- si trovi già in 1NF;
- tutti gli attributi non chiave dipendano dall'intera chiave primaria (e non solo da una parte di essa).

La 2NF elimina le dipendenze parziali e quindi riduce la ridondanza.

NOTA: La 2NF si applica solo se la PK è composta da più attributi.
Se la PK è semplice, 2NF = 1NF automaticamente.

Ora la tabella precedente che rispetta la 1FN non rispetta però la seconda forma normale.

| id   | Nome 	    | Corso              |
| ---- | ---------- | ---------------    |
| 1	   | Maria 	    | Matematica         |
| 1	   | Maria 	    | Fisica             |
| 2	   | Giovanni 	| Biologia           |

La chiave primaria è la combinazione (Id, Corso).

L'attributo "Nome" dipende solo da Id, non da tutto l'insieme (Id, Corso).

Quindi c'è una dipendenza parziale ⇒ violazione della 2NF.

Soluzione: scomposizione in due tabelle

| id_insegnante   | Nome 	    |
| ---- | ---------- |
| 1	   | Maria 	    |
| 2	   | Giovanni   |


| id_corso   | Corso 	    | id_insegnante              |
| ---- | ---------- | ---------------    |
| 1	   | Matematica 	    | 1         |
| 2	   | Fisica 	    | 1             |
| 3	   | Biologia 	| 2           |

Altro esempio: si supponga di avere a che fare con il database di una scuola con una chiave primaria composta dai campi "Codice Matricola" e "Codice Esame”:

| ● Codice Matricola	| ● Codice Esame	| Nome Matricola	| Voto Esame |
| ---- | ---------- | ---------------    | ---------------    |
| 1234	| M01	| Rossi Alberto	| 6 |
| 1234	| L02	| Rossi Alberto	| 7 |
| 1235	| L02	| Verdi Mario	| 8 |


Il database qui sopra si trova in 1NF ma non in 2NF

Perché il campo "Nome Matricola" non dipende dall'intera chiave ma solo da una parte di essa ("Codice Matricola").

Per rendere il nostro database in 2NF dovremo scomporlo in due tabelle:

| ● Codice Matricola	| ● Codice Esame	| Voto Esame |
| ---- | ---------- | ---------------    
| 1234	| M01		| 6 |
| 1234	| L02		| 7 |
| 1235	| L02		| 8 |

| ● Codice Matricola	| Nome Matricola	|
| ---- | ---------- |
| 1234	|  Rossi Alberto	|
| 1234	|  Rossi Alberto	|
| 1235	|  Verdi Mario	| 

---

### La terza forma normale (3NF)