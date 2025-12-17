/*

Esercizio riassuntivo del corso TSS
Argomento: database

FASE 2: Creazione degli INDICI

*/
-- ------------------------------------------------------------------------------------------

/*
INDICI
Aggiunta INDICI per ottimizzazione query

Analizzando le richieste tipiche di un blog:
 - servono ricerche rapide sui commenti per stato di approvazione,
 - è frequente filtrare i termini per tipo (taxonomy) o recuperarli dallo slug,
 - è necessario permettere ricerche testuali nei post su titolo e contenuto.

Per questo dovete aggiungere i seguenti indici:

1) indice sulla tabella comments relativo all'attributo status
   nome indice suggerito: k_comments_status

2) indice sulla tabella terms relativo all'attributo taxonomy
   nome indice suggerito: k_terms_taxonomy

3) indice sulla tabella terms relativo all'attributo slug
   nome indice suggerito: k_terms_slug

4) indice FULLTEXT sulla tabella posts, l'indice deve essere creato per gli attributi: title, content
   nome indice suggerito: ft_title_content