package interfaces;

import java.util.List;
import entidad.Categoria;

public interface InterfaceCategoria {
	public List<Categoria> ListadoCategoria();
	public int agregarCategoria(Categoria categoria);
	public int editarCategoria(Categoria categoria);
}
