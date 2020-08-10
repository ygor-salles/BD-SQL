Exercicio 4 - Lista 7

/* CRIAÇÃO DAS TABELA NO BD */

create table paciente (
	id int primary key,
	nome varchar(20),
	cidade varchar(20)
)

create table medico (
	id int primary key,
	nome varchar(20),
	hospital varchar(20)
)

create table consulta (
	id int primary key,
	dataa date,
	idMedico int,
	idPaciente int,
		foreign key (idPaciente) references paciente(id),
		foreign key (idMedico) references medico(id)
)

create table receita (
	idConsulta int,
	idReceita int,
	nomeMedicamento varchar(20),
		primary key (idConsulta, idReceita),
			foreign key (idConsulta) references consulta(id)
)

/* INSERÇÃO DE ELEMENTOS */

insert into paciente values
(13, 'Marcio Rodrigues', 'Itajubá'),
(1, 'Maria das Dores', 'São Joao Del Rei'),
(2, 'Jose Maria da Silva', 'São Joao Del Rei'),
(3, 'Pamela Silva', 'Itajubá')

insert into medico values 
(11, 'Lucio Andrade', 'Hospital1'),
(12, 'Lucineia Andrade', 'Hospital2'),
(13, 'Marcio Rodrigues', 'Hospital3')

insert into consulta values
(20, '2013-04-04', 11, 3),
(21, '2013-04-04', 12, 2),
(22, '2013-02-15', 12, 2),
(23, '2013-02-14', 13, 1)

insert into receita values
(21, 31, 'Medicamento1'),
(21, 32, 'Medicamento2'),
(22, 33, 'Medicamento3')

/* CONSULTAS */

1
select m.nome
from medico m, consulta c
where c.idMedico = m.id and c.dataa>'2013-02-01' and c.dataa<'2013-02-28'
group by(m.nome)

2
select nome
from paciente 
where cidade='Itajubá'

3
select p.nome, c.dataa
from paciente p, consulta c
where p.cidade='Itajubá' and c.idPaciente = p.id

4
select m.nome, c.dataa
from medico m left join consulta c on m.id = c.idMedico

5
select r.nomeMedicamento
from receita r, consulta c
where r.idConsulta = c.id and dataa > '2013-04-01' and dataa < '2013-04-15'

6
select c.dataa
from consulta c, paciente p, medico m
where p.nome='Jose Maria da Silva' and p.cidade='São Joao Del Rei' and m.nome='Lucio Andrade' and c.idMedico = m.id and c.idPaciente = p.id

7
select m.nome, p.nome, r.nomeMedicamento
from medico m, paciente p, receita r, consulta c
where c.idMedico=m.id and c.idPaciente=p.id and c.id=r.idConsulta and c.dataa>'2013-04-01' and c.dataa<'2013-04-30'

8
select nome
from medico
where id in (select id from paciente) and nome in (select nome from paciente)

9
select nome
from paciente
where id not in (select id from medico) and nome not in (select nome from medico)

10
select nome
from medico
where id not in (select id from paciente) and nome not in (select nome from paciente)

11
(select nome from medico)
union
(select nome from paciente)

12
select m.id
from medico m, consulta c
where m.id=c.idMedico and m.id in (select p.id from paciente p, consulta c where p.id=c.idPaciente)

13
select p.nome
from paciente p, consulta c
where p.id=c.idPaciente and p.id in (select m.id from medico m, consulta c where m.id=c.idMedico)

14
select m.nome, m.hospital
from medico m, consulta c
where m.id=c.idMedico and m.id in (select p.id from paciente p, consulta c where p.id=c.idPaciente and c.dataa > '2002-01-01') 
