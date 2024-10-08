USE vivero;

ALTER TABLE detalle_pedido DROP FOREIGN KEY detalle_pedido_ibfk_2;

ALTER TABLE detalle_pedido
ADD CONSTRAINT fk_detalle_pedido_producto
	FOREIGN KEY (id_producto) REFERENCES producto (id_producto)
ON DELETE CASCADE;