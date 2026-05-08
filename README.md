# Laboratório de Banco de Dados - CEFET-MG

Este repositório contém as soluções das atividades práticas realizadas na disciplina de **Banco de Dados**, integrante do curso de **Redes de Computadores** no Centro Federal de Educação Tecnológica de Minas Gerais (**CEFET-MG**).

O objetivo deste material é documentar o aprendizado em modelagem (conceitual, lógica e física), manipulação de dados (DML), definição de estrutura (DDL) e programação procedural em banco de dados utilizando o SGBD PostgreSQL.

---

## 🛠️ Tecnologias e Ferramentas

| Categoria | Ferramentas Utilizadas |
| :--- | :--- |
| **SGBD** | [PostgreSQL](https://www.postgresql.org/) |
| **Linguagens** | SQL (DML, DDL, DCL) e [PL/pgSQL](https://www.postgresql.org/docs/current/plpgsql.html) |
| **Modelagem** | [pgModeler](https://pgmodeler.io/) e [Draw.io](https://app.diagrams.net/) |
| **Gerenciamento** | [pgAdmin 4](https://www.pgadmin.org/) |

---

## 📂 Estrutura do Repositório

Abaixo está a organização das pastas. Cada diretório contém os scripts `.sql` de criação/consulta e os diagramas gerados.

```text
.
├── 📂 Aula02/          # Modelagem Conceitual (DER) - Concurso Público
├── 📂 Aula03/          # Projeto Lógico - Controle de Navios
├── 📂 Aula05/          # Implementação DDL - Rede Social Conecte-se
├── 📂 Aula06/          # Consultas DML - Gestão de Estoque
├── 📂 Aula07/          # Junções Complexas (Joins) - Sistema Treinamento
├── 📂 Aula08/          # Views e Joins - Atelier de Costura
├── 📂 Aula09/          # Programação Procedural - Banco EMI
├── 📂 Aula10/          # Lógica de Funções - Livraria
├── 📂 Aula11/          # DCL (Segurança) e Visões de Acesso
├── 📂 Aula12/          # Gatilhos (Triggers) - Automação de Estoque
├── 📂 Aula13/          # Auditoria e Integridade - E-commerce
├── 📂 Aula14/          # Regras de Negócio - Sistema de Congressos
├── 📂 Aula15/          # Transações e dblink (Multi-bancos)
├── 📂 Aula16/          # Projeto Final - JOBS
├── 📄 Enunciados/      # Documentação original (PDFs)
└── 📄 README.md        # Documentação principal do repositório
```

---

## 📘 Projetos e Atividades Desenvolvidas

### 🔹 Aula 02 – Modelagem Conceitual: Concurso Público
- Construção de Diagrama Entidade-Relacionamento (DER).
- Definição de atributos-chave e restrições estruturais.
- Aplicação de cardinalidade e especialização/generalização.

---

### 🔹 Aula 03 – Projeto Lógico: Controle de Navios
- Engenharia reversa: Mapeamento de esquema relacional para DER.
- Transformação de modelo conceitual para lógico (Modelo Relacional).
- Implementação física no PostgreSQL com restrições de integridade.

---

### 🔹 Aula 05 – Rede Social "Conecte-se"
- Modelagem de auto-relacionamento (sistema de seguidores).
- Implementação de scripts DDL para criação de tabelas e relacionamentos.
- Testes iniciais de inserção e consistência de dados.

---

### 🔹 Aula 06 – Banco de Dados de Estoque
- Consultas DML básicas e filtros avançados (`WHERE`).
- Operações de ordenação e eliminação de duplicatas (`DISTINCT`).
- Relatórios de fornecedores, peças e projetos.

---

### 🔹 Aula 07 – Sistema de Treinamento: Junções
- Prática intensiva com Álgebra Relacional: `INNER`, `LEFT`, `RIGHT` e `FULL JOIN`.
- Agregações complexas e filtragem de grupos (`GROUP BY` / `HAVING`).
- Seleção de dados em ordem crescente e decrescente.

---

### 🔹 Aula 08 – Gestão de Atelier de Costura
- Modelagem completa de processos de pedidos, trajes e materiais.
- Uso de `NATURAL JOIN` e consultas para pedidos pendentes.
- Criação de **Views** para simplificar o cálculo de consumo de tecidos.

---

### 🔹 Aula 09 – Programação SQL: Banco EMI
- Introdução à linguagem **PL/pgSQL**.
- Desenvolvimento de *Stored Procedures* e funções procedurais.
- Formatação de mensagens dinâmicas para eventos musicais.

---

### 🔹 Aula 10 – Livraria: Funções Avançadas
- Lógica de programação para somatória de encomendas por mês.
- Manipulação de strings e agrupamento dinâmico por palavra-chave.
- Cálculo de tempo entre datas para identificação de atrasos.

---

### 🔹 Aula 11 – Segurança e Autorização
- Gestão de acessos: Criação de Usuários e Grupos (`ROLES`).
- Controle de privilégios com comandos `GRANT` e `REVOKE`.
- Utilização de **Views** para mascaramento e segurança de dados sensíveis.

---

### 🔹 Aula 12 – Automação com Triggers
- Implementação de gatilhos para controle automático de estoque de livros.
- Sincronização entre tabelas de pedidos e tabelas de saldo físico.
- Automação de inserções em tabelas dependentes.

---

### 🔹 Aula 13 – E-commerce: Integridade e Scripts
- Execução de scripts complexos via terminal Shell (`.sh`).
- Auditoria de integridade comparando vendas registradas vs. estoque vendido.
- Análise de comportamento de compra de categorias específicas.

---

### 🔹 Aula 14 – Sistema de Congressos
- Alteração dinâmica de estrutura para suporte a revisores e autores.
- Funções para distribuição equilibrada de carga de trabalho entre revisores.
- Simulação de disparo de e-mails via Triggers pós-revisão.

---

### 🔹 Aula 15 – Transações e Dblink
- Controle transacional robusto: `COMMIT`, `ROLLBACK` e `SAVEPOINT`.
- Uso de **Sequences** para gerenciamento centralizado de IDs.
- Integração e consulta entre bases de dados distintas via `dblink`.

---

### 🔹 Aula 16 – Projeto JOBS: Regras de Negócio
- Implementação de histórico automático de movimentação de funcionários.
- Regras de validação para cursos baseadas em cargo e custo.
- Simulação de comunicação entre funcionários e supervisores.

---

## 👨‍💻 Felipe de Carvalho Andrade

Desenvolvido como parte das atividades da disciplina de Banco de Dados.
Curso de Redes de Computadores — **CEFET-MG**

---
> Repositório com fins exclusivamente acadêmicos.