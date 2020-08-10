EXERCICIO 4:

create or replace function composicao_igual()
returns int as $$
declare qtd int;
begin
	select count(idpecaparte) into qtd from composicao where idpecaparte = idpecacomposta;
	if not found then
		raise exception 'Não possui nenhuma composicaçao com peças iguais!';
	end if;
	return qtd;
end;
$$ language 'plpgsql';

select composicao_igual();