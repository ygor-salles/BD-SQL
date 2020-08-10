EXERCICIO 3: 

create table funcao (
	codigo int primary key,
	descricao varchar(150),
	salario float
);

create table funcion (
	codigo int primary key,
	nome varchar(50),
	dataadmissao date,
	cod_funcao int,
		foreign key (cod_funcao) references funcao(codigo)
);

create table peca (
	codigo int primary key,
	nome varchar(50),
	descricao varchar(150),
	qtdeestoque int
);

create table composicao (
	idpecacomposta int,
	idpecaparte int,
	quantidade int,
		primary key (idpecacomposta, idpecaparte, quantidade),
			foreign key (idpecacomposta) references peca(codigo),
			foreign key (idpecaparte) references peca(codigo)
);


insert into funcao values
(1, 'funcao1', 1000),
(2, 'funcao2', 2000),
(3, 'funcao3', 2000),
(4, 'funcao4', 4000)

insert into funcion values
(1, 'funcionario1', '2018-10-10', 2),
(2, 'funcionario2', '2018-02-10', 2),
(3, 'funcionario3', '2018-04-10', 3),
(4, 'funcionario4', '2018-09-10', 1),
(5, 'funcionario5', '2018-10-10', 1)

insert into peca values
(1, 'peça1', 'descricao peça 1', 100),
(2, 'peça2', 'descricao peça 2', 500),
(3, 'peça3', 'descricao peça 3', 500),
(4, 'peça4', 'descricao peça 4', 400)

insert into composicao values
(1, 4, 50),
(4, 4, 200),
(1, 3, 80),
(2, 3, 70),
(3, 2, 50)


EXERCICIO 3:
A
create or replace function funcA (mxm int)
returns void as $$
declare c composicao%rowtype; qtd int;
begin
	for c in select * from composicao loop
		if (c.quantidade > mxm) then
			raise notice 'A peça composta % e a peça parte % possui quantidade maior que o permitido', c.idpecacomposta, c.idpecaparte;
		end if;
	end loop;
	return ;
end;
$$ language 'plpgsql';

select funcA (60);


B
create or replace function funcB (cod int, valor int)
returns setof record as $$
update composicao set quantidade = valor where cod = idpecaparte;
update composicao set quantidade = valor where cod = idpecacomposta
returning *
$$ language sql;


C
create or replace function funcC (cod int)
returns record as $$
select p.nome, count(p)
from peca p, composicao c
where p.codigo = c.idpecaparte or p.codigo = c.idpecacomposta 
group by (p.codigo)
having (p.codigo) = funcC.cod
$$ language sql;

select funcC (4);


D
create or replace function funcD (cod int)
returns table (nome varchar) as $$
begin
	return query select p.nome
	from peca p, composicao c
	where p.codigo = c.idpecaparte or p.codigo = c.idpecacomposta 
	group by (p.codigo)
	having (p.codigo) = funcD.cod;
	if not found then
		raise exception 'Não existe peça com o codigo %', funcD.cod;
	end if;
end;
$$ language 'plpgsql';

select funcD (4);

