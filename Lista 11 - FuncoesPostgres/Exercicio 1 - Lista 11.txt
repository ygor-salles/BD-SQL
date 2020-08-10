
EXERCICIO 1:

create table produto (
	codigo int primary key,
	descricao varchar(50),
	preco float
);

insert into produto values 
(1000, 'produto1', 10),
(2000, 'produto2', 20),
(3000, 'produto3', 30),
(4000, 'produto4', 40),
(5000, 'produto5', 50),
(6000, 'produto6', 60),
(7000, 'produto7', 70)

B.

create or replace function atualizaPreco()
returns void as $$
declare prod produto%rowtype; aux int;
begin
	for prod in select * from produto loop
		select p.codigo into aux from produto p where p.codigo = prod.codigo;
		if aux < 2000 then 
			update produto
			set preco = preco + preco * 0.10
			where aux = codigo;
		else
			update produto
			set preco = preco + preco * 0.20
			where aux = codigo;
		end if;
	end loop;
	return ;
end;
$$ language 'plpgsql';
select atualizaPreco();

select * from produto


-> No postgre não é possível utilizar uma SQL para esse problema pois para resolver
essa questão é necessário inserir estruturas de controle como o for e if que só é 
possível na plpgsql