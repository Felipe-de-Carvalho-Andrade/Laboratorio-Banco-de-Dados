CREATE TABLE public.cliente (
    id_cliente integer NOT NULL,
    nm_cliente character(20) NOT NULL,
    nu_casa_cliente integer NOT NULL,
    nu_cep_cliente character(9) NOT NULL
);


ALTER TABLE public.cliente OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16695)
-- Name: costura; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.costura (
    id_costureiro integer NOT NULL,
    id_pedido integer NOT NULL,
    id_detalhe_pedido integer NOT NULL,
    dt_inicio_costura date NOT NULL,
    dt_fim_costura date
);


ALTER TABLE public.costura OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16690)
-- Name: costureiro; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.costureiro (
    id_costureiro integer NOT NULL,
    nm_costureiro character(20) NOT NULL,
    nu_casa_costureiro integer NOT NULL,
    nu_cep_costureiro character(8) NOT NULL
);


ALTER TABLE public.costureiro OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16670)
-- Name: detalhepedido; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detalhepedido (
    id_pedido integer NOT NULL,
    id_detalhe_pedido integer NOT NULL,
    id_traje integer NOT NULL,
    nu_tamanho integer NOT NULL,
    id_material integer
);


ALTER TABLE public.detalhepedido OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16645)
-- Name: material; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.material (
    id_material integer NOT NULL,
    nm_material character(20) NOT NULL,
    nm_cor_material character(20) NOT NULL,
    nm_padrao_material character(20) NOT NULL,
    vl_custo_material real NOT NULL
);


ALTER TABLE public.material OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16660)
-- Name: pedido; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pedido (
    id_pedido integer NOT NULL,
    id_cliente integer,
    dt_pedido date NOT NULL,
    in_finalizado character(1)
);


ALTER TABLE public.pedido OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16650)
-- Name: quantidade; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quantidade (
    id_traje integer NOT NULL,
    nu_tamanho integer NOT NULL,
    nu_quantidade real NOT NULL
);


ALTER TABLE public.quantidade OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16640)
-- Name: traje; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.traje (
    id_traje integer NOT NULL,
    te_descricao_traje character(20) NOT NULL,
    vl_custo_producao_traje real NOT NULL,
    nm_detalhe_traje character(60)
);


ALTER TABLE public.traje OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 41874)
-- Name: vw_cliente; Type: VIEW; Schema: public; Owner: postgres
--

--
-- TOC entry 3257 (class 2606 OID 16639)
-- Name: cliente cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (id_cliente);


--
-- TOC entry 3271 (class 2606 OID 16699)
-- Name: costura costura_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.costura
    ADD CONSTRAINT costura_pkey PRIMARY KEY (id_costureiro, id_pedido, id_detalhe_pedido);


--
-- TOC entry 3269 (class 2606 OID 16694)
-- Name: costureiro costureiro_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.costureiro
    ADD CONSTRAINT costureiro_pkey PRIMARY KEY (id_costureiro);


--
-- TOC entry 3267 (class 2606 OID 16674)
-- Name: detalhepedido detalhepedido_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalhepedido
    ADD CONSTRAINT detalhepedido_pkey PRIMARY KEY (id_pedido, id_detalhe_pedido);


--
-- TOC entry 3261 (class 2606 OID 16649)
-- Name: material material_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.material
    ADD CONSTRAINT material_pkey PRIMARY KEY (id_material);


--
-- TOC entry 3265 (class 2606 OID 16664)
-- Name: pedido pedido_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pedido_pkey PRIMARY KEY (id_pedido);


--
-- TOC entry 3263 (class 2606 OID 16654)
-- Name: quantidade quantidade_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quantidade
    ADD CONSTRAINT quantidade_pkey PRIMARY KEY (id_traje, nu_tamanho);


--
-- TOC entry 3259 (class 2606 OID 16644)
-- Name: traje traje_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.traje
    ADD CONSTRAINT traje_pkey PRIMARY KEY (id_traje);


--
-- TOC entry 3277 (class 2606 OID 16700)
-- Name: costura costura_id_costureiro_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.costura
    ADD CONSTRAINT costura_id_costureiro_fkey FOREIGN KEY (id_costureiro) REFERENCES public.costureiro(id_costureiro);


--
-- TOC entry 3278 (class 2606 OID 16705)
-- Name: costura costura_id_pedido_id_detalhe_pedido_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.costura
    ADD CONSTRAINT costura_id_pedido_id_detalhe_pedido_fkey FOREIGN KEY (id_pedido, id_detalhe_pedido) REFERENCES public.detalhepedido(id_pedido, id_detalhe_pedido);


--
-- TOC entry 3275 (class 2606 OID 16680)
-- Name: detalhepedido detalhepedido_id_material_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalhepedido
    ADD CONSTRAINT detalhepedido_id_material_fkey FOREIGN KEY (id_material) REFERENCES public.material(id_material);


--
-- TOC entry 3274 (class 2606 OID 16675)
-- Name: detalhepedido detalhepedido_id_pedido_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalhepedido
    ADD CONSTRAINT detalhepedido_id_pedido_fkey FOREIGN KEY (id_pedido) REFERENCES public.pedido(id_pedido);


--
-- TOC entry 3276 (class 2606 OID 16685)
-- Name: detalhepedido detalhepedido_id_traje_nu_tamanho_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalhepedido
    ADD CONSTRAINT detalhepedido_id_traje_nu_tamanho_fkey FOREIGN KEY (id_traje, nu_tamanho) REFERENCES public.quantidade(id_traje, nu_tamanho);


--
-- TOC entry 3273 (class 2606 OID 16665)
-- Name: pedido pedido_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pedido_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES public.cliente(id_cliente);


--
-- TOC entry 3272 (class 2606 OID 16655)
-- Name: quantidade quantidade_id_traje_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quantidade
    ADD CONSTRAINT quantidade_id_traje_fkey FOREIGN KEY (id_traje) REFERENCES public.traje(id_traje);





INSERT INTO public.cliente (id_cliente, nm_cliente, nu_casa_cliente, nu_cep_cliente) VALUES (1, 'Sr Jorge            ', 12, '30245839 ');
INSERT INTO public.cliente (id_cliente, nm_cliente, nu_casa_cliente, nu_cep_cliente) VALUES (2, 'Sr Bruno            ', 24, '40598382 ');
INSERT INTO public.cliente (id_cliente, nm_cliente, nu_casa_cliente, nu_cep_cliente) VALUES (3, 'Sr Getulio          ', 78, '90483746 ');
INSERT INTO public.cliente (id_cliente, nm_cliente, nu_casa_cliente, nu_cep_cliente) VALUES (4, 'Sr Joao             ', 25, '30240839 ');
INSERT INTO public.cliente (id_cliente, nm_cliente, nu_casa_cliente, nu_cep_cliente) VALUES (5, 'Sr Breno            ', 34, '29485736 ');
INSERT INTO public.cliente (id_cliente, nm_cliente, nu_casa_cliente, nu_cep_cliente) VALUES (6, 'Sra Milla           ', 31, '0394827  ');
INSERT INTO public.cliente (id_cliente, nm_cliente, nu_casa_cliente, nu_cep_cliente) VALUES (7, 'Dr Petrus           ', 3, '39485736 ');
INSERT INTO public.cliente (id_cliente, nm_cliente, nu_casa_cliente, nu_cep_cliente) VALUES (8, 'Srta Patricia       ', 100, '03948576 ');

--
-- TOC entry 3426 (class 0 OID 16690)
-- Dependencies: 216
-- Data for Name: costureiro; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.costureiro (id_costureiro, nm_costureiro, nu_casa_costureiro, nu_cep_costureiro) VALUES (1, 'Sra Renata          ', 2, '26365544');
INSERT INTO public.costureiro (id_costureiro, nm_costureiro, nu_casa_costureiro, nu_cep_costureiro) VALUES (2, 'Srta Sandra         ', 4, '30294857');
INSERT INTO public.costureiro (id_costureiro, nm_costureiro, nu_casa_costureiro, nu_cep_costureiro) VALUES (3, 'Sr Nelson           ', 56, '30293847');
INSERT INTO public.costureiro (id_costureiro, nm_costureiro, nu_casa_costureiro, nu_cep_costureiro) VALUES (4, 'Sra Zenilda         ', 27, '20394857');
INSERT INTO public.costureiro (id_costureiro, nm_costureiro, nu_casa_costureiro, nu_cep_costureiro) VALUES (5, 'Sr Saulo            ', 31, '30298173');
INSERT INTO public.costureiro (id_costureiro, nm_costureiro, nu_casa_costureiro, nu_cep_costureiro) VALUES (6, 'Sr Taylor           ', 3, '30309281');
INSERT INTO public.costureiro (id_costureiro, nm_costureiro, nu_casa_costureiro, nu_cep_costureiro) VALUES (7, 'Srta Paula          ', 7, '30293827');

INSERT INTO public.material (id_material, nm_material, nm_cor_material, nm_padrao_material, vl_custo_material) VALUES (1, 'Seda                ', 'Preto               ', 'Simples             ', 7);
INSERT INTO public.material (id_material, nm_material, nm_cor_material, nm_padrao_material, vl_custo_material) VALUES (2, 'Seda                ', 'Vermelho escuro     ', 'Tingido             ', 10);
INSERT INTO public.material (id_material, nm_material, nm_cor_material, nm_padrao_material, vl_custo_material) VALUES (3, 'Algodão             ', 'Listrado amarelo    ', 'Tecido              ', 3);
INSERT INTO public.material (id_material, nm_material, nm_cor_material, nm_padrao_material, vl_custo_material) VALUES (4, 'Algodão             ', 'Listrado verde      ', 'Tecido              ', 3);
INSERT INTO public.material (id_material, nm_material, nm_cor_material, nm_padrao_material, vl_custo_material) VALUES (5, 'Algodão             ', 'Pontilhado preto    ', 'Tecido              ', 3);
INSERT INTO public.material (id_material, nm_material, nm_cor_material, nm_padrao_material, vl_custo_material) VALUES (6, 'Algodão             ', 'Listrado vermelho   ', 'Tecido              ', 3);
INSERT INTO public.material (id_material, nm_material, nm_cor_material, nm_padrao_material, vl_custo_material) VALUES (7, 'Poliéster           ', 'Amarelo palha       ', 'Tingido             ', 2.55);
INSERT INTO public.material (id_material, nm_material, nm_cor_material, nm_padrao_material, vl_custo_material) VALUES (8, 'Algodão             ', 'Listrado azul       ', 'Tecido              ', 3);
INSERT INTO public.material (id_material, nm_material, nm_cor_material, nm_padrao_material, vl_custo_material) VALUES (9, 'Algodão             ', 'Cor-de-rosa         ', 'Tecido              ', 3);
INSERT INTO public.material (id_material, nm_material, nm_cor_material, nm_padrao_material, vl_custo_material) VALUES (10, 'Seda                ', 'Verde escuro        ', 'Tingido             ', 15);
INSERT INTO public.material (id_material, nm_material, nm_cor_material, nm_padrao_material, vl_custo_material) VALUES (11, 'Seda real           ', 'Vermelho/laranja    ', 'Tingido             ', 4);
INSERT INTO public.material (id_material, nm_material, nm_cor_material, nm_padrao_material, vl_custo_material) VALUES (12, 'Sarja               ', 'Azul marinho        ', 'Tecido              ', 5.5);
INSERT INTO public.material (id_material, nm_material, nm_cor_material, nm_padrao_material, vl_custo_material) VALUES (13, 'Algodão             ', 'Azul escuro         ', 'Tingido             ', 3.5);
INSERT INTO public.material (id_material, nm_material, nm_cor_material, nm_padrao_material, vl_custo_material) VALUES (14, 'Algodão             ', 'Verde escuro        ', 'Tingido             ', 3.5);

INSERT INTO public.pedido (id_pedido, id_cliente, dt_pedido, in_finalizado) VALUES (1, 8, '2002-01-10', 'S');
INSERT INTO public.pedido (id_pedido, id_cliente, dt_pedido, in_finalizado) VALUES (2, 7, '2002-01-11', 'S');
INSERT INTO public.pedido (id_pedido, id_cliente, dt_pedido, in_finalizado) VALUES (3, 6, '2002-01-20', 'S');
INSERT INTO public.pedido (id_pedido, id_cliente, dt_pedido, in_finalizado) VALUES (4, 5, '2002-02-02', 'S');
INSERT INTO public.pedido (id_pedido, id_cliente, dt_pedido, in_finalizado) VALUES (5, 4, '2002-02-03', 'S');
INSERT INTO public.pedido (id_pedido, id_cliente, dt_pedido, in_finalizado) VALUES (6, 3, '2002-02-20', 'N');
INSERT INTO public.pedido (id_pedido, id_cliente, dt_pedido, in_finalizado) VALUES (7, 2, '2002-02-21', 'S');
INSERT INTO public.pedido (id_pedido, id_cliente, dt_pedido, in_finalizado) VALUES (8, 1, '2002-02-27', 'N');
INSERT INTO public.pedido (id_pedido, id_cliente, dt_pedido, in_finalizado) VALUES (9, 2, '2002-02-27', 'N');
INSERT INTO public.pedido (id_pedido, id_cliente, dt_pedido, in_finalizado) VALUES (10, 3, '2002-02-28', 'N');
INSERT INTO public.pedido (id_pedido, id_cliente, dt_pedido, in_finalizado) VALUES (11, 4, '2002-03-01', 'N');
INSERT INTO public.pedido (id_pedido, id_cliente, dt_pedido, in_finalizado) VALUES (12, 5, '2002-03-03', 'N');






--
-- TOC entry 3427 (class 0 OID 16695)
-- Dependencies: 217
-- Data for Name: costura; Type: TABLE DATA; Schema: public; Owner: postgres
--




--
-- TOC entry 3425 (class 0 OID 16670)
-- Dependencies: 215
-- Data for Name: detalhepedido; Type: TABLE DATA; Schema: public; Owner: postgres
--

--
-- TOC entry 3422 (class 0 OID 16645)
-- Dependencies: 212
-- Data for Name: material; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3424 (class 0 OID 16660)
-- Dependencies: 214
-- Data for Name: pedido; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- TOC entry 3423 (class 0 OID 16650)
-- Dependencies: 213
-- Data for Name: quantidade; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- TOC entry 3421 (class 0 OID 16640)
-- Dependencies: 211
-- Data for Name: traje; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.traje (id_traje, te_descricao_traje, vl_custo_producao_traje, nm_detalhe_traje) VALUES (1, 'Calças              ', 18, '2 Zipper/sem 1.5cm botões/bainha cinta/cintura atadura      ');
INSERT INTO public.traje (id_traje, te_descricao_traje, vl_custo_producao_traje, nm_detalhe_traje) VALUES (2, 'Saia longa          ', 15, '1 Zipper/sem botão 3cm/atadura                              ');
INSERT INTO public.traje (id_traje, te_descricao_traje, vl_custo_producao_traje, nm_detalhe_traje) VALUES (3, 'Shorts              ', 10, 'Zipper/Fecho Clip                                           ');
INSERT INTO public.traje (id_traje, te_descricao_traje, vl_custo_producao_traje, nm_detalhe_traje) VALUES (4, 'Mini saia           ', 14.25, '1 Zipper/sem 2cm botão                                      ');
INSERT INTO public.traje (id_traje, te_descricao_traje, vl_custo_producao_traje, nm_detalhe_traje) VALUES (5, 'Vestido de verão    ', 20, NULL);
INSERT INTO public.traje (id_traje, te_descricao_traje, vl_custo_producao_traje, nm_detalhe_traje) VALUES (6, 'Suntop              ', 6.5, NULL);

INSERT INTO public.quantidade (id_traje, nu_tamanho, nu_quantidade) VALUES (1, 8, 2.7);
INSERT INTO public.quantidade (id_traje, nu_tamanho, nu_quantidade) VALUES (1, 10, 2.7);
INSERT INTO public.quantidade (id_traje, nu_tamanho, nu_quantidade) VALUES (1, 12, 2.8);
INSERT INTO public.quantidade (id_traje, nu_tamanho, nu_quantidade) VALUES (1, 14, 2.8);
INSERT INTO public.quantidade (id_traje, nu_tamanho, nu_quantidade) VALUES (1, 16, 3);
INSERT INTO public.quantidade (id_traje, nu_tamanho, nu_quantidade) VALUES (1, 18, 3);
INSERT INTO public.quantidade (id_traje, nu_tamanho, nu_quantidade) VALUES (2, 8, 3.4);
INSERT INTO public.quantidade (id_traje, nu_tamanho, nu_quantidade) VALUES (2, 10, 3.4);
INSERT INTO public.quantidade (id_traje, nu_tamanho, nu_quantidade) VALUES (2, 12, 3.8);
INSERT INTO public.quantidade (id_traje, nu_tamanho, nu_quantidade) VALUES (2, 14, 3.8);
INSERT INTO public.quantidade (id_traje, nu_tamanho, nu_quantidade) VALUES (2, 16, 4.2);
INSERT INTO public.quantidade (id_traje, nu_tamanho, nu_quantidade) VALUES (2, 18, 4.5);
INSERT INTO public.quantidade (id_traje, nu_tamanho, nu_quantidade) VALUES (3, 8, 1.3);
INSERT INTO public.quantidade (id_traje, nu_tamanho, nu_quantidade) VALUES (3, 10, 1.3);
INSERT INTO public.quantidade (id_traje, nu_tamanho, nu_quantidade) VALUES (3, 12, 1.3);
INSERT INTO public.quantidade (id_traje, nu_tamanho, nu_quantidade) VALUES (3, 14, 1.5);
INSERT INTO public.quantidade (id_traje, nu_tamanho, nu_quantidade) VALUES (3, 16, 1.6);
INSERT INTO public.quantidade (id_traje, nu_tamanho, nu_quantidade) VALUES (3, 18, 1.8);
INSERT INTO public.quantidade (id_traje, nu_tamanho, nu_quantidade) VALUES (4, 8, 1.2);
INSERT INTO public.quantidade (id_traje, nu_tamanho, nu_quantidade) VALUES (4, 10, 1.2);
INSERT INTO public.quantidade (id_traje, nu_tamanho, nu_quantidade) VALUES (4, 12, 1.2);
INSERT INTO public.quantidade (id_traje, nu_tamanho, nu_quantidade) VALUES (4, 14, 1.4);
INSERT INTO public.quantidade (id_traje, nu_tamanho, nu_quantidade) VALUES (4, 16, 1.5);
INSERT INTO public.quantidade (id_traje, nu_tamanho, nu_quantidade) VALUES (4, 18, 1.9);
INSERT INTO public.quantidade (id_traje, nu_tamanho, nu_quantidade) VALUES (5, 8, 3.2);
INSERT INTO public.quantidade (id_traje, nu_tamanho, nu_quantidade) VALUES (5, 10, 3.2);
INSERT INTO public.quantidade (id_traje, nu_tamanho, nu_quantidade) VALUES (5, 12, 3.2);
INSERT INTO public.quantidade (id_traje, nu_tamanho, nu_quantidade) VALUES (5, 14, 3.4);
INSERT INTO public.quantidade (id_traje, nu_tamanho, nu_quantidade) VALUES (5, 16, 5.2);
INSERT INTO public.quantidade (id_traje, nu_tamanho, nu_quantidade) VALUES (5, 18, 5.2);
INSERT INTO public.quantidade (id_traje, nu_tamanho, nu_quantidade) VALUES (6, 8, 1);
INSERT INTO public.quantidade (id_traje, nu_tamanho, nu_quantidade) VALUES (6, 10, 1);
INSERT INTO public.quantidade (id_traje, nu_tamanho, nu_quantidade) VALUES (6, 12, 1);
INSERT INTO public.quantidade (id_traje, nu_tamanho, nu_quantidade) VALUES (6, 14, 1.5);
INSERT INTO public.quantidade (id_traje, nu_tamanho, nu_quantidade) VALUES (6, 16, 1.5);
INSERT INTO public.quantidade (id_traje, nu_tamanho, nu_quantidade) VALUES (6, 18, 1.8);



INSERT INTO public.detalhepedido (id_pedido, id_detalhe_pedido, id_traje, nu_tamanho, id_material) VALUES (1, 1, 1, 8, 1);
INSERT INTO public.detalhepedido (id_pedido, id_detalhe_pedido, id_traje, nu_tamanho, id_material) VALUES (1, 2, 2, 8, 2);
INSERT INTO public.detalhepedido (id_pedido, id_detalhe_pedido, id_traje, nu_tamanho, id_material) VALUES (2, 1, 3, 10, 3);
INSERT INTO public.detalhepedido (id_pedido, id_detalhe_pedido, id_traje, nu_tamanho, id_material) VALUES (2, 2, 4, 10, 4);
INSERT INTO public.detalhepedido (id_pedido, id_detalhe_pedido, id_traje, nu_tamanho, id_material) VALUES (2, 3, 5, 10, 5);
INSERT INTO public.detalhepedido (id_pedido, id_detalhe_pedido, id_traje, nu_tamanho, id_material) VALUES (3, 1, 6, 12, 6);
INSERT INTO public.detalhepedido (id_pedido, id_detalhe_pedido, id_traje, nu_tamanho, id_material) VALUES (4, 1, 1, 14, 7);
INSERT INTO public.detalhepedido (id_pedido, id_detalhe_pedido, id_traje, nu_tamanho, id_material) VALUES (4, 2, 2, 14, 10);
INSERT INTO public.detalhepedido (id_pedido, id_detalhe_pedido, id_traje, nu_tamanho, id_material) VALUES (5, 1, 3, 16, 9);
INSERT INTO public.detalhepedido (id_pedido, id_detalhe_pedido, id_traje, nu_tamanho, id_material) VALUES (5, 2, 4, 16, 10);
INSERT INTO public.detalhepedido (id_pedido, id_detalhe_pedido, id_traje, nu_tamanho, id_material) VALUES (5, 3, 5, 16, 11);
INSERT INTO public.detalhepedido (id_pedido, id_detalhe_pedido, id_traje, nu_tamanho, id_material) VALUES (6, 1, 1, 8, 12);
INSERT INTO public.detalhepedido (id_pedido, id_detalhe_pedido, id_traje, nu_tamanho, id_material) VALUES (6, 2, 2, 8, 13);
INSERT INTO public.detalhepedido (id_pedido, id_detalhe_pedido, id_traje, nu_tamanho, id_material) VALUES (6, 3, 3, 8, 14);
INSERT INTO public.detalhepedido (id_pedido, id_detalhe_pedido, id_traje, nu_tamanho, id_material) VALUES (7, 1, 4, 10, 1);
INSERT INTO public.detalhepedido (id_pedido, id_detalhe_pedido, id_traje, nu_tamanho, id_material) VALUES (7, 2, 5, 10, 2);
INSERT INTO public.detalhepedido (id_pedido, id_detalhe_pedido, id_traje, nu_tamanho, id_material) VALUES (7, 3, 6, 10, 3);
INSERT INTO public.detalhepedido (id_pedido, id_detalhe_pedido, id_traje, nu_tamanho, id_material) VALUES (8, 1, 6, 12, 4);
INSERT INTO public.detalhepedido (id_pedido, id_detalhe_pedido, id_traje, nu_tamanho, id_material) VALUES (8, 2, 5, 12, 5);
INSERT INTO public.detalhepedido (id_pedido, id_detalhe_pedido, id_traje, nu_tamanho, id_material) VALUES (8, 3, 4, 12, 6);
INSERT INTO public.detalhepedido (id_pedido, id_detalhe_pedido, id_traje, nu_tamanho, id_material) VALUES (9, 1, 3, 14, 7);
INSERT INTO public.detalhepedido (id_pedido, id_detalhe_pedido, id_traje, nu_tamanho, id_material) VALUES (10, 1, 2, 16, 8);
INSERT INTO public.detalhepedido (id_pedido, id_detalhe_pedido, id_traje, nu_tamanho, id_material) VALUES (10, 2, 1, 16, 9);
INSERT INTO public.detalhepedido (id_pedido, id_detalhe_pedido, id_traje, nu_tamanho, id_material) VALUES (11, 1, 1, 18, 10);
INSERT INTO public.detalhepedido (id_pedido, id_detalhe_pedido, id_traje, nu_tamanho, id_material) VALUES (11, 2, 2, 18, 11);
INSERT INTO public.detalhepedido (id_pedido, id_detalhe_pedido, id_traje, nu_tamanho, id_material) VALUES (11, 3, 3, 18, 12);
INSERT INTO public.detalhepedido (id_pedido, id_detalhe_pedido, id_traje, nu_tamanho, id_material) VALUES (12, 1, 4, 8, 13);
INSERT INTO public.detalhepedido (id_pedido, id_detalhe_pedido, id_traje, nu_tamanho, id_material) VALUES (12, 2, 5, 8, 14);
INSERT INTO public.detalhepedido (id_pedido, id_detalhe_pedido, id_traje, nu_tamanho, id_material) VALUES (12, 3, 6, 8, 1);
INSERT INTO public.detalhepedido (id_pedido, id_detalhe_pedido, id_traje, nu_tamanho, id_material) VALUES (12, 4, 1, 8, 2);
INSERT INTO public.detalhepedido (id_pedido, id_detalhe_pedido, id_traje, nu_tamanho, id_material) VALUES (12, 5, 2, 8, 3);

INSERT INTO public.costura (id_costureiro, id_pedido, id_detalhe_pedido, dt_inicio_costura, dt_fim_costura) VALUES (1, 1, 1, '2002-01-10', '2002-03-05');
INSERT INTO public.costura (id_costureiro, id_pedido, id_detalhe_pedido, dt_inicio_costura, dt_fim_costura) VALUES (2, 1, 2, '2002-01-10', '2002-03-15');
INSERT INTO public.costura (id_costureiro, id_pedido, id_detalhe_pedido, dt_inicio_costura, dt_fim_costura) VALUES (3, 2, 1, '2002-01-11', '2002-03-05');
INSERT INTO public.costura (id_costureiro, id_pedido, id_detalhe_pedido, dt_inicio_costura, dt_fim_costura) VALUES (4, 2, 2, '2002-01-11', '2002-03-25');
INSERT INTO public.costura (id_costureiro, id_pedido, id_detalhe_pedido, dt_inicio_costura, dt_fim_costura) VALUES (5, 2, 3, '2002-01-11', '2002-03-05');
INSERT INTO public.costura (id_costureiro, id_pedido, id_detalhe_pedido, dt_inicio_costura, dt_fim_costura) VALUES (6, 3, 1, '2002-01-20', '2002-03-25');
INSERT INTO public.costura (id_costureiro, id_pedido, id_detalhe_pedido, dt_inicio_costura, dt_fim_costura) VALUES (7, 4, 1, '2002-02-02', '2002-03-05');
INSERT INTO public.costura (id_costureiro, id_pedido, id_detalhe_pedido, dt_inicio_costura, dt_fim_costura) VALUES (1, 4, 2, '2002-02-02', '2002-03-25');
INSERT INTO public.costura (id_costureiro, id_pedido, id_detalhe_pedido, dt_inicio_costura, dt_fim_costura) VALUES (2, 5, 1, '2002-02-03', '2002-03-15');
INSERT INTO public.costura (id_costureiro, id_pedido, id_detalhe_pedido, dt_inicio_costura, dt_fim_costura) VALUES (3, 5, 2, '2002-02-03', '2002-03-25');
INSERT INTO public.costura (id_costureiro, id_pedido, id_detalhe_pedido, dt_inicio_costura, dt_fim_costura) VALUES (4, 5, 3, '2002-02-03', '2002-03-27');
INSERT INTO public.costura (id_costureiro, id_pedido, id_detalhe_pedido, dt_inicio_costura, dt_fim_costura) VALUES (5, 6, 1, '2002-02-20', NULL);
INSERT INTO public.costura (id_costureiro, id_pedido, id_detalhe_pedido, dt_inicio_costura, dt_fim_costura) VALUES (6, 6, 2, '2002-02-20', '2002-03-28');
INSERT INTO public.costura (id_costureiro, id_pedido, id_detalhe_pedido, dt_inicio_costura, dt_fim_costura) VALUES (7, 6, 3, '2002-02-20', NULL);
INSERT INTO public.costura (id_costureiro, id_pedido, id_detalhe_pedido, dt_inicio_costura, dt_fim_costura) VALUES (1, 7, 1, '2002-02-21', NULL);
INSERT INTO public.costura (id_costureiro, id_pedido, id_detalhe_pedido, dt_inicio_costura, dt_fim_costura) VALUES (2, 7, 2, '2002-02-21', NULL);
INSERT INTO public.costura (id_costureiro, id_pedido, id_detalhe_pedido, dt_inicio_costura, dt_fim_costura) VALUES (3, 7, 3, '2002-02-21', '2002-03-28');
INSERT INTO public.costura (id_costureiro, id_pedido, id_detalhe_pedido, dt_inicio_costura, dt_fim_costura) VALUES (4, 8, 1, '2002-02-27', '2002-03-03');
INSERT INTO public.costura (id_costureiro, id_pedido, id_detalhe_pedido, dt_inicio_costura, dt_fim_costura) VALUES (5, 8, 2, '2002-02-27', NULL);
INSERT INTO public.costura (id_costureiro, id_pedido, id_detalhe_pedido, dt_inicio_costura, dt_fim_costura) VALUES (6, 8, 3, '2002-02-27', NULL);
INSERT INTO public.costura (id_costureiro, id_pedido, id_detalhe_pedido, dt_inicio_costura, dt_fim_costura) VALUES (7, 9, 1, '2002-02-27', NULL);
INSERT INTO public.costura (id_costureiro, id_pedido, id_detalhe_pedido, dt_inicio_costura, dt_fim_costura) VALUES (1, 10, 1, '2002-02-28', NULL);
INSERT INTO public.costura (id_costureiro, id_pedido, id_detalhe_pedido, dt_inicio_costura, dt_fim_costura) VALUES (2, 10, 2, '2002-03-28', NULL);
INSERT INTO public.costura (id_costureiro, id_pedido, id_detalhe_pedido, dt_inicio_costura, dt_fim_costura) VALUES (3, 11, 1, '2002-03-01', '2002-03-04');
INSERT INTO public.costura (id_costureiro, id_pedido, id_detalhe_pedido, dt_inicio_costura, dt_fim_costura) VALUES (4, 11, 2, '2002-03-01', NULL);
INSERT INTO public.costura (id_costureiro, id_pedido, id_detalhe_pedido, dt_inicio_costura, dt_fim_costura) VALUES (5, 11, 3, '2002-03-01', NULL);
INSERT INTO public.costura (id_costureiro, id_pedido, id_detalhe_pedido, dt_inicio_costura, dt_fim_costura) VALUES (7, 12, 2, '2002-03-03', NULL);
INSERT INTO public.costura (id_costureiro, id_pedido, id_detalhe_pedido, dt_inicio_costura, dt_fim_costura) VALUES (1, 12, 3, '2002-03-03', NULL);
INSERT INTO public.costura (id_costureiro, id_pedido, id_detalhe_pedido, dt_inicio_costura, dt_fim_costura) VALUES (2, 12, 4, '2002-03-03', NULL);
INSERT INTO public.costura (id_costureiro, id_pedido, id_detalhe_pedido, dt_inicio_costura, dt_fim_costura) VALUES (2, 12, 5, '2002-03-03', NULL);


-- Completed on 2024-07-31 08:40:03 -03

--
-- PostgreSQL database dump complete
--

