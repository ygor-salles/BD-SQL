/* Exercicio 2 - Lista 6.1 */
A
select nome, login
from jogador

B
select nome, login
from jogador
where nome like '%Souza%'

C
select cn.codigo, p.nome
from casos_negociacao cn left join papel p on p.papCas = cn.codigo

D
select n.data_inicio, n.data_fim, n.status
from negociacao n, atributo a
where a.nome like '%prazo de garantia%'

E
select j.nome, cn.titulo, p.nome
from jogador j, casos_negociacao cn, papel p

F
select n.codigo, n.data_inicio, n.data_fim, j.nome, n.status, a.nome 
from negociacao n, jogador j, atributo a, JogAtrib ja
where n.data_inicio > '01-03-2014' and ja.codJog = j.codigo and ja.codAtrib = a.codigo

G
select j.codigo, count(a.num_sequencial)
from jogador j, anotacoes a
group by (j.codigo)

H
select j.nome, count(a.num_sequencial)
from jogador j, anotacoes a
group by (j.nome)

I
select j.nome, count(a.num_sequencial)
from jogador j, anotacoes a
where a.codJog = j.codigo and a.grau > 3
group by (j.nome)
having count(a.num_sequencial) > 3

J
select a.nome, count(n.codigo)
from atributo a, negociacao n
group by (a.nome)

K
select max(oan.valor)
from OfertaAtribNeg oan