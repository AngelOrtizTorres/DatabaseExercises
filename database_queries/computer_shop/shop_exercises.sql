-- Autor: Ángel Ortiz Torres
-- Fecha: 31/03/2025

-- 1. Lista el nombre de todos los productos que hay en la tabla producto.
SELECT 
    *
FROM
    producto;

-- 2. Lista los nombres y los precios de todos los productos de la tabla producto.
SELECT 
    nombre, precio
FROM
    producto;
    
-- 3. Lista todas las columnas de la tabla producto.
SELECT 
    *
FROM
    productos;

-- 4. Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD).
SELECT 
    nombre, precio, precio * 1.1 AS precio_usd
FROM
    productos;

-- 5. Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD). Utiliza alias para las columnas.
SELECT 
    nombre AS 'nombre de producto',
    precio AS euros,
    precio * 1.1 AS dólares
FROM
    productos;

-- 6. Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a mayúscula.
SELECT 
    UPPER(nombre) AS nombre_mayuscula, precio
FROM
    productos;

-- 7. Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a minúscula.
SELECT 
    LOWER(nombre) AS nombre_minuscula, precio
FROM
    productos;

-- 8. Lista el nombre de todos los fabricantes en una columna y en otra columna obtenga en mayúsculas los dos primeros caracteres del nombre del fabricante.
SELECT 
    nombre, UPPER(LEFT(nombre, 2)) AS 'primeros_dos_caracteres'
FROM
    fabricantes;

-- 9. Lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor del precio.
SELECT 
    nombre, ROUND(precio) AS precio_redondeado
FROM
    productos;

-- 10. Lista los nombres y los precios de todos los productos de la tabla producto, truncando el valor del precio para mostrarlo sin cifras decimales.
SELECT 
    nombre, TRUNCATE(precio, 0) AS precio_truncado
FROM
    productos;

-- 11. Lista el código de los fabricantes que tienen productos en la tabla producto.
SELECT 
    codigo_fabricante
FROM
    productos;

-- 12. Lista el código de los fabricantes que tienen productos en la tabla producto, eliminando los códigos que aparecen repetidos.
SELECT DISTINCT
    codigo_fabricante
FROM
    productos;
-- 13. Lista los nombres de los fabricantes ordenados de forma ascendente.
SELECT 
    nombre
FROM
    fabricantes
ORDER BY nombre ASC;

-- 14. Lista los nombres de los fabricantes ordenados de forma descendente.
SELECT 
    nombre
FROM
    fabricantes
ORDER BY nombre DESC;

-- 15. Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente y en segundo lugar por el precio de forma descendente.
SELECT 
    nombre, precio
FROM
    productos
ORDER BY nombre ASC , precio DESC;

-- 16. Devuelve una lista con las 5 primeras filas de la tabla fabricante.
SELECT 
    *
FROM
    fabricantes
LIMIT 5;

-- 17. Devuelve una lista con 2 filas a partir de la cuarta fila de la tabla fabricante. La cuarta fila también se debe incluir en la respuesta.
SELECT 
    *
FROM
    fabricantes
LIMIT 3 , 2;  

-- 18. Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas ORDER BY y LIMIT)
SELECT 
    nombre, precio
FROM
    productos
ORDER BY precio ASC
LIMIT 1;

-- 19. Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER BY y LIMIT)
SELECT 
    nombre, precio
FROM
    productos
ORDER BY precio DESC
LIMIT 1;

-- 20. Lista el nombre de todos los productos del fabricante cuyo código de fabricante es igual a 2.
SELECT 
    *
FROM
    producto
WHERE
    codigo_fabricante = 2;

-- 21. Lista el nombre de los productos que tienen un precio menor o igual a 120€.
SELECT 
    *
FROM
    producto
WHERE
    precio <= 120;

-- 22. Lista el nombre de los productos que tienen un precio mayor o igual a 400€.
SELECT 
    *
FROM
    producto
WHERE
    precio >= 400;

-- 23. Lista el nombre de los productos que no tienen un precio mayor o igual a 400€.
SELECT 
    *
FROM
    producto
WHERE
    NOT precio >= 400;

-- 24. Lista todos los productos que tengan un precio entre 80€ y 300€. Sin utilizar el operador BETWEEN.
SELECT 
    *
FROM
    producto
WHERE
    precio >= 80 AND precio <= 300;

-- 25. Lista todos los productos que tengan un precio entre 60€ y 200€. Utilizando el operador BETWEEN.
SELECT 
    *
FROM
    producto
WHERE
    precio BETWEEN 80 AND 300;

-- 26. Lista todos los productos que tengan un precio mayor que 200€ y que el código de fabricante sea igual a 6.
SELECT 
    *
FROM
    producto
WHERE
    precio > 200 AND codigo_fabricante = 6;

-- 27. Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Sin utilizar el operador IN.
SELECT 
    *
FROM
    producto
WHERE
    codigo_fabricante = 1
        OR codigo_fabricante = 3
        OR codigo_fabricante = 5;

-- 28. Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Utilizando el operador IN.
SELECT 
    *
FROM
    producto
WHERE
    codigo_fabricante IN (1 , 3, 5);

-- 29. Lista el nombre y el precio de los productos en céntimos.
SELECT 
    nombre, precio * 100 AS céntimos
FROM
    productos;

-- 30. Lista los nombres de los fabricantes cuyo nombre empiece por la letra S.
SELECT 
    nombre
FROM
    fabricantes
WHERE
    nombre LIKE 'S%';

-- 31. Lista los nombres de los fabricantes cuyo nombre termine por la vocal e.
SELECT 
    nombre
FROM
    fabricantes
WHERE
    nombre LIKE '%e';

-- 32. Lista los nombres de los fabricantes cuyo nombre contenga el carácter w.
SELECT 
    nombre
FROM
    fabricantes
WHERE
    nombre LIKE '%w%';

-- 33. Lista los nombres de los fabricantes cuyo nombre sea de 4 caracteres.
SELECT 
    nombre
FROM
    fabricantes
WHERE
    LENGTH(nombre) = 4;

-- 34. Devuelve una lista con el nombre de todos los productos que contienen la cadena "Portátil" en el nombre.
SELECT 
    nombre
FROM
    productos
WHERE
    nombre LIKE '%Portátil%';

-- 35. Devuelve una lista con el nombre de todos los productos que contienen la cadena "Monitor" en el nombre y tienen un precio inferior a 215 €.
SELECT 
    nombre
FROM
    productos
WHERE
    nombre LIKE '%Monitor%' AND precio < 215;

-- 36. Lista el nombre y el precio de todos los productos que tengan un precio mayor o igual a 180€. Ordene el resultado por precio (descendente) y luego por nombre (ascendente).
SELECT 
    nombre, precio
FROM
    productos
WHERE
    precio >= 180
ORDER BY precio DESC , nombre ASC;

-- 1. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos.
SELECT 
    p.nombre, p.precio, f.codigo, f.nombre
FROM
    producto p
        JOIN
    fabricante f ON p.codigo_fabricante = f.codigo;

-- 2. Lista con el nombre del producto, precio y nombre del fabricante, ordenado alfabéticamente por fabricante.
SELECT 
    p.nombre, p.precio, f.nombre
FROM
    producto p
        JOIN
    fabricante f ON p.codigo_fabricante = f.codigo
ORDER BY f.nombre;

-- 3. Lista con el código del producto, nombre del producto, código del fabricante y nombre del fabricante.
SELECT 
    p.codigo, p.nombre, f.codigo, f.nombre
FROM
    productos p
        JOIN
    fabricantes f ON p.codigo_fabricante = f.codigo;

-- 4. Producto más barato (nombre, precio y fabricante).
SELECT 
    p.nombre AS producto, p.precio, f.nombre AS fabricante
FROM
    producto p
        JOIN
    fabricante f ON p.codigo_fabricante = f.codigo
ORDER BY p.precio ASC
LIMIT 1;

-- 5. Producto más caro (nombre, precio y fabricante).
SELECT 
    p.nombre AS producto, p.precio, f.nombre AS fabricante
FROM
    producto p
        JOIN
    fabricante f ON p.codigo_fabricante = f.codigo
ORDER BY p.precio DESC
LIMIT 1;

-- 6. Todos los productos del fabricante Lenovo.
SELECT 
    p.*
FROM
    producto p
        JOIN
    fabricante f ON p.codigo_fabricante = f.codigo
WHERE
    f.nombre = 'Lenovo';

-- 7. Productos del fabricante Crucial con precio mayor a 200€.
SELECT 
    p.*
FROM
    producto p
        JOIN
    fabricante f ON p.codigo_fabricante = f.codigo
WHERE
    f.nombre = 'Crucial' AND p.precio > 200;

-- 8. Productos de Asus, Hewlett-Packard y Seagate sin usar IN.
SELECT 
    p.*
FROM
    producto p
        JOIN
    fabricante f ON p.codigo_fabricante = f.codigo
WHERE
    f.nombre = 'Asus'
        OR f.nombre = 'Hewlett-Packard'
        OR f.nombre = 'Seagate';

-- 9. Productos de Asus, Hewlett-Packard y Seagate usando IN.
SELECT 
    p.*
FROM
    producto p
        JOIN
    fabricante f ON p.codigo_fabricante = f.codigo
WHERE
    f.nombre IN ('Asus' , 'Hewlett-Packard', 'Seagate');

-- 10. Productos de fabricantes cuyo nombre termina en vocal 'e'.
SELECT 
    p.nombre, p.precio -- , f.nombre
FROM
    producto p
        JOIN
    fabricante f ON p.codigo_fabricante = f.codigo
WHERE
    f.nombre LIKE '%e';

-- 11. Productos de fabricantes que contienen la letra 'w' en su nombre.
SELECT 
    p.nombre, p.precio -- , f.nombre
FROM
    producto p
        JOIN
    fabricante f ON p.codigo_fabricante = f.codigo
WHERE
    f.nombre LIKE '%w%';

-- 12. Productos con precio mayor o igual a 180€, ordenado por precio (desc) y luego por nombre (asc).
SELECT 
    p.nombre AS producto, p.precio, f.nombre AS fabricante
FROM
    producto p
        JOIN
    fabricante f ON p.codigo_fabricante = f.codigo
WHERE
    p.precio >= 180
ORDER BY p.precio DESC, p.nombre ASC;

-- 13. Código y nombre de fabricantes que tienen productos asociados.
SELECT DISTINCT
    f.codigo, f.nombre
FROM
    fabricante f
        JOIN
    producto p ON f.codigo = p.codigo_fabricante;