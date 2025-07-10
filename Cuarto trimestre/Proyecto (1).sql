CREATE DATABASE ProyectoREMI3;
USE ProyectoREMI3;

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
    telefonoCel bigint(10) not null,
    Contraseña varbinary(64) not null,
    tipoDoc varchar(5) not null,
    Rol int not null,
    primary key (Id_Usuario, tipoDoc, Rol),
    foreign key (tipoDoc) references Tipo_Documento (Id_tdoc),
    foreign key (Rol) references Roles (Id_Rol)
);
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



