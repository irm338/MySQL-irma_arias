

USE gaseosas_valle;

DELIMITER //

-- 1. TRIGGER: DESCONTAR STOCK AUTOMÁTICAMENTE AL VENDER
DROP TRIGGER IF EXISTS tr_actualizar_stock //
CREATE TRIGGER tr_actualizar_stock
AFTER INSERT ON detalle_pedido
FOR EACH ROW
BEGIN
    -- Descuenta la cantidad vendida del stock actual del producto
    UPDATE productos
    SET stock_actual = stock_actual - NEW.cantidad
    WHERE id_producto = NEW.id_producto;
END //


-- 2. TRIGGER: AUDITAR CAMBIOS DE PRECIO DE PRODUCTOS
DROP TRIGGER IF EXISTS tr_auditar_cambio_precio //
CREATE TRIGGER tr_auditar_cambio_precio
BEFORE UPDATE ON productos
FOR EACH ROW
BEGIN
    -- Registra en auditoría solo si el precio fue modificado
    IF OLD.precio <> NEW.precio THEN
        INSERT INTO auditoria_precios (id_producto, precio_anterior, nuevo_precio, fecha_cambio)
        VALUES (OLD.id_producto, OLD.precio, NEW.precio, NOW());
    END IF;
END //

DELIMITER ;