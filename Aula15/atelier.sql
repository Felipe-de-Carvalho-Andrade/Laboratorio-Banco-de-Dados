-- LABORATÓRIO DBLINK
-- Davi James Vilela e Felipe de Carvalho Andrade - RDC3A

-- QUESTAO 3
CREATE USER davi_o_djalma WITH PASSWORD 'djalma';

GRANT SELECT ON costureiro TO davi_o_djalma;

-- QUESTOES 4 E 5
CREATE EXTENSION IF NOT EXISTS dblink;

CREATE SERVER server_livraria_remoto
FOREIGN DATA WRAPPER dblink_fdw
OPTIONS (host 'localhost', dbname 'livraria', port '5432');

GRANT USAGE ON FOREIGN SERVER server_livraria_remoto TO davi_o_djalma;

CREATE USER MAPPING FOR davi_o_djalma
SERVER server_livraria_remoto
OPTIONS (user 'davi_o_djalma', password 'djalma');


-- Conexão com servidor remoto
SELECT dblink_connect('conexao', 'server_livraria_remoto');


-- Criação de view no banco remoto via dblink
SELECT dblink_exec(
    'conexao',
    'CREATE VIEW view_pratica14 AS SELECT * FROM livro'
);


-- Consulta cruzando dados locais e remotos
SELECT nm_costureiro
FROM (
    SELECT *
    FROM dblink('conexao', 'SELECT nm_autor FROM autor')
        AS x(nm_autor TEXT)
) sub,
costureiro
WHERE nm_costureiro = nm_autor;


-- Lista final de costureiros locais
SELECT DISTINCT nm_costureiro
FROM costureiro
ORDER BY 1;