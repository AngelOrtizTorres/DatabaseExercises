-- Autor: Ángel Ortiz Torres

DROP DATABASE IF EXISTS test_trigger;
CREATE DATABASE test_trigger;
USE test_trigger;

CREATE TABLE alumnos (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido1 VARCHAR(50) NOT NULL,
    apellido2 VARCHAR(50), 
    nota FLOAT
);

DELIMITER $$
DROP TRIGGER IF EXISTS trigger_check_nota_before_insert$$
CREATE TRIGGER trigger_check_nota_before_insert
BEFORE INSERT
ON alumnos FOR EACH ROW
BEGIN
  IF NEW.nota < 0 THEN
    SET NEW.nota = 0;
  ELSEIF NEW.nota > 10 THEN
    SET NEW.nota = 10;
  END IF;
END$$ -- Faltaba $$ para cerrar el DELIMITER$$

DROP TRIGGER IF EXISTS trigger_check_nota_before_update$$
CREATE TRIGGER trigger_check_nota_before_update
BEFORE UPDATE
ON alumnos FOR EACH ROW
BEGIN
  IF NEW.nota < 0 THEN
    SET NEW.nota = 0;
  ELSEIF NEW.nota > 10 THEN
    SET NEW.nota = 10;
  END IF;
END$$ -- Faltaba $$ para cerrar el DELIMITER$$

DELIMITER ;
INSERT INTO alumnos VALUES (1, 'Pepe', 'López', 'López', -1);
INSERT INTO alumnos VALUES (2, 'María', 'Sánchez', 'Sánchez', 11);
INSERT INTO alumnos VALUES (3, 'Juan', 'Pérez', 'Pérez', 8.5);

SELECT * FROM alumnos;

UPDATE alumnos SET nota = -4 WHERE id = 3;
UPDATE alumnos SET nota = 14 WHERE id = 3;
UPDATE alumnos SET nota = 9.5 WHERE id = 3;

SELECT * FROM alumnos;