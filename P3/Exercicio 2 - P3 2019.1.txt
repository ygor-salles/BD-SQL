/* Exercicio 2 */

CREATE MATERIALIZED VIEW transparencia (parlamentar, tipogasto, gastorealizado, fornecedor) AS (
	SELECT p.nome, t.titulo, g.valor, g.dataa, g.formapagamento, f.razzaosocial
	FROM gastorealizado g JOIN parlamentar p ON g.codPar = p.codigo
	JOIN tipogasto t ON g.codTipo = t.codigo
	JOIN fornecedor f ON g.codFornec = f.codigo
)

	
/* Deve ser criado uma VIEW Materializada pois necessita-se de desempenho na consulta e não mencionou
alterações frequentes no BD. A visão não é atualizável, ela é atualizada pois não atualizada automaticamente */