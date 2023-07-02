package interfaces;

import java.util.List;
import entidad.Producto;

public interface InterfaceProducto {
	public List<Producto> ListadoProducto(String inicial);
	public int agregarProducto(Producto product);
	public int editarProducto(Producto product);
	public int desactivarProducto(int idProducto);
	public List<Producto> ListadoProductoInactivos();
	public int activarProducto(Producto product);
}
