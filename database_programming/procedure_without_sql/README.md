# Procedimientos sin sentencias SQL

Aquí puedes acceder al archivo sql donde están todos estos ejercicios: [procedure_without_sql](procedure_without_sql.sql)

**1. Escribe un procedimiento que no tenga ningún parámetro de entrada ni de salida y que muestre el texto ¡Hola mundo!.**

```sql
CREATE PROCEDURE saludo()
BEGIN 
	SELECT saludo = "¡HOLA MUNDO!";
END;
$$
```

**2. Escribe un procedimiento que reciba un número real de entrada y muestre un mensaje indicando si el número es positivo, negativo o cero.**

```sql
CREATE PROCEDURE real_number(IN numero INT)
BEGIN
	IF numero < 0 THEN 
		SELECT 'Negativo';
	ELSEIF numero > 0 THEN
		SELECT 'Positivo';
	ELSE 
		SELECT 'Cero';
	END IF;
END;
$$
```

**3. Modifique el procedimiento diseñado en el ejercicio anterior para que tenga un parámetro de entrada, con el valor un número real, y un parámetro de salida, con una cadena de caracteres indicando si el número es positivo, negativo o cero.**

```sql
CREATE PROCEDURE real_number(IN numero INT, OUT resultado VARCHAR(50))
BEGIN
	IF numero < 0 THEN 
		SET resultado = 'Negativo';
	ELSEIF numero > 0 THEN
		SET resultado = 'Positivo';
	ELSE 
		SET resultado = 'Cero';
	END IF;
END;
$$
```

**4. Escribe un procedimiento que reciba un número real de entrada, que representa el valor de la nota de un alumno, y muestre un mensaje indicando qué nota ha obtenido teniendo en cuenta las siguientes condiciones:**

**- [0,5) = **Insuficiente**
**- [5,6) = Aprobado**
**- [6, 7) = Bien**
**- [7, 9) = Notable**
**- [9, 10] = Sobresaliente**
**- En cualquier otro caso la nota no será válida.**

```sql
CREATE PROCEDURE calificacion_if(IN nota DECIMAL(3,1))
BEGIN
	IF nota >= 0 AND nota < 5 THEN
		SELECT 'Insuficiente';
	ELSEIF nota >= 5 AND nota < 6 THEN
		SELECT 'Aprobado';
	ELSEIF nota >= 6 AND nota < 7 THEN
		SELECT 'Bien';
	ELSEIF nota >= 7 AND nota < 9 THEN
		SELECT 'Notable';
	ELSEIF nota >= 9 AND nota <= 10 THEN
		SELECT 'Sobresaliente';
	ELSE
		SELECT 'Nota no válida';
	END IF;
END;
$$
```

**5. Modifique el procedimiento diseñado en el ejercicio anterior para que tenga un parámetro de entrada, con el valor de la nota en formato numérico y un parámetro de salida, con una cadena de texto indicando la nota correspondiente.**

```sql
CREATE PROCEDURE calificacion_if(IN nota DECIMAL(3,1), OUT resultado VARCHAR(50))
BEGIN
	IF nota >= 0 AND nota < 5 THEN
		SET resultado = 'Insuficiente';
	ELSEIF nota >= 5 AND nota < 6 THEN
		SET resultado = 'Aprobado';
	ELSEIF nota >= 6 AND nota < 7 THEN
		SET resultado = 'Bien';
	ELSEIF nota >= 7 AND nota < 9 THEN
		SET resultado = 'Notable';
	ELSEIF nota >= 9 AND nota <= 10 THEN
		SET resultado = 'Sobresaliente';
	ELSE
		SET resultado = 'Nota no válida';
	END IF;
END;
$$

```

**6. Resuelva el procedimiento diseñado en el ejercicio anterior haciendo uso de la estructura de control CASE.**

```sql
CREATE PROCEDURE calificacion_case(IN nota DECIMAL(3,1), OUT resultado VARCHAR(50))
BEGIN
	CASE 
		WHEN nota >= 0 AND nota < 5 THEN
			SET resultado = 'Insuficiente';
		WHEN nota >= 5 AND nota < 6 THEN
			SET resultado = 'Aprobado';
		WHEN nota >= 6 AND nota < 7 THEN
			SET resultado = 'Bien';
		WHEN nota >= 7 AND nota < 9 THEN
			SET resultado = 'Notable';
		WHEN nota >= 9 AND nota <= 10 THEN
			SET resultado = 'Sobresaliente';
		ELSE
			SET resultado = 'Nota no válida';
	END CASE;
END;
$$
```

**7. Escribe un procedimiento que reciba como parámetro de entrada un valor numérico que represente un día de la semana y que devuelva una cadena de caracteres con el nombre del día de la semana correspondiente. Por ejemplo, para el valor de entrada 1 debería devolver la cadena lunes. Resuelva el procedimiento haciendo uso de la estructura de control IF.**

```sql
CREATE PROCEDURE dia_semana_if(IN dia INT, OUT nombre_dia VARCHAR(20))
BEGIN
	IF dia = 1 THEN
		SET nombre_dia = 'Lunes';
	ELSEIF dia = 2 THEN
		SET nombre_dia = 'Martes';
	ELSEIF dia = 3 THEN
		SET nombre_dia = 'Miércoles';
	ELSEIF dia = 4 THEN
		SET nombre_dia = 'Jueves';
	ELSEIF dia = 5 THEN
		SET nombre_dia = 'Viernes';
	ELSEIF dia = 6 THEN
		SET nombre_dia = 'Sábado';
	ELSEIF dia = 7 THEN
		SET nombre_dia = 'Domingo';
	ELSE
		SET nombre_dia = 'Día no válido';
	END IF;
END;
$$
```

**8. Resuelva el procedimiento diseñado en el ejercicio anterior haciendo uso de la estructura de control CASE.**

```sql
CREATE PROCEDURE dia_semana_case(IN dia INT, OUT nombre_dia VARCHAR(20))
BEGIN
	CASE dia
		WHEN 1 THEN SET nombre_dia = 'Lunes';
		WHEN 2 THEN SET nombre_dia = 'Martes';
		WHEN 3 THEN SET nombre_dia = 'Miércoles';
		WHEN 4 THEN SET nombre_dia = 'Jueves';
		WHEN 5 THEN SET nombre_dia = 'Viernes';
		WHEN 6 THEN SET nombre_dia = 'Sábado';
		WHEN 7 THEN SET nombre_dia = 'Domingo';
		ELSE SET nombre_dia = 'Día no válido';
	END CASE;
END;
$$
```