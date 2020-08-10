Exercicio 3 – Lista 7

Tabelas do BD Exercicio 1

/* Exercicio Lista 5.1 */
create table oferta(
	codigo int primary key,
	justificativa varchar(150),
	dataa date not null,
	status varchar(10) check(status='enviada' or status='aceita' or status='recusada')
)

create table jogador(
	codigo int primary key,
	login int not null,
	senha varchar(20) not null,
	nome varchar(50) not null,
	endereco varchar(50),
	e_mail varchar(50) not null,
	data_nascimento date check(data_nascimento > '01-01-1900'),
		unique(login, senha, nome, e_mail),
	remetente int,
		foreign key (remetente) references oferta(codigo)
)

create table anotacoes(
	num_sequencial int,
	dataa date not null,
	descricao varchar(150) not null,
	grau int not null check (grau > 1 and grau < 5),
		codJog int,
		primary key(codJog, num_sequencial),
			foreign key (codJog) references jogador(codigo) on delete cascade
)

create table casos_negociacao(
	codigo int primary key,
	titulo varchar(30) not null,
	informacoes varchar(150) not null
)

create table papel(
	papCas int,
	codigo int primary key,
	nome varchar(50) not null,
	objetivo varchar(150) not null,
	informacoes varchar(150),
		foreign key (papCas) references casos_negociacao(codigo)
)



create table atributo(
	codigo int primary key,
	nome varchar(50) not null unique,
	descricao varchar(150)
)

create table negociacao(
	codigo int primary key,
	data_inicio date not null,
	data_fim date,
	status varchar(30) check(status='andamento' or status='finalizada com acordo' or  status='finalizada sem acordo')
)

create table JogPapNeg(
	codJog int,
	codPap int,
	codNeg int,
		primary key(codJog, codPap, codNeg),
			foreign key (codJog) references jogador(codigo),
			foreign key (codPap) references papel(codigo),
			foreign key (codNeg) references negociacao(codigo)
)

create table negCas(
	codNeg int,
	codCas int,
		primary key(codNeg, codCas),
			foreign key (codNeg) references negociacao(codigo),
			foreign key (codCas) references casos_negociacao(codigo)
)

create table JogAtrib(
	codJog int,
	codAtrib int,
		primary key(codJog, codAtrib),
			foreign key (codJog) references jogador(codigo),
			foreign key (codAtrib) references atributo(codigo)
)

create table OfertaAtribNeg(
	codOferta int,
	codAtrib int,
	codNeg int,
	valor float,
		primary key(codOferta, codAtrib, codNeg),
			foreign key (codOferta) references oferta(codigo),
			foreign key (codAtrib) references atributo(codigo),
			foreign key (codNeg) references negociacao(codigo)
)

create table destinatario(
	codJog int,
	codOferta int,
		primary key(codJog, codOferta),
			foreign key (codJog) references jogador(codigo),
			foreign key (codOferta) references oferta(codigo)
)

INSERÇÃO DE ELEMENTOS

Insert into casos_negociacao values
(32, 'batatas', 'Negociacao de Batatas'), 
(33, 'laranjas', 'Negociacao de Laranjas')

insert into oferta values
(7, 'Necessidade de repor estoque2', '11-10-2019', 'enviada'),
(6, 'Necessidade de repor estoque', '10-10-2019', 'enviada')

insert into jogador values
(55, 7895, 'Senh@124', 'Fabricio Mendes', 'Rua Paulino', 'insta_175@outlook.com', '18-06-1996'),
(54, 7894, 'Senh@123', 'Fabricio Souza', 'Rua Castorino', 'fab_175@outlook.com', '18-08-1996')

insert into anotacoes values
(102, '12-04-2017', 'shor description', 4, 55),
(101, '12-05-2017', 'shor description', 3, 54)

insert into papel values
(33, 101, 'vender arroz', 'Muito em estoque')

insert into atributo values
(201, 'prazo de garantia', 'dfhdh4'),
(200, 'Expedito', 'fdgdfg')

insert into negociacao values
(79, '20-04-2015', '20-06-2018', 'andamento'),
(78, '20-20-2001', '20-20-2002', 'andamento')

insert into OfertaAtribNeg values
(6, 200, 79, 3000),
(6, 201, 79, 2000)

CONSULTAS:

A
select titulo
from casos_negociacao
where codigo not in (select nc.codCas from negCas nc, jogador j where j.nome='Joao Jose da Silva')

B
select n.codigo
from negociacao n, OfertaAtribNeg oan
where oan.valor > (select avg(valor) from OfertaAtribNeg)

C
select nome
from jogador
where codigo in (select codJog from anotacoes)

D
select n.codigo
from negociacao n, OfertaAtribNeg oan
where oan.valor = (select codigo from negociacao where codigo=01)

E
select codigo
from jogador
where codigo in (select codigo from casos_negociacao)
