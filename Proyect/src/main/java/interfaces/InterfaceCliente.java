package interfaces;

import java.util.List;

import entidad.Clientes;

public interface InterfaceCliente {
	public List<Clientes> ListadoCliente(String inicial);
	public int agregarClientes(Clientes cliente);
	public int actualizarClientes(Clientes cliente);
}
