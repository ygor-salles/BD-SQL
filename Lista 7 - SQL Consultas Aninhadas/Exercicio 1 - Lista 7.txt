Exercicio 1 – Lista 7

MAPEAMENTO – MODELO RELACIONAL

cliente(codigo, nome, dataNasc, telefone, rua, bairro, num)
funcionario(codigo, nome, cargo)
copia(numero, status, tem)
		tem referencia filme(codigo)
	aluga(codCliente, codFuncionario, numCopia, dataPDev, dataInicio)
		codCliente referencia cliente(codigo)
		codFuncionario referencia funcionario(codigo)
		numCopia referencia copia(numero)
fornecedor(cnpj, razaoSocial, endereco)
	compra(cnpj, codFuncionario, numCopia)
		cnpj referencia fornecedor(cnpj)
		codCliente referencia cliente(codigo)
		codFuncionario referencia funcionario(codigo)
filme(codigo, diretor, nome, duracao)
	ator(codigo, ator)
		codigo referencia filme(codigo)
	estilo(codigo, estilo)
		codigo referencia filme(codigo)



IMPLEMENTAÇÃO DAS TABELAS NO BANCO DE DADOS

create table cliente (
	codigo int primary key,
	nome varchar(50),
	dataNasc date,
	telefone varchar(12),
	rua varchar(50),
	bairro varchar(50),
	num int
)

create table funcionario (
	codigo int primary key,
	nome varchar(50),
	cargo varchar(30)
)

create table filme (
	codigo int primary key,
	diretor varchar(50),
	nome varchar(30),
	duracao float
)	

create table copia (
	numero int primary key,
	status varchar(15),
		check (status='Alugado' or status='Disponível'),
	tem int,
		foreign key (tem) references filme(codigo)
)

create table aluga (
	codCliente int,
	codFuncionario int,
	numCopia int,
	dataPDev date,
	dataInicio date unique,
	dataDev date,
		check(dataPDev < dataDev),
		primary key(codCliente, codFuncionario, numCopia),
			foreign key (codCliente) references cliente(codigo),
			foreign key (codFuncionario) references funcionario(codigo),
			foreign key (numCopia) references copia(numero)
)

create table fornecedor (
	cnpj varchar(20) primary key,
	razaoSocial varchar(30),
	endereco varchar(50)
)

create table compra (
	cnpj varchar(20),
	codFuncionario int,
	numCopia int,
		primary key (cnpj, codFuncionario, numCopia),
			foreign key (cnpj) references fornecedor(cnpj),
			foreign key (codFuncionario) references funcionario(codigo),
			foreign key (numCopia) references copia(numero)
)

create table ator (
	codigo int,
	ator varchar(50),
		primary key(codigo, ator),
			foreign key (codigo) references filme(codigo)
)

create table estilo (
	codigo int,
	estilo varchar(50),
		primary key(codigo, estilo),
			foreign key (codigo) references filme(codigo)
)

INSERÇÃO DE ELEMENTOS

insert into cliente values
(1, 'Cliente1', '10-07-1994', '98475-9636', 'Rua1', 'Bairro1', 111),
(2, 'Cliente2', '11-07-1994', '98475-4000', 'Rua2', 'Bairro2', 122),
(3, 'Cliente3', '10-06-1990', '98475-9000', 'Rua3', 'Bairro2', 133)

insert into funcionario values 
(10, 'Funcionario1', 'Auxiliar Tecnico'),
(20, 'José da Silva Xavier', 'Vendedor'),
(30, 'Funcionario3', 'Atendente')

insert into filme values
(11, 'Diretor1', 'Filme1', 2.5),
(12, 'Diretor1', 'Julie & Julia', 2.5),
(13, 'Woody Allen', 'Filme3', 3),
(14, 'Stanley Tucci Jr', 'Julie & Julia', 2.5)

insert into copia values 
(21, 'Disponível', 12),
(22, 'Disponível', 13)

insert into aluga values
(1, 20, 21, '18-09-2010', '18-01-2010', '18-10-2010'),
(2, 10, 22, '17-09-2010', '17-01-2010', '17-10-2010')

insert into fornecedor values
('145-526.87', 'RazaoSocial1', 'Edereço1'),
('145-526.00', 'RazaoSocial2', 'Edereço2'),
('145-526.12', 'RazaoSocial2', 'Edereço3')

insert into compra values
('145-526.87', 10, 21),
('145-526.12', 20, 22)

insert into ator values
(11, 'Ator1'),
(12, 'Ator1'),
(13, 'Philip Seymour Hoffman')

insert into estilo values
(11, 'Aventura'),
(12, 'Estilo1'),
(13, 'Estilo2')

CONSULTAS

A
select c.nome
from cliente c, aluga a, filme f, copia cp
where a.codCliente = c.codigo and cp.tem = f.codigo and f.diretor='Woody Allen'

B
select c.nome, f.nome
from cliente c, aluga a, filme fm, funcionario f
where c.codigo = a.codCliente and a.codFuncionario = f.codigo and a.numCopia = 21 and fm.nome = 'Julie & Julia' and a.dataInicio < '11-04-2014'

C
select fm.codigo, cp.numero, cp.status
from filme fm, copia cp, ator a
where ator='Philip Seymour Hoffman' and a.codigo = fm.codigo and cp.tem = fm.codigo

D
select cp.numero, cp.status
from copia cp, estilo e, filme fm
where e.estilo='Aventura' and e.codigo = fm.codigo

E
select fn.cnpj, fn.razaoSocial
from fornecedor fn, funcionario f, compra c
where c.cnpj = fn.cnpj and c.codFuncionario = f.codigo and f.nome='José da Silva Xavier'

F
select fn.cnpj, fn.razaoSocial, fm.codigo, fm.nome, cp.numero
from fornecedor fn left join compra c on c.cnpj=fn.cnpj join copia cp on cp.numero=c.numCopia join filme fm on fm.codigo = cp.tem

G
select f.nome, cp.numero, fm.nome
from funcionario f left join compra c on f.codigo=c.codFuncionario join copia cp on cp.numero=c.numCopia join filme fm on cp.tem=fm.codigo

H
select cl.nome, f.nome, cp.numero, fn.razaoSocial
from cliente cl, funcionario f, copia cp, fornecedor fn, compra c, filme fm
where c.codFuncionario = f.codigo and c.numCopia = cp.numero and c.cnpj = fn.cnpj and fm.diretor='Stanley Tucci Jr'
