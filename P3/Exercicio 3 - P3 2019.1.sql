/* Exercicio 3 */

CREATE OR REPLACE FUNCTION func4()
RETURNS TRIGGER AS $$ 
BEGIN
	IF((TG_OP == 'UPDATE') and (NEW.codigo != OLD.codigo)) THEN
		UPDATE parlamentar SET valorcota = valorcota - NEW.valor WHERE codigo = NEW.codigo;
		UPDATE parlamentar SET valorcota = valorcota - OLD.valor WHERE codigo = OLD.codigo;
	ELSE IF(TG_OP = 'INSERT') THEN
		UPDATE parlamentar SET valorcota = valorcota - NEW.valor WHERE codigo = NEW.codigo;
	ELSE IF(TG_OP = 'DELETE') THEN
		UPDATE parlamentar SET valorcota = valorcota - OLD.valor WHERE codigo = OLD.codigo;
	END IF;

	RETURN NULL;
END; 
$$ LANGUAGE 'plpgsql';


CREATE TRIGGER TRG_func4 
AFTER UPDATE OR INSERT OR DELETE ON gastorealizado
FOR EACH ROW 
EXECUTE PROCEDURE func4();