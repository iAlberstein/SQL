-- Función para calcular el total de entradas vendidas para una función

DELIMITER //

CREATE FUNCTION teatro.total_entradas_vendidas(id_funcion INT) 
RETURNS INT
NOT DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total
    FROM entradas
    WHERE id_funcion = id_funcion;
    RETURN total;
END //

DELIMITER ;


-- Función para calcular el total de ingresos por una función

DELIMITER //

CREATE FUNCTION teatro.total_ingresos_funcion(id_funcion INT) 
RETURNS DECIMAL(10,2)
NOT DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(precio) INTO total
    FROM entradas
    WHERE id_funcion = id_funcion;
    RETURN total;
END //

DELIMITER ;
