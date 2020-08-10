/* ************************************* Exercicio 1 ************************************************************* */

create table aluno (
	mat varchar(10) unique,
	nome varchar(50),
	cpf varchar(14),
	email varchar(50),
	situacao varchar(10)
)

create table disciplina (
	codigo varchar(10) primary key,
	nome varchar(50),
	descricao varchar(150),
	qtdea int
)

create table turma (
	codigo varchar(10) primary key, 
	mat varchar(10),
	codd varchar(10),
	nota float,
	freq float
		check (freq >=1 and freq <=100),
	resultado float,
		foreign key (mat) references aluno(mat),
		foreign key (codd) references disciplina(codigo)
)

create table requisito (
	codd varchar(10),
	codr varchar(10),
		foreign key (codd) references disciplina(codigo),
		foreign key (codr) references disciplina(codigo)
)



/* ************************************* Exercicio 2 ************************************************************* */

insert into aluno values
('20177485', 'Aluno 1', '147.589.698-22', 'llfdkgj@gmail.com'),
('20179674', 'Aluno 2', '147.589.541-11', 'werer21@gmail.com')

insert into disciplina values 
('COM230', 'BANCO DE DADOS I', 'ER, MEHR, TABELAS BD, FUNÇÕES, TRIGGER, VIEW, AR', 50),
('COM111', 'ESTRUTURA DE DADOS I', 'LISTAS, FILAS, PILHAS, ARVORES BINÁRIAS', 100),
('COM110', 'FUNDAMENTOS DE PROGRAMAÇÃO', 'CONDICIONAIS, LOOPS, VETORES, MATRIZES', 100)

insert into turma values
('C1106', '20177485', 'COM230', 8, 80, 8.5),
('C1107', '20179674', 'COM230', 4, 85, 5)

insert into requisito values 
('COM230', 'COM111'),
('COM111', 'COM110')



/* ************************************* Exercicio 3 ************************************************************* */

create view view3 (aluno, disciplina, turma) as (
	select a.nome as ALUNO, d.nome as DISCIPLINA, t.nota as NOTA_TURMA, t.freq as FREQUENCIA_TURMA, t.resultado as RESULTADO_TURMA
	from aluno a join turma t on a.mat = t.mat
	join disciplina d on t.codd = d.codigo
)

3.1.
select * from view3

3.2
insert into turma values
('C1108', '20177485', 'COM111', 5, 50, 6)

3.3
select * from view3

3.4
A view foi atualizada pois foi usada VIEW onde é atualizável (muda no BD muda na view) e não MATERIALIZED VIEW



/* ************************************* Exercicio 4 ************************************************************* */

create materialized view view4 (disciplina, turma) as (
	select d.nome as DISCIPLINA, r.codr as PRE_REQUISITO
	from disciplina d left join requisito r on d.codigo = r.codd
)

4.1
select * from view4

4.2
insert into requisito values
('COM110', 'COM110')

4.3
select * from view4

4.4
Não foi atualizada. Pois a Materialized View não atualiza diretamente, só a View

4.5
refresh materialized view view4

4.6
select * from view4

4.7
Sim foi atualizada após o comando refresh, ela não atualiza automaticamente é manual



/* ************************************* Exercicio 5 ************************************************************* */

create or replace function atualiza_qtd_alunos()
returns trigger as $$
begin 
	if (tg_op = 'INSERT') then
		update disciplina set qtdea = qtdea + 1 where codigo = NEW.codd;
	elseif (tg_op = 'DELETE') then
		update disciplina set qtdea = qtdea - 1 where codigo = OLD.codd;
	end if;
	return null;
end;		
$$ language 'plpgsql';

create trigger trg_atualiza_qtd_alunos
after insert or delete on turma
for each row
execute procedure atualiza_qtd_alunos();



/* ************************************* Exercicio 6 ************************************************************* */

create or replace function altera_turma ()
returns void as $$
declare t turma%rowtype;
begin 
	for t in select * from turma loop
		if (t.nota>=6) then 
			update aluno set situacao='Aprovado' where aluno.mat = t.mat;
		else
			update aluno set situacao='Reprovado' where aluno.mat = t.mat;
		end if;
	end loop;
		
	return ;
end; 
$$ language 'plpgsql';

select altera_turma ();



/* ************************************* Exercicio 7 ************************************************************* */

create or replace function lista_situacao(sit varchar(10))
returns setof record as $$
select *
from aluno
where situacao = lista_situacao.sit
$$ language sql;

select lista_situacao('Aprovado');



/* ************************************* Exercicio 8 ************************************************************* */

create or replace function altera_nota()
returns trigger as $$
begin
	if (NEW.freq<75 and NEW.nota!=0) then
		raise exception 'Frequencia menor que 75%% e nota diferente de 0';
		return NULL;
	elseif ((NEW.freq<75) and (tg_op = 'INSERT')) then
		update turma set resultado=0 where codigo = NEW.codigo;
		return NEW;
	end if;
end;
$$ language 'plpgsql';

create trigger trg_altera_nota
before insert or update on turma
for each row
execute procedure altera_nota();



/* ************************************************************* */
insert into turma values
('C1111', '20179674', 'COM230', 0, 49, 5.5)


select * from turma
delete from turma where codigo='C1111'

drop trigger trg_altera_nota on turma
drop function altera_nota()