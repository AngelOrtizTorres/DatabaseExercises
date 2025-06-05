-- Funciones con sentencias SQL

USE tienda_funciones;

-- 1. Función que devuelve el número total de productos en la tabla productos
DELIMITER $$
CREATE FUNCTION total_productos() 
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM productos;
    RETURN total;
END $$

-- 2. Función que devuelve el precio medio de productos de un fabricante dado por nombre
CREATE FUNCTION precio_medio_fabricante(nombre_fabricante VARCHAR(100)) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE promedio DECIMAL(10,2);
    SELECT AVG(p.precio) INTO promedio
    FROM productos p
    JOIN fabricantes f ON p.codigo_fabricante = f.codigo
    WHERE f.nombre = nombre_fabricante;
    RETURN promedio;
END $$

-- 3. Función que devuelve el precio máximo de productos de un fabricante dado por nombre
CREATE FUNCTION precio_maximo_fabricante(nombre_fabricante VARCHAR(100)) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE maximo DECIMAL(10,2);
    SELECT MAX(p.precio) INTO maximo
    FROM productos p
    JOIN fabricantes f ON p.codigo_fabricante = f.codigo
    WHERE f.nombre = nombre_fabricante;
    RETURN maximo;
END $$

-- 4. Función que devuelve el precio mínimo de productos de un fabricante dado por nombre
CREATE FUNCTION precio_minimo_fabricante(nombre_fabricante VARCHAR(100)) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE minimo DECIMAL(10,2);
    SELECT MIN(p.precio) INTO minimo
    FROM productos p
    JOIN fabricantes f ON p.codigo_fabricante = f.codigo
    WHERE f.nombre = nombre_fabricante;
    RETURN minimo;
END $$

DELIMITER ; 

SELECT 
    total_productos() AS total_productos,
    precio_medio_fabricante('Samsung') AS precio_medio_samsung,
    precio_maximo_fabricante('Apple') AS precio_maximo_apple,
    precio_minimo_fabricante('Sony') AS precio_minimo_sony;
