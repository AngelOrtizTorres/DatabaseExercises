# A8. Cursores

Aquí puedes acceder al archivo sql donde están todos estos ejercicios: [EJERCICIOS CURSORES](cursors.sql)

**1. Escribe las sentencias SQL necesarias para crear una base de datos llamada test, una tabla llamada alumnos y 4 sentencias de inserción para inicializar la tabla. La tabla alumnos está formada por las siguientes columnas:**

- **id (entero sin signo y clave primaria)**
- **nombre (cadena de caracteres)**
- **apellido1 (cadena de caracteres)**
- **apellido2 (cadena de caracteres)**
- **fecha_nacimiento (fecha)**

**Una vez creada la tabla se decide añadir una nueva columna a la tabla llamada edad que será un valor calculado a partir de la columna fecha_nacimiento. Escriba la sentencia SQL necesaria para modificar la tabla y añadir la nueva columna.**

**Escriba una función llamada calcular_edad que reciba una fecha y devuelva el número de años que han pasado desde la fecha actual hasta la fecha pasada como parámetro:**

- **Función: calcular_edad**
- **Entrada: Fecha**
- **Salida: Número de años (entero)**

**Ahora escriba un procedimiento que permita calcular la edad de todos los alumnmos que ya existen en la tabla. Para esto será necesario crear un procedimiento llamado actualizar_columna_edad que calcule la edad de cada alumno y actualice la tabla. Este procedimiento hará uso de la función calcular_edad que hemos creado en el paso anterior.**

```sql
-- Crear base de datos
DROP DATABASE IF EXISTS test_cursores;
CREATE DATABASE test_cursores;
USE test_cursores;

-- Crear tabla alumnos
CREATE TABLE alumnos (
    id INT UNSIGNED PRIMARY KEY,
    nombre VARCHAR(100),
    apellido1 VARCHAR(100),
    apellido2 VARCHAR(100),
    fecha_nacimiento DATE
);

-- Insertar datos de ejemplo
INSERT INTO alumnos (id, nombre, apellido1, apellido2, fecha_nacimiento) VALUES
(1, 'Ana', 'Gómez', 'López', '2000-05-10'),
(2, 'Carlos', 'Pérez', 'Santos', '1998-12-15'),
(3, 'Lucía', 'Martínez', 'Díaz', '2003-03-22'),
(4, 'Diego', 'Ruiz', 'Morales', '1995-09-01');

ALTER TABLE alumnos ADD COLUMN edad INT;

DELIMITER $$

CREATE FUNCTION calcular_edad(fecha DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE edad INT;
    SET edad = TIMESTAMPDIFF(YEAR, fecha, CURDATE());
    RETURN edad;
END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE actualizar_columna_edad()
BEGIN
    -- Variables para el cursor
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_id INT;
    DECLARE v_fecha DATE;

    -- Cursor para recorrer alumnos
    DECLARE cur CURSOR FOR
        SELECT id, fecha_nacimiento FROM alumnos;

    -- Controlador de fin de datos
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Abrir cursor
    OPEN cur;

    -- Bucle de recorrido
    read_loop: LOOP
        FETCH cur INTO v_id, v_fecha;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Actualizar edad
        UPDATE alumnos
        SET edad = calcular_edad(v_fecha)
        WHERE id = v_id;
    END LOOP;

    -- Cerrar cursor
    CLOSE cur;
END$$

DELIMITER ;
```

**2. Modifica la tabla alumnos del ejercicio anterior para añadir una nueva columna email. Una vez que hemos modificado la tabla necesitamos asignarle una dirección de correo electrónico de forma automática.**

**Escriba un procedimiento llamado crear_email que dados los parámetros de entrada: nombre, apellido1, apellido2 y dominio, cree una dirección de email y la devuelva como salida.**

- **Procedimiento: crear_email**
- **Entrada:**
- **nombre (cadena de caracteres)**
- **apellido1 (cadena de caracteres)**
- **apellido2 (cadena de caracteres)**
- **dominio (cadena de caracteres)**
- **Salida:**
- **email (cadena de caracteres)**

**devuelva una dirección de correo electrónico con el siguiente formato:**

- **El primer carácter del parámetro nombre.**
- **Los tres primeros caracteres del parámetro apellido1.**
- **Los tres primeros caracteres del parámetro apellido2.**
- **El carácter @.**
- **El dominio pasado como parámetro.**

**Ahora escriba un procedimiento que permita crear un email para todos los alumnmos que ya existen en la tabla. Para esto será necesario crear un procedimiento llamado actualizar_columna_email que actualice la columna email de la tabla alumnos. Este procedimiento hará uso del procedimiento crear_email que hemos creado en el paso anterior.**

```sql
DELIMITER $$

CREATE PROCEDURE crear_lista_emails_alumnos(OUT lista_emails TEXT)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_email VARCHAR(255);
    DECLARE tmp_lista TEXT DEFAULT '';

    -- Cursor para recorrer emails
    DECLARE cur CURSOR FOR
        SELECT email FROM alumnos WHERE email IS NOT NULL;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO v_email;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Concatenar emails con ;
        IF tmp_lista = '' THEN
            SET tmp_lista = v_email;
        ELSE
            SET tmp_lista = CONCAT(tmp_lista, ';', v_email);
        END IF;
    END LOOP;

    CLOSE cur;

    SET lista_emails = tmp_lista;
END$$

DELIMITER ;
```

**3. Escribe un procedimiento llamado crear_lista_emails_alumnos que devuelva la lista de emails de la tabla alumnos separados por un punto y coma. Ejemplo: juan@iescelia.org;maria@iescelia.org;pepe@iescelia.org;lucia@iescelia.org.**

```sql
DELIMITER $$

CREATE PROCEDURE crear_lista_emails_alumnos(OUT lista_emails TEXT)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_email VARCHAR(255);
    DECLARE tmp_lista TEXT DEFAULT '';

    -- Cursor para recorrer emails
    DECLARE cur CURSOR FOR
        SELECT email FROM alumnos WHERE email IS NOT NULL;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO v_email;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Concatenar emails con ;
        IF tmp_lista = '' THEN
            SET tmp_lista = v_email;
        ELSE
            SET tmp_lista = CONCAT(tmp_lista, ';', v_email);
        END IF;
    END LOOP;

    CLOSE cur;

    SET lista_emails = tmp_lista;
END$$

DELIMITER ;
```