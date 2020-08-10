
EXERCICIO 1:

create table departamento (
	codigo int primary key,
	descricao varchar(30),
	qtde_funcionarios int default 0
)

create table empregado (
	codigo int primary key,
	nome varchar(100),
	funcao varchar(50),
	salario decimal(9,2),
	depto int,
		foreign key (depto) references departamento(codigo)
)

/* Inserção de registros para teste */
insert into departamento values
(1, 'departamento1'),
(2, 'departamento2'),
(3, 'departamento3')

select * from departamento
/* ************************************ */



A.
create or replace function funcaoA ()
returns trigger as $$
begin
	update departamento
	set qtde_funcionarios = qtde_funcionarios + 1
	where codigo = NEW.depto;
	return null;
end;
$$ language 'plpgsql';

create trigger tr_funcaoA
after insert on empregado
for each row
execute procedure funcaoA();

/* Inserção de registros para teste */
insert into empregado values
(1, 'empregado1', 'funcao1', 1000, 1)

select * from departamento
/* ************************************ */


B.
create or replace function funcaoB ()
returns trigger as $$
begin
	update departamento
	set qtde_funcionarios = qtde_funcionarios - 1
	where codigo = OLD.depto;
	return null;
end;
$$ language 'plpgsql';

create trigger tr_funcaoB
after delete on empregado
for each row
execute procedure funcaoB();

/* Remoção de registros para teste */
delete from empregado
where codigo = 1;

select * from departamento
/* ************************************ */


C.
create or replace function funcaoC()
returns trigger as $$
begin
	if (tg_op = 'INSERT') then
		update departamento set qtde_funcionarios = qtde_funcionarios + 1 where codigo = NEW.depto;
	elseif (tg_op = 'DELETE') then
		update departamento set qtde_funcionarios = qtde_funcionarios - 1 where codigo = OLD.depto;
	elseif ((tg_op = 'UPDATE') and (OLD.depto != NEW.depto)) then
		update departamento set qtde_funcionarios = qtde_funcionarios - 1 where codigo = OLD.depto;
		update departamento set qtde_funcionarios = qtde_funcionarios + 1 where codigo = NEW.depto;
	end if;
	return null;
end;
$$ language 'plpgsql';

create trigger tr_funcaoC
after insert or delete or update on empregado
for each row
execute procedure funcaoC();

/* Atualização(Inserção e Remoção) de registros para teste */
insert into empregado values
(1, 'empregado1', 'funcao1', 1000, 1);

select * from departamento;

delete from empregado
where codigo = 1;

select * from departamento;
/* ************************************ */


/* OBS: O departamento 1 apresentou 2 empregados em uma inserção pós função C
pq na hora da inserção no momento de excutar a tabela C a regra da Função A tb
está valendo, ou seja a inserção iré afetar a função A e C, assim como na exclusão */