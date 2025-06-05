# Triggers

Aquí puedes acceder al archivo sql donde está el ejercicio 1: [ARCHIVO EJERCICIO 1](triggers.sql)

Aquí puedes acceder al archivo sql donde están todos los demás: [ARCHIVO EJERCICIOS 2, 3, 4](triggers_2.sql)

**1. Crea una base de datos llamada test que contenga una tabla llamada alumnos con las siguientes columnas.**
**Tabla alumnos:**

- **id (entero sin signo)**
- **nombre (cadena de caracteres)**
- **apellido1 (cadena de caracteres)**
- **apellido2 (cadena de caracteres)**
- **nota (número real)**

**Una vez creada la tabla escriba dos triggers con las siguientes características:**

**Trigger 1: trigger_check_nota_before_insert**
- **Se ejecuta sobre la tabla alumnos.**
- **Se ejecuta antes de una operación de inserción.**
- **Si el nuevo valor de la nota que se quiere insertar es negativo, se guarda como 0.**
- **Si el nuevo valor de la nota que se quiere insertar es mayor que 10, se guarda como 10.**
**Trigger2 : trigger_check_nota_before_update**
- **Se ejecuta sobre la tabla alumnos.**
- **Se ejecuta antes de una operación de actualización.**
- **Si el nuevo valor de la nota que se quiere actualizar es negativo, se guarda como 0.**
- **Si el nuevo valor de la nota que se quiere actualizar es mayor que 10, se guarda como 10.**
  
**Una vez creados los triggers escriba varias sentencias de inserción y actualización sobre la tabla alumnos y verifica que los triggers se están ejecutando correctamente.**
```sql
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
END$$

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
END$$

DELIMITER ;
INSERT INTO alumnos VALUES (1, 'Pepe', 'López', 'López', -1);
INSERT INTO alumnos VALUES (2, 'María', 'Sánchez', 'Sánchez', 11);
INSERT INTO alumnos VALUES (3, 'Juan', 'Pérez', 'Pérez', 8.5);

SELECT * FROM alumnos;

UPDATE alumnos SET nota = -4 WHERE id = 3;
UPDATE alumnos SET nota = 14 WHERE id = 3;
UPDATE alumnos SET nota = 9.5 WHERE id = 3;

SELECT * FROM alumnos;
```

**2. Crea una base de datos llamada test que contenga una tabla llamada alumnos con las siguientes columnas.**
**Tabla alumnos:**

- **id (entero sin signo)**
- **nombre (cadena de caracteres)**
- **apellido1 (cadena de caracteres)**
- **apellido2 (cadena de caracteres)**
- **email (cadena de caracteres)**

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
- **La dirección de email debe estar en minúsculas.**

**También deberá crear una función llamada eliminar_acentos que reciba una cadena de caracteres y devuelva la misma cadena sin acentos. La función tendrá que reemplazar todas las vocales que tengan acento por la misma vocal pero sin acento. Por ejemplo, si la función recibe como parámetro de entrada la cadena María la función debe devolver la cadena Maria.**

- **Función: eliminar_acentos**
- **Entrada:**
  - **cadena (cadena de caracteres)**
- **Salida:**
  - **(cadena de caracteres)**
  
**El procedimiento crear_email deberá hacer uso de la función eliminar_acentos.**

**Una vez creada la tabla escriba un trigger con las siguientes características:**

- **Trigger: trigger_crear_email_before_insert**
- **Se ejecuta sobre la tabla alumnos.**
- **Se ejecuta antes de una operación de inserción.**
- **Si el nuevo valor del email que se quiere insertar es NULL, entonces se le creará automáticamente una dirección de email y se insertará en la tabla.**
- **Si el nuevo valor del email no es NULL se guardará en la tabla el valor del email.**

```sql
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
            @email_generado
        );

        -- Asignar el valor generado al campo email
        SET NEW.email = @email_generado;
    END IF;
END$$
```

**3. Modifica el ejercicio anterior y añade un nuevo trigger que las siguientes características:**

**Trigger: trigger_guardar_email_after_update:**

- **Se ejecuta sobre la tabla alumnos.**
- **Se ejecuta después de una operación de actualización.**
- **Cada vez que un alumno modifique su dirección de email se deberá insertar un nuevo registro en una tabla llamada log_cambios_email.**

**La tabla log_cambios_email contiene los siguientes campos:**

- **id: clave primaria (entero autonumérico)**
- **id_alumno: id del alumno (entero)**
- **fecha_hora: marca de tiempo con el instante del cambio (fecha y hora)**
- **old_email: valor anterior del email (cadena de caracteres)**
- **new_email: nuevo valor con el que se ha actualizado**

```sql
CREATE TRIGGER trigger_guardar_email_after_update
AFTER UPDATE ON alumnos
FOR EACH ROW
BEGIN
    IF OLD.email <> NEW.email THEN
        INSERT INTO log_cambios_email (id_alumno, fecha_hora, old_email, new_email)
        VALUES (OLD.id, NOW(), OLD.email, NEW.email);
    END IF;
END$$
```

**4. Modifica el ejercicio anterior y añade un nuevo trigger que tenga las siguientes características:**

**Trigger: trigger_guardar_alumnos_eliminados:**

- **Se ejecuta sobre la tabla alumnos.**
- **Se ejecuta después de una operación de borrado.**
- **Cada vez que se elimine un alumno de la tabla alumnos se deberá insertar un nuevo registro en una tabla llamada log_alumnos_eliminados.**

**La tabla log_alumnos_eliminados contiene los siguientes campos:**

- **id: clave primaria (entero autonumérico)**
- **id_alumno: id del alumno (entero)**
- **fecha_hora: marca de tiempo con el instante del cambio (fecha y hora)**
- **nombre: nombre del alumno eliminado (cadena de caracteres)**
- **apellido1: primer apellido del alumno eliminado (cadena de caracteres)**
- **apellido2: segundo apellido del alumno eliminado (cadena de caracteres)**
- **email: email del alumno eliminado (cadena de caracteres)**

```sql
CREATE TRIGGER trigger_guardar_alumnos_eliminados
AFTER DELETE ON alumnos
FOR EACH ROW
BEGIN
    INSERT INTO log_alumnos_eliminados (
        id_alumno, fecha_hora, nombre, apellido1, apellido2, email
    )
    VALUES (
        OLD.id, NOW(), OLD.nombre, OLD.apellido1, OLD.apellido2, OLD.email
    );
END$$
```