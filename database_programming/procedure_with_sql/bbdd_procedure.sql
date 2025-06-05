DROP DATABASE IF EXISTS procedimientos;
CREATE DATABASE IF NOT EXISTS procedimientos;
USE procedimientos;

CREATE TABLE IF NOT EXISTS cliente (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    pais VARCHAR(50),
    ciudad VARCHAR(50),
    telefono VARCHAR(20)
);

INSERT INTO cliente (nombre, pais, ciudad, telefono) VALUES
('Juan Pérez', 'España', 'Madrid', '600123456'),
('Ana Torres', 'México', 'Guadalajara', '5551234567'),
('Luis Gómez', 'España', 'Barcelona', '610987654'),
('Carlos Ruiz', 'Argentina', 'Buenos Aires', '541123456'),
('Laura Fernández', 'México', 'Monterrey', '5587654321'),
('Andrés Salas', 'Chile', 'Santiago', '56912345678'),
('Marta Díaz', 'Colombia', 'Bogotá', '571987654'),
('Pedro Méndez', 'España', 'Valencia', '600555333'),
('Sofía Rivas', 'Perú', 'Lima', '511654321'),
('Diego Vargas', 'México', 'CDMX', '5567891234');

CREATE TABLE IF NOT EXISTS pago (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    formaPago VARCHAR(50),
    total DECIMAL(10,2),
    fechaPago DATE
);

INSERT INTO pago (cliente_id, formaPago, total, fechaPago) VALUES
(1, 'PayPal', 100.00, '2024-01-10'),
(2, 'Transferencia', 250.00, '2024-01-11'),
(3, 'Tarjeta', 150.00, '2024-01-12'),
(4, 'PayPal', 300.00, '2024-01-13'),
(5, 'Transferencia', 400.00, '2024-01-14'),
(6, 'Tarjeta', 50.00, '2024-01-15'),
(7, 'PayPal', 200.00, '2024-01-16'),
(8, 'Transferencia', 100.00, '2024-01-17'),
(9, 'Tarjeta', 500.00, '2024-01-18'),
(10, 'PayPal', 80.00, '2024-01-19');

CREATE TABLE IF NOT EXISTS cuadrados (
    numero INT UNSIGNED,
    cuadrado INT UNSIGNED
);

CREATE TABLE IF NOT EXISTS ejercicio (
    numero INT UNSIGNED
);

CREATE TABLE IF NOT EXISTS pares (
    numero INT UNSIGNED
);

CREATE TABLE IF NOT EXISTS impares (
    numero INT UNSIGNED
);