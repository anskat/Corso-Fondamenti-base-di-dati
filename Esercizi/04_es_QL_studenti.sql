-- VERIFICATE SEMPRE che i dati restituiti siano coerenti con la query
/*
1
seleziona gli studenti
il cui last_name è uguale a 'bianchi' e ordina per last_name
*/

/*
2
seleziona gli studenti, ordinali per last_name e mostra solo i primi 10 record
*/

/*
3
seleziona last_name, first_name, email e birth_date
dalla tabella students
il cui gender è 'maschio' e ordina per birth_date
*/

/*
4
seleziona last_name, first_name, address, city, province, email e birth_date
dalla tabella students
la cui region NON è 'Piemonte' e ordina per province, city, last_name e first_name
*/

/*
5
seleziona last_name, first_name, gender, email e birth_date
dalla tabella students
la cui birth_date è maggiore della data '1995-01-01' compresa
e ordina per birth_date dalla più recente alla più remota e per gender
*/

/*
6
seleziona last_name, first_name, email, province e birth_date
dalla tabella students
il cui gender è 'femmina' e la province è diversa da 'Torino' e ordina per last_name e first_name
*/

/*
7
seleziona last_name, first_name, email, city, province e birth_date
dalla tabella students
la cui province è Cuneo o Alessandria e ordina per province, last_name e first_name
*/

/*
8
seleziona last_name, first_name, email, birth_date e province
dalla tabella students
la cui province è Cuneo o Asti o Novara o Alessandria e ordina per province, last_name e first_name
usate l'operatore IN
*/

/*
9
seleziona last_name, first_name, email e birth_date
dalla tabella students
la cui birth_date è compresa tra il 1980-01-01 e il 1989-12-31
e il cui gender è 'maschio' e ordina per birth_date dalla più recente alla più remota,
per last_name e per first_name
*/

/*
10
seleziona last_name, first_name, email e birth_date
dalla tabella students
la cui birth_date NON è compresa tra il 1990-01-01 e il 1994-12-31
e il cui gender è 'femmina' e ordina per birth_date dalla più recente alla più remota,
per last_name e per first_name
*/

/*
11
seleziona last_name, first_name, email e birth_date
dalla tabella students
il cui last_name inizia per 'b' e ordina per last_name e first_name
*/

/*
12
seleziona last_name, first_name, email e birth_date
dalla tabella students
il cui last_name inizia per 'ba' o 'ga' e ordina per last_name e first_name
usate regexp
*/