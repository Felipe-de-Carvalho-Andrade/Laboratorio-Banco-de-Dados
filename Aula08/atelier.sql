-- FELIPE DE CARVALHO ANDRADE RED3A

-- QUESTAO 01
SELECT nm_cliente FROM cliente cl INNER JOIN pedido pd
    ON cl.id_cliente = pd.id_cliente
WHERE pd.in_finalizado = 'S';

-- QUESTAO 02
SELECT nm_cliente, in_finalizado FROM cliente cl INNER JOIN pedido pd
    ON cl.id_cliente = pd.id_cliente
WHERE pd.dt_pedido BETWEEN TO_DATE('01-01-2002','DD-MM-YYYY')
                        AND TO_DATE('20-02-2002','DD-MM-YYYY');

-- QUESTAO 03
SELECT nm_cliente, in_finalizado FROM cliente cl INNER JOIN pedido pd
    ON cl.id_cliente = pd.id_cliente
LIMIT 4;

-- QUESTAO 04
SELECT nm_material, nm_cor_material FROM material mt INNER JOIN detalhepedido dp
    ON mt.id_material = dp.id_material
INNER JOIN pedido pd
    ON dp.id_pedido = pd.id_pedido
	
GROUP BY nm_material, nm_cor_material
HAVING COUNT(*) = 3;

-- QUESTAO 05
SELECT DISTINCT nm_costureiro FROM costureiro cto NATURAL JOIN costura cta
WHERE cta.dt_fim_costura IS NULL;

-- QUESTAO 06
SELECT DISTINCT nm_costureiro FROM costureiro cto NATURAL JOIN costura cta
NATURAL JOIN detalhepedido dp 
NATURAL JOIN quantidade qtd 
NATURAL JOIN traje tr
WHERE te_descricao_traje = 'Vestido de verão';

-- QUESTAO 07
SELECT nu_tamanho FROM quantidade qtd NATURAL JOIN traje tr
WHERE tr.te_descricao_traje = 'Mini saia';

-- QUESTAO 08
SELECT nm_material, nm_cor_material FROM material mt NATURAL JOIN detalhepedido dp
NATURAL JOIN quantidade qtd
NATURAL JOIN traje tr
WHERE tr.te_descricao_traje = 'Saia longa';

-- QUESTAO 09
SELECT nu_quantidade FROM quantidade NATURAL JOIN detalhepedido dp
NATURAL JOIN material mt
NATURAL JOIN pedido pd
WHERE pd.in_finalizado = 'N'
  AND mt.nm_material = 'Poliéster'
  AND mt.nm_cor_material = 'Amarelo palha';

-- QUESTAO 10
SELECT SUM(10 * nu_quantidade) FROM quantidade qtd NATURAL JOIN detalhepedido dp
NATURAL JOIN material mt
NATURAL JOIN traje tr
WHERE tr.te_descricao_traje = 'Shorts'
  AND mt.nm_material = 'Sarja'
  AND mt.nm_cor_material = 'Azul marinho'
  AND qtd.nu_tamanho = 18;