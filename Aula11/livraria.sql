--- Davi James Vilela e Felipe de Carvalho Andrade - RED3A

--- QUESTÃO a 
CREATE USER felipe WITH PASSWORD '123456';

--- QUESTÃO b 
CREATE OR REPLACE VIEW vw_funcionarios AS SELECT DISTINCT nm_funcionario, dt_admissao
FROM funcionario f INNER JOIN pedido p
    ON f.id_funcionario = p.id_funcionario
INNER JOIN cliente c
    ON p.id_cliente = c.id_cliente
WHERE f.nm_cidade_funcionario <> c.nm_cidade_cliente

UNION

SELECT nm_funcionario, dt_admissao FROM funcionario f INNER JOIN encomenda e
    ON f.id_funcionario = e.id_funcionario
INNER JOIN cliente c
    ON e.id_cliente = c.id_cliente
WHERE f.nm_cidade_funcionario <> c.nm_cidade_cliente;

-- SELECT * FROM vw_funcionarios;

--- QUESTÃO c 
GRANT ALL PRIVILEGES ON vw_funcionarios TO felipe;

--- QUESTÃO d 
CREATE OR REPLACE FUNCTION total_encomendas(p_titulo_livro varchar(40))
RETURNS integer AS $$
DECLARE
    qtd_total integer;
BEGIN
    SELECT COUNT(el.vl_quantidade) INTO qtd_total
    FROM encomenda_livro el INNER JOIN livro l
        ON el.id_isbn = l.id_isbn
    WHERE l.nm_titulo = p_titulo_livro;

    RAISE NOTICE 'Total de encomendas: %', qtd_total;

    RETURN qtd_total;
END;
$$ LANGUAGE plpgsql;

GRANT EXECUTE ON FUNCTION total_encomendas(varchar(40)) TO felipe;
GRANT ALL PRIVILEGES ON encomenda_livro TO felipe;
GRANT ALL PRIVILEGES ON livro TO felipe;