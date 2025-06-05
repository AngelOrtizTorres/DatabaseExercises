# Funciones con sentencias SQL

Aquí puedes acceder al archivo sql donde están todos estos ejercicios: [function_with_sql](function_with_sql.sql)

Descargar archivo sql con la BBDD: [CLICK AQUÍ](bbdd_function.sql)

**1. Escribe una función para la base de datos tienda que devuelva el número total de productos que hay en la tabla productos.**

```sql
CREATE FUNCTION total_productos() 
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM productos;
    RETURN total;
END $$
```



**2. Escribe una función para la base de datos tienda que devuelva el valor medio del precio de los productos de un determinado fabricante que se recibirá como parámetro de entrada. El parámetro de entrada será el nombre del fabricante.**

```sql
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
```



**3. Escribe una función para la base de datos tienda que devuelva el valor máximo del precio de los productos de un determinado fabricante que se recibirá como parámetro de entrada. El parámetro de entrada será el nombre del fabricante.**

```sql
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
```



**4. Escribe una función para la base de datos tienda que devuelva el valor mínimo del precio de los productos de un determinado fabricante que se recibirá como parámetro de entrada. El parámetro de entrada será el nombre del fabricante.**

```sql
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
```

