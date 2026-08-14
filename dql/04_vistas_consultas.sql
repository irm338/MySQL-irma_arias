

USE gaseosas_valle;


-- Vista 1: Resumen de ventas y cantidad de pedidos por sede
CREATE OR REPLACE VIEW vista_resumen_pedidos_por_sede AS
SELECT 
    s.id_sede,
    s.nombre_sede,
    s.encargado,
    COUNT(p.id_pedido) AS total_pedidos,
    IFNULL(SUM(p.total_con_iva), 0.00) AS total_ventas_con_iva
FROM sedes s
LEFT JOIN pedidos p ON s.id_sede = p.id_sede
GROUP BY s.id_sede, s.nombre_sede, s.encargado;

-- Vista 2: Productos con stock bajo el mínimo
CREATE OR REPLACE VIEW vista_productos_bajo_stock AS
SELECT 
    id_producto,
    nombre,
    categoria,
    stock_actual,
    stock_minimo,
    (stock_minimo - stock_actual) AS unidades_faltantes
FROM productos
WHERE stock_actual <= stock_minimo;

-- Vista 3: Clientes activos con al menos un pedido
CREATE OR REPLACE VIEW vista_clientes_activos AS
SELECT DISTINCT
    c.id_cliente,
    c.nombre_completo,
    c.identificacion,
    c.telefono,
    c.correo_electronico,
    COUNT(p.id_pedido) AS total_pedidos_realizados
FROM clientes c
INNER JOIN pedidos p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.nombre_completo, c.identificacion, c.telefono, c.correo_electronico;


-- ============================================================
-- CONSULTAS REQUERIDAS (DQL)
-- ============================================================

-- 1. Productos con stock por debajo del mínimo
SELECT id_producto, nombre, categoria, stock_actual, stock_minimo 
FROM productos 
WHERE stock_actual < stock_minimo;

-- 2. Pedidos realizados entre dos fechas (BETWEEN)
SELECT id_pedido, fecha_pedido, id_cliente, id_sede, total_con_iva 
FROM pedidos 
WHERE fecha_pedido BETWEEN '2026-06-01 00:00:00' AND '2026-06-15 23:59:59'
ORDER BY fecha_pedido ASC;

-- 3. Productos más vendidos (JOIN y GROUP BY)
SELECT 
    p.id_producto,
    p.nombre,
    p.categoria,
    SUM(dp.cantidad) AS total_unidades_vendidas,
    SUM(dp.subtotal) AS total_recaudado
FROM productos p
INNER JOIN detalle_pedido dp ON p.id_producto = dp.id_producto
GROUP BY p.id_producto, p.nombre, p.categoria
ORDER BY total_unidades_vendidas DESC;

-- 4. Clientes y cantidad de pedidos realizados
SELECT 
    c.id_cliente,
    c.nombre_completo,
    COUNT(p.id_pedido) AS cantidad_pedidos
FROM clientes c
LEFT JOIN pedidos p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.nombre_completo
ORDER BY cantidad_pedidos DESC;

-- 5. Búsqueda de clientes por nombre parcial (LIKE)
SELECT id_cliente, nombre_completo, identificacion, telefono 
FROM clientes 
WHERE nombre_completo LIKE '%Tienda%';

-- 6. Consultar productos de categorías específicas (IN)
SELECT id_producto, nombre, categoria, precio, stock_actual 
FROM productos 
WHERE categoria IN ('Gaseosas', 'Energizantes');

-- 7. Cliente con mayor número de pedidos (Subconsulta)
SELECT id_cliente, nombre_completo, identificacion, correo_electronico
FROM clientes
WHERE id_cliente = (
    SELECT id_cliente 
    FROM pedidos 
    GROUP BY id_cliente 
    ORDER BY COUNT(id_pedido) DESC 
    LIMIT 1
);

-- 8. Consulta de pedidos y sus totales agrupados por sede
SELECT 
    s.nombre_sede,
    COUNT(p.id_pedido) AS total_pedidos_despachados,
    SUM(p.total_sin_iva) AS total_acumulado_sin_iva,
    SUM(p.total_con_iva) AS total_acumulado_con_iva
FROM sedes s
INNER JOIN pedidos p ON s.id_sede = p.id_sede
GROUP BY s.id_sede, s.nombre_sede;