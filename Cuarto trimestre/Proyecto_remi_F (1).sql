CREATE DATABASE ProyectoREMI5;
USE ProyectoREMI5;

CREATE TABLE Tipo_Documento(
	Id_tdoc VARCHAR(5) NOT NULL,
    Desc_tdoc VARCHAR(35) not null,
    Estado boolean not null,
    PRIMARY KEY (Id_tdoc)
);
INSERT INTO Tipo_Documento (Id_tdoc, Desc_tdoc, Estado) VALUES
('CC', 'Cédula de Ciudadanía', TRUE),
('CE', 'Cedula de Extrangeria', TRUE);

CREATE TABLE Roles (
	Id_Rol INT not null,
    Desc_rol VARCHAR(20) not null,
    primary key (Id_Rol)
);
 INSERT INTO Roles (Id_Rol, Desc_rol) VALUES
(1, 'Administrador'),
(2, 'Vendedor');

 
create table Usuario (
	Id_Usuario varbinary(130) not null,
    primerNombre VARCHAR(10) not null,
    segundoNombre Varchar(10),
    primerApellido varchar(10) not null,
    segundoApellido varchar(10),
    Correo varchar(45)not null,
    telefonoCel varchar(10) not null,
    Contraseña varbinary(64) not null,
    tipoDoc varchar(5) not null,
    Rol int not null,
    primary key (Id_Usuario, tipoDoc, Rol),
    foreign key (tipoDoc) references Tipo_Documento (Id_tdoc),
    foreign key (Rol) references Roles (Id_Rol)
);

ALTER TABLE Usuario MODIFY primerNombre VARCHAR(50);
-- Usuario como Administrador
INSERT INTO Usuario VALUES 
(aes_encrypt('1011','claveID'),'Paola','Andrea','Chacon','Hernandez','paola.a@gmail.com', 3201234567,UNHEX(SHA2('admin123', 256)), 'CC', 1),
(aes_encrypt('1012','claveID'),'Leonardo', NULL, 'Herrera', NULL, 'Leonardo.H@gail.com', 3016483845,UNHEX(SHA2('admin213', 256)), 'CC',1),
(aes_encrypt('1013', 'claveID'), 'Antonella', NULL, 'Rodriguez', NULL, 'AntonellaRodriguez@gmail.com', 3479394867, UNHEX(SHA2('vend234', 256)), 'CE',2);

create table Metodo_de_pago(
	Id_metodo varchar(5) not null,
    Desc_metodo varchar(20) not null,
    primary key (Id_metodo)
);

INSERT INTO Metodo_de_pago (Id_metodo, Desc_metodo) VALUES
('10123','Efectivo'),
('10230', 'Nequi'),
('10345','Daviplata'),
('10234','Tarjeta-Debito'),
('10456','Tarjeta-Credito');


CREATE TABLE cliente(
Id_cliente INT AUTO_INCREMENT PRIMARY KEY,
nombre varchar(10) not null,
Apellido varchar(10) not null,
correo varchar(45) not null,
Telefono varchar(10) not null
);

INSERT INTO cliente (nombre, Apellido, correo, Telefono) VALUES
('Andres', 'Pardo', 'andres.pardo@gmail.com', '3111111111'),
('Valentina', 'Diaz', 'valentina.diaz@gmail.com', '3122222222'),
('Julian', 'Cortes', 'julian.cortes@gmail.com', '3133333333'),
('Natalia', 'Reyes', 'natalia.reyes@gmail.com', '3144444444'),
('Camilo', 'Salazar', 'camilo.salazar@gmail.com', '3155555555'),
('Luisa', 'Mendoza', 'luisa.mendoza@gmail.com', '3166666666'),
('Sebastian', 'Ruiz', 'sebastian.ruiz@gmail.com', '3177777777'),
('Isabella', 'Torres', 'isabella.torres@gmail.com', '3188888888'),
('Mateo', 'Vargas', 'mateo.vargas@gmail.com', '3199999999'),
('Sofia', 'Moreno', 'sofia.moreno@gmail.com', '3200000000'),
('Daniel', 'Gonzalez', 'daniel.gonzalez@gmail.com', '3211111111'),
('Manuela', 'Castro', 'manuela.castro@gmail.com', '3222222222'),
('Esteban', 'Perez', 'esteban.perez@gmail.com', '3233333333'),
('Gabriela', 'Ramirez', 'gabriela.ramirez@gmail.com', '3244444444'),
('Felipe', 'Ortega', 'felipe.ortega@gmail.com', '3255555555'),
('Mariana', 'Suarez', 'mariana.suarez@gmail.com', '3266666666'),
('Cristina', 'Miranda', 'cris0505@gmail.com', '3138756729'),
('Santiago', 'Herrera', 'santiago.herrera@gmail.com', '3277777777'),
('Tatiana', 'Acosta', 'tatiana.acosta@gmail.com', '3288888888'),
('Valeria', 'Ramírez', 'valeria.ramirez@hotmail.com', '3209991122');


CREATE TABLE Comprobante_pago (
  Id_comprobante INT NOT NULL,
  nombreNegocio VARCHAR(15) NOT NULL,
  Direccion VARCHAR(30) NOT NULL,
  Fecha DATE NOT NULL,
  Total DOUBLE NOT NULL,
  metodoPago VARCHAR(5) NOT NULL,
  Usuario VARBINARY(130) NOT NULL,  
  Id_cliente INT,
  PRIMARY KEY (Id_comprobante, Usuario),
  FOREIGN KEY (Usuario) REFERENCES Usuario (Id_Usuario),
  FOREIGN KEY (metodoPago) REFERENCES Metodo_de_pago (Id_metodo),
  FOREIGN KEY (Id_cliente) REFERENCES cliente(Id_cliente)
);

INSERT INTO Comprobante_pago VALUES
(1, 'DistryAseo', 'Cra 10 #20-30', '2025-06-15', 171000, '10123', AES_ENCRYPT('1011', 'claveID'),1),
(2, 'DistryAseo', 'Cra 10 #20-30', '2025-06-16', 135000, '10345', AES_ENCRYPT('1011', 'claveID'),2),
(3, 'DistryAseo', 'Cra 10 #20-30', '2025-06-17',  92000, '10234', AES_ENCRYPT('1012', 'claveID'),3),
(4, 'DistryAseo', 'Cra 10 #20-30', '2025-06-17',  45000, '10345', AES_ENCRYPT('1013', 'claveID'),4),
(5, 'DistryAseo', 'Cra 10 #20-30', '2025-06-18', 111000, '10456', AES_ENCRYPT('1012', 'claveID'),5),
(6, 'DistryAseo', 'Cra 10 #20-30', '2025-06-18',  78000, '10123', AES_ENCRYPT('1012', 'claveID'),6),
(7, 'DistryAseo', 'Cra 10 #20-30', '2025-06-19',  30000, '10230', AES_ENCRYPT('1011', 'claveID'),7),
(8, 'DistryAseo', 'Cra 10 #20-30', '2025-06-19',  54000, '10234', AES_ENCRYPT('1013', 'claveID'),8),
(9, 'DistryAseo', 'Cra 10 #20-30', '2025-06-20',  25000, '10345', AES_ENCRYPT('1013', 'claveID'),9),
(10, 'DistryAseo', 'Cra 10 #20-30', '2025-06-20',  83000, '10456', AES_ENCRYPT('1011', 'claveID'),10),
(11, 'DistryAseo', 'Cra 10 #20-30', '2025-06-17', 239000, '10123', AES_ENCRYPT('1012', 'claveID'),11),
(12, 'DistryAseo', 'Cra 10 #20-30', '2025-06-18', 292000, '10234', AES_ENCRYPT('1013', 'claveID'),12),
(13, 'DistryAseo', 'Cra 10 #20-30', '2025-06-19', 260000, '10345', AES_ENCRYPT('1012', 'claveID'),13),
(14, 'DistryAseo', 'Cra 10 #20-30', '2025-06-20', 315000, '10456', AES_ENCRYPT('1011', 'claveID'),14),
(15, 'DistryAseo', 'Cra 10 #20-30', '2025-06-21', 254000, '10123', AES_ENCRYPT('1012', 'claveID'),15),
(16, 'DistryAseo', 'Cra 10 #20-30', '2025-06-22', 289000, '10230', AES_ENCRYPT('1011', 'claveID'),16),
(17, 'DistryAseo', 'Cra 10 #20-30', '2025-06-23', 320000, '10456', AES_ENCRYPT('1011', 'claveID'),17),
(18, 'DistryAseo', 'Cra 10 #20-30', '2025-06-24', 246000, '10345', AES_ENCRYPT('1012', 'claveID'),18),
(19, 'DistryAseo', 'Cra 10 #20-30', '2025-06-25', 278000, '10234', AES_ENCRYPT('1012', 'claveID'),19),
(20, 'DistryAseo', 'Cra 10 #20-30', '2025-06-26', 301000, '10123', AES_ENCRYPT('1013', 'claveID'),20);


CREATE TABLE pagos_cliente(
id_pago INT auto_increment primary KEY,
id_comprobante INT NOT NULL,
valor_total double not null,
valor_pagado DOUBLE NOT NULL,
saldo_pendiente double as (valor_total - valor_pagado)STORED,
estado_pagado varchar(15)NOT NULL,
fecha_pago date not null,
foreign key(id_comprobante )references Comprobante_pago(id_comprobante)
);

INSERT INTO pagos_cliente(id_comprobante, valor_total, valor_pagado, estado_pagado, fecha_pago) VALUES
(1, 171000, 155000, 'PENDIENTE', '2025-06-15'),
(2, 135000, 135000, 'PAGADO', '2025-06-16'),
(3, 92000, 92000, 'PAGADO', '2025-06-17'),
(4, 45000, 40000, 'PENDIENTE', '2025-06-17'),
(5, 111000, 111000, 'PAGADO', '2025-06-18'),
(6, 78000, 50000, 'PENDIENTE', '2025-06-18'),
(7, 30000, 30000, 'PAGADO', '2025-06-19'),
(8, 54000, 30000, 'PENDIENTE', '2025-06-19'),
(9, 25000, 25000, 'PAGADO', '2025-06-20'),
(10, 83000, 83000, 'PAGADO', '2025-06-20'),
(11, 239000, 200000, 'PENDIENTE', '2025-06-17'),
(12, 292000, 292000, 'PAGADO', '2025-06-18'),
(13, 260000, 240000, 'PENDIENTE', '2025-06-19'),
(14, 315000, 315000, 'PAGADO', '2025-06-20'),
(15, 254000, 254000, 'PAGADO', '2025-06-21'),
(16, 289000, 200000, 'PENDIENTE', '2025-06-22'),
(17, 320000, 300000, 'PENDIENTE', '2025-06-23'),
(18, 246000, 246000, 'PAGADO', '2025-06-24'),
(19, 278000, 278000, 'PAGADO', '2025-06-25'),
(20, 301000, 260000, 'PENDIENTE', '2025-06-26');


create table Categorias (
	Id_categoria varchar(5) not null,
    nombreCat varchar(15) not null,
    imagencat varchar(255),
    primary key (Id_categoria)
);
INSERT INTO Categorias (Id_categoria, nombreCat, imagencat) VALUES
('T', 'Trapero','trapero.jpg'),
('E', 'Escoba','escoba2.webp'),
('C', 'Cepillo','cepillito2.avif'),
('R', 'Recogedor','reco.webp'),
('P', 'Palo','palos.webp');

create table Subcategorias (
	Id_subcategoria varchar(10) not null,
    nombreSub varchar(40) not null,
    imagensub varchar(255),
    Categoria varchar(5) not null,
    primary key (Id_subcategoria, Categoria),
    foreign key (Categoria) references Categorias (Id_categoria)
);

INSERT INTO Subcategorias (Id_subcategoria, nombreSub, imagensub, Categoria) VALUES
('TB', 'Trapero blanco', 'traperoblanco.webp','T'),
('TC', 'Trapero color','traperocolor6.webp', 'T'),
('EB', 'Escoba blanca','escobab.webp', 'E'),
('EC', 'Escoba color','escobacolor.png', 'E'),
('CP', 'Cepillo plano','cepilloplano.webp','C'),
('CM', 'Cepillo mano','cepillomano.png', 'C'),
('RCB', 'Recogedor con banda','recojedorb.jpg', 'R'),
('RSB', 'Recogedor sin banda', 'recojedorsinb.png','R'),
('PET','palo de madera con tapon','palotapon.webp','P'),
('PES','Palo escoba madera sin tapon','palos.webp','P');



create table Productos(
	cod_Producto varchar(10) not null,
    Referencia varchar(45) not null,
    marcaProducto varchar(25),
    precioDocena double not null,
    Subcategoria varchar(10) not null,
    activo BOOLEAN DEFAULT TRUE,
    primary key (cod_Producto),
    foreign key (Subcategoria) references Subcategorias(Id_subcategoria)
);
INSERT INTO Productos (cod_Producto, Referencia, marcaProducto, precioDocena, Subcategoria) VALUES
('ECSS001', 'Escoba color suave superior',NULL, 27000, 'EC'),
('EBDTR002', 'Escoba blanca dura TR', 'TR', 46000, 'EB'),
('EBLVF003', 'Escoba blanca lava carro fuller', 'Fuller', 150000, 'EB'),
('TBE500', 'Trapero economico blanco 500', 'DistryAseo', 33000, 'TB'),
('TCP800', 'Trapero color plus 800', 'DistryAseo', 47000, 'TC'),
('TCM004', 'Trapero color microfibra', 'ProMax', 78000, 'TC'),
('CMCRD005', 'Cepillo color mano rd', 'RD', 25000, 'CM'),
('CPBA006', 'Cepillo plano blanco arcoaseo', 'ArcoAseo', 35000, 'CP'),
('CMBE007', 'Cepillo mano blanco economico',NULL, 16000, 'CM'),	
('RSBC008', 'Recogedor sin banda corriente',NULL, 27000, 'RSB'),
('RCBP009', 'Recogedor con banda plus', 'PLUS', 24000, 'RCB'),
('RCBS010', 'Recogedor con banda smart', 'Smart', 30000, 'RCB'),
('PEMCT011', 'Palo escoba madera con tapon', NULL, 18000, 'PET'),
('PEMST012', 'Palo escoba madera sin tapon', NULL, 17000, 'PES');



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
INSERT INTO Comprobante_Productos (Cantidad, valorUnitario, Subtotal, comprobantePago, Producto) VALUES
-- Comprobante 1
(2, 27000, 54000, 1, 'ECSS001'),
(3, 33000, 99000, 1, 'TBE500'),
(1, 18000, 18000, 1, 'PEMCT011'),

-- Comprobante 2
(1, 78000, 78000, 2, 'TCM004'),
(2, 25000, 50000, 2, 'CMCRD005'),

-- Comprobante 3: Total 92,000
(2, 46000, 92000, 3, 'EBDTR002'),

-- Comprobante 4: Total 45,000

(3, 15000, 45000, 4, 'CMBE007'),

-- Comprobante 5: Total 111,000
(1, 78000, 78000, 5, 'TCM004'),
(1, 33000, 33000, 5, 'TBE500'),

-- Comprobante 6: Total 78,000
(3, 26000, 78000, 6, 'RSBC008'),

-- Comprobante 7: Total 30,000
(1, 30000, 30000, 7, 'RCBS010'),

-- Comprobante 8: Total 54,000
(2, 27000, 54000, 8, 'ECSS001'),

-- Comprobante 9: Total 25,000
(1, 25000, 25000, 9, 'CMCRD005'),

-- Comprobante 10: Total 83,000
(1, 47000, 47000, 10, 'TCP800'),
(1, 36000, 36000, 10, 'CPBA006'),

(1, 35000, 35000, 11, 'CPBA006'),
(3, 27000, 81000, 11, 'RSBC008'),
(2, 41000, 82000, 11, 'TCP800'),
(2, 37000, 74000, 11, 'TBE500'),

(3, 46000, 138000, 12, 'EBDTR002'),
(2, 27000, 54000, 12, 'ECSS001'),
(2, 50000, 100000, 12, 'TCM004'),

(4, 33000, 132000, 13, 'TBE500'),
(2, 64000, 128000, 13, 'RCBS010'),

(3, 78000, 234000, 14, 'TCM004'),
(1, 81000, 81000, 14, 'RCBP009'),

(2, 46000, 92000, 15, 'EBDTR002'),
(3, 54000, 162000, 15, 'TCP800'),

(2, 35000, 70000, 16, 'CPBA006'),
(3, 73000, 219000, 16, 'TCM004'),

(3, 30000, 90000, 17, 'RCBS010'),
(2, 46000, 92000, 17, 'EBDTR002'),
(2, 69000, 138000, 17, 'TCM004'),

(2, 24000, 48000, 18, 'RCBP009'),
(3, 66000, 198000, 18, 'ECSS001'),

(1, 16000, 16000, 19, 'CMBE007'),
(3, 45000, 135000, 19, 'EBDTR002'),
(2, 63500, 127000, 19, 'RSBC008'),

(2, 27000, 54000, 20, 'RSBC008'),
(3, 55000, 165000, 20, 'TCP800'),
(2, 41000, 82000, 20, 'CMCRD005');

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
INSERT INTO Stock (Id_stock, stockMax, stockMin, cantidadActual, estadoProducto, productoStock) VALUES
(1, 100, 10, 50, TRUE, 'ECSS001'),       -- Escoba color suave superior
(2, 100, 10, 30, TRUE, 'TBE500'),        -- Trapero económico blanco 500
(3, 80, 10, 20, TRUE, 'TCM004'),         -- Trapero color microfibra
(4, 60, 5, 25, TRUE, 'CMCRD005'),        -- Cepillo color mano rd
(5, 70, 5, 40, TRUE, 'RCBP009'),         -- Recogedor con banda plus
(6, 100, 10, 40, TRUE, 'EBDTR002'),      -- Escoba blanca dura TR
(7, 80, 10, 60, TRUE, 'CMBE007'),        -- Cepillo mano blanco económico
(8, 70, 5, 35, TRUE, 'RSBC008'),         -- Recogedor sin banda corriente
(9, 70, 5, 30, TRUE, 'RCBS010'),         -- Recogedor con banda smart
(10, 90, 10, 20, TRUE, 'TCP800'),         -- Trapero color plus 800
(11, 90, 10, 25, TRUE, 'CPBA006'); 


create table Proveedores (
	nombreProveedor varchar(20),
    direccionProveedor varchar(45),
    telefonoProveedor varchar(10),
    correoProveedor varchar(45),
    primary key (nombreProveedor)
);
INSERT INTO Proveedores (nombreProveedor, direccionProveedor, telefonoProveedor, correoProveedor) VALUES
('SuministrosAseo', 'Calle 45 #12-89', 3104567890, 'contacto@suministrosaseo.com'),
('DistribucionesHogar', 'Av. 30 #45-67', 3001234567, 'ventas@distribhogar.com');

create table Movimientos_stock (
	Id_movimiento int not null,
    Tipo varchar(10) not null,
    Cantidad int not null,
    Fecha date not null,
    Observaciones varchar(50),
    Stock int not null,
    Proveedor varchar(20),
    primary key (Id_movimiento, Stock),
    foreign key (Stock) references Stock (Id_stock),
    foreign key (Proveedor) references Proveedores (nombreProveedor)
);

INSERT INTO Movimientos_stock (Id_movimiento, Tipo, Cantidad, Fecha, Observaciones, Stock, Proveedor) VALUES
(1, 'Entrada', 50, '2025-04-10', 'Pedido inicial escobas', 1, 'SuministrosAseo'),
(2, 'Entrada', 30, '2025-05-11', 'Compra traperos', 2, 'DistribucionesHogar'),
(3, 'Entrada', 20, '2025-06-12', 'Reposición industrial', 3, 'SuministrosAseo'),
(4, 'Entrada', 25, '2025-06-13', 'Cepillos personales', 4, 'DistribucionesHogar'),
(5, 'Entrada', 40, '2025-06-14', 'Recogedores hogar', 5, 'SuministrosAseo'),
(6, 'Salida', 10, '2025-06-15', 'Venta escobas SCSD comprobante 1', 001, NULL),
(7, 'Salida', 5, '2025-06-15', 'Venta recogedores RC comprobante 1', 005, NULL),
(8, 'Salida', 3, '2025-06-16', 'Venta traperos TB500 comprobante 1', 002, NULL),
(9, 'Salida', 2, '2025-06-16', 'Venta cepillos CME comprobante 2', 004, NULL),
(10, 'Salida', 2, '2025-06-17', 'Venta escoba dura EBDTR002 comprobante 3', 6, NULL),
(11, 'Salida', 3, '2025-06-17', 'Venta cepillo económico CMBE007 comprobante 4', 7, NULL),
(12, 'Salida', 1, '2025-06-18', 'Venta trapero microfibra TCM004 comprobante 5', 3, NULL),
(13, 'Salida', 1, '2025-06-18', 'Venta trapero blanco TBE500 comprobante 5', 2, NULL),
(14, 'Salida', 3, '2025-06-18', 'Venta recogedores sin banda RSBC008 comprobante 6', 8, NULL),
(15, 'Salida', 1, '2025-06-19', 'Venta recogedor smart RCBS010 comprobante 7', 9, NULL),
(16, 'Salida', 2, '2025-06-19', 'Venta escobas ECSS001 comprobante 8', 1, NULL),
(17, 'Salida', 1, '2025-06-20', 'Venta cepillo mano CMCRD005 comprobante 9', 4, NULL),
(18, 'Salida', 1, '2025-06-20', 'Venta trapero color plus TCP800 comprobante 10', 10, NULL),
(19, 'Salida', 1, '2025-06-20', 'Venta cepillo plano CPBA006 comprobante 10', 11, NULL),
(20, 'Salida', 1, '2025-06-17', 'Venta CPBA006 comprobante 11', 11, NULL),
(21, 'Salida', 3, '2025-06-17', 'Venta RSBC008 comprobante 11', 8, NULL),
(22, 'Salida', 2, '2025-06-17', 'Venta TCP800 comprobante 11', 10, NULL),
(23, 'Salida', 2, '2025-06-17', 'Venta TBE500 comprobante 11', 2, NULL),
(24, 'Salida', 3, '2025-06-18', 'Venta EBDTR002 comprobante 12', 6, NULL),
(25, 'Salida', 2, '2025-06-18', 'Venta ECSS001 comprobante 12', 1, NULL),
(26, 'Salida', 2, '2025-06-18', 'Venta TCM004 comprobante 12', 3, NULL),
(27, 'Salida', 4, '2025-06-19', 'Venta TBE500 comprobante 13', 2, NULL),
(28, 'Salida', 2, '2025-06-19', 'Venta RCBS010 comprobante 13', 9, NULL),
(29, 'Salida', 3, '2025-06-20', 'Venta TCM004 comprobante 14', 3, NULL),
(30, 'Salida', 1, '2025-06-20', 'Venta RCBP009 comprobante 14', 5, NULL),
(31, 'Salida', 2, '2025-06-21', 'Venta EBDTR002 comprobante 15', 6, NULL),
(32, 'Salida', 3, '2025-06-21', 'Venta TCP800 comprobante 15', 10, NULL),
(33, 'Salida', 2, '2025-06-22', 'Venta CPBA006 comprobante 16', 11, NULL),
(34, 'Salida', 3, '2025-06-22', 'Venta TCM004 comprobante 16', 3, NULL),
(35, 'Salida', 3, '2025-06-23', 'Venta RCBS010 comprobante 17', 9, NULL),
(36, 'Salida', 2, '2025-06-23', 'Venta EBDTR002 comprobante 17', 6, NULL),
(37, 'Salida', 2, '2025-06-23', 'Venta TCM004 comprobante 17', 3, NULL),
(38, 'Salida', 2, '2025-06-24', 'Venta RCBP009 comprobante 18', 5, NULL),
(39, 'Salida', 3, '2025-06-24', 'Venta ECSS001 comprobante 18', 1, NULL),
(40, 'Salida', 1, '2025-06-25', 'Venta CMBE007 comprobante 19', 7, NULL),
(41, 'Salida', 3, '2025-06-25', 'Venta EBDTR002 comprobante 19', 6, NULL),
(42, 'Salida', 2, '2025-06-25', 'Venta RSBC008 comprobante 19', 8, NULL),
(43, 'Salida', 2, '2025-06-26', 'Venta RSBC008 comprobante 20', 8, NULL),
(44, 'Salida', 3, '2025-06-26', 'Venta TCP800 comprobante 20', 10, NULL),
(45, 'Salida', 2, '2025-06-26', 'Venta CMCRD005 comprobante 20', 4, NULL);

/*Consultas */

/*¿Qué producto tiene su stock al máximo (60 unidades) y a qué categoría pertenece este producto?*/
SELECT p.Referencia, s.cantidadActual, c.nombreCat
FROM Stock s
JOIN Productos p ON s.productoStock = p.cod_Producto
JOIN Subcategorias sc ON p.Subcategoria = sc.Id_subcategoria
JOIN Categorias c ON sc.Categoria = c.Id_categoria
WHERE s.cantidadActual = 60;


/*¿Qué producto tiene su stock en el mínimo (20 unidades) junto al proveedor que suministra el mismo para así solicitar más stock? */
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

/*¿Qué categoría con la suma total de stock por cada una cuenta con más unidades de productos?
*/
SELECT c.nombreCat, SUM(s.cantidadActual) AS total_stock
FROM Stock s
JOIN Productos p ON s.productoStock = p.cod_Producto
JOIN Subcategorias sc ON p.Subcategoria = sc.Id_subcategoria
JOIN Categorias c ON sc.Categoria = c.Id_categoria
GROUP BY c.nombreCat
ORDER BY total_stock DESC
LIMIT 1;

/*¿Cuál es el producto con mayor cantidad de entradas y que proveedor suministra este producto?*/
SELECT p.Referencia, SUM(m.Cantidad) AS total_entradas, m.Proveedor
FROM Movimientos_stock m
JOIN Stock s ON m.Stock = s.Id_stock
JOIN Productos p ON s.productoStock = p.cod_Producto
WHERE m.Tipo = 'Entrada'
GROUP BY p.Referencia, m.Proveedor
ORDER BY total_entradas DESC
LIMIT 1;

/*¿Qué subcategoría con la suma total de stock por cada una cuenta con más unidades de productos?*/
SELECT sc.nombreSub, SUM(s.cantidadActual) AS total_stock
FROM Stock s
JOIN Productos p ON s.productoStock = p.cod_Producto
JOIN Subcategorias sc ON p.Subcategoria = sc.Id_subcategoria
GROUP BY sc.nombreSub
ORDER BY total_stock DESC
LIMIT 1;

/*¿Productos activos e inactivos por subcategoría?*/
SELECT sc.nombreSub, p.activo, COUNT(*) AS cantidad_productos
FROM Productos p
JOIN Subcategorias sc ON p.Subcategoria = sc.Id_subcategoria
GROUP BY sc.nombreSub, p.activo;

/*¿Mostrar la  última fecha de entrada registrada para cada producto?
*/
SELECT p.Referencia, MAX(m.Fecha) AS ultima_entrada
FROM Movimientos_stock m
JOIN Stock s ON m.Stock = s.Id_stock
JOIN Productos p ON s.productoStock = p.cod_Producto
WHERE m.Tipo = 'Entrada'
GROUP BY p.Referencia;

/*¿Identificar los productos que tienen stock igual al mínimo y cuantas salidas recientes han tenido los últimos 7 días?*/
SELECT 
    p.Referencia, 
    s.cantidadActual,
    s.stockMin,
    COUNT(m.Id_movimiento) AS salidas_recientes
FROM Stock s
JOIN Productos p ON s.productoStock = p.cod_Producto
JOIN Movimientos_stock m ON m.Stock = s.Id_stock
WHERE s.cantidadActual <= s.stockMin
  AND m.Tipo = 'Salida'
  AND m.Fecha >= CURDATE() - INTERVAL 7 DAY
GROUP BY p.Referencia, s.cantidadActual, s.stockMin
ORDER BY salidas_recientes DESC;

/*¿Mostrar las categorías que tienen más de 3 productos activos  con stock bajo el mínimo?*/
SELECT 
    c.nombreCat AS categoria,
    COUNT(*) AS productos_bajo_minimo
FROM Stock s
JOIN Productos p ON s.productoStock = p.cod_Producto
JOIN Subcategorias sc ON p.Subcategoria = sc.Id_subcategoria
JOIN Categorias c ON sc.Categoria = c.Id_categoria
WHERE s.cantidadActual < s.stockMin
GROUP BY c.nombreCat
HAVING COUNT(*) >= 1
ORDER BY productos_bajo_minimo DESC;


/*Listar todos lo productos que se encuentran inactivos y su categoría correspondiente*/
SELECT p.Referencia, sc.nombreSub, c.nombreCat
FROM Productos p
JOIN Subcategorias sc ON p.Subcategoria = sc.Id_subcategoria
JOIN Categorias c ON sc.Categoria = c.Id_categoria
WHERE p.activo = FALSE;

/*Mostrar el promedio de stock actual por subcategoría y destacar las subcategorías con valores superiores al promedio general.
*/
WITH promedio_general AS (
  SELECT AVG(s.cantidadActual) AS promedio_total
  FROM Stock s
)
SELECT sc.nombreSub, AVG(s.cantidadActual) AS promedio_subcategoria
FROM Stock s
JOIN Productos p ON s.productoStock = p.cod_Producto
JOIN Subcategorias sc ON p.Subcategoria = sc.Id_subcategoria
GROUP BY sc.nombreSub
HAVING AVG(s.cantidadActual) > (SELECT promedio_total FROM promedio_general);

/* Consultar el producto con menor cantidad de unidades actualmente disponible por cada categoría*/
SELECT c.nombreCat, p.Referencia, s.cantidadActual
FROM Stock s
JOIN Productos p ON s.productoStock = p.cod_Producto
JOIN Subcategorias sc ON p.Subcategoria = sc.Id_subcategoria
JOIN Categorias c ON sc.Categoria = c.Id_categoria
WHERE (c.nombreCat, s.cantidadActual) IN (
    SELECT c2.nombreCat, MIN(s2.cantidadActual)
    FROM Stock s2
    JOIN Productos p2 ON s2.productoStock = p2.cod_Producto
    JOIN Subcategorias sc2 ON p2.Subcategoria = sc2.Id_subcategoria
    JOIN Categorias c2 ON sc2.Categoria = c2.Id_categoria
    GROUP BY c2.nombreCat
);

/* Mostrar la suma total de salidas por cada subcategoría*/
SELECT sc.nombreSub, SUM(m.Cantidad) AS total_salidas
FROM Movimientos_stock m
JOIN Stock s ON m.Stock = s.Id_stock
JOIN Productos p ON s.productoStock = p.cod_Producto
JOIN Subcategorias sc ON p.Subcategoria = sc.Id_subcategoria
WHERE m.Tipo = 'Salida'
GROUP BY sc.nombreSub;

/*Mostrar el historial de stock (entradas y salidas) de los últimos 30 días por producto, incluyendo nombre del producto, tipo de movimiento, cantidad, fecha, y proveedor (si aplica).*/
SELECT p.Referencia, m.Tipo, m.Cantidad, m.Fecha, m.Proveedor
FROM Movimientos_stock m
JOIN Stock s ON m.Stock = s.Id_stock
JOIN Productos p ON s.productoStock = p.cod_Producto
WHERE m.Fecha >= CURDATE() - INTERVAL 30 DAY
ORDER BY p.Referencia, m.Fecha;

/* Cuantos productos han sido vendidos en más de 3 comprobantes diferentes, cuántas unidades se han vendido en total de cada uno y cuál es su stock actual comparado con lo vendido ?  */
SELECT cp.Producto, COUNT(DISTINCT cp.comprobantePago) AS cantidad_comprobantes,
       SUM(cp.Cantidad) AS total_unidades_vendidas, s.cantidadActual AS stock_actual
FROM Comprobante_Productos cp
JOIN Stock s ON cp.Producto = s.productoStock
GROUP BY cp.Producto, s.cantidadActual
HAVING COUNT(DISTINCT cp.comprobantePago) > 3;

/*¿Cuál es el número del comprobante, el nombre del vendedor y el valor total de cada venta realizada?*/
SELECT 
    cp.Id_comprobante AS Numero_Comprobante,
    CONCAT(u.primerNombre, ' ', u.primerApellido) AS Nombre_Vendedor,
    cp.Total AS Valor_Total_Venta
FROM 
    Comprobante_pago cp
JOIN 
    Usuario u ON cp.Usuario = u.Id_Usuario
JOIN 
    Roles r ON u.Rol = r.Id_Rol
WHERE 
    r.Desc_rol = 'Vendedor';


/*¿Qué método de pago ha sido el más utilizado en todas las facturas?*/
SELECT 
    mp.Desc_metodo AS Metodo_Pago,
    COUNT(*) AS Frecuencia
FROM 
    Comprobante_pago cp
JOIN 
    Metodo_de_pago mp ON cp.metodoPago = mp.Id_metodo
GROUP BY 
    cp.metodoPago
ORDER BY 
    Frecuencia DESC
LIMIT 1;

/*¿Cuál es el valor de ventas por cada mes junto a su método de pago?*/

SELECT 
    DATE_FORMAT(cp.Fecha, '%Y-%m') AS Mes,
    mp.Desc_metodo AS Metodo_Pago,
    SUM(cp.Total) AS Valor_Total_Ventas
FROM 
    Comprobante_pago cp
JOIN 
    Metodo_de_pago mp ON cp.metodoPago = mp.Id_metodo
GROUP BY 
    DATE_FORMAT(cp.Fecha, '%Y-%m'), mp.Desc_metodo
ORDER BY 
    Mes ASC, Metodo_Pago ASC;
    
/* ¿Cuál es el total de ventas realizadas por cada vendedor en cada mes?*/
SELECT 
    DATE_FORMAT(cp.Fecha, '%Y-%m') AS Mes,
    CONCAT(u.primerNombre, ' ', u.primerApellido) AS Vendedor,
    SUM(cp.Total) AS Total_Ventas
FROM 
    Comprobante_pago cp
JOIN 
    Usuario u ON cp.Usuario = u.Id_Usuario
JOIN 
    Roles r ON u.Rol = r.Id_Rol
WHERE 
    r.Desc_rol = 'Vendedor'
GROUP BY 
    Mes, Vendedor
ORDER BY 
    Mes ASC, Vendedor ASC;

/*¿Qué proveedor ha realizado el mayor número de ingresos de productos al inventario?*/
SELECT 
    ms.Proveedor,
    COUNT(*) AS Numero_De_Entradas
FROM 
    Movimientos_stock ms
WHERE 
    ms.Tipo = 'Entrada'
GROUP BY 
    ms.Proveedor
ORDER BY 
    Numero_De_Entradas DESC
LIMIT 1;

/*¿Qué proveedor ha realizado la mayor cantidad total de productos ingresados al inventario y cual es el total ingresado?*/
SELECT 
    ms.Proveedor,
    SUM(ms.Cantidad) AS Total_Productos_Ingresados
FROM 
    Movimientos_stock ms
WHERE 
    ms.Tipo = 'Entrada'
GROUP BY 
    ms.Proveedor
ORDER BY 
    Total_Productos_Ingresados DESC
LIMIT 1;

/* ¿Qué producto ha tenido la mayor variabilidad de movimiento (Entradas y salidas) en el último mes, y que proveedor está asociado a las entradas más recientes?*/
WITH Producto_Mayor_Movimiento AS (
    SELECT 
        p.cod_Producto,
        p.Referencia,
        SUM(ms.Cantidad) AS Total_Movimientos
    FROM 
        Movimientos_stock ms
    JOIN 
        Stock s ON ms.Stock = s.Id_stock
    JOIN 
        Productos p ON s.productoStock = p.cod_Producto
    WHERE 
        ms.Fecha BETWEEN DATE_SUB((SELECT MAX(Fecha) FROM Movimientos_stock), INTERVAL 1 MONTH)
                    AND (SELECT MAX(Fecha) FROM Movimientos_stock)
    GROUP BY 
        p.cod_Producto, p.Referencia
    ORDER BY 
        Total_Movimientos DESC
    LIMIT 1
)

SELECT 
    pmm.cod_Producto,
    pmm.Referencia,
    ms.Fecha AS Fecha_Entrada_Reciente,
    ms.Cantidad AS Cantidad_Entrada,
    ms.Proveedor
FROM 
    Producto_Mayor_Movimiento pmm
JOIN 
    Stock s ON s.productoStock = pmm.cod_Producto
JOIN 
    Movimientos_stock ms ON ms.Stock = s.Id_stock
WHERE 
    ms.Tipo = 'Entrada'
    AND ms.Proveedor IS NOT NULL
ORDER BY 
    ms.Fecha DESC
LIMIT 1;

/* ¿Qué proveedor ha entregado productos que luego tuvieron más de 50 salidas registradas en el mismo mes?*/
SELECT 
    ent.Proveedor,
    p.cod_Producto,
    p.Referencia,
    DATE_FORMAT(sal.Fecha, '%Y-%m') AS Mes_Salida,
    COUNT(*) AS Total_Salidas
FROM 
    Movimientos_stock ent
JOIN 
    Stock s ON ent.Stock = s.Id_stock
JOIN 
    Productos p ON s.productoStock = p.cod_Producto
JOIN 
    Movimientos_stock sal ON sal.Stock = s.Id_stock 
        AND sal.Tipo = 'Salida'
        AND ent.Proveedor IS NOT NULL
        AND DATE_FORMAT(ent.Fecha, '%Y-%m') = DATE_FORMAT(sal.Fecha, '%Y-%m')
WHERE 
    ent.Tipo = 'Entrada'
GROUP BY 
    ent.Proveedor, p.cod_Producto, p.Referencia, DATE_FORMAT(sal.Fecha, '%Y-%m')
HAVING 
    COUNT(*) > 50
ORDER BY 
    Total_Salidas DESC;
    
/*¿Cuál ha sido el promedio de unidades ingresadas por proveedor y por tipo de producto en el último semestre?*/
SELECT 
    ms.Proveedor,
    c.nombreCat AS Tipo_Producto,
    ROUND(AVG(ms.Cantidad), 2) AS Promedio_Unidades_Ingresadas
FROM 
    Movimientos_stock ms
JOIN 
    Stock s ON ms.Stock = s.Id_stock
JOIN 
    Productos p ON s.productoStock = p.cod_Producto
JOIN 
    Subcategorias sc ON p.Subcategoria = sc.Id_subcategoria
JOIN 
    Categorias c ON sc.Categoria = c.Id_categoria
WHERE 
    ms.Tipo = 'Entrada'
    AND ms.Fecha BETWEEN DATE_SUB(CURDATE(), INTERVAL 6 MONTH) AND CURDATE()
    AND ms.Proveedor IS NOT NULL
GROUP BY 
    ms.Proveedor, c.nombreCat
ORDER BY 
    ms.Proveedor, Tipo_Producto;
    
/* ¿Comparación de la cantidad  de productos ingresados y salidos por proveedor durante un mes especifico  ?
*/
SET @mes_especifico = 6;
SET @anio_especifico = 2025;

SELECT 
    p.Proveedor,
    COALESCE(SUM(CASE WHEN p.Tipo = 'Entrada' THEN p.Cantidad END), 0) AS Total_Entradas,
    COALESCE(SUM(CASE WHEN p.Tipo = 'Salida' THEN p.Cantidad END), 0) AS Total_Salidas
FROM (
    SELECT 
        ms.Proveedor,
        ms.Tipo,
        ms.Cantidad,
        ms.Stock
    FROM Movimientos_stock ms
    WHERE 
        MONTH(ms.Fecha) = @mes_especifico
        AND YEAR(ms.Fecha) = @anio_especifico
) AS p
WHERE p.Proveedor IS NOT NULL
GROUP BY p.Proveedor
ORDER BY p.Proveedor;


/* ¿Qué productos tienen más del 70% de sus movimientos como salidas y qué proveedor los ha suministrado anteriormente?*/
SELECT 
    p.cod_Producto,
    p.Referencia,
    ROUND(SUM(CASE WHEN ms.Tipo = 'Salida' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Porcentaje_Salidas,
    GROUP_CONCAT(DISTINCT ms.Proveedor ORDER BY ms.Proveedor SEPARATOR ', ') AS Proveedores_Anteriores
FROM Movimientos_stock ms
JOIN Stock s ON ms.Stock = s.Id_stock
JOIN Productos p ON s.productoStock = p.cod_Producto
WHERE ms.Tipo IN ('Entrada', 'Salida')
GROUP BY p.cod_Producto, p.Referencia
HAVING Porcentaje_Salidas > 70
ORDER BY Porcentaje_Salidas DESC;

/*¿Qué proveedor ha suministrado más productos que luego fueron vendidos por un mismo vendedor? Muestra el proveedor, el nombre del vendedor y el total de unidades vendidas de esos productos.*/
SELECT 
    ms.Proveedor,
    CONCAT(u.primerNombre, ' ', u.primerApellido) AS Vendedor,
    SUM(cp.Cantidad) AS Total_Unidades_Vendidas
FROM Movimientos_stock ms
JOIN Stock s ON ms.Stock = s.Id_stock
JOIN Productos p ON s.productoStock = p.cod_Producto
JOIN Comprobante_Productos cp ON p.cod_Producto = cp.Producto
JOIN Comprobante_pago c ON cp.comprobantePago = c.Id_comprobante
JOIN Usuario u ON u.Id_Usuario = c.Usuario
WHERE ms.Tipo = 'Entrada'
  AND u.Rol = 2 
  AND ms.Proveedor IS NOT NULL
GROUP BY ms.Proveedor, u.Id_Usuario
ORDER BY Total_Unidades_Vendidas DESC
LIMIT 1;

/*¿Cuál es el promedio de días entre cada entrada de productos por proveedor durante todo el año 2025?*/
WITH Entradas_Ordenadas AS (
  SELECT 
    Proveedor,
    Fecha,
    ROW_NUMBER() OVER (PARTITION BY Proveedor ORDER BY Fecha) AS rn
  FROM Movimientos_stock
  WHERE Tipo = 'Entrada'
    AND YEAR(Fecha) = 2025
    AND Proveedor IS NOT NULL
),
Fechas_Pareadas AS (
  SELECT 
    e1.Proveedor,
    DATEDIFF(e2.Fecha, e1.Fecha) AS Dias_entre_entradas
  FROM Entradas_Ordenadas e1
  JOIN Entradas_Ordenadas e2 
    ON e1.Proveedor = e2.Proveedor AND e1.rn + 1 = e2.rn
)
SELECT 
  Proveedor,
  ROUND(AVG(Dias_entre_entradas), 2) AS Promedio_dias_entre_entradas
FROM Fechas_Pareadas
GROUP BY Proveedor;

/*¿Qué proveedor ha suministrado la mayor cantidad total de productos (entradas) en el último mes registrado?*/

WITH Ultimo_Mes AS (
  SELECT 
    YEAR(Fecha) AS anio,
    MONTH(Fecha) AS mes
  FROM Movimientos_stock
  WHERE Tipo = 'Entrada'
  ORDER BY Fecha DESC
  LIMIT 1
),


Entradas_Mes AS (
  SELECT 
    Proveedor,
    Cantidad
  FROM Movimientos_stock
  WHERE Tipo = 'Entrada'
    AND Proveedor IS NOT NULL
    AND (YEAR(Fecha), MONTH(Fecha)) = (
        SELECT anio, mes FROM Ultimo_Mes
    )
)

SELECT 
  Proveedor,
  SUM(Cantidad) AS Total_Productos_Ingresados
FROM Entradas_Mes
GROUP BY Proveedor
ORDER BY Total_Productos_Ingresados DESC
LIMIT 1;

/*.¿Qué productos suministrados por cada proveedor tienen el menor nivel de stock actualmente?
*/

WITH Productos_Proveedor AS (
  SELECT 
    ms.Proveedor,
    p.cod_Producto,
    p.Referencia,
    s.cantidadActual,
    ROW_NUMBER() OVER (PARTITION BY ms.Proveedor ORDER BY s.cantidadActual ASC) AS rn
  FROM Movimientos_stock ms
  JOIN Stock s ON ms.Stock = s.Id_stock
  JOIN Productos p ON s.productoStock = p.cod_Producto
  WHERE ms.Tipo = 'Entrada'
    AND ms.Proveedor IS NOT NULL
)
SELECT 
  Proveedor,
  cod_Producto,
  Referencia,
  cantidadActual AS Stock_Actual
FROM Productos_Proveedor
WHERE rn = 1
ORDER BY Proveedor;

/*¿ Consultar el comprobante el vendedor junto con el valor total de la venta para analizar el responsable de cada venta realizada en el establecimiento ? */

SELECT 
  u.Id_Usuario,
  CONCAT(u.primerNombre,' ',u.primerApellido) AS Vendedor,
  cp.Id_comprobante,
  cp.Total
FROM Comprobante_pago cp
JOIN Usuario u ON cp.Usuario = u.Id_Usuario;

/* ¿Realizar una consulta donde se pueda conocer el método de pago más utilizado por los clientes ? */
SELECT 
  mp.Desc_metodo,
  COUNT(*) AS Veces_usado
FROM Comprobante_pago cp
JOIN Metodo_de_pago mp ON cp.metodoPago = mp.Id_metodo
GROUP BY mp.Desc_metodo
ORDER BY Veces_usado DESC
LIMIT 1;

/*¿Realizar una consulta que me permita conocer el valor total por cada método de pago?
*/

SELECT 
  mp.Desc_metodo,
  SUM(cp.Total) AS Total_por_metodo
FROM Comprobante_pago cp
JOIN Metodo_de_pago mp ON cp.metodoPago = mp.Id_metodo
GROUP BY mp.Desc_metodo;

/*Realizar una consulta para conocer el valor total de las ventas por mes de cada venta ?*/
SELECT 
  DATE_FORMAT(cp.Fecha,'%Y-%m') AS Mes,
  SUM(cp.Total) AS Total_Mensual
FROM Comprobante_pago cp
GROUP BY Mes
ORDER BY Mes;

/*¿Realizar una consulta donde se identifique la gestión de cada usuario con los productos?*/
SELECT 
  u.Id_Usuario,
  CONCAT(u.primerNombre,' ',u.primerApellido) AS Usuario,
  r.Desc_rol,
  cp.Id_comprobante,
  COUNT(distinct cpr.Producto) AS Productos_distintos,
  SUM(cpr.Cantidad) AS Unidades_vendidas
FROM Usuario u
JOIN Roles r ON u.Rol = r.Id_Rol
JOIN Comprobante_pago cp ON cp.Usuario = u.Id_Usuario
JOIN Comprobante_Productos cpr ON cpr.comprobantePago = cp.Id_comprobante
GROUP BY u.Id_Usuario;

/*¿Cuál es el promedio de pago recibido por cada método de pago y su número de transacciones?*/

SELECT 
  mp.Desc_metodo,
  COUNT(pc.id_pago) AS Transacciones,
  AVG(pc.valor_pagado) AS Promedio_pagado
FROM pagos_cliente pc
JOIN Comprobante_pago cp ON pc.id_comprobante = cp.Id_comprobante
JOIN Metodo_de_pago mp ON cp.metodoPago = mp.Id_metodo
GROUP BY mp.Desc_metodo;

/*¿Qué clientes tienen más de un comprobante con saldo pendiente y cuál es el total de su deuda acumulada?*/
SELECT 
  c.Id_cliente,
  c.nombre, c.Apellido,
  COUNT(DISTINCT cp.Id_comprobante) AS Comprobantes_pendientes,
  SUM(pc.saldo_pendiente) AS Deuda_total
FROM cliente c
JOIN Comprobante_pago cp ON c.Id_cliente = cp.Id_cliente
JOIN pagos_cliente pc ON pc.id_comprobante = cp.Id_comprobante
WHERE pc.estado_pagado = 'PENDIENTE'
GROUP BY c.Id_cliente
HAVING Comprobantes_pendientes > 1;

/*.¿Cuáles usuarios han procesado ventas que suman más de $1.000.000 en un mes específico?*/

SET @mes = 6;
SET @anio = 2025;

SELECT 
  u.Id_Usuario,
  CONCAT(u.primerNombre,' ',u.primerApellido) AS Usuario,
  DATE_FORMAT(cp.Fecha,'%Y-%m') AS Mes,
  SUM(cp.Total) AS Total_mes
FROM Usuario u
JOIN Comprobante_pago cp ON cp.Usuario = u.Id_Usuario
WHERE YEAR(cp.Fecha) = @anio AND MONTH(cp.Fecha) = @mes
GROUP BY u.Id_Usuario
HAVING Total_mes > 1000000;

/*. Valor total pagado y pendiente por cada cliente, incluyendo número de facturas y promedio por factura.*/
SELECT 
  c.Id_cliente,
  CONCAT(c.nombre,' ',c.Apellido) AS Cliente,
  COUNT(DISTINCT cp.Id_comprobante) AS Num_facturas,
  SUM(pc.valor_pagado) AS Total_pagado,
  SUM(pc.saldo_pendiente) AS Total_pendiente,
  ROUND((SUM(pc.valor_pagado)+SUM(pc.saldo_pendiente))/COUNT(DISTINCT cp.Id_comprobante),2) AS Promedio_por_factura
FROM cliente c
JOIN Comprobante_pago cp ON c.Id_cliente = cp.Id_cliente
JOIN pagos_cliente pc ON pc.id_comprobante = cp.Id_comprobante
GROUP BY c.Id_cliente;

/*Productos vendidos por cada vendedor, mostrando la cantidad total de productos diferentes que ha vendido.*/
SELECT 
  u.Id_Usuario,
  CONCAT(u.primerNombre,' ',u.primerApellido) AS Vendedor,
  COUNT(DISTINCT cpr.Producto) AS Tipos_productos_vendidos
FROM Usuario u
JOIN Comprobante_pago cp ON cp.Usuario = u.Id_Usuario
JOIN Comprobante_Productos cpr ON cpr.comprobantePago = cp.Id_comprobante
GROUP BY u.Id_Usuario;

/* ¿Qué métodos de pago han sido usados por cada cliente y cuántas veces se usó cada uno?*/
SELECT 
  c.Id_cliente,
  CONCAT(c.nombre,' ',c.Apellido) AS Cliente,
  mp.Desc_metodo,
  COUNT(*) AS Veces
FROM cliente c
JOIN Comprobante_pago cp ON cp.Id_cliente = c.Id_cliente
JOIN Metodo_de_pago mp ON cp.metodoPago = mp.Id_metodo
GROUP BY c.Id_cliente, mp.Id_metodo;

/*  Clientes que han usado más de un método de pago distinto en sus compras.*/
SELECT 
  c.Id_cliente,
  CONCAT(c.nombre,' ',c.Apellido) AS Cliente,
  COUNT(DISTINCT cp.metodoPago) AS Metodos_usados
FROM cliente c
JOIN Comprobante_pago cp ON cp.Id_cliente = c.Id_cliente
GROUP BY c.Id_cliente
HAVING Metodos_usados > 1;

/* ¿Cuáles productos generan mayor ingreso total considerando su subtotal en cada comprobante?*/

SELECT 
  p.cod_Producto,
  p.Referencia,
  SUM(cpr.Subtotal) AS Ingreso_total
FROM Productos p
JOIN Comprobante_Productos cpr ON cpr.Producto = p.cod_Producto
GROUP BY p.cod_Producto
ORDER BY Ingreso_total DESC
LIMIT 5;

/*¿Qué vendedor ha vendido más productos únicos (diferentes referencias) en total?
*/

SELECT 
  u.Id_Usuario,
  CONCAT(u.primerNombre,' ',u.primerApellido) AS Vendedor,
  COUNT(DISTINCT cpr.Producto) AS Productos_unicos_vendidos
FROM Usuario u
JOIN Comprobante_pago cp ON cp.Usuario = u.Id_Usuario
JOIN Comprobante_Productos cpr ON cpr.comprobantePago = cp.Id_comprobante
GROUP BY u.Id_Usuario
ORDER BY Productos_unicos_vendidos DESC
LIMIT 1;

/*¿Qué porcentaje del total de ventas se ha pagado completamente frente a lo pendiente?*/
SELECT 
  ROUND(SUM(CASE WHEN pc.estado_pagado='PAGADO' THEN pc.valor_total ELSE 0 END)*100
        / SUM(pc.valor_total), 2) AS Porc_pagado_completo,
  ROUND(SUM(CASE WHEN pc.estado_pagado<>'PAGADO' THEN pc.saldo_pendiente ELSE 0 END)*100
        / SUM(pc.valor_total), 2) AS Porc_pendiente
FROM pagos_cliente pc;
