package controlador;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import capaAyudante_controlador.DaoCategoria;
import capaAyudante_controlador.DaoProducto;
import entidad.Categoria;
import entidad.Producto;
import entidad.Usuario;

/**
 * Servlet implementation class ServletProductos
 */
@WebServlet("/servletProduct")
public class ServletProductos extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String ejecutarProductos = request.getParameter("ejecutar");
		if (ejecutarProductos.equalsIgnoreCase("listar"))
			listaProductosInic(request, response);
		else if (ejecutarProductos.equalsIgnoreCase("agregarProd"))
			agregarProductos(request, response);
		else if (ejecutarProductos.equalsIgnoreCase("agregarCateg"))
			agregarCategoria(request, response);
		else if (ejecutarProductos.equalsIgnoreCase("actualizarProduc"))
			actualizarProductos(request, response); 
		else if (ejecutarProductos.equalsIgnoreCase("actualizarCateg"))
			actualizarCategoria(request, response);
		else if (ejecutarProductos.equalsIgnoreCase("eliminar"))
			elminarProductos(request, response);
		else if (ejecutarProductos.equalsIgnoreCase("activar"))
			activarProductos(request, response);

	}

	private void activarProductos(HttpServletRequest request, HttpServletResponse response) throws IOException {
		DaoProducto daoProduc = new DaoProducto();
		HttpSession session = request.getSession();
		Usuario usuario = (Usuario) session.getAttribute("usuario");
		if (usuario != null) {
			try {
				Producto prod = new Producto();

				prod.setCodProducto(Integer.parseInt(request.getParameter("codigoProdcuto")));
				prod.setStock(Integer.parseInt(request.getParameter("stockProdcuto")));

				int salida = daoProduc.activarProducto(prod);

				if (salida > 0) {
					if (prod.getStock() > 0) {
						request.getSession().setAttribute("TIPO", "ajs-success");
						request.getSession().setAttribute("MENSAJE", "Se activo correctamente");
					}else {
						request.getSession().setAttribute("TIPO", "ajs-error");
						request.getSession().setAttribute("MENSAJE", "Porfavor agregue un stock");
					}
		
				} else {
					request.getSession().setAttribute("TIPO", "ajs-error");
					request.getSession().setAttribute("MENSAJE", "error");
				}

				response.sendRedirect("servletUsuar?ejecutar=listarInactivos");
			} catch (Exception e) {
				// TODO: handle exception
			}
		} else {
			response.sendRedirect("index.jsp");
		}

	}

	private void elminarProductos(HttpServletRequest request, HttpServletResponse response) throws IOException {
		DaoProducto daoProduc = new DaoProducto();
		HttpSession session = request.getSession();
		Usuario usuario = (Usuario) session.getAttribute("usuario");
		if (usuario != null) {
			
			int codProd = Integer.parseInt(request.getParameter("codigoEliminarproducto"));

			int salida = daoProduc.desactivarProducto(codProd);
			
			if (salida > 0) {
				request.getSession().setAttribute("TIPO", "ajs-error");
				request.getSession().setAttribute("MENSAJE", "Se desactivo correctamente");
			} else {
				request.getSession().setAttribute("TIPO", "ajs-error");
				request.getSession().setAttribute("MENSAJE", "error");
			}
			
			response.sendRedirect("servletProduct?ejecutar=listar&incial=");
			
		}else {
			response.sendRedirect("index.jsp");
		}

	}

	private void actualizarProductos(HttpServletRequest request, HttpServletResponse response) throws IOException {
		DaoProducto daoProduc = new DaoProducto();
		HttpSession session = request.getSession();
		Usuario usuario = (Usuario) session.getAttribute("usuario");
		if (usuario != null) {
			Categoria ca= new Categoria();
			Producto pro = new Producto();
			
			pro.setCodProducto(Integer.parseInt(request.getParameter("codigoProductoActu")));
			pro.setNombreProducto(request.getParameter("nombreProductoActu"));
			pro.setStock(Integer.parseInt(request.getParameter("stockProductoActu")));
			pro.setFechadeVencimiento(java.sql.Date.valueOf(request.getParameter("fechaProductoActu")));
			pro.setPrecio(Double.parseDouble(request.getParameter("precioProductoActu")));
			ca.setCod_categoria(Integer.parseInt(request.getParameter("categoriaProducActu")));
			pro.setCategoria(ca);
			
			int salida = daoProduc.editarProducto(pro);
			
			if (salida > 0) {
				request.getSession().setAttribute("TIPO", "ajs-success");
				request.getSession().setAttribute("MENSAJE", "Se actualizo correctamente");
			} else {
				request.getSession().setAttribute("TIPO", "ajs-error");
				request.getSession().setAttribute("MENSAJE", "error");
			}
			
			response.sendRedirect("servletProduct?ejecutar=listar&incial=");
			
		}else {
			response.sendRedirect("index.jsp");
		}

	}

	private void actualizarCategoria(HttpServletRequest request, HttpServletResponse response) throws IOException {
		DaoCategoria daoCateg = new DaoCategoria();
		HttpSession session = request.getSession();
		Usuario usuario = (Usuario) session.getAttribute("usuario");
		if (usuario != null) {
			try {
				Categoria ca= new Categoria();
				ca.setCod_categoria(Integer.parseInt(request.getParameter("categoriaCodigoActu")));
				ca.setNombreCategoria(request.getParameter("categoriaNombreActu"));
				int salida = daoCateg.editarCategoria(ca);
				
				if (salida > 0) {
					request.getSession().setAttribute("TIPO", "ajs-success");
					request.getSession().setAttribute("MENSAJE", "Se actualizo correctamente");
				} else {
					request.getSession().setAttribute("TIPO", "ajs-error");
					request.getSession().setAttribute("MENSAJE", "error");
				}
				
				response.sendRedirect("servletProduct?ejecutar=listar&incial=");
				
			} catch (Exception e) {
				// TODO: handle exception
			}
		} else {
			response.sendRedirect("index.jsp");
		}

	}

	private void agregarProductos(HttpServletRequest request, HttpServletResponse response) throws IOException {
		DaoProducto daoProduc = new DaoProducto();
		HttpSession session = request.getSession();
		Usuario usuario = (Usuario) session.getAttribute("usuario");
		if (usuario != null) {
			Categoria ca= new Categoria();
			Producto pro = new Producto();
			
			pro.setNombreProducto(request.getParameter("nombreProductoAgre"));
			pro.setStock(Integer.parseInt(request.getParameter("stockProductoAgre")));
			pro.setFechadeVencimiento(java.sql.Date.valueOf(request.getParameter("fechaProductoAgre")));
			pro.setPrecio(Double.parseDouble(request.getParameter("precioProductoAgre")));
			ca.setCod_categoria(Integer.parseInt(request.getParameter("categoriaProducAgre")));
			pro.setCategoria(ca);
			
			int salida = daoProduc.agregarProducto(pro);
			
			if (salida > 0) {
				request.getSession().setAttribute("TIPO", "ajs-success");
				request.getSession().setAttribute("MENSAJE", "Se agrego correctamente");
			} else {
				request.getSession().setAttribute("TIPO", "ajs-error");
				request.getSession().setAttribute("MENSAJE", "error");
			}
			
			response.sendRedirect("servletProduct?ejecutar=listar&incial=");
			
		}else {
			response.sendRedirect("index.jsp");
		}

	}

	private void agregarCategoria(HttpServletRequest request, HttpServletResponse response) throws IOException {
		DaoCategoria daoCateg = new DaoCategoria();
		HttpSession session = request.getSession();
		Usuario usuario = (Usuario) session.getAttribute("usuario");
		if (usuario != null) {
			try {
				Categoria ca= new Categoria();
				ca.setNombreCategoria(request.getParameter("categoriaNombre"));
				int salida = daoCateg.agregarCategoria(ca);
				
				if (salida > 0) {
					request.getSession().setAttribute("TIPO", "ajs-success");
					request.getSession().setAttribute("MENSAJE", "Se agrego correctamente");
				} else {
					request.getSession().setAttribute("TIPO", "ajs-error");
					request.getSession().setAttribute("MENSAJE", "error");
				}
				
				 response.sendRedirect("servletProduct?ejecutar=listar&incial=");
			} catch (Exception e) {
				// TODO: handle exception
			}
		} else {
			response.sendRedirect("index.jsp");
		}
	}

	private void listaProductosInic(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub
		DaoCategoria daoCateg = new DaoCategoria();
		DaoProducto daoProduc = new DaoProducto();
		HttpSession session = request.getSession();
		Usuario usuario = (Usuario) session.getAttribute("usuario");
		if (usuario != null) {
			try {
				String inicial = request.getParameter("incial");
				List<Producto> listaProducto = daoProduc.ListadoProducto(inicial);
				List<Categoria> listaCategoria = daoCateg.ListadoCategoria();

				request.setAttribute("produc", listaProducto);
				
				request.setAttribute("categorias", listaCategoria);
				
				request.getRequestDispatcher("RegistrarProductos.jsp").forward(request, response);
			} catch (Exception e) {
				// TODO: handle exception
			}
		} else {
			response.sendRedirect("index.jsp");
		}
	}

}
