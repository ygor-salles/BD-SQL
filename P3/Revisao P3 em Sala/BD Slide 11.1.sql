

CREATE TABLE departamento (
    codigo integer primary key,
    nome character varying(100) NOT NULL
);


CREATE TABLE funcionario
(
    codigo integer NOT NULL,
    nome character varying(100) NOT NULL,
    salario double precision NOT NULL,
    codept integer NOT NULL,
    CONSTRAINT funcionario_pkey PRIMARY KEY (codigo),
    CONSTRAINT funcionario_dept_fkey FOREIGN KEY (codept)
        REFERENCES public.departamento (codigo) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE projeto (
    codigo integer primary key,
    nome character varying(150) NOT NULL,
    descricao character varying(150) NOT NULL,
    dataf date NOT NULL,
    datai date
);

CREATE TABLE alocacao
(
    codp integer NOT NULL,
    codf integer NOT NULL,
    horas double precision NOT NULL,
    datai date NOT NULL,
    CONSTRAINT alocacao_pkey PRIMARY KEY (codp, codf),
    CONSTRAINT alocacao_codf_fkey FOREIGN KEY (codf)
        REFERENCES public.funcionario (codigo) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT alocacao_codp_fkey FOREIGN KEY (codp)
        REFERENCES public.projeto (codigo) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT alocacao_horas_check CHECK (horas > 0::double precision)
)

INSERT INTO public.departamento VALUES (1, 'DMC');
INSERT INTO public.departamento VALUES (2, 'IFQ');
INSERT INTO public.departamento VALUES (3, 'IRN');


INSERT INTO public.funcionario VALUES (4, 'Bia', 12500, 1);
INSERT INTO public.funcionario VALUES (5, 'Geraldo', 2500, 1);
INSERT INTO public.funcionario VALUES (6, 'Simone', 21000, 2);
INSERT INTO public.funcionario VALUES (3, 'Lucia', 25600, 3);
INSERT INTO public.funcionario VALUES (1, 'Antonio', 20000, 1);
INSERT INTO public.funcionario VALUES (2, 'Joao', 50000, 1);
INSERT INTO public.funcionario VALUES (7, 'Melina', 25000, 3);
INSERT INTO public.funcionario VALUES (8, 'Valeria', 12000, 2);

INSERT INTO public.projeto VALUES (2, 'Visualização de Dados Publicos', 'Elaboração de um painel de visualização', '2017-09-10', '2016-08-05');
INSERT INTO public.projeto VALUES (3, 'Mineração de Dados Geolocalizados', 'Projeto para explorar a base de dados geográfica do governo federal', '2017-05-03', NULL);
INSERT INTO public.projeto VALUES (1, 'Qualidade de Dados Governamentais', 'Projeto para avaliar a qualidade dos dados de compra do governo federal', '2017-05-04', '2015-02-02');

INSERT INTO public.alocacao VALUES (3, 1, 2, '2017-05-04');
INSERT INTO public.alocacao VALUES (2, 5, 5, '2016-08-05');
INSERT INTO public.alocacao VALUES (3, 3, 5, '2017-05-04');
INSERT INTO public.alocacao VALUES (3, 2, 2, '2017-05-04');
INSERT INTO public.alocacao VALUES (3, 5, 15, '2017-05-04');
INSERT INTO public.alocacao VALUES (3, 4, 5, '2017-05-04');
INSERT INTO public.alocacao VALUES (3, 6, 20, '2017-06-06');
INSERT INTO public.alocacao VALUES (1, 2, 24, '2015-04-05');



1 - função para atualizar o 
salario do funcionario onde qtd horas trabalhadas pelo funcionario > qtdeh e salario do funcionario > funcionario

create or replace function func1 (qtdh int, bonus double precision)
returns void as $$
update funcionario f
set salario = salario + bonus
where qtdh < (select sum(horas) from alocacao where codf = f.codigo) 
$$ language sql;

select func1 (2, 1000);


2 - Retornar a media de salarios por departamento cuja media for maior que um valor qualquer

select codept, avg(salario) as medias
from funcionario
group by codept
having avg(salario) > 6000


3 - Retorne o nome dos funcionarios que ganham mais que a média

select nome
from funcionario
where salario > (select avg(salario) from funcionario)


PROVA
1 - A
select codigo
from parlamentar
where (select count(codigo) from tipo) = 
(select count distinct(codt) from gastorealizado g where g.codp = p.codigo)



