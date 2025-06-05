-- Autor: Ángel Ortiz Torres

USE procedimientos;

/* 1. Escribe un procedimiento que reciba el nombre de un país como parámetro de entrada y realice una consulta sobre la 
tabla cliente para obtener todos los clientes que existen en la tabla de ese país. */
DELIMITER $$
CREATE PROCEDURE obtener_clientes_por_pais(IN sel_pais VARCHAR(50))
BEGIN
    SELECT * FROM cliente
    WHERE pais = sel_pais;
END $$

/* 2. Escribe un procedimiento que reciba como parámetro de entrada una forma de pago, que será una cadena de caracteres 
(Ejemplo: PayPal, Transferencia, etc). Y devuelva como salida el pago de máximo valor realizado para esa forma de pago. 
Deberá hacer uso de la tabla pago de la base de datos jardineria. */
CREATE PROCEDURE pago_maximo_por_forma(IN sel_formaPago VARCHAR(50))
BEGIN
    SELECT * FROM pago
    WHERE formaPago = sel_formaPago
    ORDER BY total DESC
    LIMIT 1;
END $$

/* 3. Escribe un procedimiento que reciba como parámetro de entrada una forma de pago, que será una cadena de caracteres 
(Ejemplo: PayPal, Transferencia, etc). Y devuelva como salida los siguientes valores teniendo en cuenta la forma de pago 
seleccionada como parámetro de entrada:

- el pago de máximo valor,

- el pago de mínimo valor,

- el valor medio de los pagos realizados,

- la suma de todos los pagos,

- el número de pagos realizados para esa forma de pago.

Deberá hacer uso de la tabla pago de la base de datos jardineria. */
CREATE PROCEDURE estadisticas_pago(IN selec_formaPago VARCHAR(50))
BEGIN
    SELECT 
        MAX(total) AS pago_maximo,
        MIN(total) AS pago_minimo,
        AVG(total) AS pago_promedio,
        SUM(total) AS suma_total,
        COUNT(*) AS numero_pagos
    FROM pago
    WHERE formaPago = selec_formaPago;
END $$

/* 4. Crea una base de datos llamada procedimientos que contenga una tabla llamada cuadrados. La tabla cuadrados debe tener dos 
columnas de tipo INT UNSIGNED, una columna llamada número y otra columna llamada cuadrado.

Una vez creada la base de datos y la tabla deberá crear un procedimiento llamado calcular_cuadrados con las siguientes 
características. El procedimiento recibe un parámetro de entrada llamado tope de tipo INT UNSIGNED y calculará el valor de los 
cuadrados de los primeros números naturales hasta el valor introducido como parámetro. El valor del números y de sus cuadrados 
deberán ser almacenados en la tabla cuadrados que hemos creado previamente.

Tenga en cuenta que el procedimiento deberá eliminar el contenido actual de la tabla antes de insertar los nuevos valores de 
los cuadrados que va a calcular.

Utilice un bucle WHILE para resolver el procedimiento. */
CREATE PROCEDURE calcular_cuadrados(IN tope INT UNSIGNED)
BEGIN
    DECLARE i INT UNSIGNED DEFAULT 1;
    DELETE FROM cuadrados;

    WHILE i <= tope DO
        INSERT INTO cuadrados(numero, cuadrado) VALUES(i, i * i);
        SET i = i + 1;
    END WHILE;
END $$

-- 5. Utilice un bucle REPEAT para resolver el procedimiento del ejercicio anterior.
CREATE PROCEDURE calcular_cuadrados_repeat(IN tope INT UNSIGNED)
BEGIN
    DECLARE i INT UNSIGNED DEFAULT 1;
    DELETE FROM cuadrados;

    REPEAT
        INSERT INTO cuadrados(numero, cuadrado) VALUES(i, i * i);
        SET i = i + 1;
    UNTIL i > tope
    END REPEAT;
END $$

-- 6. Utilice un bucle LOOP para resolver el procedimiento del ejercicio anterior.
CREATE PROCEDURE calcular_cuadrados_loop(IN tope INT UNSIGNED)
BEGIN
    DECLARE i INT UNSIGNED DEFAULT 1;
    DELETE FROM cuadrados;

    mi_loop: LOOP
        IF i > tope THEN
            LEAVE mi_loop;
        END IF;
        INSERT INTO cuadrados(numero, cuadrado) VALUES(i, i * i);
        SET i = i + 1;
    END LOOP mi_loop;
END $$

/* 7. Crea una base de datos llamada procedimientos que contenga una tabla llamada ejercicio. La tabla debe tener una única columna 
llamada número y el tipo de dato de esta columna debe ser INT UNSIGNED.

Una vez creada la base de datos y la tabla deberá crear un procedimiento llamado calcular_números con las siguientes características. 
El procedimiento recibe un parámetro de entrada llamado valor_inicial de tipo INT UNSIGNED y deberá almacenar en la tabla ejercicio 
toda la secuencia de números desde el valor inicial pasado como entrada hasta el 1.

Tenga en cuenta que el procedimiento deberá eliminar el contenido actual de las tablas antes de insertar los nuevos valores.

Utilice un bucle WHILE para resolver el procedimiento. */
CREATE PROCEDURE calcular_numeros(IN valor_inicial INT UNSIGNED)
BEGIN
    DECLARE i INT UNSIGNED;
    SET i = valor_inicial;
    DELETE FROM ejercicio;

    WHILE i >= 1 DO
        INSERT INTO ejercicio(numero) VALUES(i);
        SET i = i - 1;
    END WHILE;
END $$

-- 8. Utilice un bucle REPEAT para resolver el procedimiento del ejercicio anterior.
CREATE PROCEDURE calcular_numeros_repeat(IN valor_inicial INT UNSIGNED)
BEGIN
    DECLARE i INT UNSIGNED;
    SET i = valor_inicial;
    DELETE FROM ejercicio;

    REPEAT
        INSERT INTO ejercicio(numero) VALUES(i);
        SET i = i - 1;
    UNTIL i < 1
    END REPEAT;
END $$

-- 9. Utilice un bucle LOOP para resolver el procedimiento del ejercicio anterior.
CREATE PROCEDURE calcular_numeros_loop(IN valor_inicial INT UNSIGNED)
BEGIN
    DECLARE i INT UNSIGNED;
    SET i = valor_inicial;
    DELETE FROM ejercicio;

    mi_loop: LOOP
        IF i < 1 THEN
            LEAVE mi_loop;
        END IF;
        INSERT INTO ejercicio(numero) VALUES(i);
        SET i = i - 1;
    END LOOP mi_loop;
END $$

/* 10. Crea una base de datos llamada procedimientos que contenga una tabla llamada pares y otra tabla llamada impares. Las dos tablas deben tener única columna llamada número y el tipo de dato de esta columna debe ser INT UNSIGNED.**

Una vez creada la base de datos y las tablas deberá crear un procedimiento llamado calcular_pares_impares con las siguientes 
características. El procedimiento recibe un parámetro de entrada llamado tope de tipo INT UNSIGNED y deberá almacenar en la tabla 
pares aquellos números pares que existan entre el número 1 el valor introducido como parámetro. Habrá que realizar la misma 
operación para almacenar los números impares en la tabla impares.
Tenga en cuenta que el procedimiento deberá eliminar el contenido actual de las tablas antes de insertar los nuevos valores.
Utilice un bucle WHILE para resolver el procedimiento. */
CREATE PROCEDURE calcular_pares_impares(IN tope INT UNSIGNED)
BEGIN
    DECLARE i INT UNSIGNED DEFAULT 1;
    DELETE FROM pares;
    DELETE FROM impares;

    WHILE i <= tope DO
        IF MOD(i, 2) = 0 THEN
            INSERT INTO pares(numero) VALUES(i);
        ELSE
            INSERT INTO impares(numero) VALUES(i);
        END IF;
        SET i = i + 1;
    END WHILE;

END $$

-- 11. Utilice un bucle REPEAT para resolver el procedimiento del ejercicio anterior.
CREATE PROCEDURE calcular_pares_impares_repeat(IN tope INT UNSIGNED)
BEGIN
    DECLARE i INT UNSIGNED DEFAULT 1;
    DELETE FROM pares;
    DELETE FROM impares;

    REPEAT
        IF MOD(i, 2) = 0 THEN
            INSERT INTO pares(numero) VALUES(i);
        ELSE
            INSERT INTO impares(numero) VALUES(i);
        END IF;
        SET i = i + 1;
    UNTIL i > tope
    END REPEAT;
END $$

-- 12. Utilice un bucle LOOP para resolver el procedimiento del ejercicio anterior.
CREATE PROCEDURE calcular_pares_impares_loop(IN tope INT UNSIGNED)
BEGIN
    DECLARE i INT UNSIGNED DEFAULT 1;
    DELETE FROM pares;
    DELETE FROM impares;

    mi_loop: LOOP
        IF i > tope THEN
            LEAVE mi_loop;
        END IF;

        IF MOD(i, 2) = 0 THEN
            INSERT INTO pares(numero) VALUES(i);
        ELSE
            INSERT INTO impares(numero) VALUES(i);
        END IF;

        SET i = i + 1;
    END LOOP mi_loop;
END $$

DELIMITER ;

-- 1. Obtener clientes por país
CALL obtener_clientes_por_pais('España');

-- 2. Pago de máximo valor por forma de pago
CALL pago_maximo_por_forma('PayPal');

-- 3. Estadísticas de pagos por forma de pago
CALL estadisticas_pago('Transferencia');

-- 4. Calcular cuadrados con WHILE
CALL calcular_cuadrados(10);

-- 7. Calcular números descendentes con WHILE
CALL calcular_numeros(10);
SELECT * FROM ejercicio;

-- 10. Calcular pares e impares con WHILE
CALL calcular_pares_impares(10);
SELECT * FROM pares;
SELECT * FROM impares;