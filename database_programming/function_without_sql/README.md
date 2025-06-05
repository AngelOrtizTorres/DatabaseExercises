# Funciones sin sentencias SQL

Aquí puedes acceder al archivo sql donde están todos estos ejercicios: [function_without_sql](function_without_sql.sql)

**1. Escribe una función que reciba un número entero de entrada y devuelva TRUE si el número es par o FALSE en caso contrario.**

```sql
DELIMITER $$

CREATE FUNCTION es_par(numero INT) RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    RETURN (MOD(numero, 2) = 0);
END $$
```



**2. Escribe una función que devuelva el valor de la hipotenusa de un triángulo a partir de los valores de sus lados.**

```sql
CREATE FUNCTION hipotenusa(cateto1 DOUBLE, cateto2 DOUBLE) RETURNS DOUBLE
DETERMINISTIC
BEGIN
    RETURN SQRT(POW(cateto1, 2) + POW(cateto2, 2));
END $$
```



**3. Escribe una función que reciba como parámetro de entrada un valor numérico que represente un día de la semana y que devuelva una cadena de caracteres con el nombre del día de la semana correspondiente. Por ejemplo, para el valor de entrada 1 debería devolver la cadena lunes.**

```sql
CREATE FUNCTION nombre_dia(numero INT) RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
    CASE numero
        WHEN 1 THEN RETURN 'Lunes';
        WHEN 2 THEN RETURN 'Martes';
        WHEN 3 THEN RETURN 'Miércoles';
        WHEN 4 THEN RETURN 'Jueves';
        WHEN 5 THEN RETURN 'Viernes';
        WHEN 6 THEN RETURN 'Sábado';
        WHEN 7 THEN RETURN 'Domingo';
        ELSE RETURN 'Inválido';
    END CASE;
END $$
```



**4. Escribe una función que reciba tres números reales como parámetros de entrada y devuelva el mayor de los tres.**

```sql
CREATE FUNCTION maximo_de_tres(a DOUBLE, b DOUBLE, c DOUBLE) RETURNS DOUBLE
DETERMINISTIC
BEGIN
    RETURN GREATEST(a, b, c);
END $$
```



**5. Escribe una función que devuelva el valor del área de un círculo a partir del valor del radio que se recibirá como parámetro de entrada.**

```sql
CREATE FUNCTION area_circulo(radio DOUBLE) RETURNS DOUBLE
DETERMINISTIC
BEGIN
    RETURN PI() * POW(radio, 2);
END $$
```



**6. Escribe una función que devuelva como salida el número de años que han transcurrido entre dos fechas que se reciben como parámetros de entrada. Por ejemplo, si pasamos como parámetros de entrada las fechas 2018-01-01 y 2008-01-01 la función tiene que devolver que han pasado 10 años.**

**Para realizar esta función puede hacer uso de las siguientes funciones que nos proporciona MySQL:**

- **DATEDIFF**
- **TRUNCATE**

```sql
CREATE FUNCTION anos_entre(f1 DATE, f2 DATE) RETURNS INT
DETERMINISTIC
BEGIN
    RETURN TRUNCATE(DATEDIFF(f1, f2) / 365, 0);
END $$
```



**7. Escribe una función que reciba una cadena de entrada y devuelva la misma cadena pero sin acentos. La función tendrá que reemplazar todas las vocales que tengan acento por la misma vocal pero sin acento. Por ejemplo, si la función recibe como parámetro de entrada la cadena María la función debe devolver la cadena Maria.**

```sql
CREATE FUNCTION quitar_acentos(cadena VARCHAR(255)) RETURNS VARCHAR(255)
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
END $$
```


