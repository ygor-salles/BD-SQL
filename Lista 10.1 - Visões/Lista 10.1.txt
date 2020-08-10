
create table usuario (
	codigo varchar(5) unique,
	nome varchar(50),
	login varchar(50),
	senha varchar(50)
)

create table tarefa (
	codigo varchar(5) primary key,
	dataInicio date,
	nome varchar(50),
	dataFim date
)

create table atividade (
	codigo varchar(5) primary key,
	titulo varchar(30),
	nome varchar(50),
	graurisco int
)

create table atividadetarefa (
	codtrf varchar(5),
	codatv varchar(5),
	codusr varchar(5),
	dataInicio date,
	qtdehoras int,
		primary key (codtrf, codatv),
		foreign key (codtrf) references tarefa(codigo),
		foreign key (codatv) references atividade(codigo),
		foreign key (codusr) references usuario(codigo)
)

create materialized view consulta1 (tarefa, atividadetarefa) as (
	select t.codigo, t.nome, sum(atrf.qtdehoras)
	from tarefa t join atividadetarefa atrf
	on t.codigo = atrf.codtrf 
	group by (t.codigo)
);

create view consulta2 (usuario, tarefa, atividadetarefa) as (
	select u.nome, u.descricao, t.dataInicio, t.dataFim, t.descricao, atrf.dataInicio, atrf.qtdehoras
	from usuario u join atividadetarefa atrf on u.codigo = atrf.codusr
	join tarefa t on atrf.codtrf = t.codigo
);

	