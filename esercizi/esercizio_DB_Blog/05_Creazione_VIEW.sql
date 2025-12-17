/*

Esercizio riassuntivo del corso TSS
Argomento: database

FASE 4: Creazione delle VIEW

*/
-- ------------------------------------------------------------------------------------------

/*
VISTE
Creazione di alcune viste
1)
-- creare vista 'v_list_posts' che mostri elenco articoli i cui campi sono in ordine:
   created_at - alias: `published on`,
   title,
   excerpt,
   autore (ottenuto concatenando first_name e last_name dello user), alias: author
-- NON aggiungere order by, meglio metterlo nella query. Vale per tutte le viste

2)
-- Creare vista 'v_posts_with_comments' che mostri elenco articoli con numero di commenti
-- Mostra i post con conteggio dei soli commenti APPROVATI, con status = 'approved'.
-- i campi da mostrare sono in ordine:
   p.id,
   p.title,
   num_comments

3)
-- Creare vista 'v_users_posts_count' che mostri elenco utenti con numero di articoli scritti
-- Per monitorare l’attività degli autori.
-- i campi da mostrare sono in ordine:
   u.id,
   autore (ottenuto concatenando first_name e last_name dello user), alias: author
   num_posts

4)
-- Creare vista 'v_posts_with_generalinfo' con elenco post, data di pubblicazione, nome e cognome dell'autore, categorie, tag e riassunto del post(excerpt)
-- i campi da mostrare sono in ordine:
    p.id,
    p.title,
    published on,
    autore (ottenuto concatenando first_name e last_name dello user), alias: author
    categories,
    tags,
    excerpt
-- ATTENZIONE
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