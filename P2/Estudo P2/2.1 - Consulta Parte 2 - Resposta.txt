1) 
Select a.nome, l.titulo, e.razaosocial
from autor a join autor a au on a.codigo = au.codautor join livro l on au.codlivro = l.codigo join editora e on l.ideditora = e.id
where l.titulo like '%democracia%'

2)
Select a.nome 
from autor a
(select count (codigo) from livro)
(select count (au.codlivro) from autoria au where au.codautor = a.cod)

3.
select e.razaosocial, e.cnpj, l.titulo
from editora e left join livro l on e.id = l.ideditora

4.
Select a.nome, count (l.codigo)
from autor a join autoria au on a.codigo = au.codautor join livro l on l.codigo = au.codlivro
where l.categoria = 'drama'
group by a.nome
having count(l.codigo) > 10

5.
select a.nome
from autor a
where a.codigo not in (select cod autor from autoria)

6.
select l.titulo
from livro l
where l.qtdepagina > (select avg(qtdepagina) from livro)