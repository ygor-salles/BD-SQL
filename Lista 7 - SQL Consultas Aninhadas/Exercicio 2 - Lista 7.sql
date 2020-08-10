Exercicio 2 – Lista 7

MAPEAMENTO – MODELO RELACIONAL

pessoa(cpf, nome)
professor(cpf, salario)
	cpf referencia pessoa(cpf)
aluno(cpf, matricula)
	cpf referencia pessoa(cpf)
turma(numero, sala, horario, atuacao, da_turma_disciplina)
	atuacao referencia professor(cpf)
	matricula(cpf, numero, status)
		cpf referencia aluno(cpf)
		numero referencia turma(numero)
	da_turma_disciplina referencia disciplina(codigo)
disciplina(codigo, nome, numeroCreditos, regencia)
	regencia referencia professor(cpf)
prova(codDisciplina, numero, valor, descricao)
	codDisciplina referencia disciplina(codigo)
	faz(cpf, codDisciplina, numero, nota)
		cpf, codDisciplina referencia aluno(cpf, codDisciplina)
		numero referencia prova(numero)

	
IMPLEMENTAÇÃO DAS TABELAS NO BANCO DE DADOS

create table pessoa (
	cpf varchar(14) primary key,
	nome varchar(50)
)

create table professor (
	cpf varchar(14) primary key,
	salario float,
		foreign key (cpf) references pessoa(cpf)
)

create table aluno (
	cpf varchar(14) primary key,
	matricula char(10),
		foreign key (cpf) references pessoa(cpf)
)
create table disciplina (
	codigo int primary key,
	nome varchar(50),
	numeroCreditos int,
	regencia varchar(14),
		foreign key (regencia) references professor(cpf)
)

create table turma (
	numero int primary key,
	sala int,
	horario float,
	atuacao varchar(14),
	da_turma_disciplina int,
		foreign key (atuacao) references professor(cpf),
		foreign key (da_turma_disciplina) references disciplina(codigo)
)

create table matricula (
	cpf varchar(14),
	numero int,
	status varchar(20),
		primary key (cpf, numero),
			foreign key (cpf) references aluno(cpf),
			foreign key (numero) references turma(numero)
)

create table prova(
	codDisciplina int,
	numero int,
	valor float,
	descricao varchar(150),
		primary key (codDisciplina, numero),
			foreign key (codDisciplina) references disciplina(codigo) on delete cascade
)

create table faz (
	cpf varchar(14),
	codDisciplina int,
	numero int,
	nota float,
		primary key (cpf, codDisciplina, numero),
			foreign key (cpf) references aluno(cpf),
			foreign key (codDisciplina, numero) references prova(codDisciplina, numero)
)

INSERÇÃO DE REGISTROS

insert into pessoa values
('198.208.476-98', 'Lucas Oliveira Silva'),
('135.258.976-00', 'Maria Clara Eduarda'),
('145.258.476-99', 'Maria Lucia da Silva'),
('145.258.476-98', 'João Lúcio da Silva')

insert into professor values
('145.258.476-99', 9500),
('145.258.476-98', 9500)

insert into aluno values
('198.208.476-98', '2018036874'),
('135.258.976-00', '2016025698')

insert into disciplina values
(03, 'Matemática', 10, '145.258.476-99'),
(04, 'Ciencias', 12, '145.258.476-98')

insert into turma values
(15, 01, 3, '145.258.476-99', 03),
(16, 02, 4, '145.258.476-98', 04)

insert into matricula values
('198.208.476-98', 15, 'Deferido'),
('135.258.976-00', 16, 'Indeferido')

insert into prova values
(03, 07, 100, 'Capitulo 1 de Matematica'),
(04, 08, 100, 'Capitulo 1 de Ciencias')

insert into faz values
('198.208.476-98', 03, 07, 88),
('135.258.976-00', 04, 08, 42)








CONSULTAS

A
select p.nome, d.codigo, t.numero, m.status 
from pessoa p, aluno a, disciplina d, turma t, matricula m
where m.cpf = a.cpf and m.numero = t.numero and p.cpf = a.cpf and t.da_turma_disciplina = d.codigo
order by (p.nome)

B
select p.nome, d.codigo
from pessoa p left join disciplina d on d.regencia <> p.cpf join aluno a on p.cpf = a.cpf 

C
select d.codigo, d.nome, p.nome, pv.numero, pv.valor
from disciplina d, pessoa p, professor pf, prova pv 
where pf.cpf = p.cpf and pv.codDisciplina = d.codigo

D
select codDisciplina, count(numero)
from prova
group by (codDisciplina)

E
select count(pv.numero)
from prova pv, pessoa p, professor pf, disciplina d
where p.cpf = pf.cpf and pv.codDisciplina = d.codigo and p.nome = 'João Lúcio da Silva'

F
select pv.codDisciplina, count(pv.numero)
from prova pv, pessoa p, professor pf
where p.cpf = pf.cpf and p.nome = 'João Lúcio da Silva'
group by (pv.codDisciplina)
having count(pv.numero) > 2

G
select pf.cpf, p.nome, d.nome 
from professor pf, pessoa p, disciplina d, turma t
where p.cpf = pf.cpf and t.da_turma_disciplina = d.codigo and t.horario > 19

H
select count(t.numero)
from disciplina d, turma t
where t.da_turma_disciplina = d.codigo and t.horario > 19

I
select d.nome, count(t.numero)
from disciplina d, turma t
where t.horario > 19 and t.da_turma_disciplina = d.codigo
group by (d.nome)
having count(t.numero) > 4

J
select cpf
from aluno
where cpf in (select cpf from professor)

K
(select p.nome from aluno a, pessoa p where p.cpf = a.cpf)
union
(select p.nome from professor pf, pessoa p where pf.cpf = p.cpf)

L
(select p.nome from aluno a, pessoa p where p.cpf = a.cpf)
intersect 
(select p.nome from professor pf, pessoa p where pf.cpf = p.cpf)

M
(select distinct p.nome from aluno a, pessoa p where p.cpf = a.cpf)
except
(select p.nome from professor pf, pessoa p where pf.cpf = p.cpf)
