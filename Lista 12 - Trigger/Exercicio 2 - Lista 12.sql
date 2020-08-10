EXERCICIO 2:

create table departamento (
	codd int primary key,
	sigla varchar(10),
	nome varchar(50),
	qtdef int
);

create table funcionario (
	codf int primary key,
	nome varchar(50),
	codd int,
	salario float,
	totalHoras float default 44,
	horaExtra float default 0,
		foreign key (codd) references departamento(codd)
);

create table projeto (
	codp int primary key,
	nome varchar(50),
	descricao varchar(50),
	datai date,
	situacao int check (situacao=1 or situacao=2)
);

create table alocacao (
	codp int,
	codf int, 
	horasProjeto float,
	situacao int check (situacao=1 or situacao=2 or situacao=3),
		foreign key (codp) references projeto(codp),
		foreign key (codf) references funcionario(codf)
);

/* Inserção de Registros para teste */
insert into departamento values
(1, 'CTR', 'Controladoria', 10),
(2, 'RH', 'Recursos Humanos', 8),
(3, 'ENG', 'Engenharia', 25),
(4, 'TI', 'Tecnologia da Informação', 7)

insert into funcionario values
(1, 'funcionario1', 4, 3000),
(2, 'funcionario2', 4, 2500),
(3, 'funcionario3', 3, 5000),
(4, 'funcionario4', 2, 2500)

insert into projeto values 
(1, 'projeto1', 'descricao projeto1', '2018-02-02'),
(2, 'projeto2', 'descricao projeto2', '2018-02-03'),
(3, 'projeto3', 'descricao projeto3', '2018-02-05')

--> A TABELA ALOCAÇÃO SERÁ INSERIDA DEPOIS DA CRIAÇÃO DOS TRIGGER'S PARA VALIDAR

/* ********************************************************** */

A.
create or replace function funcaoA ()
returns trigger as $$
declare f funcionario%rowtype;
begin
	if (tg_op = 'INSERT') then
		update funcionario set totalHoras = totalHoras - NEW.horasProjeto where codf = NEW.codf;
	elseif (tg_op = 'DELETE') then
		update funcionario set totalHoras = totalHoras + OLD.horasProjeto where codf = OLD.codf;
	end if;

	for f in select * from funcionario loop
		if (f.totalHoras < 0) then
			update funcionario set horaExtra = (-totalHoras) where f.codf = codf;
		else
			update funcionario set horaExtra = 0 where f.codf = codf;
		end if;
	end loop; 

	return null;
end;
$$ language 'plpgsql';

create trigger trg_funcaoA
after insert or delete on alocacao
for each row
execute procedure funcaoA ();

drop trigger trg_funcaoA on alocacao
drop function funcaoA ()


B.
create or replace function atualiza_situacaoProjeto()
returns trigger as $$
declare p projeto%rowtype;  qtd int;
begin
	if (tg_op = 'INSERT') then
		for p in select * from projeto loop
			select count(a.situacao) into qtd from alocacao a where a.codp = p.codp and situacao=1;
			if (qtd >= 1) then
				update projeto set situacao=1 where codp = p.codp;
			else
				update projeto set situacao=2 where codp = p.codp;
			end if;
		end loop;
	
	elseif (tg_op = 'DELETE') then
		for p in select * from projeto loop
			select count(a.situacao) into qtd from alocacao a where a.codp = p.codp and situacao=1;
			if (qtd >= 1) then
				update projeto set situacao=1 where codp = p.codp;
			else
				update projeto set situacao=2 where codp = p.codp;
			end if;
		end loop;
		
	elseif ((tg_op = 'UPDATE') and (NEW.codp != OLD.codp)) then
		for p in select * from projeto loop
			select count(a.situacao) into qtd from alocacao a where a.codp = p.codp and situacao=1;
			if (qtd >= 1) then
				update projeto set situacao=1 where codp = p.codp;
			else
				update projeto set situacao=2 where codp = p.codp;
			end if;
		end loop;
	end if;
		
	return null;
end;
$$ language 'plpgsql';

create trigger tr_atualiza_situacaoProjeto
after insert or delete or update on alocacao
for each row
execute procedure atualiza_situacaoProjeto();




/* Teste para validação após a criação de trigger */
insert into alocacao values
(1, 2, 8, 2),
(1, 1, 10, 1),
(2, 1, 40, 1),
(2, 3, 28, 1),
(1, 1, 18, 3),
(3, 2, 8, 2)

select * from alocacao

select * from funcionario

select * from projeto

delete from alocacao

select * from funcionario

select * from projeto
/* ********************************************************** */