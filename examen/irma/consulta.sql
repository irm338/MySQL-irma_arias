

SELECT 
    c.nombre AS nombre_cliente,
    COUNT(p.id) AS cantidad_pedidos,
    SUM(p.total) AS total_comprobado

FROM cliente C
INNER JOIN pedido p ON c.id = p.id_cliente
WHERE YEAR( p.fecha_pedido ) = YEAR(CURDATE()) --YEAR me muestra unicamente el año actual ---
GROUP BY c.id, c.nombre
ORDER BY total_comprobado DESC
LIMIT 5;
