CREATE TABLE local
	(
	nu_local		INTEGER 		PRIMARY KEY,
	nm_cidade		CHAR(20),
	nm_pais		CHAR(20)
	);

CREATE TABLE musico 
	(
	nu_musico 				INTEGER 		PRIMARY KEY,
	nm_musico				CHAR(20) NOT NULL,
	dt_nascimento     		DATE,
	dt_falecimento    		DATE default null,
	nu_local_nascimento		INTEGER 		REFERENCES local (nu_local),
	nu_local_residencia		INTEGER 		REFERENCES local (nu_local),
      check ((dt_nascimento IS NULL) OR 
             (TO_DATE ('1-Jan-1900', 'DD-Mon_YYYY') < dt_nascimento)),
	check ((dt_nascimento IS NULL) OR (dt_falecimento IS NULL) OR (dt_falecimento > dt_nascimento))
	);

CREATE TABLE interprete
	(
	nu_interprete		INTEGER		PRIMARY KEY,
	nu_musico_interprete	INTEGER NOT NULL	REFERENCES musico (nu_musico),
	nm_instrumento		CHAR(10) NOT NULL,
	tp_interprete		CHAR(10)		default 'not known'
	);

CREATE TABLE compositor
	(
	nu_compositor		INTEGER 		PRIMARY KEY,
	nu_musico_compositor	INTEGER NOT NULL	REFERENCES musico (nu_musico),
	tp_compositor		CHAR(10)
	);

CREATE TABLE banda
	(
	nu_banda			INTEGER 		PRIMARY KEY,
	nm_banda			CHAR(20),
	nu_local_banda		INTEGER NOT NULL	REFERENCES local (nu_local),
	tp_banda			CHAR(10),
	dt_criacao_banda	      DATE,
	nu_musico_contato_banda	INTEGER NOT NULL	REFERENCES musico (nu_musico)
	);

CREATE TABLE atuacao
	(
	nu_interprete		INTEGER  		 REFERENCES interprete (nu_interprete),
	nu_banda			INTEGER  		 REFERENCES banda (nu_banda),
	PRIMARY KEY ( nu_interprete, nu_banda)
	);

CREATE TABLE musica
	(
	nu_musica		INTEGER 		PRIMARY KEY,
	dt_musica		DATE,
	nm_musica		CHAR(40) NOT NULL,
	nu_local_musica			INTEGER 		REFERENCES local (nu_local)
	);

CREATE TABLE composicao
	(
	nu_compositor		INTEGER 		REFERENCES compositor (nu_compositor),
	nu_musica		INTEGER 		REFERENCES musica (nu_musica),
	PRIMARY KEY ( nu_compositor, nu_musica )
	);

CREATE TABLE evento
	(
	nu_evento	 		INTEGER 		PRIMARY KEY,
	nm_auditorio		CHAR(20),
	nu_local_evento		INTEGER NOT NULL	REFERENCES local (nu_local),
	dt_evento	      	DATE,             
	nu_musico_organizador	INTEGER 		REFERENCES musico (nu_musico)
	);

CREATE TABLE show
	(
	nu_show			INTEGER 		PRIMARY KEY,
	nu_banda			INTEGER NOT NULL	REFERENCES banda (nu_banda),
	nu_musica			INTEGER NOT NULL 	REFERENCES musica (nu_musica),
	nu_musico_condutor	INTEGER 		REFERENCES musico (nu_musico),
	nu_evento			INTEGER 		REFERENCES evento (nu_evento)
	);



INSERT INTO local VALUES ( 1 , 'Manchester' , 'England' );
INSERT INTO local VALUES ( 2 , 'Edinburgh' , 'Scotland' );
INSERT INTO local VALUES ( 3 , 'Salzburg' , 'Austria' );
INSERT INTO local VALUES ( 4 , 'New York' , 'USA' );
INSERT INTO local VALUES ( 5 , 'Birmingham' , 'England' );
INSERT INTO local VALUES ( 6 , 'Glasgow' , 'Scotland' );
INSERT INTO local VALUES ( 7 , 'London' , 'England' );
INSERT INTO local VALUES ( 8 , 'Chicago' , 'USA' );
INSERT INTO local VALUES ( 9 , 'Amsterdam' , 'Netherlands' );
INSERT INTO musico VALUES ( 1 , 'Fred Bloggs' , '2-Jan-1948',NULL , 1, 2);
INSERT INTO musico VALUES ( 2, 'John Smith' , '3-Mar-1950',NULL , 3, 4);
INSERT INTO musico VALUES ( 3 , 'Helen Smyth' , '8-Aug-1948',NULL , 4,5);
INSERT INTO musico VALUES ( 4 , 'Harriet Smithson' , '9-May-1909','20-Sep-1980' , 5, 6);
INSERT INTO musico VALUES ( 5 , 'James First' , '10-Jun-1965',NULL , 7, 7);
INSERT INTO musico VALUES ( 6 , 'Theo Mengel' , '12-Aug-1948',NULL , 7, 1);
INSERT INTO musico VALUES ( 7 , 'Sue Little' , '21-Feb-1945',NULL , 8, 9);
INSERT INTO musico VALUES ( 8 , 'Harry Forte' , '28-Feb-1951',NULL , 1,8);
INSERT INTO musico VALUES ( 9 , 'Phil Hot' , '30-Jun-1942',NULL , 2, 7);
INSERT INTO musico VALUES ( 10 , 'Jeff Dawn' , '12-Dec-1949',NULL ,3 ,6);
INSERT INTO musico VALUES ( 11 , 'Rose Spring' , '25-May-1948',NULL ,4 ,5);
INSERT INTO musico VALUES ( 12 , 'Davis Heavan' , '3-Oct-1975',NULL , 5, 4);
INSERT INTO musico VALUES ( 13, 'Lovely Time' , '28-Dec-1948',NULL , 6, 3);
INSERT INTO musico VALUES ( 14 , 'Alan Fluff' , '15-Jan-1935','15-May-1997' , 7,2);
INSERT INTO musico VALUES ( 15 , 'Tony Smythe' , '2-Apr-1932',NULL , 8, 1);
INSERT INTO musico VALUES ( 16 , 'James Quick' , '8-Aug-1924',NULL , 9, 2);
INSERT INTO musico VALUES ( 17 , 'Freda Miles' , '4-Jul-1920',NULL , 9, 3);
INSERT INTO musico VALUES ( 18 , 'Elsie James' , '6-May-1947',NULL , 8, 5);
INSERT INTO musico VALUES ( 19 , 'Andy Jones' , '8-Oct-1958',NULL , 7, 6);
INSERT INTO musico VALUES ( 20 , 'Louise Simpson' , '10-Jan-1948','11-Feb-1998' , 6, 6);
INSERT INTO musico VALUES ( 21 , 'James Steeple' , '10-Jan-1947',NULL , 5, 6);
INSERT INTO musico VALUES ( 22 , 'Steven Chaytors' , '11-Mar-1956',NULL , 6, 7);
INSERT INTO compositor VALUES (1 , 1, 'jazz');
INSERT INTO compositor VALUES ( 2, 3, 'classical');
INSERT INTO compositor VALUES ( 3, 5, 'jazz');
INSERT INTO compositor VALUES ( 4, 7, 'classical');
INSERT INTO compositor VALUES ( 5, 9, 'jazz');
INSERT INTO compositor VALUES (6 , 11, 'rock');
INSERT INTO compositor VALUES (7 , 13, 'classical');
INSERT INTO compositor VALUES ( 8, 15, 'jazz');
INSERT INTO compositor VALUES ( 9, 17, 'classical');
INSERT INTO compositor VALUES ( 10 , 19, 'jazz');
INSERT INTO compositor VALUES ( 11, 10, 'rock');
INSERT INTO compositor VALUES ( 12, 8, 'jazz');
INSERT INTO interprete VALUES ( 1, 2, 'violin','classical' );
INSERT INTO interprete VALUES ( 2, 4, 'viola','classical' );
INSERT INTO interprete VALUES ( 3, 6, 'banjo','jazz' );
INSERT INTO interprete VALUES ( 4, 8, 'violin','classical' );
INSERT INTO interprete VALUES ( 5, 12, 'guitar','jazz' );
INSERT INTO interprete VALUES ( 6, 14, 'violin','classical' );
INSERT INTO interprete VALUES ( 7, 16, 'trumpet','jazz' );
INSERT INTO interprete VALUES ( 8, 18, 'viola','classical' );
INSERT INTO interprete VALUES ( 9, 20, 'bass','jazz' );
INSERT INTO interprete VALUES ( 10, 2, 'flute','jazz' );
INSERT INTO interprete VALUES ( 11, 20, 'cornet','jazz' );
INSERT INTO interprete VALUES ( 12, 6, 'violin','jazz' );
INSERT INTO interprete VALUES ( 13, 8, 'drums','jazz' );
INSERT INTO interprete VALUES ( 14, 10, 'violin','classical' );
INSERT INTO interprete VALUES ( 15, 12, 'cello','classical' );
INSERT INTO interprete VALUES ( 16, 14, 'viola','classical' );
INSERT INTO interprete VALUES ( 17, 16, 'flute','jazz' );
INSERT INTO interprete VALUES ( 18, 18, 'guitar' );
INSERT INTO interprete VALUES ( 19, 20, 'trombone','jazz' );
INSERT INTO interprete VALUES ( 20, 3, 'horn','jazz' );
INSERT INTO interprete VALUES ( 21, 5, 'violin','jazz' );
INSERT INTO interprete VALUES ( 22, 7, 'cello','classical' );
INSERT INTO interprete VALUES ( 23, 2, 'bass','jazz' );
INSERT INTO interprete VALUES ( 24, 4, 'violin','jazz' );
INSERT INTO interprete VALUES ( 25, 6, 'drums','classical' );
INSERT INTO interprete VALUES ( 26, 8, 'clarinet','jazz' );
INSERT INTO interprete VALUES ( 27, 10, 'bass','jazz' );
INSERT INTO interprete VALUES ( 28, 12, 'viola','classical' );
INSERT INTO interprete VALUES ( 29, 18, 'cello','classical' );
INSERT INTO banda VALUES ( 1,'ROP',5 ,'classical','1-Jan-1930',11 );
INSERT INTO banda VALUES ( 2,'AASO',6 ,'classical',null,10 );
INSERT INTO banda VALUES ( 3,'The J Bs',8 ,'jazz',null,12 );
INSERT INTO banda VALUES ( 4,'BBSO', 9,'classical',null,21 );
INSERT INTO banda VALUES ( 5,'The left Overs',2 ,'jazz',null, 8);
INSERT INTO banda VALUES ( 6,'Somebody Loves this',1 ,'jazz',null, 6);
INSERT INTO banda VALUES ( 7,'Oh well', 4,'classical',null,3 );
INSERT INTO banda VALUES ( 8,'Swinging strings',4 ,'classical',null, 7);
INSERT INTO banda VALUES ( 9,'The Rest', 9,'jazz',null, 16);
INSERT INTO musica VALUES ( 1, '17-Jun-1975','Opus 1', 1);
INSERT INTO musica VALUES ( 2, '21-Jul-1976','Here Goes', 2);
INSERT INTO musica VALUES ( 3, '14-Dec-1981','Valiant Knight', 3);
INSERT INTO musica VALUES ( 4, '12-Jan-1982','Little Piece', 4);
INSERT INTO musica VALUES ( 5, '13-Mar-1985','Simple Song', 5);
INSERT INTO musica VALUES ( 6, '14-Apr-1986','Little Swing Song', 6);
INSERT INTO musica VALUES ( 7, '13-May-1987','Fast Journey', 7);
INSERT INTO musica VALUES ( 8, '14-Feb-1976','Simple Love Song', 8);
INSERT INTO musica VALUES ( 9, '21-Jan-1982','Complex Rythms', 9);
INSERT INTO musica VALUES ( 10, '23-Feb-1985','Drumming Rythms', 9);
INSERT INTO musica VALUES ( 11, '18-Mar-1978','Fast Drumming', 8);
INSERT INTO musica VALUES ( 12, '13-Aug-1984','Slow Song', 7);
INSERT INTO musica VALUES ( 13, '14-Sep-1968','Blue Roses', 6);
INSERT INTO musica VALUES ( 14, '15-Nov-1983','Velvet Rain', 5);
INSERT INTO musica VALUES ( 15, '16-May-1982','Cold Wind', 4);
INSERT INTO musica VALUES ( 16, '18-Jun-1983','After the Wind Blows', 3);
INSERT INTO musica VALUES ( 17, NULL,'A Simple Piece', 2);
INSERT INTO musica VALUES ( 18, '12-Jan-1985','Long Rythms', 1);
INSERT INTO musica VALUES ( 19, '12-Feb-1988','Eastern Wind', 1);
INSERT INTO musica VALUES ( 20, NULL,'Slow Symphony Blowing', 2);
INSERT INTO musica VALUES ( 21, '12-Jul-1990','A Last Song', 6);
INSERT INTO composicao VALUES (1 ,1 );
INSERT INTO composicao VALUES (3 ,2 );
INSERT INTO composicao VALUES (5 ,3 );
INSERT INTO composicao VALUES (7 ,4 );
INSERT INTO composicao VALUES (9 ,5 );
INSERT INTO composicao VALUES (11 , 6);
INSERT INTO composicao VALUES (12 , 7);
INSERT INTO composicao VALUES (1 , 8);
INSERT INTO composicao VALUES (7 , 9);
INSERT INTO composicao VALUES (9 , 10);
INSERT INTO composicao VALUES (2 , 11);
INSERT INTO composicao VALUES ( 4, 12);
INSERT INTO composicao VALUES ( 3, 13);
INSERT INTO composicao VALUES ( 5, 14);
INSERT INTO composicao VALUES (6 , 15);
INSERT INTO composicao VALUES (8 , 16);
INSERT INTO composicao VALUES (10 , 17);
INSERT INTO composicao VALUES (3 , 18);
INSERT INTO composicao VALUES ( 12, 19);
INSERT INTO composicao VALUES ( 4, 20);
INSERT INTO composicao VALUES ( 6, 21);
INSERT INTO composicao VALUES ( 5, 13);
INSERT INTO composicao VALUES ( 3, 14);
INSERT INTO evento VALUES ( 1,'Bridgewater Hall',1 ,'6-Jan-1995', 21);
INSERT INTO evento VALUES ( 2,'Bridgewater Hall',1 ,'8-May-1996', 3);
INSERT INTO evento VALUES ( 3,'Usher Hall',2 ,'3-Jun-1995', 3);
INSERT INTO evento VALUES ( 4,'Assembly Rooms',2 ,'20-Sep-1997',21 );
INSERT INTO evento VALUES ( 5,'Festspiel Haus',3 ,'21-Feb-1995',8 );
INSERT INTO evento VALUES ( 6,'Royal Albert Hall',7 ,'12-Apr-1993',8 );
INSERT INTO evento VALUES ( 7,'eventogebouw',9 ,'14-May-1993', 8);
INSERT INTO evento VALUES ( 8,'Metropolitan',4 ,'15-Jun-1997',21 );
INSERT INTO atuacao VALUES ( 1, 1);
INSERT INTO atuacao VALUES ( 3, 1);
INSERT INTO atuacao VALUES ( 4, 1);
INSERT INTO atuacao VALUES ( 5, 1);
INSERT INTO atuacao VALUES ( 6, 1);
INSERT INTO atuacao VALUES ( 7, 1);
INSERT INTO atuacao VALUES ( 8, 1);
INSERT INTO atuacao VALUES ( 10, 2);
INSERT INTO atuacao VALUES ( 12, 2);
INSERT INTO atuacao VALUES ( 13, 2);
INSERT INTO atuacao VALUES ( 14, 2);
INSERT INTO atuacao VALUES ( 15, 2);
INSERT INTO atuacao VALUES ( 17, 2);
INSERT INTO atuacao VALUES ( 18, 2);
INSERT INTO atuacao VALUES ( 19, 3);
INSERT INTO atuacao VALUES ( 20, 3);
INSERT INTO atuacao VALUES ( 21, 4);
INSERT INTO atuacao VALUES ( 22, 4);
INSERT INTO atuacao VALUES ( 23, 4);
INSERT INTO atuacao VALUES ( 25, 5);
INSERT INTO atuacao VALUES ( 26, 6);
INSERT INTO atuacao VALUES ( 27, 6);
INSERT INTO atuacao VALUES (28 , 7);
INSERT INTO atuacao VALUES (29 , 7);
INSERT INTO atuacao VALUES ( 1, 7 );
INSERT INTO atuacao VALUES ( 4, 7);
INSERT INTO atuacao VALUES ( 6, 7);
INSERT INTO atuacao VALUES ( 8, 7);
INSERT INTO atuacao VALUES ( 14, 8);
INSERT INTO atuacao VALUES ( 15, 8);
INSERT INTO atuacao VALUES ( 28, 8);
INSERT INTO show VALUES ( 1, 1, 1, 21, 1);
INSERT INTO show VALUES ( 2, 1, 3, 21, 1);
INSERT INTO show VALUES ( 3, 1, 5, 21, 1);
INSERT INTO show VALUES ( 4, 1, 2, 1, 2);
INSERT INTO show VALUES ( 5, 2, 4, 21, 2);
INSERT INTO show VALUES ( 6, 2, 6, 21, 2);
INSERT INTO show VALUES ( 7, 4, 19, 9, 3);
INSERT INTO show VALUES ( 8, 4, 20,10, 3);
INSERT INTO show VALUES ( 9, 5, 12,10, 4);
INSERT INTO show VALUES ( 10, 5, 13,11, 4);
INSERT INTO show VALUES ( 11, 3, 5,13 , 5);
INSERT INTO show VALUES ( 12, 3, 6,13 , 5);
INSERT INTO show VALUES ( 13, 3, 7,13 , 5);
INSERT INTO show VALUES ( 14, 6, 20,14 , 6);
INSERT INTO show VALUES ( 15, 8, 12,15 , 7);
INSERT INTO show VALUES ( 16, 9, 16,21 , 8);
INSERT INTO show VALUES ( 17, 9, 17,21 , 8);
INSERT INTO show VALUES ( 18, 9, 18,21 , 8);
INSERT INTO show VALUES ( 19, 9, 19,21 , 8);
INSERT INTO show VALUES ( 20, 4, 12,10 , 3);

