

USE gaseosas_valle;

DELIMITER //

-- 1. FUNCIÓN: CALCULAR TOTAL CON IVA (19%)
DROP FUNCTION IF EXISTS fn_calcular_total_con_iva //
CREATE FUNCTION fn_calcular_total_con_iva(p_id_pedido INT)
RETURNS DECIMAL(12,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_subtotal DECIMAL(12,2) DEFAULT 0.00;
    DECLARE v_total_iva DECIMAL(12,2) DEFAULT 0.00;

    -- Obtiene la suma de subtotales del detalle del pedido
    SELECT IFNULL(SUM(subtotal), 0.00) 
    INTO v_subtotal
    FROM detalle_pedido
    WHERE id_pedido = p_id_pedido;

    -- Calcula el valor con IVA (19%)
    SET v_total_iva = v_subtotal * 1.19;

    RETURN v_total_iva;
END //


-- 2. FUNCIÓN: VALIDAR DISPONIBILIDAD DE STOCK
DROP FUNCTION IF EXISTS fn_validar_stock //
CREATE FUNCTION fn_validar_stock(p_id_producto INT, p_cantidad_solicitada INT)
RETURNS VARCHAR(100)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_stock_actual INT DEFAULT 0;
    DECLARE v_mensaje VARCHAR(100);

    -- Obtiene el stock actual del producto
    SELECT stock_actual INTO v_stock_actual
    FROM productos
    WHERE id_producto = p_id_producto;

    -- Valida disponibilidad
    IF v_stock_actual IS NULL THEN
        SET v_mensaje = 'Error: El producto no existe.';
    ELSEIF v_stock_actual >= p_cantidad_solicitada THEN
        SET v_mensaje = CONCAT('Stock disponible. (Actual: ', v_stock_actual, ' unidades)');
    ELSE
        SET v_mensaje = CONCAT('Stock insuficiente. (Disponible: ', v_stock_actual, ' unidades)');
    END IF;

    RETURN v_mensaje;
END //

DELIMITER ;