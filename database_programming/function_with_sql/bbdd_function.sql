-- Autor: Ángel Ortiz Torres

DROP DATABASE IF EXISTS tienda_funciones;
CREATE DATABASE IF NOT EXISTS tienda_funciones;
USE tienda_funciones;

-- 2. Crear la tabla fabricantes
DROP TABLE IF EXISTS fabricantes;
CREATE TABLE fabricantes (
    codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,  -- Código del fabricante
    nombre VARCHAR(100) NOT NULL                    -- Nombre del fabricante
);

DROP TABLE IF EXISTS productos;
CREATE TABLE productos (
    codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,  -- Código del producto
    nombre VARCHAR(100) NOT NULL,                     -- Nombre del producto
    precio DECIMAL(10,2) NOT NULL,                    -- Precio del producto
    codigo_fabricante INT UNSIGNED,                   -- Código del fabricante
    FOREIGN KEY (codigo_fabricante) REFERENCES fabricantes(codigo)
);

INSERT INTO fabricantes (nombre) VALUES
('Samsung'),
('Apple'),
('Sony'),
('LG'),
('Huawei');

INSERT INTO productos (nombre, precio, codigo_fabricante) VALUES
('Galaxy S21', 799.99, 1),
('iPhone 13', 999.99, 2),
('Xperia 5 II', 849.99, 3),
('LG OLED TV', 1599.99, 4),
('Mate 40 Pro', 1099.99, 5),
('Galaxy Note 20', 999.99, 1),
('iPhone 12', 899.99, 2),
('Xperia 1 II', 1199.99, 3),
('LG NanoCell TV', 799.99, 4),
('Mate 30 Pro', 899.99, 5);