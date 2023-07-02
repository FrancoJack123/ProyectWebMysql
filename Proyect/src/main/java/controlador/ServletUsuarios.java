package controlador;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import capaAyudante_controlador.ClsUsuario;
import capaAyudante_controlador.DaoProducto;
import entidad.Cargo;
import entidad.Producto;
import entidad.Usuario;

/**
 * Servlet implementation class ServletUsuarios
 */
@WebServlet("/servletUsuar")

public class ServletUsuarios extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String ejecutarUsuarios = request.getParameter("ejecutar");
		if (ejecutarUsuarios.equalsIgnoreCase("listar"))
			listaUsuariosInic(request, response);
		else if (ejecutarUsuarios.equalsIgnoreCase("listarInactivos"))
			listaInactivos(request, response);
		else if (ejecutarUsuarios.equalsIgnoreCase("agregar"))
			agregarUsuario(request, response);
		else if (ejecutarUsuarios.equalsIgnoreCase("actualizar"))
			actualizarUsuario(request, response);
		else if (ejecutarUsuarios.equalsIgnoreCase("eliminar"))
			elminarUsuario(request, response);
		else if (ejecutarUsuarios.equalsIgnoreCase("activar"))
			activarUsuario(request, response);

	}

	private void activarUsuario(HttpServletRequest request, HttpServletResponse response) throws IOException {
		ClsUsuario cls = new ClsUsuario();
		HttpSession session = request.getSession();
		Usuario usuario = (Usuario) session.getAttribute("usuario");
		if (usuario != null) {
			if (usuario.getCargo().getIdCargo() == 1) {
				try {
					int idUsuario;
					idUsuario = Integer.parseInt(request.getParameter("codigoActivar"));

					int salida = cls.activarUsuario(idUsuario);

					if (salida > 0) {
						request.getSession().setAttribute("TIPO", "ajs-success");
						request.getSession().setAttribute("MENSAJE", "Se activo correctamente");
					} else {
						request.getSession().setAttribute("TIPO", "ajs-error");
						request.getSession().setAttribute("MENSAJE", "error");
					}

					response.sendRedirect("servletUsuar?ejecutar=listarInactivos");
				} catch (Exception e) {
					// TODO: handle exception
				}
			} else {
				request.getSession().setAttribute("TIPO", "ajs-error");
				request.getSession().setAttribute("MENSAJE", "Esta opcion no esta disponible");
				response.sendRedirect("servletUsuar?ejecutar=listarInactivos");
			}
		} else {
			response.sendRedirect("index.jsp");
		}

	}

	private void listaInactivos(HttpServletRequest request, HttpServletResponse response) throws IOException {
		ClsUsuario cls = new ClsUsuario();
		DaoProducto daoProduc = new DaoProducto();
		HttpSession session = request.getSession();
		Usuario usuario = (Usuario) session.getAttribute("usuario");
		if (usuario != null) {
			try {
				List<Usuario> listadoUsuarioInactivos = cls.ListadoUsuarioInactivos();
				List<Producto> listadoProductoInactivos = daoProduc.ListadoProductoInactivos();
				request.setAttribute("usuarioInactivos", listadoUsuarioInactivos);
				request.setAttribute("productosInactivos", listadoProductoInactivos);
				request.getRequestDispatcher("Inactivos.jsp").forward(request, response);
			} catch (Exception e) {
				// TODO: handle exception
			}
		} else {
			request.getSession().setAttribute("TIPO", "ajs-error");
			request.getSession().setAttribute("MENSAJE", "Porfavor ingrese un usuario");
			response.sendRedirect("index.jsp");
		}
	}

	private void elminarUsuario(HttpServletRequest request, HttpServletResponse response) throws IOException {
		ClsUsuario cls = new ClsUsuario();
		HttpSession session = request.getSession();
		Usuario usuario = (Usuario) session.getAttribute("usuario");
		if (usuario != null) {
			if (usuario.getCargo().getIdCargo() == 1) {
				try {
					int codigo;
					codigo = Integer.parseInt(request.getParameter("nombreEliminar"));
					System.out.println(codigo);
					System.out.println(usuario.getIdUsuario());
					if (codigo != usuario.getIdUsuario()) {
						int salida = cls.desactivarUsuario(codigo);

						if (salida > 0) {

							request.getSession().setAttribute("TIPO", "ajs-error");
							request.getSession().setAttribute("MENSAJE", "Se desactivo correctamente");
						} else {
							request.getSession().setAttribute("TIPO", "ajs-error");
							request.getSession().setAttribute("MENSAJE", "error");
						}
						
					} else {
						request.getSession().setAttribute("TIPO", "ajs-error");
						request.getSession().setAttribute("MENSAJE", "Usted no se puede descativar");
					}

					response.sendRedirect("servletUsuar?ejecutar=listar&incial=");
				} catch (Exception e) {
					e.printStackTrace();
				}
			} else {
				request.getSession().setAttribute("TIPO", "ajs-error");
				request.getSession().setAttribute("MENSAJE", "Esta opcion no esta disponible");
				response.sendRedirect("servletUsuar?ejecutar=listar&incial=");
			}
		} else {
			request.getSession().setAttribute("TIPO", "ajs-error");
			request.getSession().setAttribute("MENSAJE", "Porfavor ingrese un usuario");
			response.sendRedirect("index.jsp");
		}

	}

	private void actualizarUsuario(HttpServletRequest request, HttpServletResponse response) throws IOException {
		ClsUsuario cls = new ClsUsuario();
		HttpSession session = request.getSession();
		Usuario usuario = (Usuario) session.getAttribute("usuario");
		if (usuario != null) {
			if (usuario.getCargo().getIdCargo() == 1) {
				try {
					Usuario usu = new Usuario();
					Cargo cargo = new Cargo();

					usu.setIdUsuario(Integer.parseInt(request.getParameter("codigoActualizar")));
					usu.setNombre(request.getParameter("nombreActualizar"));
					usu.setApellidos(request.getParameter("apellidoActualizar"));
					usu.setTelefono(request.getParameter("numeroActualizar"));
					usu.setCorreo(request.getParameter("correoActualizar"));
					cargo.setIdCargo(Integer.parseInt(request.getParameter("cargoActualizar")));
					usu.setCargo(cargo);

					int salida = cls.actualizarUsuario(usu);

					if (salida > 0) {
						request.getSession().setAttribute("TIPO", "ajs-success");
						request.getSession().setAttribute("MENSAJE", "Se actualizo correctamente");
					} else {
						request.getSession().setAttribute("TIPO", "ajs-error");
						request.getSession().setAttribute("MENSAJE", "error");
					}

					response.sendRedirect("servletUsuar?ejecutar=listar&incial=");
				} catch (Exception e) {
					e.printStackTrace();
				}
			} else {
				request.getSession().setAttribute("TIPO", "ajs-error");
				request.getSession().setAttribute("MENSAJE", "Esta opcion no esta disponible");
				response.sendRedirect("servletUsuar?ejecutar=listar&incial=");
			}
		} else {
			request.getSession().setAttribute("TIPO", "ajs-error");
			request.getSession().setAttribute("MENSAJE", "Porfavor ingrese un usuario");
			response.sendRedirect("index.jsp");
		}

	}

	private void agregarUsuario(HttpServletRequest request, HttpServletResponse response) throws IOException {
		ClsUsuario cls = new ClsUsuario();
		HttpSession session = request.getSession();
		Usuario usuario = (Usuario) session.getAttribute("usuario");
		if (usuario != null) {
			if (usuario.getCargo().getIdCargo() == 1) {
				try {
					Usuario usu = new Usuario();
					Cargo cargo = new Cargo();

					usu.setNombre(request.getParameter("nombreAgregar"));
					usu.setApellidos(request.getParameter("apellidoAgregar"));
					usu.setTelefono(request.getParameter("telefonoAgregar"));
					usu.setCorreo(request.getParameter("correoAgregar"));
					usu.setNombreUsuario(request.getParameter("usuarioAgregar"));
					usu.setClave(request.getParameter("contrasela"));
					cargo.setIdCargo(Integer.parseInt(request.getParameter("cargoAgregar")));
					usu.setCargo(cargo);

					int salida = cls.agregarUsuario(usu);

					if (salida > 0) {
						request.getSession().setAttribute("TIPO", "ajs-success");
						request.getSession().setAttribute("MENSAJE", "Se registro correctamente");
					} else {
						request.getSession().setAttribute("TIPO", "ajs-error");
						request.getSession().setAttribute("MENSAJE", "error");
					}
					response.sendRedirect("servletUsuar?ejecutar=listar&incial=");

				} catch (Exception e) {
					e.printStackTrace();
				}
			} else {
				request.getSession().setAttribute("TIPO", "ajs-error");
				request.getSession().setAttribute("MENSAJE", "Esta opcion no esta disponible");
				response.sendRedirect("servletUsuar?ejecutar=listar&incial=");
			}
		} else {
			request.getSession().setAttribute("TIPO", "ajs-error");
			request.getSession().setAttribute("MENSAJE", "Porfavor ingrese un usuario");
			response.sendRedirect("index.jsp");
		}
	}

	private void listaUsuariosInic(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ClsUsuario cls = new ClsUsuario();
		HttpSession session = request.getSession();
		Usuario usuario = (Usuario) session.getAttribute("usuario");
		if (usuario != null) {
			try {
				String inicial = request.getParameter("incial");
				List<Usuario> listaUsuarios = cls.ListadoUsuarios(inicial);
				request.setAttribute("usuarios", listaUsuarios);
				request.getRequestDispatcher("RegistrarUsuarios.jsp").forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			request.getSession().setAttribute("TIPO", "ajs-error");
			request.getSession().setAttribute("MENSAJE", "Porfavor ingrese un usuario");
			response.sendRedirect("index.jsp");
		}
	}

}
