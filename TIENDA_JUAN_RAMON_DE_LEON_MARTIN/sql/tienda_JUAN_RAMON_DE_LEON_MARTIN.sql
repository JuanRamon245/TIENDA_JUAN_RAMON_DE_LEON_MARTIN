CREATE DATABASE IF NOT EXISTS hibernateBBDDTienda;
USE hibernateBBDDTienda;

CREATE TABLE IF NOT EXISTS Usuario (
	id int AUTO_INCREMENT,
    rol_id int,
    email varchar(255) NOT NULL,
    clave varchar(255) NOT NULL, 
    nombre varchar(255) NOT NULL,
    apellidos varchar(255) NOT NULL,
    baja boolean,
    PRIMARY KEY (id) 
);

CREATE TABLE IF NOT EXISTS Producto (
	id int AUTO_INCREMENT,
    nombre varchar(255) NOT NULL,
    descripcion varchar(255) NOT NULL,
    precio double,
    stock int,
    impuesto double,
    baja boolean,
    PRIMARY KEY (id) 
);

CREATE TABLE IF NOT EXISTS Detalle (
	id int AUTO_INCREMENT,
    pedido_id int,
    producto_id int,
    unidades int,
    preciounidad double,
    impuesto double,
    total double,
    PRIMARY KEY (id) 
);

CREATE TABLE IF NOT EXISTS Pedido (
	id int AUTO_INCREMENT,
    usuario_id int,
    fecha date,
	metodopago varchar(255) NOT NULL,
    num_factura varchar(255) NOT NULL,
    total double,
    PRIMARY KEY (id) 
);

INSERT INTO Producto (nombre, descripcion, precio, stock, impuesto, baja) VALUE ("ProductoA", "Descripcion del productoA", 22.30, 100, 1.5, false);
INSERT INTO Producto (nombre, descripcion, precio, stock, impuesto, baja) VALUE ("ProductoB", "Descripcion del productoB", 32.30, 100, 1.5, false);
INSERT INTO Producto (nombre, descripcion, precio, stock, impuesto, baja) VALUE ("ProductoC", "Descripcion del productoC", 24.30, 100, 1.5, false);
INSERT INTO Producto (nombre, descripcion, precio, stock, impuesto, baja) VALUE ("ProductoD", "Descripcion del productoD", 12.65, 100, 1.5, false);
INSERT INTO Producto(nombre, descripcion, precio, stock, impuesto, baja) VALUE ("ProductoE", "Descripcion del productoE", 50.40, 200, 1.5, false);
