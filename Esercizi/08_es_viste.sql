-- 1)
-- Create una vista che mostri il cognome, il nome, l'email degli studenti
-- chiamate la vista "studenti_info"
-- le intestazioni delle colonne risultanti della vista dovranno essere:
-- cognome, il nome, l'email

/*
-- 2)
Creare una vista che mostri gli studenti divisi in base alle Generazioni
-- chiamate la vista "studenti_generazioni"
-- considerando i periodi seguenti per l'assegnazione delle generazioni:
-- Baby boomers o "Boomers" (1946-1964)
-- Generazione X (1965-1979)
-- Generazione Y o “Millennials” (1980-1996)
-- Generazione Z o "Centennials" (1997-2012)
-- Generazione Alpha o "Screenagers" (2013-2024)
-- Generazione Beta (2025-2038)
-- (non importa che i record della tabella non coprano tutte le casisitiche: mi
interessa la query)
-- le intestazioni delle colonne risultanti della vista dovranno essere:
-- nome, cognome, indirizzo, citta, provincia, regione, email, data_nascita,
generazione
*/

-- 3)
-- Create una vista che mostri il cognome, il nome, l'email del docente e corsi assegnati
-- chiamate la vista "docenti_corsi"
-- le intestazioni delle colonne risultanti della vista dovranno essere:
-- cognome, il nome, l'email, corso (usate alias nella vista)

-- 4)
-- Create una vista che mostri solo i docenti per i quali non esistono corsi assegnati
-- chiamate la vista "docenti_nocorsi"
-- le intestazioni delle colonne risultanti della vista dovranno essere:
-- cognome, nome, email

-- 5)
-- Create una vista che mostri solo i corsi per i quali non esistono docenti assegnati
-- chiamate la vista "corsi_nodocenti"
-- le intestazioni delle colonne risultanti della vista dovranno essere:
-- titolo

-- 6)
-- Create una vista che mostri solo gli studenti iscritti
-- chiamate la vista "studenti_iscritti"
-- le intestazioni delle colonne risultanti della vista dovranno essere:
-- cognome, nome, email, indirizzo, provincia, regione

-- 7)
-- Create una vista che mostri solo gli studenti non iscritti
-- chiamate la vista "studenti_noiscritti"
-- le intestazioni delle colonne risultanti della vista dovranno essere:
-- cognome, nome, email, indirizzo, provincia, regione

-- 8)
-- Create una vista che mostri gli studenti che hanno più di 30 anni iscritti ai corsi,
-- e il corso a cui sono iscritti
-- chiamate la vista "iscritti_over30"
-- le intestazioni delle colonne risultanti della vista dovranno essere:
-- cognome, nome, email, età (usate funzione per calcloare età e alias per l'intestazione della colonna ), titolo as corso