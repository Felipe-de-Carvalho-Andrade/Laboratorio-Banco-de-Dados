-- Davi James Vilela Guimarães e Felipe de Carvalho Andrade

-- PARTE 1
ALTER TABLE course ADD COLUMN cost DECIMAL(10,2);
ALTER TABLE course ADD COLUMN location VARCHAR(50);

ALTER TABLE employee ADD COLUMN current_position VARCHAR(30);
ALTER TABLE employee ADD COLUMN current_salary DECIMAL(8,2);

ALTER TABLE jobhistory DROP CONSTRAINT jobhistory_pkey;
ALTER TABLE jobhistory ADD PRIMARY KEY (empno, position, startdate);

-- PARTE 2
CREATE OR REPLACE FUNCTION fn_valida_custo_curso_gerente()
RETURNS TRIGGER AS $$
DECLARE
    v_custo DECIMAL(10,2);
    v_eh_gerente BOOLEAN;
BEGIN
    SELECT cost INTO v_custo
    FROM course
    WHERE courseno = NEW.courseno;

    SELECT EXISTS (
        SELECT 1 FROM department WHERE head = NEW.empno
    ) INTO v_eh_gerente;

    IF v_custo > 10000 AND NOT v_eh_gerente THEN
        RAISE EXCEPTION 'Curso restrito a gerentes';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_valida_custo_curso
BEFORE INSERT OR UPDATE ON empcourse
FOR EACH ROW
EXECUTE FUNCTION fn_valida_custo_curso_gerente();

-- PARTE 3
CREATE OR REPLACE FUNCTION fn_atualiza_historico_salarial()
RETURNS TRIGGER AS $$
BEGIN
    IF (OLD.current_position IS DISTINCT FROM NEW.current_position)
    OR (OLD.current_salary IS DISTINCT FROM NEW.current_salary) THEN

        UPDATE jobhistory
        SET enddate = CURRENT_DATE
        WHERE empno = OLD.empno AND enddate IS NULL;

        IF NEW.current_position IS NOT NULL THEN
            INSERT INTO jobhistory (empno, position, startdate, enddate, salary)
            VALUES (NEW.empno, NEW.current_position, CURRENT_DATE, NULL, NEW.current_salary);
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_movimentacao_empregado
AFTER UPDATE ON employee
FOR EACH ROW
EXECUTE FUNCTION fn_atualiza_historico_salarial();

CREATE OR REPLACE FUNCTION fn_historico_gerencia()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.head IS DISTINCT FROM NEW.head THEN

        IF OLD.head IS NOT NULL THEN
            UPDATE jobhistory
            SET enddate = CURRENT_DATE
            WHERE empno = OLD.head AND enddate IS NULL;
        END IF;

        IF NEW.head IS NOT NULL THEN
            INSERT INTO jobhistory (empno, position, startdate, enddate, salary)
            VALUES (NEW.head, 'Head - ' || NEW.dname, CURRENT_DATE, NULL,
                   (SELECT current_salary FROM employee WHERE empno = NEW.head));
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_mudanca_gerente
AFTER UPDATE ON department
FOR EACH ROW
EXECUTE FUNCTION fn_historico_gerencia();

-- PARTE 4
CREATE OR REPLACE VIEW v_ranking_cursos_empregados AS
SELECT
    e.empno,
    e.forenames,
    e.surname,
    COUNT(ec.courseno) AS total_cursos
FROM employee e
LEFT JOIN empcourse ec ON e.empno = ec.empno
GROUP BY e.empno, e.forenames, e.surname
ORDER BY total_cursos DESC;

-- PARTE 5
CREATE OR REPLACE FUNCTION fn_notifica_deslocamento_bh()
RETURNS TRIGGER AS $$
DECLARE
    v_local_curso VARCHAR(50);
    v_nome_curso VARCHAR(30);
    v_nome_emp VARCHAR(50);
    v_nome_sup VARCHAR(50);
BEGIN
    SELECT cname, location INTO v_nome_curso, v_local_curso
    FROM course
    WHERE courseno = NEW.courseno;

    IF v_local_curso IS NOT NULL
       AND UPPER(v_local_curso) <> 'BELO HORIZONTE' THEN

        SELECT forenames || ' ' || surname INTO v_nome_emp
        FROM employee
        WHERE empno = NEW.empno;

        SELECT sup.forenames || ' ' || sup.surname INTO v_nome_sup
        FROM employee emp
        JOIN department d ON emp.depno = d.depno
        JOIN employee sup ON d.head = sup.empno
        WHERE emp.empno = NEW.empno;

        RAISE NOTICE 'E-MAIL PARA: %', COALESCE(v_nome_sup, 'Gerente Geral');
        RAISE NOTICE 'FUNCIONÁRIO: %', v_nome_emp;
        RAISE NOTICE 'CURSO: % em %', v_nome_curso, v_local_curso;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_aviso_deslocamento
AFTER INSERT ON empcourse
FOR EACH ROW
EXECUTE FUNCTION fn_notifica_deslocamento_bh();