-- Autor: Ángel Ortiz Torres

-- 1. Obtener el número total de alquileres por cliente
SELECT 
    customer_id,
    c.first_name,
    c.last_name,
    (SELECT 
            COUNT(*)
        FROM
            rental r
        WHERE
            r.customer_id = c.customer_id) AS total_alquileres
FROM
    customer c;

-- 2. Clientes que han realizado al menos 10 alquileres
SELECT 
    customer_id, first_name, last_name
FROM
    customer c
WHERE
    (SELECT 
            COUNT(*)
        FROM
            rental r
        WHERE
            r.customer_id = c.customer_id) >= 10;

-- 3. Listado de películas con su número de alquileres
SELECT 
    film_id,
    title,
    (SELECT 
            COUNT(*)
        FROM
            inventory i
                JOIN
            rental r ON i.inventory_id = r.inventory_id
        WHERE
            i.film_id = f.film_id) AS total_alquileres
FROM
    film f;

-- 4. Películas más largas que el promedio de su categoría
SELECT 
    title, length, category.name AS category
FROM
    film f
        JOIN
    film_category fc ON f.film_id = fc.film_id
        JOIN
    category ON fc.category_id = category.category_id
WHERE
    f.length > (SELECT 
            AVG(f2.length)
        FROM
            film f2
                JOIN
            film_category fc2 ON f2.film_id = fc2.film_id
        WHERE
            fc2.category_id = fc.category_id);

-- 5. Actores que han trabajado en alguna película
SELECT 
    actor_id, first_name, last_name
FROM
    actor
WHERE
    actor_id IN (SELECT DISTINCT
            actor_id
        FROM
            film_actor);

-- 6. Películas que no han sido alquiladas nunca
SELECT 
    title
FROM
    film
WHERE
    film_id NOT IN (SELECT 
            i.film_id
        FROM
            inventory i
                JOIN
            rental r ON i.inventory_id = r.inventory_id);

-- 7. Clientes con alquileres en la tienda 1
SELECT DISTINCT
    c.customer_id, c.first_name, c.last_name
FROM
    customer c
WHERE
    c.customer_id IN (SELECT 
            r.customer_id
        FROM
            rental r
                JOIN
            inventory i ON r.inventory_id = i.inventory_id
        WHERE
            i.store_id = 1);

-- 8. Categoría más popular (por número de alquileres)
SELECT 
    name
FROM
    category
WHERE
    category_id = (SELECT 
            fc.category_id
        FROM
            film_category fc
                JOIN
            inventory i ON fc.film_id = i.film_id
                JOIN
            rental r ON i.inventory_id = r.inventory_id
        GROUP BY fc.category_id
        ORDER BY COUNT(*) DESC
        LIMIT 1);

-- 9. Películas más largas que todas las películas de animación
SELECT 
    title, length
FROM
    film
WHERE
    length > ALL (SELECT 
            f.length
        FROM
            film f
                JOIN
            film_category fc ON f.film_id = fc.film_id
                JOIN
            category c ON fc.category_id = c.category_id
        WHERE
            c.name = 'Animation');

-- 10. Películas alquiladas por el cliente 'MARIA SMITH'
SELECT 
    title
FROM
    film
WHERE
    film_id IN (SELECT 
            film_id
        FROM
            inventory
        WHERE
            inventory_id IN (SELECT 
                    inventory_id
                FROM
                    rental
                WHERE
                    customer_id = (SELECT 
                            customer_id
                        FROM
                            customer
                        WHERE
                            first_name = 'MARY'
                                AND last_name = 'SMITH')));
