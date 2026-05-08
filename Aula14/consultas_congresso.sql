--- Felipe de Carvalho Andrade - RED3A

--- QUESTAO 01
CREATE OR REPLACE VIEW vw_artigos_participantes AS
SELECT p.id_participante, p.nm_participante, a.id_artigo, a.nm_titulo_artigo,
    CASE
        WHEN aa.id_participante IS NOT NULL THEN 'Autor'
        WHEN ra.id_participante IS NOT NULL THEN 'Revisor'
        ELSE 'Nenhum'
    END AS tipo_participacao
FROM participante p LEFT JOIN autor_artigo aa
    ON p.id_participante = aa.id_participante
LEFT JOIN artigo a
    ON aa.id_artigo = a.id_artigo
LEFT JOIN revisor_artigo ra
   ON p.id_participante = ra.id_participante
   AND ra.id_artigo = a.id_artigo;

--- QUESTAO 02
CREATE OR REPLACE FUNCTION distribuir_artigos()
RETURNS void AS $$
DECLARE
    id_artigo_atual INTEGER;
    id_revisor_atual INTEGER;
    total_revisores INTEGER;
    total_artigos INTEGER;
    revisor_index INTEGER;
BEGIN
    SELECT COUNT(*) INTO total_revisores  FROM participante_congresso
    WHERE in_eh_revisor = 1;

    SELECT COUNT(*) INTO total_artigos FROM artigo;

    FOR id_artigo_atual IN
        SELECT id_artigo FROM artigo
    LOOP
        revisor_index := (id_artigo_atual - 1) % total_revisores + 1;

        SELECT id_participante
        INTO id_revisor_atual
        FROM participante_congresso
        WHERE in_eh_revisor = 1
        LIMIT 1 OFFSET revisor_index - 1;

        INSERT INTO revisor_artigo (id_participante, id_artigo, dt_prazo_revisao)
        VALUES (id_revisor_atual, id_artigo_atual, NOW() + INTERVAL '1 month');
    END LOOP;
END;
$$ LANGUAGE plpgsql;

--- QUESTAO 03
CREATE OR REPLACE FUNCTION notificar_autores()
RETURNS TRIGGER AS $$
DECLARE
    autor RECORD;
BEGIN
    FOR autor IN
        SELECT p.nm_email_participante FROM autor_artigo aa
		INNER JOIN participante p
            ON aa.id_participante = p.id_participante
        WHERE aa.id_artigo = NEW.id_artigo
    LOOP
        RAISE NOTICE 'E-mail enviado para %: Seu artigo foi revisado.', autor.nm_email_participante;
    END LOOP;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER enviar_email_autor AFTER INSERT ON revisor_artigo FOR EACH ROW
EXECUTE FUNCTION notificar_autores();

--- QUESTAO 04
CREATE OR REPLACE VIEW vw_artigos_com_notas_altas AS
SELECT a.id_artigo, a.nm_titulo_artigo, a.dt_envio_artigo, AVG(ra.nu_nota) AS media_nota
FROM artigo a INNER JOIN revisor_artigo ra
    ON a.id_artigo = ra.id_artigo

GROUP BY
    a.id_artigo,
    a.nm_titulo_artigo,
    a.dt_envio_artigo
HAVING AVG(ra.nu_nota) > 8
ORDER BY a.dt_envio_artigo DESC;