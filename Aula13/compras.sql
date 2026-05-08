--- Felipe de Carvalho Andrade RED3A

--- QUESTAO a
SELECT p.category, SUM(o.quantity) FROM products p
NATURAL JOIN cust_hist ch
NATURAL JOIN orderlines o
WHERE o.orderdate > '15-01-2009'

GROUP BY 1;

--- QUESTAO b
CREATE OR REPLACE FUNCTION total_produtos_categoria(INT)
RETURNS inventory.quan_in_stock%TYPE AS $$
DECLARE
    qtd_total inventory.quan_in_stock%TYPE;
    categoria ALIAS FOR $1;
BEGIN
    SELECT INTO qtd_total
        SUM(i.quan_in_stock)
    FROM inventory i
    NATURAL JOIN products p
    WHERE p.category = categoria;

    RETURN qtd_total;
END;
$$ LANGUAGE plpgsql;

-- SELECT total_produtos_categoria(1);

--- QUESTAO c
CREATE OR REPLACE VIEW verifica_integridade AS
SELECT p.prod_id, i.sales, COALESCE(SUM(o.quantity), 0) AS calculo_sales
FROM products p NATURAL JOIN inventory i NATURAL JOIN orderlines o

GROUP BY 1, 2
ORDER BY 1;

SELECT prod_id, sales, calculo_sales FROM verifica_integridade
WHERE sales <> calculo_sales

GROUP BY 1, 2, 3
ORDER BY 1;

--- QUESTAO d
SELECT c.age, COALESCE(COUNT(c.customerid), 0) FROM customers c
NATURAL JOIN cust_hist ch
NATURAL JOIN products p
WHERE p.category = 10

GROUP BY 1
ORDER BY 1;

--- QUESTAO e
SELECT p.title, COALESCE(COUNT(c.customerid), 0) FROM customers c
NATURAL JOIN cust_hist ch
NATURAL JOIN products p

GROUP BY 1
ORDER BY 2 DESC;