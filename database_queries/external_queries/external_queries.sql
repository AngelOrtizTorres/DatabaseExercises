-- Autor: Ángel Ortiz Torres

-- 1. Listar todas las ventas, incluyendo aquellas que no tienen un videojuego o consola asociada.
-- Usamos LEFT JOIN porque queremos todas las ventas aunque no tengan un videojuego o consola relacionada.
-- Si un videojuego o consola no existe para una venta en particular, aparecerá NULL en esos campos.
SELECT 
    v.venta_id,
    v.fecha,
    j.titulo,
    j.genero,
    j.precio,
    c.nombre AS consola
FROM
    Ventas v
        LEFT JOIN
    Videojuegos j ON v.juego_id = j.juego_id
        LEFT JOIN
    Consolas c ON v.consola_id = c.consola_id;
-- LEFT JOIN garantiza que todas las ventas se muestren, incluso si no tienen un videojuego o consola asociada.

-- 2. Mostrar todos los clientes y la cantidad de compras que han realizado (videojuegos o consolas).
-- Se usa LEFT JOIN para incluir a todos los clientes, incluso aquellos que no han realizado ninguna compra.
-- En esos casos, el conteo de compras aparecerá como 0.
SELECT 
    c.cliente_id,
    c.nombre,
    c.apellido,
    COUNT(v.venta_id) AS total_compras
FROM
    Clientes c
        LEFT JOIN
    Ventas v ON c.cliente_id = v.cliente_id
GROUP BY c.cliente_id;
-- Si un cliente no ha comprado nada, la función COUNT devuelve 0 en lugar de NULL.

-- 3. Obtener todos los videojuegos y cuántas veces han sido vendidos, ordenados por cantidad de ventas.
-- Usamos RIGHT JOIN en lugar de LEFT JOIN para asegurarnos de que todos los videojuegos aparezcan en el resultado, incluso si no han sido vendidos.
-- Cuando un videojuego no tiene ventas, COUNT(v.venta_id) devolverá 0.
SELECT 
    j.titulo, 
    j.plataforma, 
    COUNT(v.venta_id) AS total_ventas
FROM
    Ventas v
        RIGHT JOIN
    Videojuegos j ON v.juego_id = j.juego_id
GROUP BY j.juego_id
ORDER BY total_ventas DESC;
-- RIGHT JOIN prioriza la tabla Videojuegos, asegurando que todos los juegos se muestren aunque no tengan ventas.

-- 4. Mostrar todas las consolas y si han sido compradas o no.
-- Usamos LEFT JOIN porque queremos que todas las consolas aparezcan, incluso si nunca se han vendido.
SELECT 
    c.consola_id,
    c.nombre,
    c.fabricante,
    COUNT(v.venta_id) AS total_ventas
FROM
    Consolas c
        LEFT JOIN
    Ventas v ON c.consola_id = v.consola_id
GROUP BY c.consola_id;
-- Consolas sin ventas aparecerán con total_ventas = 0.

-- 5. Listar todos los clientes y los videojuegos que han comprado, incluyendo aquellos sin compras.
-- Se usa RIGHT JOIN para asegurarnos de que todos los videojuegos comprados aparezcan en la lista.
SELECT 
    c.cliente_id, 
    c.nombre, 
    c.apellido, 
    j.titulo, 
    j.genero
FROM
    Videojuegos j
        RIGHT JOIN
    Ventas v ON j.juego_id = v.juego_id
        RIGHT JOIN
    Clientes c ON v.cliente_id = c.cliente_id;
-- RIGHT JOIN garantiza que todos los videojuegos comprados aparezcan, incluso si algunos clientes no han realizado compras.

-- 6. Listar todas las ventas con el nombre del cliente asociado, incluyendo clientes que no han comprado nada.
-- Se usa RIGHT JOIN para incluir a todos los clientes, incluso si no han realizado ninguna compra.
SELECT 
    c.cliente_id, 
    c.nombre, 
    c.apellido, 
    v.venta_id, 
    v.fecha
FROM
    Ventas v
        RIGHT JOIN
    Clientes c ON v.cliente_id = c.cliente_id;
-- RIGHT JOIN prioriza los clientes, asegurando que todos se muestren aunque no tengan ventas.

-- 7. Mostrar todas las consolas y si se han vendido en alguna compra.
-- Usamos LEFT JOIN porque queremos ver todas las consolas, aunque no hayan sido vendidas.
SELECT 
    c.consola_id,
    c.nombre,
    c.precio,
    COUNT(v.venta_id) AS total_ventas
FROM
    Consolas c
        LEFT JOIN
    Ventas v ON c.consola_id = v.consola_id
GROUP BY c.consola_id;
-- Consolas sin ventas aparecerán con total_ventas = 0.

-- 8. Obtener todos los videojuegos vendidos y los clientes que los compraron.
-- Usamos RIGHT JOIN para asegurarnos de que todos los clientes aparezcan, incluso si algunos juegos no han sido comprados.
SELECT 
    c.nombre, 
    c.apellido, 
    j.titulo, 
    j.plataforma
FROM
    Videojuegos j
        RIGHT JOIN
    Ventas v ON j.juego_id = v.juego_id
        RIGHT JOIN
    Clientes c ON v.cliente_id = c.cliente_id;
-- RIGHT JOIN garantiza que todos los clientes estén en la lista, incluso si no han comprado videojuegos.

-- 9. Listar todos los videojuegos y sus ventas, asegurando que los juegos sin ventas aparezcan.
-- Se usa RIGHT JOIN en lugar de LEFT JOIN para priorizar la tabla Videojuegos y garantizar que todos se muestren.
SELECT 
    j.juego_id, 
    j.titulo, 
    COUNT(v.venta_id) AS total_ventas
FROM
    Ventas v
        RIGHT JOIN
    Videojuegos j ON v.juego_id = j.juego_id
GROUP BY j.juego_id;
-- RIGHT JOIN hace que los videojuegos siempre aparezcan en la lista, incluso si no tienen ventas.

-- 10. Mostrar el total de ventas por cliente, incluyendo aquellos que no han comprado nada.
-- Se usa LEFT JOIN para asegurarnos de que todos los clientes aparezcan, incluso si no han realizado compras.
SELECT 
    c.cliente_id,
    c.nombre,
    c.apellido,
    COUNT(v.venta_id) AS total_ventas
FROM
    Clientes c
        LEFT JOIN
    Ventas v ON c.cliente_id = v.cliente_id
GROUP BY c.cliente_id
ORDER BY total_ventas DESC;
-- Los clientes sin compras aparecerán con total_ventas = 0.