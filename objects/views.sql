CREATE VIEW teatro.entradas_compradas AS
SELECT e.id_entrada, e.precio, e.fecha_compra, u.nombre, u.apellido, es.titulo
FROM entradas e
JOIN usuarios u ON e.id_usuario = u.id_usuario
JOIN funciones f ON e.id_funcion = f.id_funcion
JOIN espectaculos es ON f.id_espectaculo = es.id_espectaculo;

CREATE VIEW teatro.usuarios_y_roles AS
SELECT u.id_usuario, u.nombre, u.apellido, r.nombre_rol
FROM usuarios u
JOIN usuarios_roles ur ON u.id_usuario = ur.id_usuario
JOIN roles r ON ur.id_rol = r.id_rol;

CREATE VIEW teatro.historial_funciones_view AS
SELECT h.id_historial, h.accion, h.fecha_accion, f.id_funcion, es.titulo
FROM historial_funciones h
JOIN funciones f ON h.id_funcion = f.id_funcion
JOIN espectaculos es ON f.id_espectaculo = es.id_espectaculo;

CREATE VIEW teatro.pagos_detalle AS
SELECT p.id_pago, p.monto, p.fecha_pago, e.id_entrada, u.nombre, u.apellido
FROM pagos p
JOIN entradas e ON p.id_entrada = e.id_entrada
JOIN usuarios u ON e.id_usuario = u.id_usuario;

CREATE VIEW teatro.facturas_detalle AS
SELECT f.id_factura, f.monto, f.fecha_factura, e.id_entrada, u.nombre, u.apellido
FROM facturas f
JOIN entradas e ON f.id_entrada = e.id_entrada
JOIN usuarios u ON e.id_usuario = u.id_usuario;
