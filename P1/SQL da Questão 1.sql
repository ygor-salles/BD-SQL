create table instalacao
(
	codigo int primary key, 
	tipo varchar(15) check(tipo='r'or tipo='c'),
	rua varchar(50),
	num int,
	comp int,
	bairro varchar(50),
	cep char(9),
	cidade varchar(50),
	estado char(2)	
)

create table publica
(
	codigo int primary key,
	orgao varchar(30),
	formacao varchar(30),
	foreign key (codigo) references instalacao(codigo)	
)

create table privada(
	codigo int primary key,
	cpf_cnpj varchar(20),
	alugada boolean,
	foreign key (codigo) references instalacao(codigo)
)

create table vistoria(
	codigo int primary key,
	datafim date,
	qtdeTotal int,
	cpf_responsavel varchar(20),
	cod_inst int,
	foreign key (cod_inst) references instalacao(codigo)
	
)
