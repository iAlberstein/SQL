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
