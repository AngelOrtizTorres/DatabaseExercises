-- Autor: Ángel Ortiz Torres

DROP DATABASE IF EXISTS TiendaVideojuegos;
CREATE DATABASE TiendaVideojuegos;
USE TiendaVideojuegos;

-- Tabla de Videojuegos
CREATE TABLE Videojuegos (
    juego_id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    genero VARCHAR(50) NOT NULL,
    plataforma VARCHAR(50) NOT NULL,
    precio DECIMAL(10,2) NOT NULL
);

-- Tabla de Consolas
CREATE TABLE Consolas (
    consola_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    fabricante VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL
);

-- Tabla de Clientes
CREATE TABLE Clientes (
    cliente_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(15)
);

-- Tabla de Ventas (Corrección: Agregamos consola_id para registrar ventas de consolas)
CREATE TABLE Ventas (
    venta_id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    juego_id INT DEFAULT NULL,
    consola_id INT DEFAULT NULL,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cliente_id) REFERENCES Clientes(cliente_id),
    FOREIGN KEY (juego_id) REFERENCES Videojuegos(juego_id),
    FOREIGN KEY (consola_id) REFERENCES Consolas(consola_id)
);

-- Insertando TODOS los Videojuegos
INSERT INTO Videojuegos (titulo, genero, plataforma, precio) VALUES 
('The Legend of Zelda: Breath of the Wild', 'Aventura', 'Nintendo Switch', 59.99),
('God of War', 'Acción', 'PlayStation 5', 49.99),
('Halo Infinite', 'FPS', 'Xbox Series X', 54.99),
('Red Dead Redemption 2', 'Mundo Abierto', 'PC', 39.99),
('Elden Ring', 'RPG', 'PlayStation 5', 59.99),
('Super Mario Odyssey', 'Plataformas', 'Nintendo Switch', 49.99),
('Cyberpunk 2077', 'RPG', 'PC', 34.99),
('FIFA 23', 'Deportes', 'PlayStation 5', 59.99),
('Call of Duty: Modern Warfare II', 'FPS', 'Xbox Series X', 69.99),
('Resident Evil 4 Remake', 'Terror', 'PC', 59.99),
('The Last of Us Part II', 'Acción', 'PlayStation 5', 59.99),
('Animal Crossing: New Horizons', 'Simulación', 'Nintendo Switch', 49.99),
('Assassin\'s Creed Valhalla', 'Aventura', 'PC', 39.99),
('Horizon Forbidden West', 'Aventura', 'PlayStation 5', 59.99),
('GTA V', 'Mundo Abierto', 'PC', 29.99),
('Minecraft', 'Sandbox', 'Todas', 19.99),
('NBA 2K23', 'Deportes', 'Xbox Series X', 59.99),
('Sekiro: Shadows Die Twice', 'RPG', 'PC', 49.99),
('Ghost of Tsushima', 'Acción', 'PlayStation 5', 59.99),
('Among Us', 'Multijugador', 'PC', 9.99);

-- Insertando TODAS las Consolas
INSERT INTO Consolas (nombre, fabricante, precio) VALUES 
('PlayStation 5', 'Sony', 499.99),
('Xbox Series X', 'Microsoft', 499.99),
('Nintendo Switch', 'Nintendo', 299.99),
('Steam Deck', 'Valve', 399.99),
('PlayStation 4', 'Sony', 299.99),
('Xbox Series S', 'Microsoft', 299.99),
('Nintendo Switch OLED', 'Nintendo', 349.99),
('PlayStation VR2', 'Sony', 549.99);

-- Insertando TODOS los Clientes Originales
INSERT INTO Clientes (nombre, apellido, email, telefono) VALUES 
('Juan', 'Pérez', 'juan.perez@email.com', '654321987'),
('María', 'González', 'maria.gonzalez@email.com', '698745632'),
('Carlos', 'Ramírez', 'carlos.ramirez@email.com', '987654321'),
('Alejandro', 'Torres', 'alejandro.torres@email.com', '612345678'),
('Beatriz', 'Mendoza', 'beatriz.mendoza@email.com', '612345679'),
('Daniel', 'Fernández', 'daniel.fernandez@email.com', '612345680'),
('Ana', 'Sánchez', 'ana.sanchez@email.com', '615987654'),
('Luis', 'García', 'luis.garcia@email.com', '612345678'),
('Elena', 'Martínez', 'elena.martinez@email.com', '667234567'),
('Pablo', 'Fernández', 'pablo.fernandez@email.com', '654876543');

-- Insertando Ventas con Videojuegos y Consolas
INSERT INTO Ventas (cliente_id, juego_id, consola_id) VALUES 
(1, 1, NULL), -- Juan compra Zelda
(2, 2, NULL), -- María compra God of War
(3, 3, NULL), -- Carlos compra Halo Infinite
(4, NULL, 1), -- Alejandro compra una PS5
(5, NULL, 2), -- Beatriz compra una Xbox Series X
(6, NULL, 3), -- Daniel compra una Nintendo Switch
(7, 4, NULL), -- Ana compra Red Dead Redemption 2
(8, 5, NULL), -- Luis compra Elden Ring
(9, 6, NULL), -- Elena compra Super Mario Odyssey
(10, 1, NULL), -- Pablo compra Zelda
(1, NULL, 4), -- Juan compra Steam Deck
(2, NULL, 5), -- María compra una PlayStation 4
(3, NULL, 6), -- Carlos compra una Xbox Series S
(4, NULL, 7), -- Alejandro compra una Switch OLED
(5, NULL, 8); -- Beatriz compra PlayStation VR2