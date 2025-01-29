
-- realizar_pago_y_generar_entrada 

-- (debería fallar)
CALL teatro.realizar_pago_y_generar_entrada(
    1,
    123.00,
    'test@test.com',
    2
);

-- (debería ser exitoso)
CALL teatro.realizar_pago_y_generar_entrada(
    1,
    123.00,
    'carlosrodriguez@example.com',
    2
);


-- registrar_valoracion

-- (debería fallar)
CALL teatro.registrar_valoracion(
    'test@test.com', -- No permitirá cargar la valoración por no ser un email válido
    1,
    6, -- No permitirá cargar la valoración por ser requisito que sea del 1 al 5
    'Este es un comentario de prueba'
);

-- (debería ser exitoso)
CALL teatro.registrar_valoracion(
    'juanperez@example.com',
    1,
    5,
    'Este es un comentario de prueba'
);