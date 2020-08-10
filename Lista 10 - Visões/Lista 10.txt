/* CRIAÇÃO DE TABELAS NO BD */

create table funcao (
	codigo int primary key,
	descricao varchar(50) not null,
	salario float not null
)

create table funcionario (
	codigo int primary key,
	nome varchar(50) not null,
	dataadmissao date not null,
	cod_funcao int not null,
		foreign key (cod_funcao) references funcao(codigo)
)

create table peca (
	codigo varchar(5) primary key,
	nome varchar(50) not null,
	descricao varchar(50) not null,
	qtdeestoque int not null 
)

create table composicao (
	idpecacomposta varchar(5),
	idpecaparte varchar(5),
	quantidade int,
		primary key (idpecacomposta, idpecaparte, quantidade),
			foreign key (idpecacomposta) references peca(codigo),
			foreign key (idpecaparte) references peca(codigo) 
)

/* EXERCICIO 1 - CRIAÇÃO DE VIEWS */

create view funcaoView as (
select codigo, descricao
from funcao
)

create view funcionarioView as (
select codigo, nome
from funcionario
)

create view pecaView as (
select *
from peca 
)

create view composicaoView as (
select *
from composicao
)

/* EXERCICIO 2 - INSERÇÃO DE REGISTROS NAS TABELAS */

insert into funcao values
(10, 'funcao1', 1000),
(20, 'funcao2', 2000),
(30, 'funcao3', 3000),
(40, 'funcao4', 4000),
(50, 'funcao5', 5000)

insert into funcionario values
(1, 'funcionario1', '2001-04-04', 10),
(2, 'funcionario2', '2002-04-04', 20),
(3, 'funcionario3', '2003-04-04', 30),
(4, 'funcionario4', '2004-04-04', 40),
(5, 'funcionario5', '2005-04-04', 50)

insert into peca values 
('P1', 'peca1', 'descricao1', 101),
('P2', 'peca2', 'descricao2', 201),
('P3', 'peca3', 'descricao3', 301)

insert into composicao values
('P1', 'P2', 50),
('P2', 'P1', 40),
('P1', 'P1', 30),
('P2', 'P3', 50),
('P1', 'P3', 100)


/* EXERCICIO 3 - RELATORIO NA VIEW MATERIALIZADA */

create materialized view relatorio (composicao, peca) as(
	select c.idpecacomposta, p.nome as pecacompposta, p.nome as pecaparte, c.quantidade
	from composicao c, peca p
	where c.idpecacomposta = p.codigo or c.idpecaparte = p.codigo
)


/* EXERCICIO 4 */

create table departamento (
	codigo int primary key,
	descricao varchar(30) not null,
	numero_funcionarios int default 0
)

create table empregado (
	codigo int primary key,
	nome varchar(100) not null,
	funcao varchar(50) not null,
	salario double precision not null,
	depto int not null,
		foreign key (depto) references departamento(codigo) on delete cascade
)

insert into departamento values 
(1, 'dept1'),
(2, 'dept2'),
(3, 'dept3'),
(4, 'dept4'),
(5, 'dept5'),
(6, 'dept6'),
(7, 'dept7'),
(8, 'dept8'),
(9, 'dept9'),
(10, 'dept10')

insert into empregado values
(1, 'empregado1', 'operador', 2000, 1),
(2, 'empregado2', 'operador', 2000, 1),
(3, 'empregado3', 'supervisor', 7000, 2),
(4, 'empregado4', 'especialista', 6500, 2),
(5, 'empregado5', 'operador', 2000, 2),
(6, 'empregado6', 'analista', 3500, 3),
(7, 'empregado7', 'analista', 3500, 4),
(8, 'empregado8', 'engenheiro', 5000, 4),
(9, 'empregado9', 'operador', 2000, 6),
(10, 'empregado10', 'engenheiro', 4500, 7)

A.
create view funcaoA (departamento, empregado) as (
	select d.descricao, e.nome, e.salario, e.funcao
	from departamento d join empregado e on d.codigo = e.depto
)

B.
create materialized view funcaoB (departamento, empregado) as (
	select d.descricao, count(e.codigo), max(e.salario), min(e.salario), avg(e.salario)
	from departamento d join empregado e on d.codigo = e.depto
	group by(d.descricao)
)

C. A visões não são atualizáveis no postgres. Não! kkkk


/* EXERCICIO 5 */

caso A:
create materialized view consulta1 (veiculo, servico, funcionario, veiculoservico) as (
	select v.placa, s.titulo, vs.duracao, f.nome
	from veiculo v, veiculoservico vs, servico s, funcionario f
	where vs.codveiculo = v.codigo and vs.codservico = s.codigo and vs.codfuncionario = f.codigo
)

caso B:
create view veiculoView as (
	select * from veiculo
)

create materialized view servicoView as (
	select * from servico
)

create view funcionarioView as (
	select * from funcionario
)

create view veiculoservicoView as (
	select * from veiculoservico
)

C. A visão da questão A não pois o proprio enunciado diz que não, dae cria a materialized view.
A questão B todas são editáveis menos a serviço

