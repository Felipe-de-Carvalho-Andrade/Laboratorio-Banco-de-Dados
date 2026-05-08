-- FELIPE DE CARVALHO ANDRADE - RED3A

-- QUESTAO 01
SELECT fnome, fcidade FROM fornecedor;

-- QUESTAO 02 
SELECT pnome FROM peca
	WHERE peso > 15;

-- QUESTAO 03
SELECT fnome FROM fornecedor f, fornecimento fo
	WHERE f.fcodigo = fo.fcodigo AND fo.jcodigo = 1;

-- QUESTAO 04
SELECT SUM(quantidade) FROM fornecimento fo
	WHERE fo.jcodigo = 2;

-- QUESTAO 05
SELECT SUM(quantidade) FROM fornecimento fo
	WHERE fo.pcodigo = 1 AND fo.jcodigo = 1;

-- QUESTAO 06
SELECT fnome FROM fornecedor
	WHERE fcodigo NOT IN (SELECT fcodigo FROM fornecimento);

-- QUESTAO 07
SELECT pe.pnome, SUM(quantidade) FROM peca pe, fornecimento fo
	WHERE pe.pcodigo = fo.pcodigo
	GROUP BY pe.pnome
	ORDER BY pe.pnome;

-- QUESTAO 08
SELECT COUNT(*) FROM projeto;

-- QUESTAO 09
SELECT pe.pnome, pe.cor FROM peca pe, fornecimento fo
	WHERE pe.pcodigo = fo.pcodigo AND fo.jcodigo = 3;

-- QUESTAO 10
SELECT fnome FROM fornecedor
	ORDER BY fnome;

-- QUESTAO 11
SELECT po.jnome FROM projeto po, fornecedor f, peca pe, fornecimento fo
	WHERE f.fcodigo = fo.fcodigo 
		AND po.jcodigo = fo.jcodigo 
		AND pe.pcodigo = fo.pcodigo
		AND f.fcidade = 'Londrina'
		AND pe.pcidade = 'Londrina';

-- QUESTAO 12
SELECT DISTINCT pe.pnome FROM peca pe, fornecedor f, fornecimento fo
	WHERE fo.pcodigo = pe.pcodigo
	  AND fo.fcodigo = f.fcodigo
	  AND (f.fstatus = 20 OR f.fstatus = 10);