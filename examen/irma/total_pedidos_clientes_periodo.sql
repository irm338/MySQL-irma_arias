

CREATE FUNCTION total_pedidos_cliente_periodo(
    p_id_cliente INT,
    p_fecha_inicio DATE,
    p_fecha_fin DATE
) 

RETURNS DECIMAL(10, 2)
DETERMINISTIC -- ME PERMITE DEVOLVER EL MISMO RESULTADO-- 
BEGIN
    DECLARE V_total DECIMAL(10,2);

    SELECT COALESCE(SUM(total), 0) --  COALESCE- DEVUELVE EL PRIMER VALOR QUE NO SSEA NULO--
    INTO v_total
    FROM pedidos


    WHERE id_cliente = p_id_cliente
        AND fecha_pedido BETWEEN p_fecha_inicio AND p_fecha_fin; --- BETWEEN- HACE QUE BUSQUE LOS REGISTROS ESPECICÇFICOS--


    RETURN v_total;

END //


   

