package interfaces;

import java.util.List;

import entidad.Clientes;
import entidad.Pedido;
import entidad.Pedido_detalle;
import entidad.Producto;

public interface InterfacePedido {
	public Clientes BuscarCliente(int documentoDni);
	public Producto BuscarProducto(int codigo);
	public int AgregarPedido(Pedido ped);
	public int AgregarDetallePedido(Pedido_detalle pedDeta);
	public List<Pedido> ListadoPedido(String inicial);
	public int CancelarPedido( int codped);
	public int FinalizarPedido( int codped);
}
