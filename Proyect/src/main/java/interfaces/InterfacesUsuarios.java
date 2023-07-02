package interfaces;

import java.util.List;

import entidad.Usuario;

public interface InterfacesUsuarios {
	public int iniciarSesion(Usuario usu);
	public List<Usuario> ListadoUsuarios(String inicial);
	public int agregarUsuario(Usuario usua);
	public int actualizarUsuario(Usuario usuar);
	public int desactivarUsuario(int idUsuario);
	public List<Usuario> ListadoUsuarioInactivos();
	public int activarUsuario(int idUsuario);
	
}
