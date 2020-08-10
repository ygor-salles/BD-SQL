create table usuario (
	codigo int primary key,
	login varchar(15) not null,
	senha varchar(15) not null,
	unique(login, senha)
)

create table e_mail(
	codUsuario int,
	e_mail varchar(50),
		primary key(codUsuario, e_mail),
			foreign key (codUsuario) references usuario(codigo)
)

create table questionario(
	codigo int primary key,
	titulo varchar(30) not null, 
	descricao varchar(150),
	data_criacao date,
	data_termino date,
	check (data_termino > data_criacao)
)

create table respondente(
	codUsuario int primary key,
	cpf varchar(14) unique,
		foreign key (codUsuario) references usuario(codigo)
)

create table agente(
	codUsuario int primary key,
	cargo varchar(20),
	agQuestionario int not null,
		foreign key (codUsuario) references usuario(codigo),
		foreign key (agQuestionario) references questionario(codigo)
)

create table questao(
	codigo int primary key,
	enunciado varchar(150) not null,
	tipo char(9) not null,
	 check(tipo='subjetiva' or tipo='objetiva')
)

create table questao_questionario(
	codQuestao int,
	codQuestionario int,
	fato char(15) not null,
	 check(fato='obrigatória' or fato='não obrigatória'),
	peso float not null,
		primary key(codQuestao, codQuestionario),
			foreign key (codQuestao) references questao(codigo),
			foreign key (codQuestionario) references questionario(codigo)
)

create table resp_questao_questionario(
	codResp int,
	codQuestao int,
	codQuestionario int,
	resposta varchar(50),
		primary key(codResp, codQuestao, codQuestionario),
			foreign key (codResp) references respondente(codUsuario),
			foreign key (codQuestao) references questao(codigo),
			foreign key (codQuestionario) references questionario(codigo)
)
