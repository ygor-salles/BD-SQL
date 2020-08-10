/* Exercicio Lista 5.1 */
create table jogador(
	codigo int primary key,
	login varchar(10) not null,
	senha varchar(20) not null,
	nome varchar(50) not null,
	endereco varchar(50),
	email varchar(50) not null,
	data_nascimento date check(data_nascimento > '01-01-1900'),
		unique(login, senha, nome, email)
)

create table anotacao(
	num_sequencial int,
	codJog int,
	dataa date not null,
	descricao varchar(150) not null,
	grau int not null check (grau > 1 and grau < 5),
		primary key(codJog, num_sequencial),
			foreign key (codJog) references jogador(codigo) on delete cascade
)

create table caso(
	codigo int primary key,
	titulo varchar(30) not null,
	informacoes varchar(150) not null
)

create table papel(
	codigo int primary key,
	nome varchar(50) not null,
	objetivo varchar(150) not null,
	codCaso int,
	informacoes varchar(150),
		foreign key (codCaso) references caso(codigo)
)

create table atributo(
	codigo int primary key,
	nome varchar(50) not null unique,
	descricao varchar(150)
)

create table negociacao(
	codigo int primary key,
	codCaso int,
	codJog int,
	codAtrib int,
	valorAtrib float,
	data_inicio date not null,
	data_fim date,
	status varchar(30), 
		check(status='andamento' or status='finalizada com acordo' or  status='finalizada sem acordo'),
		foreign key (codCaso) references caso(codigo),
		foreign key (codJog) references jogador(codigo),
		foreign key (codAtrib) references atributo(codigo)
)

create table oferta(
	codigo int primary key,
	justificativa varchar(150),
	dataa date not null,
	status varchar(10) check(status='enviada' or status='aceita' or status='recusada'),
	valor float,
	codAtrib int,
	codNeg int,
	jogRemetente int,
	jogDestinatario int,
		foreign key (codAtrib) references atributo(codigo),
		foreign key (codNeg) references negociacao(codigo),
		foreign key (jogRemetente) references jogador(codigo),
		foreign key (jogDestinatario) references jogador(codigo)
)
 
3 – INSERÇÃO DE REGISTROS (TERMINAR):

insert into jogador values
(1, 'E001245', 'Feijão@789', 'Jogador1', 'Endereço1', 'dfsdf@gmail.com', '01-05-1990'),
(2, 'M001445', 'Arroz@789', 'Jogador2', 'Endereço2', 'wqwegf@gmail.com', '01-05-1990'),
(3, 'T001201', 'Batatao@789', 'Jogador3', 'Endereço1', 'hyjhgfsh@gmail.com', '01-05-1990'),
(4, 'E001236', 'Carne@789', 'Jogador4', 'Endereço4', 'gdshds@gmail.com', '02-05-1990'),
(5, 'E002457', 'Paçoca@789', 'Jogador5', 'Endereço1', 'yerjfdsa@gmail.com', '03-05-1990')

insert into anotacao values
(1, 2, '01-01-2017', 'descricao Anotação 1', 2),
(2, 1, '02-03-2018', 'descricao Anotação 2', 2),
(3, 2, '01-01-2017', 'descricao Anotação 3', 3),
(4, 4, '02-04-2018', 'descricao Anotação 4', 2),
(5, 5, '01-01-2017', 'descricao Anotação 5', 4)

insert into caso values
(1, 'Caso Negociação 1', 'Informação Caso 1'),
(2, 'Caso Negociação 2', 'Informação Caso 2'),
(3, 'Caso Negociação 3', 'Informação Caso 3'),
(4, 'Caso Negociação 4', 'Informação Caso 4'),
(5, 'Caso Negociação 5', 'Informação Caso 5')

insert into papel values
(1, 'papel1', 'Objetivo Papel 1', 3, 'Informações Papel 1'),
(2, 'papel2', 'Objetivo Papel 2', 2, 'Informações Papel 2'),
(3, 'papel3', 'Objetivo Papel 3', 1, 'Informações Papel 3'),
(4, 'papel4', 'Objetivo Papel 4', 3, 'Informações Papel 4'),
(5, 'papel5', 'Objetivo Papel 5', 5, 'Informações Papel 5')

insert into atributo values
(1,'atributo1', 'Descrição atributo 1'),
(2,'atributo2', 'Descrição atributo 2'),
(3,'atributo3', 'Descrição atributo 3'),
(4,'atributo4', 'Descrição atributo 4'),
(5,'atributo5', 'Descrição atributo 5')

insert into negociacao values
(10, 1, 2, 2, 1000, '02-02-2017', '03-03-2017', 'andamento'),
(11, 2, 3, 1, 2000, '04-04-2017', '05-05-2017', 'finalizada com acordo')

insert into oferta values
(1, 'justificativa Oferta 1', '01-02-2017', 'enviada', 1250.3, 1, 10, 3, 4),
(2, 'justificativa Oferta 2', '05-05-2017', 'enviada', 2500.3, 3, 10, 3, 4),
(3, 'justificativa Oferta 3', '01-02-2017', 'aceita', 3000, 1, 11, 3, 1),
(4, 'justificativa Oferta 4', '05-02-2018', 'recusada', 500, 2, 10, 5, 4),
(5, 'justificativa Oferta 5', '01-04-2019', 'aceita', 120, 5, 11, 2, 4)

