--- Felipe de Carvalho Andarde - RED3A

--- QUESTAO a
CREATE TABLE estoque (
    id_isbn VARCHAR(15) NOT NULL,
    qt_estoque INTEGER NOT NULL,
    qt_reservada INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT estoque_pk PRIMARY KEY (id_isbn),

    CONSTRAINT livro_fk FOREIGN KEY (id_isbn)
        REFERENCES livro (id_isbn)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
);

--- QUESTAO b/c
CREATE OR REPLACE FUNCTION atualiza_estoque()
RETURNS trigger AS $$
BEGIN
    UPDATE estoque
    SET qt_estoque = qt_estoque - NEW.vl_quantidade,
        qt_reservada = qt_reservada + NEW.vl_quantidade
    WHERE id_isbn = NEW.id_isbn;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER atualiza_estoque AFTER UPDATE ON pedido_livro FOR EACH ROW
EXECUTE FUNCTION atualiza_estoque();

-- Inserir livros na tabela estoque com algumas quantidades
INSERT INTO estoque (id_isbn, qt_estoque, qt_reservada) VALUES
('8534602379', 100, 0),  -- Engenharia de Software
('0000000001', 100, 0),  -- Redes de Computadores
('0000000002', 100, 0),  -- Clipper 5.2 Iniciação e Referência
('0000000003', 100, 0);  -- Clipper 5.2 Avançado

-- Inserir valor na tabela pedido_livro
-- INSERT INTO pedido_livro (id_pedido, id_isbn, vl_quantidade) VALUES (1, '8534602379', 2);

-- Atualizando a quantidade de livros
UPDATE pedido_livro
SET vl_quantidade = 3
WHERE id_pedido = 1
  AND id_isbn = '8534602379';

-- Testes
SELECT * FROM estoque
WHERE id_isbn = '8534602379';

SELECT * FROM pedido_livro
WHERE id_pedido = 1
  AND id_isbn = '8534602379';

--- QUESTAO d
CREATE OR REPLACE FUNCTION atualiza_estoque_novo_livro()
RETURNS trigger AS $$
BEGIN
    INSERT INTO estoque (id_isbn, qt_estoque, qt_reservada)
    VALUES (NEW.id_isbn, 0, 0);

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_atualiza_estoque_novo_livro AFTER INSERT ON livro FOR EACH ROW 
EXECUTE FUNCTION atualiza_estoque_novo_livro();

-- Inserindo um novo livro na tabela livro
INSERT INTO livro (nm_titulo, id_isbn, dt_publicacao, nu_edicao, nu_volume, id_categoria, id_editora, vl_preco)
VALUES ('Introdução a Física Moderna', '1234567890', '2024-11-11', 1, 1, 1, 1, 50.00);

-- Verificando se a tabela estoque foi atualizada corretamente
-- SELECT * FROM estoque WHERE id_isbn = '1234567890';