-- CONSULTA 01
SELECT u.nm_usuario, p.conteudo, p.dt_criacao FROM usuario u LEFT JOIN postagem p 
	ON u.id_usuario = p.id_usuario
	ORDER BY u.nm_usuario ASC;

-- CONSULTA 02

SELECT seguido.nm_usuario AS perfil, seguidor.nm_usuario AS seguidor
	FROM usuario_usuario uu JOIN usuario seguido 
 		ON uu.id_usuario_seguido = seguido.id_usuario
	JOIN usuario seguidor 
		ON uu.id_usuario_seguidor = seguidor.id_usuario;
