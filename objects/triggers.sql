-- Trigger para registrar en el historial cuando una función se modifica
DELIMITER //

CREATE TRIGGER teatro.after_funcion_update
AFTER UPDATE ON funciones
FOR EACH ROW
BEGIN
    INSERT INTO teatro.historial_funciones (id_funcion, accion, fecha_accion)
    VALUES (NEW.id_funcion, 'Actualización de función', NOW());
END //

DELIMITER ;

-- Trigger para registrar en el historial cuando una entrada se modifica
DELIMITER //

CREATE TRIGGER teatro.after_entrada_update
AFTER UPDATE ON entradas
FOR EACH ROW
BEGIN
    INSERT INTO teatro.historial_entradas (id_entrada, accion, fecha_accion)
    VALUES (NEW.id_entrada, 'Actualización de entrada', NOW());
END //

DELIMITER ;