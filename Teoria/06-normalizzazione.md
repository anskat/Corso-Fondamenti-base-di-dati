## Normalizzazione del database

**Regole da rispettare nel definire le tabelle**

### La prima forma normale (1NF)

Si dice che una database è in 1NF (prima forma normale) se per ogni tabella/relazione contenuta nella base dati:

- non presenta gruppi di attributi che si ripetono (ossia ciascun attributo è definito su un dominio con valori atomici)
- tutti i valori di un attributo sono dello stesso tipo (appartengono allo stesso dominio)
- esiste una chiave primaria (ossia esiste un attributo o un insieme di attributi che identificano in modo univoco ogni tupla della relazione)
- l'ordine delle righe è irrilevante (non è portatore di informazioni)

---

|Id	 | Nome 	| Corsi.        |
|----|----------|---------------|
|1	 |Maria 	|Matematica, Fisica|
|2	 |Giovanni 	|Biologia|

Questa tabella NON è in 1NF in quanto, ogni colonna deve assumere un solo valore, ovvero non può essere una matrice o un’array di valori.