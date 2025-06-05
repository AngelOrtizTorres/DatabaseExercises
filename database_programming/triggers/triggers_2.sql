-- Autor: Ángel Ortiz Torres

/* Crea una base de datos llamada test que contenga una tabla llamada alumnos con las siguientes columnas.
Tabla alumnos:

- id (entero sin signo)
- nombre (cadena de caracteres)
- apellido1 (cadena de caracteres)
- apellido2 (cadena de caracteres)
- email (cadena de caracteres)
Escriba un procedimiento llamado crear_email que dados los parámetros de entrada: nombre, apellido1, apellido2 y dominio, cree una dirección de email y la devuelva como salida.

- Procedimiento: crear_email
- Entrada:
	- nombre (cadena de caracteres)
	- apellido1 (cadena de caracteres)
	- apellido2 (cadena de caracteres)
	- dominio (cadena de caracteres)
- Salida:
	- email (cadena de caracteres)
devuelva una dirección de correo electrónico con el siguiente formato:

- El primer carácter del parámetro nombre.
- Los tres primeros caracteres del parámetro apellido1.
- Los tres primeros caracteres del parámetro apellido2.
- El carácter @.
- El dominio pasado como parámetro.
- La dirección de email debe estar en minúsculas.
También deberá crear una función llamada eliminar_acentos que reciba una cadena de caracteres y devuelva la misma cadena sin acentos. La función tendrá que reemplazar todas las vocales que tengan acento por la misma vocal pero sin acento. Por ejemplo, si la función recibe como parámetro de entrada la cadena María la función debe devolver la cadena Maria.

- Función: eliminar_acentos
- Entrada:
	- cadena (cadena de caracteres)
- Salida:
	- (cadena de caracteres)
El procedimiento crear_email deberá hacer uso de la función eliminar_acentos.

Una vez creada la tabla escriba un trigger con las siguientes características:

- Trigger: trigger_crear_email_before_insert
	- Se ejecuta sobre la tabla alumnos.
	- Se ejecuta antes de una operación de inserción.
	- Si el nuevo valor del email que se quiere insertar es NULL, entonces se le creará automáticamente una dirección de email y se insertará en la tabla.
	- Si el nuevo valor del email no es NULL se guardará en la tabla el valor del email.*/

DROP DATABASE IF EXISTS test_triggers_2;
CREATE DATABASE test_triggers_2;
USE test_triggers_2;

CREATE TABLE alumnos (
id INT PRIMARY KEY,
nombre VARCHAR(50),
apellido1 VARCHAR(50), 
apellido2 VARCHAR(50),
email VARCHAR(100)
);

CREATE TABLE log_cambios_email (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_alumno INT,
    fecha_hora DATETIME,
    old_email VARCHAR(255),
    new_email VARCHAR(255)
);

CREATE TABLE log_alumnos_eliminados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_alumno INT,
    fecha_hora DATETIME,
    nombre VARCHAR(255),
    apellido1 VARCHAR(255),
    apellido2 VARCHAR(255),
    email VARCHAR(255)
);

DELIMITER $$

CREATE PROCEDURE crear_email(
    IN nombre VARCHAR(50),
    IN apellido1 VARCHAR(50),
    IN apellido2 VARCHAR(50),
    IN dominio VARCHAR(100),
    OUT email VARCHAR(200)
)
BEGIN

    DECLARE nom VARCHAR(50);
    DECLARE ape1 VARCHAR(50);
    DECLARE ape2 VARCHAR(50);

    -- Eliminar acentos de cada parte
    SET nom = eliminar_acentos(nombre);
    SET ape1 = eliminar_acentos(apellido1);
    SET ape2 = eliminar_acentos(apellido2);
    
    SET email = LOWER(
        CONCAT(
            LEFT(nom, 1),
            LEFT(ape1, 3),
            LEFT(ape2, 3),
            '@',
            dominio
        )
    );
END;
$$

CREATE FUNCTION eliminar_acentos(cadena VARCHAR(255))
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    SET cadena = REPLACE(cadena, 'á', 'a');
    SET cadena = REPLACE(cadena, 'é', 'e');
    SET cadena = REPLACE(cadena, 'í', 'i');
    SET cadena = REPLACE(cadena, 'ó', 'o');
    SET cadena = REPLACE(cadena, 'ú', 'u');
    
    SET cadena = REPLACE(cadena, 'Á', 'A');
    SET cadena = REPLACE(cadena, 'É', 'E');
    SET cadena = REPLACE(cadena, 'Í', 'I');
    SET cadena = REPLACE(cadena, 'Ó', 'O');
    SET cadena = REPLACE(cadena, 'Ú', 'U');
    RETURN cadena;
END;
$$

CREATE TRIGGER trigger_crear_email_before_insert
BEFORE INSERT ON alumnos
FOR EACH ROW
BEGIN
    -- Solo si el email es NULL
    IF NEW.email IS NULL THEN
        CALL crear_email(
            NEW.nombre,
            NEW.apellido1,
            NEW.apellido2,
            'iesgrancapitan.es',
            NEW.email
        );
    END IF;
END$$

/* 3. Modifica el ejercicio anterior y añade un nuevo trigger que las siguientes características:

Trigger: trigger_guardar_email_after_update:

Se ejecuta sobre la tabla alumnos.
Se ejecuta después de una operación de actualización.
Cada vez que un alumno modifique su dirección de email se deberá insertar un nuevo registro en una tabla llamada log_cambios_email.
La tabla log_cambios_email contiene los siguientes campos:

id: clave primaria (entero autonumérico)
id_alumno: id del alumno (entero)
fecha_hora: marca de tiempo con el instante del cambio (fecha y hora)
old_email: valor anterior del email (cadena de caracteres)
new_email: nuevo valor con el que se ha actualizado */

CREATE TRIGGER trigger_guardar_email_after_update
AFTER UPDATE ON alumnos
FOR EACH ROW
BEGIN
    IF OLD.email <> NEW.email THEN
        INSERT INTO log_cambios_email (id_alumno, fecha_hora, old_email, new_email)
        VALUES (OLD.id, NOW(), OLD.email, NEW.email);
    END IF;
END$$

/* 4. Modifica el ejercicio anterior y añade un nuevo trigger que tenga las siguientes características:

Trigger: trigger_guardar_alumnos_eliminados:

Se ejecuta sobre la tabla alumnos.
Se ejecuta después de una operación de borrado.
Cada vez que se elimine un alumno de la tabla alumnos se deberá insertar un nuevo registro en una tabla llamada log_alumnos_eliminados.
La tabla log_alumnos_eliminados contiene los siguientes campos:

id: clave primaria (entero autonumérico)
id_alumno: id del alumno (entero)
fecha_hora: marca de tiempo con el instante del cambio (fecha y hora)
nombre: nombre del alumno eliminado (cadena de caracteres)
apellido1: primer apellido del alumno eliminado (cadena de caracteres)
apellido2: segundo apellido del alumno eliminado (cadena de caracteres)
email: email del alumno eliminado (cadena de caracteres) */

CREATE TRIGGER trigger_guardar_alumnos_eliminados
AFTER DELETE ON alumnos
FOR EACH ROW
BEGIN
    INSERT INTO log_alumnos_eliminados (id_alumno, fecha_hora, nombre, apellido1, apellido2, email)
    VALUES (OLD.id, NOW(), OLD.nombre, OLD.apellido1, OLD.apellido2, OLD.email);
END$$


DELIMITER ; 

INSERT INTO alumnos (id, nombre, apellido1, apellido2)
VALUES (1, 'María', 'García', 'Pérez');

INSERT INTO alumnos (id, nombre, apellido1, apellido2)
VALUES (2, 'Antonio', 'González', 'Álvarez');

INSERT INTO alumnos (id, nombre, apellido1, apellido2)
VALUES (3, 'Natalia', 'Pérez', 'Fernández');

INSERT INTO alumnos (id, nombre, apellido1, apellido2, email)
VALUES (4, 'Diego', 'Ruiz', 'Morales', "diego.ruiz@cordoba.com");

UPDATE alumnos SET email = 'mgarper@example.com' WHERE id = 1;
UPDATE alumnos SET email = 'dieguito@example.com' WHERE id = 4;

DELETE FROM alumnos WHERE id = 2;
DELETE FROM alumnos WHERE id = 3;

SELECT * FROM alumnos;

SELECT * FROM log_alumnos_eliminados;

SELECT * FROM log_cambios_email;
