
EXERCICIO 2:

MAPEAMENTO MODELO RELACIONAL - letras maísculas são chaves primárias

requisicao(CODIGO, tipo, valor, descricao)
cliente(CODIGO, nome, cpf)
	faz(CODREQ, CODCLI)
		codreq referencia requisicao(codigo)
		codcli referencia cliente(codigo)
funcionario(MATRICULA, nome)
produto(CODIGO, titulo, descricao)
	execucao(CODPRODUTO, MATRICULA, CODREQ)
		codproduto referencia produto(codigo)
		matricula referencia funcionario(matricula)
		codreq referencia requisicao(codigo)


CRIAÇÃO DE TABELAS NO BANCO DE DADOS:

create table requisicao (
	codigo varchar(10) primary key,
	tipo varchar(30),
	valor float,
	descricao varchar(150)
);

create table cliente (
	codigo varchar(10) primary key,
	nome varchar(50),
	cpf varchar(14) unique
);

create table faz (
	codReq varchar(10),
	codCli varchar(10),
		primary key (codReq, codCli),
			foreign key (codReq) references requisicao(codigo),
			foreign key (codCli) references cliente(codigo)
);

create table funcionario (
	matricula varchar(10) primary key,
	nome varchar(50)
);

create table produto (
	codigo varchar(10) primary key,
	titulo varchar(50),
	descricao varchar(150)
);

create table execucao (
	codProduto varchar(10),
	matricula varchar(10),
	codReq varchar(10),
		primary key (codProduto, matricula, codReq),
			foreign key (codProduto) references produto(codigo),
			foreign key (matricula) references funcionario(matricula),
			foreign key (codReq) references requisicao(codigo)
);

insert into requisicao values
('1', 'tipo1', 100, 'descricaoReq 1'),
('2', 'tipo2', 200, 'descricaoReq 2'),
('3', 'tipo3', 300, 'descricaoReq 3'),
('4', 'tipo4', 400, 'descricaoReq 4')

insert into cliente values
('100', 'cliente1', '147.158.123-78'),
('200', 'cliente2', '147.158.147-01'),
('300', 'cliente3', '145.298.472-00')

insert into faz values
('1', '300'),
('1', '100'),
('4', '300'),
('2', '300'),
('1', '200')

insert into funcionario values
('2014789', 'Jose Anchieta'),
('2016978', 'Pablo Escobar'),
('1478964', 'Sergião Berranteiro'),
('3687459', 'Marilda Mendes'),
('9877452', 'Paulinho Coró')

insert into produto values
('A01', 'produto1', 'DescricaoProd 1'),
('A02', 'produto2', 'DescricaoProd 2'),
('A03', 'produto3', 'DescricaoProd 3'),
('A04', 'produto4', 'DescricaoProd 4'),
('A05', 'produto5', 'DescricaoProd 5')

insert into execucao values
('A01', '1478964', '2'),
('A01', '2016978', '1'),
('A02', '1478964', '3'),
('A03', '9877452', '1'),
('A04', '9877452', '2')

1º
create or replace function func1 (cod varchar(10))
returns float as $$
select sum(r.valor)
from requisicao r join faz f on r.codigo = f.codReq
where func1.cod = f.codCli
$$  language sql;

select func1 ('300');


2º
create or replace function func2 (mat varchar(10))
returns table(titulo varchar(50)) as $$
begin
	return query select p.titulo
	from produto p join execucao e on p.codigo = e.codProduto
	where e.matricula = func2.mat
	group by (p.titulo);
	if not found then
		raise exception 'Não existe produtos para o funcionário %', func2.mat;
	end if;
end;
$$ language 'plpgsql';

select func2 ('9877452');


3º

create or replace function func3 (mxmCli int)
returns int as $$
declare c cliente%rowtype; cr requisicao.codigo%type; qtd int; cont int = 0;
begin
	for c in select * from cliente loop
		select count(codCli) into qtd from faz where codCli = c.codigo;
		select r.codigo into cr from requisicao r, faz f where f.codReq = r.codigo;
		if (qtd > mxmCli) then
			raise notice 'A requisição % possui mais clientes que o permetido', cr;
			cont := cont + 1;
		end if;
	end loop;
	return cont;
end;
$$ language 'plpgsql';

select func3 (0);