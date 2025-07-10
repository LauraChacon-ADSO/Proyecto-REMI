use ProyectoREMI3;

-- 1. Producto con stock mínimo y proveedor más reciente (Evitar desabastecimiento)
SELECT p.Referencia, s.cantidadActual, m.Proveedor
FROM Stock s
JOIN Productos p ON s.productoStock = p.cod_Producto
JOIN Movimientos_stock m ON m.Stock = s.Id_stock
WHERE s.cantidadActual = (
    SELECT MIN(cantidadActual) FROM Stock
)
AND m.Tipo = 'Entrada'
ORDER BY m.Fecha DESC
LIMIT 1;

-- 2. Historial de movimientos del último mes (Auditoría del inventario)
SELECT p.Referencia, m.Tipo, m.Cantidad, m.Fecha, m.Proveedor
FROM Movimientos_stock m
JOIN Stock s ON m.Stock = s.Id_stock
JOIN Productos p ON s.productoStock = p.cod_Producto
WHERE m.Fecha >= CURDATE() - INTERVAL 30 DAY
ORDER BY p.Referencia, m.Fecha;

-- 3. Subcategoría con más unidades en stock (Análisis de inventario)
SELECT sc.nombreSub, SUM(s.cantidadActual) AS total_stock
FROM Stock s
JOIN Productos p ON s.productoStock = p.cod_Producto
JOIN Subcategorias sc ON p.Subcategoria = sc.Id_subcategoria
GROUP BY sc.nombreSub
ORDER BY total_stock DESC
LIMIT 1;

-- 4. Producto con mayor movimiento y proveedor reciente (Rotación de productos)
WITH Producto_Mayor_Movimiento AS (
    SELECT p.cod_Producto, p.Referencia, SUM(ms.Cantidad) AS Total_Movimientos
    FROM Movimientos_stock ms
    JOIN Stock s ON ms.Stock = s.Id_stock
    JOIN Productos p ON s.productoStock = p.cod_Producto
    WHERE ms.Fecha BETWEEN DATE_SUB((SELECT MAX(Fecha) FROM Movimientos_stock), INTERVAL 1 MONTH)
                          AND (SELECT MAX(Fecha) FROM Movimientos_stock)
    GROUP BY p.cod_Producto, p.Referencia
    ORDER BY Total_Movimientos DESC
    LIMIT 1
)
SELECT pmm.cod_Producto, pmm.Referencia, ms.Fecha AS Fecha_Entrada_Reciente, ms.Cantidad, ms.Proveedor
FROM Producto_Mayor_Movimiento pmm
JOIN Stock s ON s.productoStock = pmm.cod_Producto
JOIN Movimientos_stock ms ON ms.Stock = s.Id_stock
WHERE ms.Tipo = 'Entrada' AND ms.Proveedor IS NOT NULL
ORDER BY ms.Fecha DESC
LIMIT 1;

-- 5. Total de ventas por mes y método de pago (Análisis financiero)
SELECT DATE_FORMAT(cp.Fecha, '%Y-%m') AS Mes, mp.Desc_metodo AS Metodo_Pago, SUM(cp.Total) AS Valor_Total_Ventas
FROM Comprobante_pago cp
JOIN Metodo_de_pago mp ON cp.metodoPago = mp.Id_metodo
GROUP BY DATE_FORMAT(cp.Fecha, '%Y-%m'), mp.Desc_metodo
ORDER BY Mes ASC, Metodo_Pago ASC;

-- 6. Productos con mayores ingresos generados (Top productos estrella)
SELECT p.cod_Producto, p.Referencia, SUM(cpr.Subtotal) AS Ingreso_total
FROM Productos p
JOIN Comprobante_Productos cpr ON cpr.Producto = p.cod_Producto
GROUP BY p.cod_Producto
ORDER BY Ingreso_total DESC
LIMIT 5;

-- 7. Promedio de pagos y número de transacciones por método (Comportamiento del cliente)
SELECT mp.Desc_metodo, COUNT(pc.id_pago) AS Transacciones, AVG(pc.valor_pagado) AS Promedio_pagado
FROM pagos_cliente pc
JOIN Comprobante_pago cp ON pc.id_comprobante = cp.Id_comprobante
JOIN Metodo_de_pago mp ON cp.metodoPago = mp.Id_metodo
GROUP BY mp.Desc_metodo;

-- 8. Clientes con más de 1 comprobante pendiente y su deuda total
SELECT c.Id_cliente, c.nombre, c.Apellido,
       COUNT(DISTINCT cp.Id_comprobante) AS Comprobantes_pendientes,
       SUM(pc.saldo_pendiente) AS Deuda_total
FROM cliente c
JOIN Comprobante_pago cp ON c.Id_cliente = cp.Id_cliente
JOIN pagos_cliente pc ON pc.id_comprobante = cp.Id_comprobante
WHERE pc.estado_pagado = 'PENDIENTE'
GROUP BY c.Id_cliente
HAVING Comprobantes_pendientes > 1;

-- 9. Porcentaje de ventas pagadas completamente vs pendientes
SELECT 
  ROUND(SUM(CASE WHEN pc.estado_pagado='PAGADO' THEN pc.valor_total ELSE 0 END)*100 / SUM(pc.valor_total), 2) AS Porc_pagado_completo,
  ROUND(SUM(CASE WHEN pc.estado_pagado<>'PAGADO' THEN pc.saldo_pendiente ELSE 0 END)*100 / SUM(pc.valor_total), 2) AS Porc_pendiente
FROM pagos_cliente pc;

-- 10. Vendedor con más productos únicos vendidos
SELECT u.Id_Usuario, CONCAT(u.primerNombre,' ',u.primerApellido) AS Vendedor,
       COUNT(DISTINCT cpr.Producto) AS Productos_unicos_vendidos
FROM Usuario u
JOIN Comprobante_pago cp ON cp.Usuario = u.Id_Usuario
JOIN Comprobante_Productos cpr ON cpr.comprobantePago = cp.Id_comprobante
GROUP BY u.Id_Usuario
ORDER BY Productos_unicos_vendidos DESC
LIMIT 1;
