CREATE TABLE tipo_navio (
    tipo VARCHAR(50),
    tonelagem NUMERIC(10, 2) CONSTRAINT chk_tonelagem_positiva CHECK (tonelagem > 0),
    casco VARCHAR(50),
    CONSTRAINT pk_tipo_navio PRIMARY KEY (tipo)
);

CREATE TABLE estado_pais (
    nome VARCHAR(100),
    continente VARCHAR(50) NOT NULL,
    CONSTRAINT pk_estado_pais PRIMARY KEY (nome)
);

CREATE TABLE corpo_agua (
    nome VARCHAR(100),
    CONSTRAINT pk_corpo_agua PRIMARY KEY (nome)
);

CREATE TABLE porto (
    pj_nome VARCHAR(100),
    nome_estado_pais VARCHAR(100),
    nome_corpo_agua VARCHAR(100),
    CONSTRAINT pk_porto PRIMARY KEY (pj_nome, nome_estado_pais, nome_corpo_agua),
    
    CONSTRAINT fk_porto_estado_pais 
        FOREIGN KEY (nome_estado_pais) REFERENCES estado_pais(nome) 
        ON UPDATE CASCADE 
		ON DELETE RESTRICT,
        
    CONSTRAINT fk_porto_corpo_agua 
        FOREIGN KEY (nome_corpo_agua) REFERENCES corpo_agua(nome) 
        ON UPDATE CASCADE 
		ON DELETE RESTRICT
);

CREATE TABLE navio (
    nnome VARCHAR(100),
    proprietario VARCHAR(100),
    tipo_navio VARCHAR(50) NOT NULL,
    porto_origem_pj VARCHAR(100),
    porto_origem_estado VARCHAR(100),
    porto_origem_agua VARCHAR(100),
    
    CONSTRAINT pk_navio PRIMARY KEY (nnome),
    
    CONSTRAINT fk_navio_tipo 
        FOREIGN KEY (tipo_navio) REFERENCES tipo_navio(tipo) 
        ON UPDATE CASCADE 
		ON DELETE RESTRICT,
        
    CONSTRAINT fk_navio_porto_origem 
        FOREIGN KEY (porto_origem_pj, porto_origem_estado, porto_origem_agua) 
        REFERENCES porto(pj_nome, nome_estado_pais, nome_corpo_agua)
        ON UPDATE CASCADE 
		ON DELETE SET NULL
);

CREATE TABLE movimento_navio (
    nnome_navio VARCHAR(100),
    data_mov DATE DEFAULT CURRENT_DATE, 
    tempo_mov TIME DEFAULT CURRENT_TIME, 
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6),
    
    CONSTRAINT pk_movimento_navio PRIMARY KEY (nnome_navio, data_mov, tempo_mov),
    
    CONSTRAINT fk_movimento_navio_navio 
        FOREIGN KEY (nnome_navio) REFERENCES navio(nnome) 
        ON UPDATE CASCADE 
		ON DELETE CASCADE,
        
    CONSTRAINT chk_latitude CHECK (latitude BETWEEN -90 AND 90),
    CONSTRAINT chk_longitude CHECK (longitude BETWEEN -180 AND 180)
);

CREATE TABLE visita (
    nnome_navio VARCHAR(100),
    porto_pj VARCHAR(100),
    porto_estado VARCHAR(100),
    porto_agua VARCHAR(100),
    data_chegada TIMESTAMP NOT NULL,
    data_partida TIMESTAMP,
    
    CONSTRAINT pk_visita PRIMARY KEY (nnome_navio, porto_pj, porto_estado, porto_agua, data_chegada),
    
    CONSTRAINT fk_visita_navio 
        FOREIGN KEY (nnome_navio) REFERENCES navio(nnome) 
        ON UPDATE CASCADE 
		ON DELETE CASCADE,
        
    CONSTRAINT fk_visita_porto 
        FOREIGN KEY (porto_pj, porto_estado, porto_agua) 
        REFERENCES porto(pj_nome, nome_estado_pais, nome_corpo_agua)
        ON UPDATE CASCADE 
		ON DELETE RESTRICT,

    CONSTRAINT chk_datas_visita CHECK (data_partida >= data_chegada)
);