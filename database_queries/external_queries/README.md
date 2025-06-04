# Consultas Externas

> [!Note]
> En este caso son consultas realizadas con LEFT JOIN e RIGHT JOIN, en cada consulta se explica el motivo del uso de uno u otro.

Descargar archivo sql con la BBDD: [CLICK AQUÍ](external_queries_bbdd.sql)

Aquí puedes acceder al archivo sql donde están todos estos ejercicios: [external_queries.sql](external_queries.sql)

---

**1. Listar todas las ventas, incluyendo aquellas que no tienen un videojuego o consola asociada.**
```sql
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
```
**2. Mostrar todos los clientes y la cantidad de compras que han realizado (videojuegos o consolas).**
```sql
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
```
**3. Obtener todos los videojuegos y cuántas veces han sido vendidos, ordenados por cantidad de ventas.**
```sql
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
```
**4. Mostrar todas las consolas y si han sido compradas o no.**
```sql
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
```
**5. Listar todos los clientes y los videojuegos que han comprado, incluyendo aquellos sin compras.**
```sql
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
```
**6. Listar todas las ventas con el nombre del cliente asociado, incluyendo clientes que no han comprado nada.**
```sql
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
```
**7. Mostrar todas las consolas y si se han vendido en alguna compra.**
```sql
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
```
**8. Obtener todos los videojuegos vendidos y los clientes que los compraron.**
```sql
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
```
**9. Listar todos los videojuegos y sus ventas, asegurando que los juegos sin ventas aparezcan.**
```sql
SELECT 
    j.juego_id, 
    j.titulo, 
    COUNT(v.venta_id) AS total_ventas
FROM
    Ventas v
        RIGHT JOIN
    Videojuegos j ON v.juego_id = j.juego_id
GROUP BY j.juego_id;
```
**10. Mostrar el total de ventas por cliente, incluyendo aquellos que no han comprado nada.**
```sql
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
```