USE vivero;

ALTER TABLE detalle_pedido DROP FOREIGN KEY fk_detallePedido_producto;

ALTER TABLE detalle_pedido
ADD CONSTRAINT fk_detallePedido_producto
	FOREIGN KEY (id_producto) REFERENCES producto (id_producto)
ON DELETE CASCADE;