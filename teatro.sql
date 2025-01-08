-- Creación de la base de datos
CREATE DATABASE teatro;
USE teatro;

-- Tabla GENEROS
CREATE TABLE generos (
    id_genero INT AUTO_INCREMENT PRIMARY KEY,
    genero VARCHAR(50) NOT NULL
);

-- Tabla ESPECTÁCULOS
CREATE TABLE espectaculos (
    id_espectaculo INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    duracion INT NOT NULL,
    id_genero INT NOT NULL,
    FOREIGN KEY (id_genero) REFERENCES generos(id_genero)
);

-- Tabla SALAS
CREATE TABLE salas (
    id_sala INT AUTO_INCREMENT PRIMARY KEY,
    nombre_sala VARCHAR(100) NOT NULL,
    capacidad INT NOT NULL
);

-- Tabla FUNCIONES
CREATE TABLE funciones (
    id_funcion INT AUTO_INCREMENT PRIMARY KEY,
    id_espectaculo INT NOT NULL,
    id_sala INT NOT NULL,
    fecha_funcion DATE NOT NULL,
    hora_funcion TIME NOT NULL,
    FOREIGN KEY (id_espectaculo) REFERENCES espectaculos(id_espectaculo),
    FOREIGN KEY (id_sala) REFERENCES salas(id_sala)
);

-- Tabla USUARIOS
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(20)
);

-- Tabla ENTRADAS
CREATE TABLE entradas (
    id_entrada INT AUTO_INCREMENT PRIMARY KEY,
    id_funcion INT NOT NULL,
    id_usuario INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    fecha_compra DATETIME NOT NULL,
    FOREIGN KEY (id_funcion) REFERENCES funciones(id_funcion),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);


-----------------------------------------------------------------------

--ENTREGA Nº2

-- Inserción de datos en tabla GENEROS
INSERT INTO GENEROS (id_genero, genero) VALUES
(1, 'Drama'),
(2, 'Comedia'),
(3, 'Musical'),
(4, 'Infantil');

-- Inserción de datos en tabla SALAS
INSERT INTO SALAS (id_sala, nombre_sala, capacidad) VALUES
(1, 'Sala Principal', 500),
(2, 'Sala Secundaria', 200);

-- Inserción de datos en tabla ESPECTÁCULOS
INSERT INTO ESPECTACULOS (id_espectaculo, titulo, fecha, hora, duracion, id_genero) VALUES
(1, 'El Gran Musical', '2025-01-15', '20:00', 120, 3),
(2, 'Comedia de la Vida', '2025-01-16', '21:00', 90, 2);

-- Inserción de datos en tabla FUNCIONES
INSERT INTO FUNCIONES (id_funcion, id_espectaculo, id_sala, fecha_funcion, hora_funcion) VALUES
(1, 1, 1, '2025-01-15', '20:00'),
(2, 2, 2, '2025-01-16', '21:00');

-- Inserción de datos en tabla USUARIOS
INSERT INTO USUARIOS (id_usuario, nombre, apellido, email, telefono) VALUES
(1, 'Juan', 'Pérez', 'juan.perez@example.com', '1234567890'),
(2, 'María', 'Gómez', 'maria.gomez@example.com', '0987654321');

-- Inserción de datos en tabla ENTRADAS
INSERT INTO ENTRADAS (id_entrada, id_funcion, id_usuario, precio, fecha_compra) VALUES
(1, 1, 1, 1500.00, '2025-01-01'),
(2, 2, 2, 1200.00, '2025-01-02');


-- creación de vistas, funciones, stored procedures y triggers

-- Vista v_funciones_por_genero
CREATE VIEW v_funciones_por_genero AS
SELECT g.genero, e.titulo, f.fecha_funcion, f.hora_funcion
FROM GENEROS g
JOIN ESPECTACULOS e ON g.id_genero = e.id_genero
JOIN FUNCIONES f ON e.id_espectaculo = f.id_espectaculo;

-- Vista v_entradas_por_usuario
CREATE VIEW v_entradas_por_usuario AS
SELECT u.nombre, u.apellido, e.titulo, f.fecha_funcion, f.hora_funcion, en.precio
FROM USUARIOS u
JOIN ENTRADAS en ON u.id_usuario = en.id_usuario
JOIN FUNCIONES f ON en.id_funcion = f.id_funcion
JOIN ESPECTACULOS e ON f.id_espectaculo = e.id_espectaculo;

-- Función fn_precio_total_usuario
DELIMITER //
CREATE FUNCTION fn_precio_total_usuario(uid INT) RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
  DECLARE total DECIMAL(10, 2);
  SELECT SUM(precio) INTO total
  FROM ENTRADAS
  WHERE id_usuario = uid;
  RETURN total;
END //
DELIMITER ;

-- Función fn_capacidad_restante
DELIMITER //
CREATE FUNCTION fn_capacidad_restante(fid INT) RETURNS INT
DETERMINISTIC
BEGIN
  DECLARE capacidad_restante INT;
  SELECT s.capacidad - COUNT(e.id_entrada) INTO capacidad_restante
  FROM SALAS s
  JOIN FUNCIONES f ON s.id_sala = f.id_sala
  LEFT JOIN ENTRADAS e ON f.id_funcion = e.id_funcion
  WHERE f.id_funcion = fid;
  RETURN capacidad_restante;
END //
DELIMITER ;

-- Stored Procedure sp_registrar_compra
DELIMITER //
CREATE PROCEDURE sp_registrar_compra(IN uid INT, IN fid INT, IN precio DECIMAL(10, 2))
BEGIN
  INSERT INTO ENTRADAS (id_funcion, id_usuario, precio, fecha_compra)
  VALUES (fid, uid, precio, NOW());
END //
DELIMITER ;

-- Trigger tr_borrar_funcion
DELIMITER //
CREATE TRIGGER tr_borrar_funcion
AFTER DELETE ON FUNCIONES
FOR EACH ROW
BEGIN
  DELETE FROM ENTRADAS WHERE id_funcion = OLD.id_funcion;
END //
DELIMITER ;

-- Trigger tr_actualizar_capacidad
DELIMITER //
CREATE TRIGGER tr_actualizar_capacidad
AFTER INSERT ON ENTRADAS
FOR EACH ROW
BEGIN
  UPDATE SALAS
  SET capacidad = capacidad - 1
  WHERE id_sala = (SELECT id_sala FROM FUNCIONES WHERE id_funcion = NEW.id_funcion);
END //
DELIMITER ;
