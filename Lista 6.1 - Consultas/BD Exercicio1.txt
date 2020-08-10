/* Exercicio 2 - Lista 5 */
create table cliente(
	no_cliente int primary key,
	nome varchar(50) not null,
	CGCJ varchar(30) not null unique
)

create table projeto(
	id int primary key,
	nome varchar(50) not null,
	projCliente int not null,
		foreign key (projCliente) references cliente(no_cliente)
)

create table desenvolvedor(
	codigo int primary key,	
	nome varchar(50) not null,
	custo float not null,
	check (custo > 0)
)

create table alocação_projDes(
	id int,
	codigo int,
	ate int not null,
	de int not null,
		primary key(id, codigo, de),
			foreign key (id) references projeto(id),
			foreign key (codigo) references desenvolvedor(codigo)
)

/* Inserção de Elementos */
insert into cliente values
(10, 'Cliente1', '123456'),
(50, 'Cliente1', '123457'),
(60, 'Jose da Silva Xavier', '123458')

insert into projeto values
(101, 'projeto1', 10),
(20, 'projeto2', 50),
(30, 'projeto3', 60)

insert into desenvolvedor values
(1, 'Desenvolvedor1', 1000),
(2, 'Desenvolvedor2', 5600),
(3, 'Desenvolvedor3', 3000)

insert into alocação_projDes values 
(101, 1, 100, 50),
(30, 2, 100, 51),
(30, 3, 100, 52)
