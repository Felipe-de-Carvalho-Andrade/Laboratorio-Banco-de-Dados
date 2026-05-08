create table fornecedor (
	fcodigo integer not null,
	fnome varchar(30),
	fstatus integer,
	fcidade varchar(30),
	constraint fornecedor_pkey primary key(fcodigo)
);

create table projeto (
	jcodigo integer not null,
	jnome varchar(30),
	jcidade varchar(30),
	constraint projeto_pkey primary key(jcodigo)
);

create table peca (
	pcodigo integer not null,
	pnome varchar(30),
	cor varchar(30),
	peso integer,
	pcidade varchar(30),
	constraint peca_pkey primary key(pcodigo)
);

create table fornecimento (
	fcodigo integer,
	pcodigo integer,
	jcodigo integer,
	quantidade integer,
	constraint forn_forn_fkey foreign key(fcodigo)
		references fornecedor(fcodigo)
		on delete restrict on update restrict,
	constraint forn_peca_fkey foreign key(pcodigo)
		references peca(pcodigo)
		on delete restrict on update restrict,
	constraint forn_projeto_fkey foreign key(jcodigo)
		references projeto(jcodigo)
		on delete restrict on update restrict,
	constraint forn_pkey primary key(fcodigo, pcodigo, jcodigo)
);

insert into fornecedor values (1,'Loja das Peças',20,'Londrina');
insert into fornecedor values (2,'Peças Brasil',10,'Ribeirão Preto');
insert into fornecedor values (3,'Carrefour',30,'Ribeirão Preto');
insert into fornecedor values (4,'Marks',20,'Londrina');
insert into fornecedor values (5,'Leroy Merlin',30,'Vitória');

insert into peca values (1,'Porca','Vermelho',12,'Londrina');
insert into peca values (2,'Parafuso de porca','Verde',17,'Ribeirão Preto');
insert into peca values (3,'Parafuso simples','Azul',17,'Niterói');
insert into peca values (4,'Parafuso simples','Vermelho',14,'Londrina');
insert into peca values (5,'Prego','Azul',12,'Ribeirão Preto');
insert into peca values (6,'Roda dentada','Vermelho',19,'Londrina');

insert into projeto values (1,'Raiz','Ribeirão Preto');
insert into projeto values (2,'Saraiva','Niterói');
insert into projeto values (3,'Pedreira','Vitória');
insert into projeto values (4,'RM & S','Vitória');
insert into projeto values (5,'MRV','Londrina');
insert into projeto values (6,'Simplus','Osasco');
insert into projeto values (7,'Tatico','Londrina');

insert into fornecimento values (1,1,1,200);
insert into fornecimento values (1,1,4,700);
insert into fornecimento values (2,3,1,400);
insert into fornecimento values (2,3,2,200);
insert into fornecimento values (2,3,3,200);
insert into fornecimento values (2,3,4,500);
insert into fornecimento values (2,3,5,600);
insert into fornecimento values (2,3,6,400);
insert into fornecimento values (2,3,7,800);
insert into fornecimento values (2,5,2,100);
insert into fornecimento values (3,3,1,200);
insert into fornecimento values (3,4,2,500);
insert into fornecimento values (4,6,3,300);
insert into fornecimento values (4,6,7,300);
insert into fornecimento values (5,2,2,200);
insert into fornecimento values (5,2,4,100);
insert into fornecimento values (5,5,5,500);
insert into fornecimento values (5,5,7,100);
insert into fornecimento values (5,6,2,200);
insert into fornecimento values (5,1,4,1000);
insert into fornecimento values (5,3,4,1200);
insert into fornecimento values (5,4,4,800);
insert into fornecimento values (5,5,4,400);
insert into fornecimento values (5,6,4,500);



	
