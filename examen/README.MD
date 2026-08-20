 Módulo Comercial - Gaseosas del Valle S.A.

Este repositorio contiene las soluciones en SQL desarrolladas para el área comercial de Gaseosas del Valle S.A., enfocadas en el análisis de clientes, control de pedidos y auditoría automatizada.

## Estructura ENTREGABLE

1. **`01_funcion_total_pedidos.sql`**: Función almacenada `total_pedidos_cliente_periodo` para calcular compras por rangos de fecha personalizados.


2. **`02_vista_clientes_activos.sql`**: Vista `vista_clientes_activos` que filtra clientes con actividad comercial en los últimos 90 días.

3. **`03_top_clientes_año.sql`**: Consulta analítica con `ORDER BY` y `LIMIT 5` para identificar a los mejores clientes del año actual.

4. **`04_trigger_auditoria.sql`**: Trigger `registrar_nuevo_pedido_trigger` y su respectiva tabla `auditoria_pedidos` para el registro automático de inserciones.

## Instrucciones de Ejecución

### Ejecución de la Función
```sql
SELECT total_pedidos_cliente_periodo(1, '2026-01-01', '2026-08-20');
Visualización de la Vista
SQL


SELECT * FROM vista_clientes_activos;
Ejecución de la Consulta Analítica
SQL


SELECT * FROM (



) AS top_clientes;
Prueba del Trigger
SQL



INSERT INTO pedidos (id_cliente, fecha_pedido, total) VALUES (1, CURDATE(), 150.00);
SELECT * FROM auditoria_pedidos;

