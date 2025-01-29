-- Procedure para realizar un pago y luego generar la entrada
DELIMITER //

CREATE PROCEDURE teatro.realizar_pago_y_generar_entrada(
    IN id_funcion INT,
    IN monto DECIMAL(10,2),
    IN email_usuario VARCHAR(100),
    IN id_metodo_pago INT
)
BEGIN
    -- Declaración de variables al inicio del bloque BEGIN
    DECLARE usuario_id INT;
    DECLARE id_entrada INT;
    DECLARE fecha_pago DATETIME;
    DECLARE metodo_pago_valido INT;

    -- Obtener la fecha y hora actuales
    SET fecha_pago = NOW();

    -- Verificar que el id_metodo_pago sea válido
    SELECT COUNT(*) INTO metodo_pago_valido
    FROM metodos_de_pago
    WHERE id_metodo_pago = id_metodo_pago;

    IF metodo_pago_valido = 0 THEN
        SELECT '[fallo] ALGO FALLÓ: MÉTODO DE PAGO NO VÁLIDO' AS msg;
        ROLLBACK;
    END IF;

    -- Iniciar la transacción
    START TRANSACTION;

    -- Verificar si el email proporcionado es válido
    SELECT id_usuario INTO usuario_id
    FROM teatro.usuarios
    WHERE email = email_usuario;

    IF usuario_id IS NULL THEN
        SELECT '[fallo] ALGO FALLÓ: EMAIL DEL USUARIO NO VÁLIDO' AS msg;
        ROLLBACK;

    END IF;

    -- Crear la entrada asociada al pago (se inserta primero)
    INSERT INTO teatro.entradas (id_funcion, id_usuario, precio, fecha_compra)
    VALUES (id_funcion, usuario_id, monto, fecha_pago);

    -- Obtener el id_entrada generado
    SET id_entrada = LAST_INSERT_ID();

    -- Verificar que el id_entrada haya sido generado correctamente
    IF id_entrada IS NULL THEN
        SELECT '[fallo] ALGO FALLÓ: ERROR AL GENERAR LA ENTRADA' AS msg;
        ROLLBACK;
    END IF;

    -- Realizar el pago (insertar el pago asociando el id_entrada)
    INSERT INTO teatro.pagos (id_entrada, monto, fecha_pago, id_metodo_pago)
    VALUES (id_entrada, monto, fecha_pago, id_metodo_pago);

    -- Confirmar la transacción
    SELECT '[éxito] SUCESS: PAGO EXITOSO' AS msg;
    COMMIT;
END //

DELIMITER ;



-- Procedure para realizar una valoración
DELIMITER //

CREATE PROCEDURE teatro.registrar_valoracion(
    IN email_usuario VARCHAR(100),
    IN id_funcion INT,
    IN puntuacion INT,
    IN comentario TEXT
)
BEGIN
    -- Declaración de variables
    DECLARE usuario_id INT;
    DECLARE fecha_valoracion DATETIME;
    DECLARE comentario_valido BOOLEAN;

    -- Obtener la fecha y hora actuales
    SET fecha_valoracion = NOW();

    -- Validar que la puntuación esté en el rango de 1 a 5
    IF puntuacion < 1 OR puntuacion > 5 THEN
        SELECT '[fallo] ALGO FALLÓ: LA PUNTUACIÓN DEBE SER ENTRE 1 Y 5' AS msg;
    END IF;

    -- Validar que el comentario no exceda los 140 caracteres
    SET comentario_valido = LENGTH(comentario) <= 140;
    IF NOT comentario_valido THEN
        SELECT '[fallo] ALGO FALLÓ: EL COMENTARIO NO PUEDE EXCEDER LOS 140 CARACTERES' AS msg;
    END IF;

    -- Verificar si el email del usuario existe
    SELECT id_usuario INTO usuario_id
    FROM teatro.usuarios
    WHERE email = email_usuario;

    IF usuario_id IS NULL THEN
        SELECT '[fallo] ALGO FALLÓ: USUARIO CON ESE EMAIL NO ENCONTRADO' AS msg;
    END IF;

    -- Insertar la valoración en la tabla
    INSERT INTO teatro.valoraciones (id_funcion, id_usuario, puntuacion, comentario, fecha_valoracion)
    VALUES (id_funcion, usuario_id, puntuacion, comentario, fecha_valoracion);

    -- Mensaje de éxito
    SELECT '[éxito] SUCESS: VALORACIÓN REGISTRADA EXITOSAMENTE' AS msg;

END //

DELIMITER ;



-----------------------------------

-- Ver testeos en la carpeta "test"