-- FELIPE DE CARVALHO ANDRADE RED3A

-- QUESTAO 01
SELECT nm_empregado, nm_sobrenome FROM empregado e INNER JOIN historico_emprego h
    ON e.nu_empregado = h.nu_empregado
WHERE nm_cargo = 'Accountant';

-- QUESTAO 02
SELECT nm_empregado AS NomeEmpregado, nm_sobrenome AS SobrenomeEmpregado
FROM empregado e INNER JOIN empregado_curso ec
    	ON e.nu_empregado = ec.nu_empregado
INNER JOIN curso cr
    	ON cr.nu_curso = ec.nu_curso
WHERE nm_curso = 'Ada' OR nm_curso = 'LANs';

-- QUESTAO 03
SELECT nm_curso FROM curso cr INNER JOIN empregado_curso ec
    ON cr.nu_curso = ec.nu_curso
INNER JOIN empregado e
    ON e.nu_empregado = ec.nu_empregado

GROUP BY nm_curso
HAVING COUNT(*) <= 10
ORDER BY nm_curso DESC;

-- QUESTAO 04
SELECT nm_depto, COUNT(*) FROM empregado e INNER JOIN departamento dp
    ON e.nu_depto = dp.nu_depto
	
GROUP BY nm_depto
ORDER BY nm_depto;

-- QUESTAO 05
SELECT nm_depto, COUNT(*) FROM empregado e INNER JOIN departamento dp
    ON e.nu_depto = dp.nu_depto
	
GROUP BY nm_depto
HAVING COUNT(*) > 6
ORDER BY nm_depto;

-- QUESTAO 06
SELECT nm_empregado, nm_sobrenome FROM empregado e
INNER JOIN ( SELECT nu_depto, COUNT(*) FROM empregado
    GROUP BY nu_depto
    HAVING COUNT(*) = 6
) a
    ON e.nu_depto = a.nu_depto;

-- QUESTAO 07
SELECT DISTINCT nm_empregado, nm_sobrenome FROM empregado e
INNER JOIN historico_emprego he
    ON e.nu_empregado = he.nu_empregado
WHERE (he.dt_fim - he.dt_inicio) / 365 = 3;

-- QUESTAO 08
SELECT cr1.nm_curso, cr1.dt_curso FROM curso cr1
INNER JOIN curso cr2
    ON cr1.dt_curso = cr2.dt_curso
	AND cr1.nu_curso <> cr2.nu_curso;

-- QUESTAO 09
SELECT nm_curso FROM curso cr LEFT JOIN empregado_curso ec
    ON cr.nu_curso = ec.nu_curso
LEFT JOIN empregado e
    ON e.nu_empregado = ec.nu_empregado
WHERE ec.nu_empregado IS NULL;

-- QUESTAO 10
SELECT nm_curso FROM curso cr
WHERE EXTRACT(MONTH FROM dt_curso) = 10;

-- QUESTAO 11
SELECT nm_curso AS nome_curso, COUNT(*) AS qtd_alunos
FROM curso cr
LEFT JOIN empregado_curso ec
    ON cr.nu_curso = ec.nu_curso
	
GROUP BY nm_curso
HAVING COUNT(ec.nu_empregado) = (
    SELECT MAX(qtd_alunos) FROM (
        SELECT COUNT(ec.nu_empregado) AS qtd_alunos
        FROM curso cr
        LEFT JOIN empregado_curso ec
            ON cr.nu_curso = ec.nu_curso
        GROUP BY cr.nm_curso
    ) AS ContagemAlunos
);

-- QUESTAO 12
SELECT nm_empregado, nm_sobrenome,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, dt_nascimento))
FROM empregado e

ORDER BY e.dt_nascimento
LIMIT 3;