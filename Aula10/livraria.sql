--- Felipe Andrade RED3A

--- QUESTAO a
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

-- SELECT total_encomendas('Helena');

--- QUESTAO b
CREATE OR REPLACE FUNCTION encomendas_no_mes(ano_corrente integer)
RETURNS TABLE(mes integer, qtd_total integer) AS $$
BEGIN
    RETURN QUERY
    SELECT EXTRACT(MONTH FROM ec.dt_encomenda)::integer AS mes,
           SUM(el.vl_quantidade)::integer AS qtd_total
    FROM encomenda ec
    INNER JOIN encomenda_livro el
        ON ec.id_encomenda = el.id_encomenda
    WHERE EXTRACT(YEAR FROM ec.dt_encomenda) = ano_corrente
    GROUP BY EXTRACT(MONTH FROM ec.dt_encomenda)
    ORDER BY mes;
END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM encomendas_no_mes(1998);

--- QUESTAO c
CREATE OR REPLACE FUNCTION pedidos_livro(p_id_cliente integer)
RETURNS TABLE(palavra_chave varchar(30), qtd_total integer) AS $$
BEGIN
    RETURN QUERY
    SELECT pc.te_descricao AS palavra_chave,
           SUM(pl.vl_quantidade)::integer AS qtd_total
    FROM pedido p
    INNER JOIN pedido_livro pl
        ON p.id_pedido = pl.id_pedido
    INNER JOIN livro l
        ON pl.id_isbn = l.id_isbn
    INNER JOIN palavra_chave_livro pcl
        ON l.id_isbn = pcl.id_isbn
    INNER JOIN palavra_chave pc
        ON pcl.id_palavra_chave = pc.id_palavra_chave
    WHERE p.id_cliente = p_id_cliente
    GROUP BY pc.te_descricao;
END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM pedidos_livro(1);

--- QUESTAO d
CREATE OR REPLACE FUNCTION nomes_encomendas()
RETURNS TABLE(v_nm_cliente varchar(40), nm_encomenda varchar(40)) AS $$
BEGIN
    RETURN QUERY
    SELECT c.nm_cliente AS v_nm_cliente,
           l.nm_titulo AS nm_encomenda
    FROM encomenda e
    INNER JOIN cliente c
        ON e.id_cliente = c.id_cliente
    INNER JOIN encomenda_livro el
        ON e.id_encomenda = el.id_encomenda
    INNER JOIN livro l
        ON el.id_isbn = l.id_isbn
    WHERE e.nu_prazo_estimado > 7;
END;
$$ LANGUAGE plpgsql;

-- SELECT nomes_encomendas();