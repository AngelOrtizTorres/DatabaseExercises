# Manejo de errores en MySQL

Aquí puedes acceder al archivo sql donde están todos estos ejercicios: [ARCHIVO SQL](error_handling.sql)

**1. Crea una base de datos llamada test que contenga una tabla llamada alumno. La tabla debe tener cuatro columnas:**

- **id: entero sin signo (clave primaria).**
- **nombre: cadena de 50 caracteres.**
- **apellido1: cadena de 50 caracteres.**
- **apellido2: cadena de 50 caracteres.**
  
**Una vez creada la base de datos y la tabla deberá crear un procedimiento llamado insertar_alumno con las siguientes características. El procedimiento recibe cuatro parámetros de entrada (id, nombre, apellido1, apellido2) y los insertará en la tabla alumno. El procedimiento devolverá como salida un parámetro llamado error que tendrá un valor igual a 0 si la operación se ha podido realizar con éxito y un valor igual a 1 en caso contrario.**

**Deberá manejar los errores que puedan ocurrir cuando se intenta insertar una fila que contiene una clave primaria repetida.**

```sql
CREATE DATABASE IF NOT EXISTS test;
USE test;

DROP TABLE IF EXISTS alumno;
CREATE TABLE alumno (
    id INT UNSIGNED PRIMARY KEY,
    nombre VARCHAR(50),
    apellido1 VARCHAR(50),
    apellido2 VARCHAR(50)
);

DELIMITER $$

CREATE PROCEDURE insertar_alumno (
    IN p_id INT UNSIGNED,
    IN p_nombre VARCHAR(50),
    IN p_apellido1 VARCHAR(50),
    IN p_apellido2 VARCHAR(50),
    OUT p_error INT
)
BEGIN
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        SET p_error = 1;

    SET p_error = 0;

    INSERT INTO alumno (id, nombre, apellido1, apellido2)
    VALUES (p_id, p_nombre, p_apellido1, p_apellido2);
END $$
```

