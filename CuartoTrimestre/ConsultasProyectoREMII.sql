SELECT 
	p.Referencia AS nombre_producto,
	c.nombreCat AS categoria
	FROM Stock s
	JOIN Productos p ON s.productoStock = p.cod_Producto
	JOIN Subcategorias sc ON p.Subcategoria = sc.Id_subcategoria
	JOIN Categorias c ON sc.Categoria = c.Id_categoria
	WHERE s.stockMax = (
	SELECT MAX(stockMax) FROM Stock
	);
    
SELECT * FROM Stock WHERE cantidadActual <= stockMin;

SELECT 
    p.Referencia AS nombre_producto,
    s.cantidadActual AS stock_actual,
    s.stockMin AS stock_minimo,
    m1.Proveedor AS proveedor_suministra,
    m1.Fecha AS fecha_ultima_entrada
FROM Stock s
JOIN Productos p ON s.productoStock = p.cod_Producto
JOIN Movimientos_stock m1 ON m1.Stock = s.Id_stock AND m1.Tipo = 'Entrada'
LEFT JOIN Movimientos_stock m2 
    ON m1.Stock = m2.Stock 
    AND m2.Tipo = 'Entrada' 
    AND m1.Fecha < m2.Fecha
WHERE m2.Stock IS NULL
  AND s.cantidadActual <= s.stockMin;

SELECT 
		c.nombreCat AS categoria,
		SUM(s.cantidadActual) AS total_stock
	FROM Productos p
	JOIN Stock s ON p.cod_Producto = s.productoStock
	JOIN Subcategorias sc ON p.Subcategoria = sc.Id_subcategoria
	JOIN Categorias c ON sc.Categoria = c.Id_categoria
	GROUP BY c.nombreCat
	ORDER BY total_stock DESC
	LIMIT 1;



SELECT 
		p.Referencia AS producto,
		SUM(m.Cantidad) AS total_entradas,
		m.Proveedor AS proveedor
	FROM Movimientos_stock m
	JOIN Stock s ON m.Stock = s.Id_stock
	JOIN Productos p ON s.productoStock = p.cod_Producto
	WHERE m.Tipo = 'Entrada'
	GROUP BY p.Referencia, m.Proveedor
	ORDER BY total_entradas DESC
	LIMIT 1;


SELECT 
		s.nombreSub AS subcategoria,
		SUM(st.cantidadActual) AS total_stock
	FROM Stock st
	JOIN Productos p ON st.productoStock = p.cod_Producto
	JOIN Subcategorias s ON p.Subcategoria = s.Id_subcategoria
	GROUP BY s.nombreSub
	ORDER BY total_stock DESC
	LIMIT 1;


SELECT 
		cp.Id_comprobante AS numero_comprobante,
		CONCAT(u.PrimerNombre, ' ', u.PrimerApellido) AS nombre_vendedor,
		cp.Total AS valor_total
	FROM Comprobante_pago cp
	JOIN Usuario u ON cp.Usuario = u.Id_Usuario;


SELECT 
		mp.Desc_metodo AS metodo_pago,
		COUNT(*) AS veces_utilizado
	FROM Comprobante_pago cp
	JOIN Metodo_de_pago mp ON cp.metodoPago = mp.Id_metodo
	GROUP BY mp.Desc_metodo
	ORDER BY veces_utilizado DESC
	LIMIT 1;

SELECT 
    DATE_FORMAT(cp.Fecha, '%Y-%m') AS mes,
    mp.Desc_metodo,
    SUM(cp.Total) AS total_ventas
FROM Comprobante_pago cp
JOIN Metodo_de_pago mp ON cp.metodoPago = mp.Id_metodo
GROUP BY mes, mp.Desc_metodo
ORDER BY mes;

SELECT 
    DATE_FORMAT(cp.Fecha, '%Y-%m') AS mes,
    CONCAT(u.primerNombre, ' ', u.primerApellido) AS nombre_vendedor,
    SUM(cp.Total) AS total_ventas
FROM Comprobante_pago cp
JOIN Usuario u ON cp.Usuario = u.Id_Usuario
WHERE u.Rol = 2
GROUP BY mes, nombre_vendedor
ORDER BY mes;

SELECT 
    ms.Proveedor,
    COUNT(*) AS cantidad_ingresos
FROM Movimientos_stock ms
WHERE ms.Tipo = 'Entrada'
GROUP BY ms.Proveedor
ORDER BY cantidad_ingresos DESC
LIMIT 1;


SELECT 
    cp.Id_comprobante,
    CONCAT(u.primerNombre, ' ', u.primerApellido) AS vendedor,
    cp.Total
FROM Comprobante_pago cp
JOIN Usuario u ON cp.Usuario = u.Id_Usuario
WHERE u.Rol = 2;

SELECT 
    mp.Desc_metodo,
    COUNT(*) AS veces_usado
FROM Comprobante_pago cp
JOIN Metodo_de_pago mp ON cp.metodoPago = mp.Id_metodo
GROUP BY mp.Desc_metodo
ORDER BY veces_usado DESC
LIMIT 1;

SELECT 
    mp.Desc_metodo,
    SUM(cp.Total) AS total_ventas
FROM Comprobante_pago cp
JOIN Metodo_de_pago mp ON cp.metodoPago = mp.Id_metodo
GROUP BY mp.Desc_metodo;

SELECT 
    DATE_FORMAT(cp.Fecha, '%Y-%m') AS mes,
    SUM(cp.Total) AS total_ventas
FROM Comprobante_pago cp
GROUP BY mes
ORDER BY mes;

SELECT 
    CONCAT(u.primerNombre, ' ', u.primerApellido) AS vendedor,
    p.Referencia AS producto,
    SUM(cp2.Cantidad) AS cantidad_vendida,
    SUM(cp2.Subtotal) AS valor_total
FROM Usuario u
JOIN Comprobante_pago cp ON cp.Usuario = u.Id_Usuario
JOIN Comprobante_Productos cp2 ON cp.Id_comprobante = cp2.comprobantePago
JOIN Productos p ON cp2.Producto = p.cod_Producto
WHERE u.Rol = 2
    GROUP BY vendedor, producto
    ORDER BY vendedor;

SELECT
U.primerNombre,
U.primerApellido,
CONVERT(aes_decrypt(U.Contraseña,'llaveSecreta123') using utf8) AS contraseña_cifrada
FROM 
usuario U
WHERE
U.primerNombre ='Paola';
