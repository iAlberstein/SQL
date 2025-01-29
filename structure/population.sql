-- Inserción de datos en la tabla GENEROS
INSERT INTO teatro.generos (genero) VALUES
('Comedia'),
('Drama'),
('Musical'),
('Terror'),
('Fantasía');

-- Inserción de datos en la tabla ESPECTÁCULOS
INSERT INTO teatro.espectaculos (titulo, fecha, hora, duracion, id_genero) VALUES
('El Gran Show', '2025-02-10', '20:00:00', 120, 1),
('Drama en la Noche', '2025-02-15', '21:00:00', 150, 2),
('Canta con Nosotros', '2025-03-01', '19:30:00', 90, 3),
('Pesadilla Oscura', '2025-03-05', '22:00:00', 100, 4),
('Mundo Mágico', '2025-03-10', '18:00:00', 130, 5);

-- Inserción de datos en la tabla SALAS
INSERT INTO teatro.salas (nombre_sala, capacidad) VALUES
('Sala Principal', 500),
('Sala Secundaria', 200),
('Sala VIP', 50);

-- Inserción de datos en la tabla FUNCIONES
INSERT INTO teatro.funciones (id_espectaculo, id_sala, fecha_funcion, hora_funcion) VALUES
(1, 1, '2025-02-10', '20:00:00'),
(2, 2, '2025-02-15', '21:00:00'),
(3, 1, '2025-03-01', '19:30:00'),
(4, 2, '2025-03-05', '22:00:00'),
(5, 1, '2025-03-10', '18:00:00');

-- Inserción de datos en la tabla USUARIOS
INSERT INTO teatro.usuarios (nombre, apellido, email, telefono) VALUES
('Juan', 'Pérez', 'juanperez@example.com', '1234567890'),
('María', 'González', 'mariagonzalez@example.com', '0987654321'),
('Carlos', 'Rodríguez', 'carlosrodriguez@example.com', '1122334455');

-- Inserción de datos en la tabla ROLES
INSERT INTO teatro.roles (nombre_rol, descripcion) VALUES
('Administrador', 'Acceso total a todos los recursos y configuraciones'),
('Usuario', 'Acceso limitado a funciones básicas'),
('Premium', 'Acceso a funciones avanzadas y contenido exclusivo');

-- Inserción de datos en la tabla USUARIOS_ROLES
INSERT INTO teatro.usuarios_roles (id_usuario, id_rol) VALUES
(1, 1),
(2, 2),
(3, 3);

-- Inserción de datos en la tabla ENTRADAS
INSERT INTO teatro.entradas (id_funcion, id_usuario, precio, fecha_compra) VALUES
(1, 1, 2000.00, '2025-01-10 12:00:00'),
(2, 2, 1500.00, '2025-01-12 15:30:00'),
(3, 3, 2500.00, '2025-01-14 18:45:00');

-- Insertar métodos de pago en la tabla metodos_de_pago
INSERT INTO teatro.metodos_de_pago (metodo_pago) VALUES
('efectivo'),
('Tarjeta_credito'),
('Tarjeta_debito'),
('Mercado_pago');

-- Inserción de datos en la tabla PAGOS
INSERT INTO teatro.pagos (id_entrada, monto, fecha_pago, id_metodo_pago) VALUES
(1, 2000.00, '2025-01-10 12:30:00', 1),
(2, 1500.00, '2025-01-12 15:45:00', 2),
(3, 2500.00, '2025-01-14 19:00:00', 3);

-- Inserción de datos en la tabla HISTORIAL_FUNCIONES
INSERT INTO teatro.historial_funciones (id_funcion, accion, fecha_accion) VALUES
(1, 'Se agregó nueva función', '2025-01-01 10:00:00'),
(2, 'Se reprogramó la fecha de función', '2025-01-05 14:00:00');

-- Inserción de datos en la tabla HISTORIAL_ENTRADAS
INSERT INTO teatro.historial_entradas (id_entrada, accion, fecha_accion) VALUES
(1, 'Entrada comprada', '2025-01-10 12:00:00'),
(2, 'Entrada cancelada', '2025-01-12 16:00:00');

-- Inserción de datos en la tabla FACTURAS
INSERT INTO teatro.facturas (id_entrada, fecha_factura, monto) VALUES
(1, '2025-01-10 12:35:00', 200.00),
(2, '2025-01-12 16:15:00', 150.00);

-- Inserción de datos en la tabla TICKETS
INSERT INTO teatro.tickets (id_entrada, estado) VALUES
(1, 'validado'),
(2, 'pendiente');

-- Inserción de datos en la tabla VALORACIONES
INSERT INTO teatro.valoraciones (id_funcion, id_usuario, puntuacion, comentario, fecha_valoracion) VALUES
(1, 1, 5, 'Excelente espectáculo, me encantó!', '2025-02-10 22:00:00'),
(2, 2, 4, 'Muy buena actuación, aunque la historia me pareció lenta', '2025-02-15 23:00:00'),
(3, 3, 5, 'Un show maravilloso, muy recomendable!', '2025-03-01 21:00:00');
