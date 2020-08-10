/* Exercicio 4 */

CREATE OR REPLACE FUNCTION atualizaCota(novovalorcota float)
RETURNS VOID AS $$ 
DECLARE p parlamentar%rowtype; vlr FLOAT;
BEGIN
	FOR p IN SELECT * FROM parlamentar LOOP
		SELECT valorcota INTO vlr FROM parlamentar WHERE codigo = p.codigo;
		IF(vlr > 0) THEN
			UPDATE parlamentar SET valorcota = novovalorcota WHERE codigo = p.codigo;
		ELSEIF(vlr = 0) THEN
			UPDATE parlamentar SET valorcota = novovalorcota WHERE codigo = p.codigo;
		ELSEIF(vlr < 0) THEN
			UPDATE parlamentar SET valorcota = valorcota + novovalorcota WHERE codigo = p.codigo;
		END IF;
	END LOOP;
END; 
$$ LANGUAGE 'plpgsql';

SELECT atualizaCota (100);