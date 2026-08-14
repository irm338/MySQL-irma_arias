

DROP DATABASE IF EXISTS gaseosas_valle;
CREATE DATABASE gaseosas_valle CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE gaseosas_valle;

-- 1. TABLA: SEDES
CREATE TABLE sedes (
    id_sede INT AUTO_INCREMENT PRIMARY KEY,
    nombre_sede VARCHAR(100) NOT NULL,
    ubicacion VARCHAR(150) NOT NULL,
    capacidad_almacenamiento INT NOT NULL,
    encargado VARCHAR(100) NOT NULL
);

-- 2. TABLA: PRODUCTOS
CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    volumen_ml INT NOT NULL,
    stock_actual INT NOT NULL,
    stock_minimo INT NOT NULL
);

-- 3. TABLA: CLIENTES
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(120) NOT NULL,
    identificacion VARCHAR(20) NOT NULL UNIQUE,
    direccion VARCHAR(150) NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    correo_electronico VARCHAR(100) NOT NULL
);

-- 4. TABLA: PEDIDOS
CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    fecha_pedido DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_cliente INT NOT NULL,
    id_sede INT NOT NULL,
    total_sin_iva DECIMAL(12,2) DEFAULT 0.00,
    total_con_iva DECIMAL(12,2) DEFAULT 0.00,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_sede) REFERENCES sedes(id_sede) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 5. TABLA INTERMEDIA: DETALLE_PEDIDO
CREATE TABLE detalle_pedido (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 6. TABLA DE AUDITORÍA: AUDITORIA_PRECIOS
CREATE TABLE auditoria_precios (
    id_auditoria INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    precio_anterior DECIMAL(10,2) NOT NULL,
    nuevo_precio DECIMAL(10,2) NOT NULL,
    fecha_cambio DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto) ON DELETE CASCADE
);


-- ============================================================
-- INSERCIÓN DE DATOS REALES (MÁS DE 50 REGISTROS POR TABLAS)
-- ============================================================

-- INSERCIÓN EN SEDES (3 Sedes)
INSERT INTO sedes (nombre_sede, ubicacion, capacidad_almacenamiento, encargado) VALUES
('Sede Principal Girón', 'Zona Industrial Chiamonte Bodega 4, Girón', 50000, 'Carlos Eduardo Mendoza'),
('Sede Bucaramanga Norte', 'Carrera 15 # 22-45, Bucaramanga', 35000, 'Martha Lucía Gómez'),
('Sede Piedecuesta Sur', 'Anillo Vial Km 3 Bodega 12, Piedecuesta', 30000, 'Jhon Jairo Villamizar');

-- INSERCIÓN EN PRODUCTOS (25 Productos)
INSERT INTO productos (nombre, categoria, precio, volumen_ml, stock_actual, stock_minimo) VALUES
('Coca-Cola Personal', 'Gaseosas', 2500.00, 400, 1200, 200),
('Coca-Cola 1.5 Litros', 'Gaseosas', 5500.00, 1500, 800, 150),
('Coca-Cola 3 Litros NR', 'Gaseosas', 9800.00, 3000, 450, 100),
('Coca-Cola Sin Azúcar 400ml', 'Gaseosas', 2500.00, 400, 300, 100),
('Colombiana 350ml Vidrio', 'Gaseosas', 2200.00, 350, 950, 150),
('Colombiana 1.5 Litros', 'Gaseosas', 4800.00, 1500, 600, 100),
('Colombiana 3 Litros', 'Gaseosas', 8500.00, 3000, 400, 80),
('Manzana Postobón 350ml', 'Gaseosas', 2200.00, 350, 1100, 200),
('Manzana Postobón 1.5L', 'Gaseosas', 4800.00, 1500, 750, 120),
('Manzana Postobón 3L', 'Gaseosas', 8500.00, 3000, 80, 100), -- Bajo stock
('Pepsi Personal 400ml', 'Gaseosas', 2000.00, 400, 500, 100),
('Pepsi 1.5 Litros', 'Gaseosas', 4500.00, 1500, 320, 80),
('Sprite 400ml', 'Gaseosas', 2400.00, 400, 40, 100), -- Bajo stock
('Cuatro 400ml', 'Gaseosas', 2500.00, 400, 380, 90),
('Hit Mora 500ml', 'Jugos', 2800.00, 500, 900, 150),
('Hit Mango 500ml', 'Jugos', 2800.00, 500, 850, 150),
('Hit Lulo 1.5L', 'Jugos', 5200.00, 1500, 25, 80), -- Bajo stock
('Hit Naranja Piña 500ml', 'Jugos', 2800.00, 500, 600, 100),
('Agua Cristal 600ml', 'Aguas', 1500.00, 600, 2000, 300),
('Agua Cristal Con Gas 600ml', 'Aguas', 1800.00, 600, 800, 150),
('Agua Cristal 5 Litros', 'Aguas', 6500.00, 5000, 150, 50),
('Electrolit Coco 625ml', 'Hidratantes', 7500.00, 625, 300, 50),
('Gatorade Tropical 500ml', 'Hidratantes', 4200.00, 500, 450, 80),
('Red Bull 250ml', 'Energizantes', 8200.00, 250, 180, 40),
('Peak Energizante 500ml', 'Energizantes', 3500.00, 500, 30, 60); -- Bajo stock

-- INSERCIÓN EN CLIENTES (20 Clientes)
INSERT INTO clientes (nombre_completo, identificacion, direccion, telefono, correo_electronico) VALUES
('Tienda El Esquinazo', '91234567-1', 'Calle 12 # 15-22, Girón', '3158901234', 'elesquinazo.giron@gmail.com'),
('Supermercado Mas x Menos', '890201450-3', 'Carrera 27 # 36-10, Bucaramanga', '3174567890', 'compras@masxmenos.com'),
('Autoservicio La Quinta', '63512890-5', 'Calle 8 # 11-04, Piedecuesta', '3102345678', 'laquinta.piede@hotmail.com'),
('Restaurante El Portal Gironés', '900341890-2', 'Carrera 25 # 28-14, Girón', '3189012345', 'elportal.giron@gmail.com'),
('Estanco y Licores La 33', '1098654321', 'Calle 33 # 21-40, Bucaramanga', '3123456789', 'estancola33@outlook.com'),
('Tienda Don Pedro', '13845920', 'Carrera 10 # 5-18, Girón', '3167890123', 'pedro.perez@gmail.com'),
('Minimarket San Jorge', '901238475-6', 'Calle 105 # 22-15, Provenza, Bucaramanga', '3115678901', 'sanjorge.provenza@gmail.com'),
('Cafetería La 19', '37890123', 'Carrera 19 # 35-02, Bucaramanga', '3148901234', 'cafeteria19.bga@gmail.com'),
('Tienda La Bendición', '63214587', 'Calle 4 # 8-30, Piedecuesta', '3190123456', 'labendicion.piede@gmail.com'),
('Supertienda La Florida', '900567123-8', 'Carrera 12 # 20-50, Floridablanca', '3134567890', 'laflorida.ventas@gmail.com'),
('Droguería y Variedades La Rebaja', '800147258-9', 'Calle 15 # 22-10, Girón', '3151234567', 'giron.rebaja@drogueria.com'),
('Cigarrería El Parque', '1095782134', 'Carrera 9 # 12-05, Piedecuesta', '3178901234', 'elparque_piede@yahoo.es'),
('Asadero y Restaurante Pollo Sabroso', '901847362-1', 'Calle 45 # 15-33, Bucaramanga', '3109012345', 'pollosabroso.bga@gmail.com'),
('Tienda Los Paisas', '71234890', 'Carrera 18 # 10-12, Girón', '3128901234', 'lospaisas.giron@gmail.com'),
('Comercializadora El Triunfo', '900123987-4', 'Calle 28 # 14-20, Bucaramanga', '3160123456', 'triunfo_ventas@gmail.com'),
('Tienda Doña Maria', '37584920', 'Calle 6 # 9-11, Piedecuesta', '3181234567', 'donamaria.piede@gmail.com'),
('Estanco San Francisco', '1098456123', 'Carrera 21 # 18-40, Bucaramanga', '3112345678', 'sanfrancisco.licores@gmail.com'),
('Restaurante Mi Colombia', '901456321-7', 'Calle 30 # 25-12, Girón', '3138901234', 'micolombia.giron@gmail.com'),
('Autoservicio El Central', '900789654-2', 'Carrera 15 # 8-04, Piedecuesta', '3156789012', 'elcentral.piede@gmail.com'),
('Tienda La Sombra', '13987456', 'Calle 10 # 14-08, Girón', '3170123456', 'lasombra.giron@gmail.com');

-- INSERCIÓN EN PEDIDOS (35 Pedidos)
INSERT INTO pedidos (fecha_pedido, id_cliente, id_sede, total_sin_iva, total_con_iva) VALUES
('2026-06-01 08:30:00', 1, 1, 150000.00, 178500.00),
('2026-06-02 09:15:00', 2, 2, 450000.00, 535500.00),
('2026-06-03 10:00:00', 3, 3, 210000.00, 249900.00),
('2026-06-04 11:20:00', 4, 1, 98000.00, 116620.00),
('2026-06-05 14:10:00', 5, 2, 320000.00, 380800.00),
('2026-06-06 15:45:00', 6, 1, 85000.00, 101150.00),
('2026-06-07 09:00:00', 7, 2, 190000.00, 226100.00),
('2026-06-08 10:30:00', 8, 2, 125000.00, 148750.00),
('2026-06-09 13:00:00', 9, 3, 175000.00, 208250.00),
('2026-06-10 16:20:00', 10, 2, 280000.00, 333200.00),
('2026-06-11 08:45:00', 1, 1, 220000.00, 261800.00),
('2026-06-12 11:00:00', 2, 2, 600000.00, 714000.00),
('2026-06-13 14:30:00', 11, 1, 140000.00, 166600.00),
('2026-06-14 15:10:00', 12, 3, 95000.00, 113050.00),
('2026-06-15 09:30:00', 13, 2, 310000.00, 368900.00),
('2026-06-16 10:15:00', 14, 1, 180000.00, 214200.00),
('2026-06-17 12:00:00', 15, 2, 520000.00, 618800.00),
('2026-06-18 16:00:00', 16, 3, 110000.00, 130900.00),
('2026-06-19 08:15:00', 17, 2, 240000.00, 285600.00),
('2026-06-20 11:40:00', 18, 1, 165000.00, 196350.00),
('2026-06-21 14:00:00', 19, 3, 205000.00, 243950.00),
('2026-06-22 15:30:00', 20, 1, 130000.00, 154700.00),
('2026-06-23 09:10:00', 1, 1, 195000.00, 232050.00),
('2026-06-24 10:50:00', 2, 2, 410000.00, 487900.00),
('2026-06-25 13:20:00', 3, 3, 160000.00, 190400.00),
('2026-06-26 16:15:00', 4, 1, 105000.00, 124950.00),
('2026-06-27 08:50:00', 5, 2, 290000.00, 345100.00),
('2026-06-28 11:15:00', 7, 2, 215000.00, 255850.00),
('2026-06-29 14:40:00', 10, 2, 350000.00, 416500.00),
('2026-06-30 17:00:00', 13, 2, 275000.00, 327250.00),
('2026-07-01 09:00:00', 15, 2, 480000.00, 571200.00),
('2026-07-02 10:30:00', 17, 2, 190000.00, 226100.00),
('2026-07-03 12:10:00', 2, 2, 530000.00, 630700.00),
('2026-07-04 15:00:00', 1, 1, 210000.00, 249900.00),
('2026-07-05 16:30:00', 3, 3, 185000.00, 220150.00);

-- INSERCIÓN EN DETALLE_PEDIDO (68 Ítems)
INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, subtotal) VALUES
(1, 1, 40, 100000.00), (1, 5, 20, 44000.00), (1, 19, 4, 6000.00),
(2, 2, 50, 275000.00), (2, 6, 30, 144000.00), (2, 15, 11, 31000.00),
(3, 3, 15, 147000.00), (3, 7, 6, 51000.00), (3, 21, 2, 12000.00),
(4, 8, 30, 66000.00), (4, 15, 10, 28000.00), (4, 19, 2, 4000.00),
(5, 1, 60, 150000.00), (5, 9, 25, 120000.00), (5, 23, 12, 50000.00),
(6, 11, 30, 60000.00), (6, 18, 7, 25000.00),
(7, 2, 20, 110000.00), (7, 16, 25, 70000.00), (7, 19, 6, 10000.00),
(8, 4, 30, 75000.00), (8, 14, 20, 50000.00),
(9, 6, 25, 120000.00), (9, 17, 10, 52000.00), (9, 20, 2, 3000.00),
(10, 3, 20, 196000.00), (10, 8, 30, 66000.00), (10, 22, 2, 18000.00),
(11, 1, 50, 125000.00), (11, 5, 30, 66000.00), (11, 15, 10, 29000.00),
(12, 2, 60, 330000.00), (12, 9, 40, 192000.00), (12, 24, 10, 78000.00),
(13, 8, 40, 88000.00), (13, 16, 15, 42000.00), (13, 19, 6, 10000.00),
(14, 11, 35, 70000.00), (14, 18, 7, 25000.00),
(15, 1, 80, 200000.00), (15, 6, 15, 72000.00), (15, 23, 9, 38000.00),
(16, 5, 50, 110000.00), (16, 15, 20, 56000.00), (16, 20, 8, 14000.00),
(17, 3, 35, 343000.00), (17, 7, 15, 127500.00), (17, 21, 7, 49500.00),
(18, 8, 35, 77000.00), (18, 16, 10, 28000.00), (18, 19, 3, 5000.00),
(19, 2, 30, 165000.00), (19, 12, 12, 54000.00), (19, 22, 3, 21000.00),
(20, 1, 45, 112500.00), (20, 14, 15, 37500.00), (20, 19, 10, 15000.00),
(21, 6, 30, 144000.00), (21, 17, 10, 52000.00), (21, 20, 5, 9000.00),
(22, 5, 40, 88000.00), (22, 18, 12, 33600.00), (22, 19, 5, 8400.00),
(23, 1, 50, 125000.00), (23, 8, 25, 55000.00), (23, 15, 5, 15000.00),
(24, 2, 50, 275000.00), (24, 9, 20, 96000.00), (24, 23, 9, 39000.00),
(25, 3, 12, 117600.00), (25, 7, 4, 34000.00), (25, 21, 1, 8400.00),
(26, 11, 40, 80000.00), (26, 18, 7, 25000.00),
(27, 1, 60, 150000.00), (27, 6, 20, 96000.00), (27, 22, 6, 44000.00),
(28, 5, 50, 110000.00), (28, 16, 30, 84000.00), (28, 19, 14, 21000.00),
(29, 3, 25, 245000.00), (29, 8, 35, 77000.00), (29, 24, 3, 28000.00),
(30, 2, 35, 192500.00), (30, 15, 20, 56000.00), (30, 23, 6, 26500.00),
(31, 1, 100, 250000.00), (31, 6, 35, 168000.00), (31, 21, 9, 62000.00),
(32, 5, 60, 132000.00), (32, 16, 15, 42000.00), (32, 20, 9, 16000.00),
(33, 3, 40, 392000.00), (33, 9, 20, 96000.00), (33, 24, 5, 42000.00),
(34, 1, 60, 150000.00), (34, 8, 20, 44000.00), (34, 15, 6, 16000.00),
(35, 6, 25, 120000.00), (35, 17, 10, 52000.00), (35, 19, 8, 13000.00);