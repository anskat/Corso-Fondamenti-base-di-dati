/*

Esercizio riassuntivo del corso TSS
Argomento: database

FASE 1: Creazione del DB, delle tabelle complete di FOREIGN KEY

*/
-- ------------------------------------------------------------------------------------------

/*
Si vuole realizzare un database relazionale per un sistema di blogging.
Il sistema dovrà permettere di:
  -  gestire utenti registrati che scrivono articoli;
  -  memorizzare i post (articoli) con titolo, contenuto, estratto e altre informazioni;
  -  organizzare i post in categorie e tag (termini);
  -  permettere ai visitatori e agli utenti registrati di scrivere commenti, con la possibilità di rispondere a commenti già esistenti (commenti annidati);
  -  associare termini ai post tramite relazioni;

Il database deve inoltre:
  -  garantire l’integrità referenziale tra le entità: cioè definire cosa accade quando si eliminano record collegati tra loro (ON DELETE …);
  -  prevedere indici per migliorare le prestazioni delle query, compresi indici FULLTEXT per la ricerca nei post.
------------------------------------------------------------------------------------------

Esercizio (DCL)
Consegna:
 - Creazione del database 'Blog';
 - Creazione dell'utente 'app_blog' con password 'blog2025!': l'host è 'localhost';
 - assegnate tutti i privilegi sul database 'Blog' all'utente app_blog ;

Utilizzate l'utente appena crato per connettervi al databse 'Blog'
(createvi una shortcut in Workbench)

Una volta connessi dovete creare le tabelle necessarie
 - users
 - posts (un post è scritto da uno user, uno user scrive più post)
 - comments (un commento è legato ad un post, un post può avere molti commenti)
 - terms
 - term_relationships (tabella associativa per la relazione molti a molti tra terms e post)

Di seguito il dettaglio per ogni tabella
NB: alcuni campi subiranno modifiche successive, lasciateli come indicato ora.
NB2: In base alle relazioni tra le tabelle sono previste anche delle FOREIGN KEY e SELF FOREIGN KEY, seguite le istruzioni
indicate tabella per tabella

------------------------------------------------------------------------------------------
Esercizio (DDL)
Attributi tabella: users
  id: chiave primaria che si autoincrementa,
  nome: campo stringa di massimo 20 caratteri,
  cognome: campo stringa di massimo 30 caratteri,
  username: campo stringa di massimo 100 caratteri, obbligatorio, deve essere univoco,
  email: campo stringa di massimo 100 caratteri, obbligatorio, deve essere univoco,
  password: campo stringa di massimo 255 caratteri, obbligatorio,
  created_at: timestamp che memorizza il momento della creazione del record (valore di default = istante di inserimento),
  updated_at: timestamp che memorizza il momento dell’aggiornamento del record (si aggiorna automaticamente ad ogni modifica).

-------------------------------

Attributi tabella: posts
  id: chiave primaria che si autoincrementa,
  title: campo stringa di massimo 255 caratteri, obbligatorio,
  slug: campo stringa di massimo 255 caratteri, obbligatorio, deve essere univoco (rappresenta il nome breve utile a costruire il link del post),
  excerpt: campo testo, opzionale → breve riassunto del contenuto,
  content: campo testo, obbligatorio → corpo completo del post,
  post_type: campo stringa di massimo 20 caratteri, con valore di default 'post' → serve a distinguere se si tratta di un articolo o di una pagina statica,
  author_id: intero, obbligatorio → riferimento all’autore del post (utente registrato),
  status: valore enumerato tra 'draft', 'published', 'private', 'trash', con valore di default 'draft',
  created_at: timestamp che memorizza il momento della creazione del record,
  updated_at: timestamp che memorizza il momento dell’aggiornamento del record.

Tabella posts – indicazioni foreign key
  La colonna author_id è un riferimento alla tabella users.
  Ogni post deve avere un autore registrato.
  Se un utente viene eliminato, anche i suoi post devono essere eliminati (ON DELETE CASCADE).
  Se l’identificativo dell’utente (id) viene modificato, la modifica deve propagarsi sui post collegati (ON UPDATE CASCADE).
  In pratica gli id cambiano raramente, ma il CASCADE serve per garantire coerenza anche in quel caso.
  Date voi un nome alla constraint, es: fk_posts_author
  
-------------------------------

Attributi tabella: comments
  id: chiave primaria che si autoincrementa,
  post_id: intero, obbligatorio → riferimento al post a cui appartiene il commento,
  user_id: intero, opzionale → riferimento all’utente registrato che ha scritto il commento (se il commento è di un visitatore anonimo, può essere NULL),
  parent_comment_id: intero, opzionale → riferimento a un altro commento (self-reference) per permettere i commenti annidati,
  author_name: stringa di massimo 100 caratteri,
  author_email: stringa di massimo 100 caratteri,
  content: testo, obbligatorio,
  status: valore enumerato tra 'approved', 'pending', 'spam', 'trash', con valore di default 'pending',
  created_at: timestamp che memorizza il momento della creazione del record,
  updated_at: timestamp che memorizza il momento dell’aggiornamento del record.

Tabella comments – indicazioni foreign key
  La colonna post_id è un riferimento alla tabella posts.
  Ogni commento appartiene a un post.
  Se un post viene eliminato, anche i suoi commenti devono essere eliminati (ON DELETE CASCADE).
  Se l’identificativo del post cambia, deve aggiornarsi automaticamente nei commenti (ON UPDATE CASCADE).
  In pratica gli id cambiano raramente, ma il CASCADE serve per garantire coerenza anche in quel caso.
  Date voi un nome alla constraint, es: fk_comments_post

  La colonna user_id è un riferimento alla tabella users.
  Se l’utente viene eliminato, i suoi commenti rimangono ma il riferimento all’utente diventa nullo (ON DELETE SET NULL).
  Se l’identificativo dell’utente cambia, deve aggiornarsi automaticamente nei commenti (ON UPDATE CASCADE).
  In pratica gli id cambiano raramente, ma il CASCADE serve per garantire coerenza anche in quel caso.
  Date voi un nome alla constraint, es: fk_comments_user

  La colonna parent_comment_id è un riferimento alla stessa tabella comments (self reference).
  Serve a gestire i commenti annidati.
  Se il commento padre viene eliminato, il riferimento al commento padre nei figli diventa nullo (ON DELETE SET NULL).
  Se l’identificativo del commento padre cambia, il riferimento deve aggiornarsi automaticamente (ON UPDATE CASCADE).
  In pratica gli id cambiano raramente, ma il CASCADE serve per garantire coerenza anche in quel caso.
  Date voi un nome alla constraint, es: fk_comments_parent

-------------------------------

Attributi tabella: terms
  id: chiave primaria che si autoincrementa,
  name: campo stringa di massimo 255 caratteri, obbligatorio → nome del termine (es. “Tecnologia”, “PHP”),
  slug: campo stringa di massimo 255 caratteri, obbligatorio → nome breve unico da usare nei link,
  description: campo testo, opzionale → descrizione del termine,
  taxonomy: campo stringa di massimo 100 caratteri, obbligatorio → indica il tipo di termine (category, tag, ecc.),
  parent_term_id: intero, opzionale → riferimento a un altro termine per costruire gerarchie (es. categoria “Programmazione” → sottocategoria “PHP”),
  created_at: timestamp che memorizza il momento della creazione del record,
  updated_at: timestamp che memorizza il momento dell’aggiornamento del record.

Tabella terms – indicazioni foreign key
  La colonna parent_term_id è un riferimento alla stessa tabella terms.
  Serve a gestire la gerarchia dei termini (categorie e sottocategorie).
  Se un termine padre viene eliminato, i figli devono rimanere ma senza più riferimento al padre (ON DELETE SET NULL).
  Se l’identificativo del termine padre cambia, il riferimento deve aggiornarsi automaticamente (ON UPDATE CASCADE).
  Date voi un nome alla constraint, es: fk_terms_parent

-------------------------------

Attributi tabella: term_relationships
  relationship_id: chiave primaria che si autoincrementa,
  term_id: intero, obbligatorio → riferimento a un termine (categoria o tag),
  object_id: intero, obbligatorio → riferimento a un post,
  created_at: timestamp che memorizza il momento della creazione del record,
  updated_at: timestamp che memorizza il momento dell’aggiornamento del record.
Nota: la tabella term_relationships serve come tabella ponte (molti-a-molti) tra posts e terms.

Tabella term_relationships – indicazioni foreign key
  La colonna term_id è un riferimento alla tabella terms.
  Se un termine viene eliminato, devono sparire anche le relazioni con i post (ON DELETE CASCADE).
  Se l’identificativo del termine cambia, la modifica deve propagarsi nelle relazioni (ON UPDATE CASCADE).
  Date voi un nome alla constraint, es: fk_term_rel_term
  
  La colonna object_id è un riferimento alla tabella posts.
  Se un post viene eliminato, devono sparire anche le relazioni con i termini (ON DELETE CASCADE).
  Se l’identificativo del post cambia, la modifica deve propagarsi nelle relazioni (ON UPDATE CASCADE).
  Date voi un nome alla constraint, es: fk_term_rel_post

-------------------------------
MODIFICHE
Modifiche alla tabelle create:
-- Modificare gli attributi in tabella users
  nome, rinominarlo in
  first_name
  e modificare dimensione del tipo e renderlo obbligatorio
  campo stringa di massimo 100 caratteri, obbligatorio,
  
  cognome, rinominarlo in
  last_name
  e modificare dimensione del tipo e renderlo obbligatorio
  campo stringa di massimo 100 caratteri, obbligatorio,

-- Aggiungere colonna featured_image DOPO status in posts, campo per eventuale immagine di copertina, verrà memorizzato il percorso dell'immagine associata al post
  featured_image: campo stringa di massimo 255 caratteri, opzionale