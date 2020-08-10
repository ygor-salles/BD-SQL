/* Exercicio 1 - Lista 6.1 */
A
select nome, CGCJ
from cliente
where no_cliente between 45 and 162

B
select *
from desenvolvedor
where custo > 5500

C
select *
from cliente 
where nome='Jose da Silva Xavier'

D
select codigo, de, ate
from alocação_projDes
where id=101

E
select p.nome, a.id, a.de, a.ate
from projeto p, alocação_projDes a
where a.id=101 and p.id=101

F
select a.id, a.de, a.ate
from alocação_projDes a, desenvolvedor d
where d.custo > 2500 and a.codigo = d.codigo

G
select p.nome, a.de, a.ate, d.nome
from projeto p, alocação_projDes a, desenvolvedor d
where d.custo > 2500 and a.codigo = d.codigo and a.id = p.id