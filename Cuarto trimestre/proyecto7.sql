CREATE DATABASE ProyectoREMI;
USE ProyectoREMI;

CREATE TABLE Tipo_Documento(
	Id_tdoc VARCHAR(5) NOT NULL,
    Desc_tdoc VARCHAR(35) not null,
    Estado boolean not null,
    PRIMARY KEY (Id_tdoc)
);

CREATE TABLE Roles (
	Id_Rol INT not null,
    Desc_rol VARCHAR(20) not null,
    primary key (Id_Rol)
);

create table Usuario (
	Id_Usuario INT(11) not null,
    primerNombre VARCHAR(10) not null,
    segundoNombre Varchar(10),
    primerApellido varchar(10) not null,
    segundoApellido varchar(10),
    Correo varchar(45)not null,
    telefonoCel bigint(10) not null,
    Contraseña varbinary(130) not null,
    tipoDoc varchar(5) not null,
    Rol int not null,
    primary key (Id_Usuario, tipoDoc, Rol),
    foreign key (tipoDoc) references Tipo_Documento (Id_tdoc),
    foreign key (Rol) references Roles (Id_Rol)
);

create table Metodo_de_pago(
	Id_metodo varchar(5) not null,
    Desc_metodo varchar(20) not null,
    primary key (Id_metodo)
);

create table Comprobante_pago (
	Id_comprobante int not null,
    nombreNegocio VARCHAR(15) not null,
    Direccion varchar(30) not null,
    Fecha date not null,
    Total double not null,
    metodoPago varchar(5) not null,
    Usuario int(11) not null,
    primary key (Id_comprobante, Usuario),
    foreign key (Usuario) references Usuario (Id_Usuario),
    foreign key (metodoPago) references Metodo_de_pago (Id_metodo)
);

create table Categorias (
	Id_categoria varchar(5) not null,
    nombreCat varchar(15) not null,
    primary key (Id_categoria)
);

create table Subcategorias (
	Id_subcategoria varchar(10) not null,
    nombreSub varchar(15) not null,
    Categoria varchar(5) not null,
    primary key (Id_subcategoria, Categoria),
    foreign key (Categoria) references Categorias (Id_categoria)
);

create table Productos(
	cod_Producto varchar(10) not null,
    Referencia varchar(45) not null,
    marcaProducto varchar(25) not null,
    precioDocena double not null,
    Subcategoria varchar(10) not null,
    primary key (cod_Producto, Subcategoria),
    foreign key (Subcategoria) references Subcategorias (Id_subcategoria)
);

create table Comprobante_Productos(
	Cantidad int not null,
    valorUnitario double not null,
    Subtotal double not null,
    comprobantePago int not null,
    Producto varchar(10) not null,
    primary key (comprobantePago, Producto),
    foreign key (comprobantePago) references Comprobante_pago (Id_comprobante),
	foreign key (Producto) references Productos (cod_Producto)
);

create table Stock (
	Id_stock int not null,
    stockMax int not null,
    stockMin int not null,
    cantidadActual int not null,
    estadoProducto boolean not null,
    productoStock varchar(10) not null,
    primary key (Id_stock),
    foreign key (productoStock) references Productos (cod_Producto)
);

create table Proveedores (
	nombreProveedor varchar(20) not null,
    direccionProveedor varchar(45) not null,
    telefonoProveedor int(10) not null,
    correoProveedor varchar(45) not null,
    primary key (nombreProveedor)
);

create table Movimientos_stock (
	Id_movimiento int not null,
    Tipo varchar(10) not null,
    Cantidad int not null,
    Fecha date not null,
    Observaciones varchar(50),
    Stock int not null,
    Proveedor varchar(20) not null,
    primary key (Id_movimiento, Stock),
    foreign key (Stock) references Stock (Id_stock),
    foreign key (Proveedor) references Proveedores (nombreProveedor)
);


SELECT 
  p.Referencia AS nombre_producto,
  c.nombreCat AS categoria,
  s.cantidadActual
FROM Stock s
JOIN Productos p ON s.productoStock = p.cod_Producto
JOIN Subcategorias sc ON p.Subcategoria = sc.Id_subcategoria
JOIN Categorias c ON sc.Categoria = c.Id_categoria
WHERE s.stockMax = (
  SELECT MAX(stockMax) FROM Stock
);



SELECT 
    p.Referencia AS nombre_producto,
    s.cantidadActual AS stock_actual,
    s.stockMin AS stock_minimo,
    m.Proveedor AS proveedor_suministra
FROM Stock s
JOIN Productos p ON s.productoStock = p.cod_Producto
JOIN (
    SELECT Stock, MAX(Fecha) AS ultima_fecha
    FROM Movimientos_stock
    WHERE Tipo = 'Entrada'
    GROUP BY Stock
) AS ult ON s.Id_stock = ult.Stock
JOIN Movimientos_stock m 
    ON m.Stock = ult.Stock AND m.Fecha = ult.ultima_fecha AND m.Tipo = 'Entrada'
WHERE s.cantidadActual = s.stockMin;



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
