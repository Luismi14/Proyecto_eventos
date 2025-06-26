-- Este script contiene solo el TRIGGER y se ejecutará después de las tablas.
USE eventos;

CREATE TRIGGER generar_id_usuario_trigger
BEFORE INSERT
ON usuarios
FOR EACH ROW
BEGIN
  DECLARE next_val INT;
  SELECT IFNULL(MAX(CAST(SUBSTRING(u.ID_Usuario, 5) AS UNSIGNED)), 0) + 1
  INTO next_val
  FROM usuarios u
  WHERE u.ID_Usuario LIKE 'COD-%';

  IF next_val IS NULL OR next_val = 1 THEN
    SET next_val = 10000;
  END IF;

  SET NEW.ID_Usuario = CONCAT('COD-', LPAD(next_val, 5, '0'));
END;
