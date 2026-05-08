--- Felipe de Carvalho Andrade - RED3A

--- QUESTAO a
CREATE OR REPLACE FUNCTION verifica_habilidade(
    p_instrumento CHAR(10),
    p_mensagem_adicional TEXT DEFAULT '',
    p_telefone_contato CHAR(15) DEFAULT ''
) RETURNS VOID AS $$
DECLARE
    v_nome_musico CHAR(20);
BEGIN
    FOR v_nome_musico IN SELECT m.nm_musico FROM interprete i
		INNER JOIN musico m ON i.nu_musico_interprete = m.nu_musico
	    WHERE i.nm_instrumento = p_instrumento
    LOOP
        RAISE NOTICE 'Prezado(a) %,' , v_nome_musico;
        RAISE NOTICE 'Você foi selecionado em nosso banco de dados em virtude da sua habilidade em tocar %.', p_instrumento;
        RAISE NOTICE 'Atualmente, surgiu uma vaga para % na nossa organização.', p_instrumento;
        
        IF p_telefone_contato <> '' THEN
            RAISE NOTICE 'Caso você tenha interesse, entre em contato através do telefone %.', p_telefone_contato;
        END IF;
        
        IF p_mensagem_adicional <> '' THEN
            RAISE NOTICE '%', p_mensagem_adicional;
        END IF;
        
        RAISE NOTICE '---';
		RAISE NOTICE '';
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- SELECT verifica_habilidade('violin', 'Por favor, entre em contato o mais breve possível.', '(31) 3321-2323');

--- QUESTAO b
CREATE OR REPLACE FUNCTION convidar_musicos(data_evento DATE) 
RETURNS VOID AS $$
DECLARE
    r_evento RECORD;
    r_musico RECORD;
BEGIN
    FOR r_evento IN SELECT e.nu_evento, e.nm_auditorio, l.nm_cidade, l.nm_pais FROM evento e
        INNER JOIN local l ON e.nu_local_evento = l.nu_local
        WHERE e.dt_evento = data_evento
    LOOP
        FOR r_musico IN SELECT DISTINCT m.nm_musico FROM atuacao a 
			INNER JOIN banda b ON a.nu_banda = b.nu_banda
            INNER JOIN show s ON b.nu_banda = s.nu_banda
            INNER JOIN interprete i ON a.nu_interprete = i.nu_interprete
            INNER JOIN musico m ON i.nu_musico_interprete = m.nu_musico
            WHERE s.nu_evento = r_evento.nu_evento
        LOOP
            RAISE NOTICE 'Prezado(a) %,', r_musico.nm_musico;
            RAISE NOTICE 'Você está sendo convidado(a) para um evento que ocorrerá no dia %.', TO_CHAR(data_evento, 'DD/MM/YYYY');
            RAISE NOTICE 'O evento será realizado no auditório "%", localizado em %, %.', 
                         r_evento.nm_auditorio, r_evento.nm_cidade, r_evento.nm_pais;
            RAISE NOTICE 'Será uma honra contar com a sua presença.';
            RAISE NOTICE 'Atenciosamente,';
            RAISE NOTICE 'Equipe de Eventos';

            RAISE NOTICE '---';
			RAISE NOTICE '';
        END LOOP;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- SELECT convidar_musicos('20-Sep-1997');