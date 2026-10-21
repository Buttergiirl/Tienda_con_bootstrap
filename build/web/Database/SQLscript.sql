CREATE DATABASE tienda;
USE tienda;
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    alias VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL
);
CREATE TABLE productos (
id int auto_increment KEY,
nombre varchar(255) NOT NULL,
precio decimal(10, 2) NOT NULL,
stock INT NOT NULL
);
INSERT INTO usuarios (alias, email, password)
SELECT 'Administrador', 'admin@tienda.com', 'tienda123'
WHERE NOT EXISTS (
    SELECT 1 FROM usuarios
    WHERE email = 'admin@tienda.com'
);
INSERT INTO productos (nombre, precio, stock) 
VALUES ('Teclado Mecánico', 7500, 5);
INSERT INTO productos (nombre, precio, stock) 
VALUES('Mouse Inalámbrico', 4000, 7);
INSERT INTO productos (nombre, precio, stock) 
VALUES('Monitor 24 pulgadas', 20000, 8);

SELECT * FROM productos;