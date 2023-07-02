package entidad;

public class Pedido_detalle {
	int codPedidoDetalle, cantidad;
	Pedido pedido;
	Producto producto;
	double precioVenta;
	
	public int getCodPedidoDetalle() {
		return codPedidoDetalle;
	}
	public void setCodPedidoDetalle(int codPedidoDetalle) {
		this.codPedidoDetalle = codPedidoDetalle;
	}
	public int getCantidad() {
		return cantidad;
	}
	public void setCantidad(int cantidad) {
		this.cantidad = cantidad;
	}
	public Pedido getPedido() {
		return pedido;
	}
	public void setPedido(Pedido pedido) {
		this.pedido = pedido;
	}
	public Producto getProducto() {
		return producto;
	}
	public void setProducto(Producto producto) {
		this.producto = producto;
	}
	public double getPrecioVenta() {
		return precioVenta;
	}
	public void setPrecioVenta(double precioVenta) {
		this.precioVenta = precioVenta;
	}

}

