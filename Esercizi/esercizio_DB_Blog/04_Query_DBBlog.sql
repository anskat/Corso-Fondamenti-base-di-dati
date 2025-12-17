/*

Esercizio riassuntivo del corso TSS
Argomento: database

FASE 5: Query sul DB

*/
-- ------------------------------------------------------------------------------------------

/*
-- Query 1
-- Elenco articoli e autore ordinati per data decrescente
-- Il result set risultante deve riportare le colonne:
-- title, content, featured_image, username, p.created_at, p.updated_at
-- i record devono essere ordinati per data di creazione del post


-- Query 2
-- Elenco articoli e autore pubblicati dopo una certa data (≥ agosto 2025)
-- Il result set deve riportare le colonne:
-- title, content, username, p.created_at
-- I record devono essere filtrati mostrando solo quelli con created_at >= '2025-08-01'


-- Query 3 – Elenco articoli e autore pubblicati nel mese di luglio dell’anno corrente
-- Il result set deve riportare le colonne:
-- title, content, username, p.created_at
-- I record devono essere filtrati mostrando solo quelli con month(created_at) = 7
-- e year(created_at) uguale all’anno corrente


-- Query 4 – Elenco dei 3 articoli più recenti e autore che li ha scritti
-- Il result set deve riportare le colonne:
-- title, content, username, p.created_at
-- I record devono essere ordinati per created_at in ordine decrescente
-- e limitati ai primi 3 (LIMIT 3)


-- Query 5 – Elenco articoli dell’autore con username = 'verdi'
-- Il result set deve riportare le colonne:
-- title, content, username, p.created_at
-- I record devono essere filtrati mostrando solo quelli con username = 'verdi'
-- I record devono essere ordinati per created_at in ordine decrescente


-- Query 6 – Conteggio degli articoli per autore
-- Il result set deve riportare le colonne:
-- username, numero di articoli scritti (alias: articoli scritti)
-- I record devono essere raggruppati per autore
-- Ordinare i risultati in ordine decrescente per numero di articoli scritti


-- Query 7 – Autore/i che hanno scritto più articoli
-- Il result set deve riportare le colonne:
-- username, numero di articoli scritti (alias: articoli scritti)
-- Mostrare solo gli autori che hanno il massimo numero di articoli
-- Utilizzare HAVING confrontando con un sottoquery di conteggio articoli per autore


-- Query 8 – Elenco articoli di una specifica categoria
-- Il result set deve riportare le colonne:
-- title, content, t.name (alias: term), t.taxonomy, p.created_at
-- I record devono essere filtrati mostrando solo quelli appartenenti alla categoria 'Primi piatti'


-- Query 9 – Elenco articoli di uno specifico tag
-- Il result set deve riportare le colonne:
-- title, content, t.name (alias: term), t.taxonomy, p.created_at
-- I record devono essere filtrati mostrando solo quelli con tag 'uova'


-- Query 10 – Elenco di tutti i commenti approvati di uno specifico articolo
-- Il result set deve riportare le colonne:
-- post_id, author_email, comments.content, comments.status
-- I record devono essere filtrati per post_id = 1
-- e status = 'approved'
-- Ordinare i risultati per created_at in ordine crescente


-- Query 11 – Conteggio dei commenti approvati per ogni post
-- Il result set deve riportare le colonne:
-- post_id, numero di commenti approvati (alias: quanti)
-- I record devono essere raggruppati per post_id
-- Mostrare solo i post che hanno almeno un commento approvato


-- Query 12 – Elenco articoli con commenti associati
-- Il result set deve riportare le colonne:
-- p.id, p.title, c.content
-- Mostrare solo i post che hanno almeno un commento


-- Query 13 – Elenco articoli senza commenti
-- Il result set deve riportare le colonne:
-- p.id, p.title, c.content (che sarà NULL se non ci sono commenti)
-- Mostrare solo i post che non hanno alcun commento


-- Query 14 – Conteggio dei commenti di un articolo specifico (id = 1)
-- Il result set deve riportare le colonne:
-- id del post e numero di commenti associati
-- I record devono essere filtrati mostrando solo il post con id = 1


-- Query 15 – Elenco articoli con categorie e tag (tutti i termini)
-- Il result set deve riportare le colonne:
-- p.id, p.author_id, title, content, username, t.name (alias: term), t.taxonomy, p.created_at
-- Mostrare i post con eventuali termini associati (categorie o tag)


-- Query 16 – Elenco articoli con categorie e tag separati
-- Il result set deve riportare le colonne:
-- p.id, p.title, p.excerpt, u.username, categories, tags, p.created_at
-- Dove categories è la concatenazione dei termini taxonomy = 'category'
-- e tags è la concatenazione dei termini taxonomy = 'tag'
-- per creare le colonne 'categories' e 'tag' dovete usare due funzioni:
-- GROUP_CONCAT() -- documentazione: https://dev.mysql.com/doc/refman/8.4/en/aggregate-functions.html#function_group-concat
-- IF - vista in aula (vi serve per distinguere se taxonomy è uguale a 'category' e se taxonomy è uguale a 'tag')
-- IF diventa argomento di GROUP_CONCAT
-- esempio di uso di GROUP_CONCAT() su database corsi:
/*
select
	d.nome `Nome Docente`,
    d.cognome `Cognome Docente`,
    count(*)  `Quanti`,
    group_concat(c.titolo ORDER BY c.titolo DESC SEPARATOR '; ')  `Corsi assegnati`
from docenti d
join corsi c
on d.id = c.docente_id
group by d.id;
*/


-- Query 17 – Ricerca full-text negli articoli
-- Seleziona gli articoli che contengono le parole 'facile, veloce'
-- Il result set deve riportare le colonne:
-- title, content, peso (risultato della funzione MATCH)
-- Usare MATCH(title, content) AGAINST ('facile, veloce')


-- Query 18 – Ricerca full-text negli articoli
-- Seleziona gli articoli che contengono esattamente la frase "filetti di merluzzo al forno"
-- Usare MATCH con stringa fra virgolette doppie


-- Query 19 – Ricerca full-text negli articoli
-- Seleziona gli articoli che devono contenere la parola 'forno' e NON devono contenere la parola 'pentola'
-- Usare MATCH in modalità BOOLEAN MODE