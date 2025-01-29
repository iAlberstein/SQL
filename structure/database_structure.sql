-- Creación de la base de datos `teatro`.
DROP DATABASE IF EXISTS teatro;
CREATE DATABASE teatro;
USE teatro;

-- Tabla GENEROS
DROP TABLE IF EXISTS generos;
CREATE TABLE generos (
    id_genero INT AUTO_INCREMENT PRIMARY KEY,
    genero VARCHAR(50) NOT NULL
);

-- Tabla ESPECTÁCULOS
DROP TABLE IF EXISTS espectaculos;
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
DROP TABLE IF EXISTS salas;
CREATE TABLE salas (
    id_sala INT AUTO_INCREMENT PRIMARY KEY,
    nombre_sala VARCHAR(100) NOT NULL,
    capacidad INT NOT NULL
);

-- Tabla FUNCIONES
DROP TABLE IF EXISTS funciones;
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
DROP TABLE IF EXISTS usuarios;
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(20)
);



-- Tabla ROLES
DROP TABLE IF EXISTS roles;
CREATE TABLE roles (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre_rol VARCHAR(50) NOT NULL UNIQUE,
    descripcion TEXT
);

-- Tabla USUARIOS_ROLES
DROP TABLE IF EXISTS usuarios_roles;
CREATE TABLE usuarios_roles (
    id_usuario INT NOT NULL,
    id_rol INT NOT NULL,
    PRIMARY KEY (id_usuario, id_rol),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_rol) REFERENCES roles(id_rol) ON DELETE CASCADE
);

-- Tabla ENTRADAS
DROP TABLE IF EXISTS entradas;
CREATE TABLE entradas (
    id_entrada INT AUTO_INCREMENT PRIMARY KEY,
    id_funcion INT NOT NULL,
    id_usuario INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    fecha_compra DATETIME NOT NULL,
    FOREIGN KEY (id_funcion) REFERENCES funciones(id_funcion),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- Crear la tabla metodos_de_pago
DROP TABLE IF EXISTS metodos_de_pago;
CREATE TABLE metodos_de_pago (
    id_metodo INT AUTO_INCREMENT PRIMARY KEY,  -- Asegúrate de que esta columna exista como clave primaria
    metodo_pago VARCHAR(50) NOT NULL CHECK (metodo_pago IN ('Tarjeta_credito', 'Tarjeta_debito', 'Mercado_pago', 'efectivo'))
);

-- Crear la tabla pagos, que referenciará metodos_de_pago
DROP TABLE IF EXISTS pagos;
CREATE TABLE pagos (
    id_pago INT AUTO_INCREMENT PRIMARY KEY,
    id_entrada INT NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    fecha_pago DATETIME NOT NULL,
    id_metodo_pago INT NOT NULL,
    FOREIGN KEY (id_entrada) REFERENCES entradas(id_entrada),
    FOREIGN KEY (id_metodo_pago) REFERENCES metodos_de_pago(id_metodo)  -- Referencia correcta a la columna `id_metodo`
);


-- Tabla HISTORIAL_FUNCIONES
DROP TABLE IF EXISTS historial_funciones;
CREATE TABLE historial_funciones (
    id_historial INT AUTO_INCREMENT PRIMARY KEY,
    id_funcion INT NOT NULL,
    accion VARCHAR(255) NOT NULL,
    fecha_accion DATETIME NOT NULL,
    FOREIGN KEY (id_funcion) REFERENCES funciones(id_funcion)
);

-- Tabla HISTORIAL_ENTRADAS
DROP TABLE IF EXISTS historial_entradas;
CREATE TABLE historial_entradas (
    id_historial INT AUTO_INCREMENT PRIMARY KEY,
    id_entrada INT NOT NULL,
    accion VARCHAR(255) NOT NULL,
    fecha_accion DATETIME NOT NULL,
    FOREIGN KEY (id_entrada) REFERENCES entradas(id_entrada)
);

-- Tabla FACTURAS
DROP TABLE IF EXISTS facturas;
CREATE TABLE facturas (
    id_factura INT AUTO_INCREMENT PRIMARY KEY,
    id_entrada INT NOT NULL,
    fecha_factura DATETIME NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_entrada) REFERENCES entradas(id_entrada)
);

-- Tabla TICKETS
DROP TABLE IF EXISTS tickets;
CREATE TABLE tickets (
    id_ticket INT AUTO_INCREMENT PRIMARY KEY,
    id_entrada INT NOT NULL,
    estado ENUM('pendiente', 'validado') NOT NULL,
    FOREIGN KEY (id_entrada) REFERENCES entradas(id_entrada)
);

-- Tabla VALORACIONES
DROP TABLE IF EXISTS valoraciones;
CREATE TABLE valoraciones (
    id_valoracion INT AUTO_INCREMENT PRIMARY KEY,
    id_funcion INT NOT NULL,
    id_usuario INT NOT NULL,
    puntuacion INT NOT NULL CHECK (puntuacion >= 1 AND puntuacion <= 5),
    comentario TEXT,
    fecha_valoracion DATETIME NOT NULL,
    FOREIGN KEY (id_funcion) REFERENCES funciones(id_funcion),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);


