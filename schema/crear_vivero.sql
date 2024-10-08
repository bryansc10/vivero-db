DROP DATABASE IF EXISTS vivero;
CREATE DATABASE vivero;
USE vivero;

CREATE TABLE oficina (
  id_oficina INT AUTO_INCREMENT NOT NULL,
  codigo_oficina VARCHAR(10),
  ciudad VARCHAR(30) NOT NULL,
  pais VARCHAR(50) NOT NULL,
  region VARCHAR(50) DEFAULT NULL,
  codigo_postal VARCHAR(10) NOT NULL,
  telefono VARCHAR(20) NOT NULL,
  PRIMARY KEY (id_oficina)
);

CREATE TABLE empleado (
  id_empleado INT AUTO_INCREMENT NOT NULL,
  codigo_empleado INT NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  extension VARCHAR(10) NOT NULL,
  email VARCHAR(100) NOT NULL,
  id_oficina INT NOT NULL,
  id_jefe INTEGER DEFAULT NULL,
  puesto VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (id_empleado),
  CONSTRAINT fk_empleado_oficina FOREIGN KEY (id_oficina) REFERENCES oficina (id_oficina),
  CONSTRAINT fk_empleado_empleado FOREIGN KEY (id_jefe) REFERENCES empleado (id_empleado)
);

CREATE TABLE gama_producto (
  id_gama INT AUTO_INCREMENT NOT NULL,
  gama VARCHAR(50) NOT NULL,
  descripcion_texto TEXT,
  descripcion_html TEXT,
  imagen VARCHAR(256),
  PRIMARY KEY (id_gama)
);

CREATE TABLE cliente (
  id_cliente INT AUTO_INCREMENT NOT NULL,
  codigo_cliente INTEGER NOT NULL,
  nombre_cliente VARCHAR(50) NOT NULL,
  nombre_contacto VARCHAR(30) DEFAULT NULL,
  apellido_contacto VARCHAR(30) DEFAULT NULL,
  telefono VARCHAR(15) NOT NULL,
  fax VARCHAR(15) NOT NULL,
  ciudad VARCHAR(50) NOT NULL,
  region VARCHAR(50) DEFAULT NULL,
  pais VARCHAR(50) DEFAULT NULL,
  codigo_postal VARCHAR(10) DEFAULT NULL,
  id_empleado INTEGER DEFAULT NULL,
  limite_credito DECIMAL(15,2) DEFAULT NULL,
  PRIMARY KEY (id_cliente),
  CONSTRAINT fk_cliente_empleado FOREIGN KEY (id_empleado) REFERENCES empleado (id_empleado)
);

CREATE TABLE pedido (
  id_pedido INT AUTO_INCREMENT NOT NULL,
  codigo_pedido INTEGER NOT NULL,
  fecha_pedido DATE NOT NULL,
  fecha_esperada DATE NOT NULL,
  fecha_entrega DATE DEFAULT NULL,
  estado VARCHAR(15) NOT NULL,
  comentarios TEXT,
  id_cliente INTEGER NOT NULL,
  PRIMARY KEY (id_pedido),
  CONSTRAINT fk_pedido_cliente FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente)
);

CREATE TABLE producto (
  id_producto INT AUTO_INCREMENT NOT NULL,
  codigo_producto VARCHAR(15) NOT NULL,
  nombre VARCHAR(70) NOT NULL,
  id_gama INT NOT NULL,
  dimensiones VARCHAR(25) NULL,
  proveedor VARCHAR(50) DEFAULT NULL,
  descripcion text NULL,
  cantidad_en_stock SMALLINT NOT NULL,
  precio_venta NUMERIC(15,2) NOT NULL,
  precio_proveedor NUMERIC(15,2) DEFAULT NULL,
  PRIMARY KEY (id_producto),
  CONSTRAINT fk_producto_gamaProducto FOREIGN KEY (id_gama) REFERENCES gama_producto (id_gama)
);

CREATE TABLE detalle_pedido (
  id_detalle_pedido INT AUTO_INCREMENT NOT NULL,
  id_pedido INTEGER NOT NULL,
  id_producto INTEGER NOT NULL,
  cantidad INTEGER NOT NULL,
  precio_unidad DECIMAL(15,2) NOT NULL,
  numero_linea SMALLINT NOT NULL,
  PRIMARY KEY (id_detalle_pedido),
  CONSTRAINT fk_detallePedido_pedido FOREIGN KEY (id_pedido) REFERENCES pedido (id_pedido),
  CONSTRAINT fk_detallePedido_producto FOREIGN KEY (id_producto) REFERENCES producto (id_producto)
);

CREATE TABLE pago (
  id_pago INT AUTO_INCREMENT NOT NULL,
  id_cliente INTEGER NOT NULL,
  forma_pago VARCHAR(40) NOT NULL,
  id_transaccion VARCHAR(50) NOT NULL,
  fecha_pago DATE NOT NULL,
  total DECIMAL(15,2) NOT NULL,
  PRIMARY KEY (id_pago),
  CONSTRAINT fk_pago_cliente FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente)
);