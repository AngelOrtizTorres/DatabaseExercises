# Consultas en Sakila

> [!Important]
>Para poder realizar los ejercicios que expongo necesitas tener instalada la bbdd de sakila.
>
>Descarga los archivos desde la página oficial de MySQL: https://dev.mysql.com/doc/sakila/en/sakila-installation.html
> 
>Descarga los archivos:
>
>`sakila-schema.sql` → Crea la estructura de la base de >datos. 
>
>`sakila-data.sql` → Inserta los datos en las tablas.

Aquí puedes acceder al archivo sql donde están todos estos ejercicios: [sakila_exercises.sql](sakila_exercises.sql)

## EJERCICIOS SIMPLES

**1. Obtener las películas alquiladas por un cliente específico.**
```sql
SELECT 
    c.customer_id, c.first_name, c.last_name, f.title
FROM
    rental r
        JOIN
    customer c ON r.customer_id = c.customer_id
        JOIN
    inventory i ON r.inventory_id = i.inventory_id
        JOIN
    film f ON i.film_id = f.film_id
WHERE
    c.customer_id = 1;
```
**2. Ver los clientes registrados.**
```sql
SELECT 
    customer_id, first_name, last_name
FROM
    customer
LIMIT 5;
```
**3. Ver las primeras películas disponibles**
```sql
SELECT 
    *
FROM
    film
LIMIT 10;
```
**4. Cuántas tablas hay en la base de datos**
```sql
SELECT 
    COUNT(*)
FROM
    information_schema.tables
WHERE
    table_schema = 'sakila';
```
**5. Cuántas claves foráneas hay en la base de datos**
```sql
SELECT 
    COUNT(*)
FROM
    information_schema.key_column_usage
WHERE
    table_schema = 'sakila'
        AND referenced_table_name IS NOT NULL;
```
**6. ¿Cuántas películas hay en la tabla film?**
```sql
SELECT 
    COUNT(*)
FROM
    film;
```
**7. ¿Cuántos clientes hay en la base de datos?**
```sql
SELECT 
    COUNT(*)
FROM
    customer;
```
**8. Encuentra las 5 películas más alquiladas.**
```sql
SELECT 
    f.title, COUNT(*) AS rentals
FROM
    rental r
        JOIN
    inventory i ON r.inventory_id = i.inventory_id
        JOIN
    film f ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY rentals DESC
LIMIT 5;
```

## EJERCICIOS MULTITABLAS

**1. Lista el título de cada película, su duración (rental_duration) y el nombre de su idioma.**
```sql
SELECT 
    f.title, f.rental_duration, l.name
FROM
    film f
        JOIN
    language l ON f.language_id = l.language_id;
```
**2. Lista el título de cada película, su duración y el nombre de su idioma, ordenado por idioma alfabéticamente.**
```sql
SELECT 
    f.title, f.rental_duration, l.name
FROM
    film f
        JOIN
    language l ON f.language_id = l.language_id
ORDER BY l.name;
```
**3. Lista el ID de la película, su título, el ID del idioma y el nombre del idioma.**
```sql
SELECT 
    f.film_id, f.title, l.language_id, l.name
FROM
    film f
        JOIN
    language l ON f.language_id = l.language_id;
```
**4. Devuelve el título, la duración y el nombre del idioma de la película con menor duración de alquiler.**
```sql
SELECT 
    f.title, f.rental_duration, l.name
FROM
    film f
        JOIN
    language l ON f.language_id = l.language_id
ORDER BY f.rental_duration ASC
LIMIT 1;
```
**5. Devuelve el título, la duración y el nombre del idioma de la película con mayor duración de alquiler.**
```sql
SELECT 
    f.title, f.rental_duration, l.name
FROM
    film f
        JOIN
    language l ON f.language_id = l.language_id
ORDER BY f.rental_duration DESC
LIMIT 1;
```
**6. Lista todas las películas de la categoría "Comedy".**
```sql
SELECT 
    f.title
FROM
    film f
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
WHERE
    c.name = 'Comedy';
```
**7. Lista todas las películas de la categoría "Action" con una duración de alquiler mayor que 5 días.**
```sql
SELECT 
    f.title, f.rental_duration
FROM
    film f
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
WHERE
    c.name = 'Action'
    AND f.rental_duration > 5;
```
**8. Lista todas las películas de las categorías "Horror", "Drama" y "Documentary" (sin usar IN).**
```sql
SELECT 
    f.title
FROM
    film f
        JOIN
    film_category fc ON f.film_id = fc.film_id
        JOIN
    category c ON fc.category_id = c.category_id
WHERE
    c.name = 'Horror' OR c.name = 'Drama'
        OR c.name = 'Documentary';
```
**9. Lista todas las películas de las categorías "Horror", "Drama" y "Documentary" (usando IN).**
```sql
SELECT 
    f.title
FROM
    film f
        JOIN
    film_category fc ON f.film_id = fc.film_id
        JOIN
    category c ON fc.category_id = c.category_id
WHERE
    c.name IN ('Horror' , 'Drama', 'Documentary');
```
**10. Lista las películas y su duración de alquiler, cuyo idioma termine con la letra "h".**
```sql
SELECT 
    f.title, f.rental_duration
FROM
    film f
        JOIN
    language l ON f.language_id = l.language_id
WHERE
    l.name LIKE '%h';
```
**11. Lista las películas y su duración de alquiler cuyo idioma contenga la letra "a".**
```sql
SELECT 
    f.title, f.rental_duration
FROM
    film f
        JOIN
    language l ON f.language_id = l.language_id
WHERE
    l.name LIKE '%a%';
```
**12. Lista título, duración y nombre del idioma de las películas con una duración mayor o igual a 7 días, ordenadas por duración descendente y luego por título ascendente.**
```sql
SELECT 
    f.title, f.rental_duration, l.name
FROM
    film f
        JOIN
    language l ON f.language_id = l.language_id
WHERE
    f.rental_duration >= 7
ORDER BY f.rental_duration DESC , f.title ASC;
```
**13. Lista el ID y nombre de todas las categorías que tienen películas asociadas.**
```sql
SELECT DISTINCT
    c.category_id, c.name
FROM
    category c
        JOIN
    film_category fc ON c.category_id = fc.category_id;
```