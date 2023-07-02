package controlador;

import java.io.IOException;

import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import capaAyudante_controlador.DaoCliente;
import entidad.Clientes;
import entidad.Usuario;

/**
 * Servlet implementation class ServletClientes
 */
@WebServlet("/servletclient")
public class ServletClientes extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String ejecutarClientes = request.getParameter("ejecutarClientes");
		if (ejecutarClientes.equalsIgnoreCase("listar"))
			listaClientesInic(request, response);
		else if (ejecutarClientes.equalsIgnoreCase("agregar"))
			agregarClientes(request, response);
		else if (ejecutarClientes.equalsIgnoreCase("actualizar"))
			actualizarClientes(request, response);
		
	}

	private void actualizarClientes(HttpServletRequest request, HttpServletResponse response) throws IOException {
		DaoCliente daoCLiente = new DaoCliente();
		HttpSession session = request.getSession();
		Usuario usuario = (Usuario) session.getAttribute("usuario");
		if (usuario != null) {
			try {
				Clientes cli= new Clientes();
				
				cli.setCod_cliente(Integer.parseInt(request.getParameter("codigoActualizar")));
				cli.setNombre(request.getParameter("nombreAgregar"));
				cli.setApellidos(request.getParameter("apellidoAgregar"));
				cli.setDni(request.getParameter("dniAgregar"));
				cli.setTelefono(request.getParameter("telefonoAgregar"));
				cli.setCorreo(request.getParameter("correoAgregar"));
				cli.setDireccion(request.getParameter("dirrecionAgregar"));
				
				int salida= daoCLiente.actualizarClientes(cli);
				if (salida > 0) {
					request.getSession().setAttribute("TIPO", "ajs-success");
					request.getSession().setAttribute("MENSAJE", "Se actualizó correctamente");
				}else {
					request.getSession().setAttribute("TIPO", "ajs-error");
					request.getSession().setAttribute("MENSAJE", "error");
				}
				
				response.sendRedirect("servletclient?ejecutarClientes=listar&incial=");
			} catch (Exception e) {
				// TODO: handle exception
			}
		}else {
			response.sendRedirect("index.jsp");
		}
		
	}

	private void agregarClientes(HttpServletRequest request, HttpServletResponse response) throws IOException {
		DaoCliente daoCLiente = new DaoCliente();
		HttpSession session = request.getSession();
		Usuario usuario = (Usuario) session.getAttribute("usuario");
		if (usuario != null) {
			Clientes cli= new Clientes();
			
			cli.setNombre(request.getParameter("nombreAgregar"));
			cli.setApellidos(request.getParameter("apellidoAgregar"));
			cli.setDni(request.getParameter("dniAgregar"));
			cli.setTelefono(request.getParameter("telefonoAgregar"));
			cli.setCorreo(request.getParameter("correoAgregar"));
			cli.setDireccion(request.getParameter("dirrecionAgregar"));
			
			int salida= daoCLiente.agregarClientes(cli);
			if (salida > 0) {
				request.getSession().setAttribute("TIPO", "ajs-success");
				request.getSession().setAttribute("MENSAJE", "Se registro correctamente");
			}else {
				request.getSession().setAttribute("TIPO", "ajs-error");
				request.getSession().setAttribute("MENSAJE", "EL DNI del cliente ya se encuentra registrado");
			}
			response.sendRedirect("servletclient?ejecutarClientes=listar&incial=");
		}else {
			response.sendRedirect("index.jsp");
		}
		
	}

	private void listaClientesInic(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub
		DaoCliente daoCLiente = new DaoCliente();
		HttpSession session = request.getSession();
		Usuario usuario = (Usuario) session.getAttribute("usuario");
		if (usuario != null) {
			try {
				String inicial = request.getParameter("incial");
				List<Clientes> listaClientes = daoCLiente.ListadoCliente(inicial);
				request.setAttribute("clientes", listaClientes);
				request.getRequestDispatcher("RegistrarCliente.jsp").forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else {
			response.sendRedirect("index.jsp");
		}
	}

}
