-- ============================================================================
-- TABELLA USERS
-- ============================================================================
*/
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(20),
    cognome VARCHAR(30),
    username VARCHAR(100) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


-- ============================================================================
-- TABELLA POSTS
-- ============================================================================
*/
CREATE TABLE posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    slug VARCHAR(255) NOT NULL UNIQUE,
    excerpt TEXT,
    content TEXT NOT NULL,
    post_type VARCHAR(20) DEFAULT 'post',
    author_id INT NOT NULL,
    status ENUM('draft','published','private','trash') DEFAULT 'draft',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_posts_author FOREIGN KEY (author_id)
        REFERENCES users(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- ============================================================================
-- TABELLA COMMENTS
-- ============================================================================
*/
CREATE TABLE comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT NOT NULL,
    user_id INT NULL,
    parent_comment_id INT NULL,
    author_name varchar(100),
    author_email varchar(100),
    content TEXT NOT NULL,
    status ENUM('approved','pending','spam','trash') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_comments_post FOREIGN KEY (post_id)
        REFERENCES posts(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_comments_user FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    CONSTRAINT fk_comments_parent FOREIGN KEY (parent_comment_id)
        REFERENCES comments(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- ============================================================================
-- TABELLA TERMS
-- ============================================================================
*/
CREATE TABLE terms (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(255) NOT NULL UNIQUE,
    description TEXT,
    taxonomy VARCHAR(100) NOT NULL,
    parent_term_id INT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_terms_parent FOREIGN KEY (parent_term_id)
        REFERENCES terms(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- ============================================================================
-- TABELLA TERM_RELATIONSHIPS
-- ============================================================================
*/
CREATE TABLE term_relationships (
    relationship_id INT AUTO_INCREMENT PRIMARY KEY,
    term_id INT NOT NULL,
    object_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_term_rel_term FOREIGN KEY (term_id)
        REFERENCES terms(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_term_rel_post FOREIGN KEY (object_id)
        REFERENCES posts(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Rinominare e modificare nome e cognome
ALTER TABLE users 
    CHANGE nome first_name VARCHAR(100) NOT NULL,
    CHANGE cognome last_name VARCHAR(100) NOT NULL;

-- Aggiunta colonna featured_image nella tabella posts
ALTER TABLE posts
    ADD COLUMN featured_image VARCHAR(255) NULL AFTER status;

-- ============================================================================
-- INDICI
-- ============================================================================
*/
-- 1) indice su comments.status
CREATE INDEX k_comments_status ON comments(status);

-- 2) indice su terms.taxonomy
CREATE INDEX k_terms_taxonomy ON terms(taxonomy);

-- 3) indice su terms.slug
CREATE INDEX k_terms_slug ON terms(slug);

-- 4) indice FULLTEXT su posts(title, content)
CREATE FULLTEXT INDEX ft_title_content ON posts(title, content);

-- ============================================================================
-- VISTE
-- ============================================================================

CREATE OR REPLACE VIEW v_list_posts AS
SELECT
    p.created_at AS `published on`,
    p.title AS Titolo,
    p.excerpt AS Riassunto,
    CONCAT(u.first_name, ' ', u.last_name) AS Autore
FROM posts p
JOIN users u ON p.author_id = u.id;

CREATE VIEW v_posts_with_comments AS
SELECT 
    p.id,
    p.title,
    COUNT(c.id) AS num_comments
FROM posts p
JOIN comments c 
    ON p.id = c.post_id AND c.status = 'approved'
GROUP BY p.id, p.title;

CREATE VIEW v_users_posts_count AS
SELECT 
    u.id,
    CONCAT(u.first_name, ' ', u.last_name) AS autore,
    COUNT(p.id) AS num_posts
FROM users u
LEFT JOIN posts p ON u.id = p.author_id
GROUP BY u.id;

CREATE VIEW v_posts_with_generalinfo AS
SELECT 
    p.id,
    p.title,
    p.created_at AS `published on`,
    CONCAT(u.first_name, ' ', u.last_name) AS autore,
    GROUP_CONCAT(IF(t.taxonomy = 'category', t.name, NULL) SEPARATOR ', ') AS categories,
    GROUP_CONCAT(IF(t.taxonomy = 'tag', t.name, NULL) SEPARATOR ', ') AS tags,
    p.excerpt
FROM posts p
JOIN users u ON p.author_id = u.id
LEFT JOIN term_relationships tr ON p.id = tr.object_id
LEFT JOIN terms t ON tr.term_id = t.id
GROUP BY p.id;