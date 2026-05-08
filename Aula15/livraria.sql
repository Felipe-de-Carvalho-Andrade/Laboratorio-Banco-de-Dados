-- LABORATÓRIO DBLINK
-- Davi James Vilela Guimarães e Felipe de Carvalho Andrade - RDC3A

-- QUESTAO 1
CREATE SEQUENCE sequenciador
INCREMENT BY 2
MINVALUE 2;

-- QUESTAO 2
CREATE OR REPLACE FUNCTION obter_novo_valor_sequencia()
RETURNS INTEGER AS $$
DECLARE
    retorno INTEGER;
BEGIN
    SELECT NEXTVAL('sequenciador') INTO retorno;
    RETURN retorno;
END;
$$ LANGUAGE plpgsql;