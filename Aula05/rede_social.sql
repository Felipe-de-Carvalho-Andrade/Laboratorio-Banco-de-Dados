CREATE TABLE usuario (
    id_usuario SERIAL, 
    nm_usuario VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    dt_nascimento DATE NOT NULL,
    CONSTRAINT pk_usuario PRIMARY KEY (id_usuario),
    CONSTRAINT uk_usuario_email UNIQUE (email) 
);

CREATE TABLE usuario_usuario (
    id_usuario_seguidor INTEGER NOT NULL,
    id_usuario_seguido INTEGER NOT NULL,
    dt_seguir DATE DEFAULT CURRENT_DATE, 
    
    CONSTRAINT pk_usuario_usuario PRIMARY KEY (id_usuario_seguidor, id_usuario_seguido),
    CONSTRAINT fk_seguidor FOREIGN KEY (id_usuario_seguidor)
        REFERENCES usuario (id_usuario) 
		ON DELETE CASCADE,
    CONSTRAINT fk_seguido FOREIGN KEY (id_usuario_seguido)
        REFERENCES usuario (id_usuario) 
		ON DELETE CASCADE
);

CREATE TABLE postagem (
    id_postagem SERIAL,
    conteudo TEXT NOT NULL,
    dt_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_usuario INTEGER NOT NULL,
    
    CONSTRAINT pk_postagem PRIMARY KEY (id_postagem),
    CONSTRAINT fk_postagem_usuario FOREIGN KEY (id_usuario)
        REFERENCES usuario (id_usuario) 
		ON DELETE CASCADE
);

CREATE TABLE comentario (
    id_comentario SERIAL,
    conteudo TEXT NOT NULL,
    dt_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_usuario INTEGER NOT NULL,
    id_postagem INTEGER NOT NULL,
    
    CONSTRAINT pk_comentario PRIMARY KEY (id_comentario),
    CONSTRAINT fk_comentario_usuario FOREIGN KEY (id_usuario)
        REFERENCES usuario (id_usuario) 
		ON DELETE CASCADE,
    CONSTRAINT fk_comentario_postagem FOREIGN KEY (id_postagem)
        REFERENCES postagem (id_postagem) 
		ON DELETE CASCADE
);