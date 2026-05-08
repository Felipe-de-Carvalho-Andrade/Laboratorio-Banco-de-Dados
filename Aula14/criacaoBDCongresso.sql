/*
DROP TABLE artigo;
DROP TABLE participante;
DROP TABLE autor_artigo;
DROP TABLE cartao_credito;
DROP TABLE congresso;
DROP TABLE participante_congresso;
DROP TABLE revisor_artigo;
*/

CREATE TABLE artigo (
  id_artigo serial NOT NULL ,
  nm_titulo_artigo varchar(100),
  nm_resumo_artigo varchar(200),
  nm_artigo varchar(100),
  dt_envio_artigo date,
  qt_revisoes_artigo integer,
  PRIMARY KEY  (id_artigo)
) ;



CREATE TABLE participante (
  id_participante serial NOT NULL ,
  nm_participante varchar(50),
  nm_endereco_participante varchar(200),
  nu_tel_participante varchar(20),
  nm_email_participante varchar(50),
  nm_empresa_participante varchar(100),
  nm_login_participante varchar(20),
  nm_senha_participante varchar(20),
  PRIMARY KEY  (id_participante)
) ;


CREATE TABLE autor_artigo (
  id_autor_artigo serial NOT NULL,
  id_participante integer NOT NULL,
  id_artigo integer NOT NULL,
  PRIMARY KEY  (id_autor_artigo),
  CONSTRAINT autor_artigo_fk FOREIGN KEY (id_participante) REFERENCES participante (id_participante) 
	ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT autor_artigo_fk1 FOREIGN KEY (id_artigo) REFERENCES artigo (id_artigo) 
	ON DELETE RESTRICT ON UPDATE RESTRICT 
) ;



CREATE TABLE cartao_credito (
  id_cartao_credito serial NOT NULL,
  nu_cartao_credito varchar(20),
  nm_bandeira_cartao varchar(20) ,
  dt_venc_cartao date ,
  id_participante integer NOT NULL,
  PRIMARY KEY  (id_cartao_credito),
  CONSTRAINT cartao_credito_fk FOREIGN KEY (id_participante) REFERENCES participante (id_participante) 
	ON DELETE RESTRICT ON UPDATE CASCADE
) ;



CREATE TABLE congresso (
  id_congresso serial NOT NULL,
  nm_congresso varchar(20) ,
  nm_sede_congresso varchar(100) ,
  dt_inicio_congresso date ,
  dt_fim_congresso date ,
  dt_prazo_submissao date ,
  dt_prazo_revisao date ,
  vl_inscricao numeric(9,3) ,
  PRIMARY KEY  (id_congresso)
) ;


CREATE TABLE participante_congresso (
  id_participante_congresso serial NOT NULL,
  id_congresso integer NOT NULL,
  id_participante integer NOT NULL,
  nu_inscricao integer ,
  in_eh_revisor numeric(1) default 0,
  PRIMARY KEY  (id_participante_congresso),
  CONSTRAINT congresso_participante_fk FOREIGN KEY (id_congresso) REFERENCES congresso (id_congresso) 
	ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT congresso_participante_fk1 FOREIGN KEY (id_participante) REFERENCES participante (id_participante) 
	ON DELETE RESTRICT ON UPDATE CASCADE
) ;



CREATE TABLE revisor_artigo (
  id_revisor_artigo serial NOT NULL,
  id_participante integer NOT NULL,
  id_artigo integer NOT NULL,
  nu_nota numeric(9,3) ,
  nm_comentario varchar(200) ,
  dt_prazo_revisao date ,
  dt_revisao date ,
  PRIMARY KEY  (id_revisor_artigo),
  CONSTRAINT revisor_artigo_fk FOREIGN KEY (id_participante) REFERENCES participante (id_participante) 
	ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT revisor_artigo_fk1 FOREIGN KEY (id_artigo) REFERENCES artigo (id_artigo) 
	ON DELETE RESTRICT ON UPDATE CASCADE
) ;

create or replace function povoa_banco() 
returns boolean as
'
declare
	valor_max_cong integer default 100;
	valor_max integer default 1000;
	cont integer default 1;
	cont_congresso integer default 1;
	dt_submissao date default now();
	pz_revisao date default now();

	lastIdParticipante integer;
	lastIdCongresso integer;
	lastIdArtigo integer;

begin

  while cont_congresso < valor_max_cong loop

  insert into congresso (nm_congresso, nm_sede_congresso, dt_inicio_congresso, dt_fim_congresso, dt_prazo_submissao, dt_prazo_revisao, vl_inscricao)
  values (''ERBASE ''|| cont_congresso , ''Salvador'', to_date(''2012-08-12'',''AAAA-MM-DD''), to_date(''2012-08-16'',''AAAA-MM-DD''), to_date(''2012-06-12'',''AAAA-MM-DD''), to_date(''2012-07-12'',''AAAA-MM-DD''), 20.00 + cont);

  select into lastIdCongresso currval(''congresso_id_congresso_seq'');

  while cont < valor_max loop

     insert into participante (nm_participante, nm_endereco_participante, nu_tel_participante, nm_email_participante, nm_empresa_participante)
     values ( ''Participante '' || cont, ''Endereco do participante ''||cont, ''(71)8888-9999'',
     ''participante''||cont||''@erbase.com'', ''Empresa do participante ''||cont );
     
     select into lastIdParticipante currval(''participante_id_participante_seq'');

     insert into cartao_credito (nu_cartao_credito, nm_bandeira_cartao, dt_venc_cartao, id_participante)
     values (''1111 2222 3333 4444'' , ''VISA'', to_date(''2016-01-01'',''AAAA-MM-DD''), lastIdParticipante);

     insert into participante_congresso (id_participante, id_congresso, nu_inscricao, in_eh_revisor)
     values (lastIdParticipante, lastIdCongresso, 20120+cont, random() );

     insert into artigo (nm_resumo_artigo, dt_envio_artigo)
     values ( ''Resumo do artigo ''||cont, dt_submissao);

     select into lastIdArtigo currval(''artigo_id_artigo_seq'');
    
     insert into autor_artigo (id_participante, id_artigo)
     values (lastIdParticipante, lastIdArtigo);

     if cont > 2 then
        insert into revisor_artigo (id_participante, id_artigo, nu_nota, nm_comentario, dt_prazo_revisao)
        values (lastIdParticipante-1, lastIdArtigo, random()*10.1, ''Comentario do revisor ''|| cont, pz_revisao);
     end if;
     
     cont = cont + 1;

  end loop;
  
  cont = 0;
  cont_congresso = cont_congresso + 1;
  
  end loop;
return ''t'';
end;
'
language 'plpgsql';


-- select * from povoa_banco();