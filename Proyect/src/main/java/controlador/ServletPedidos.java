package controlador;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import capaAyudante_controlador.DaoCliente;
import capaAyudante_controlador.DaoPedidos;
import capaAyudante_controlador.DaoProducto;
import capa_datos.MysqlBDConexion;
import entidad.Clientes;
import entidad.Pedido;
import entidad.Pedido_detalle;
import entidad.Producto;
import entidad.Usuario;

/**
 * Servlet implementation class ServletPedidos
 */
@WebServlet("/servletpedido")
public class ServletPedidos extends HttpServlet {
	Clientes cli = new Clientes();
	Producto pro = new Producto();
	DaoProducto daoProduc = new DaoProducto();
	List<Producto> listaProducto = daoProduc.ListadoProducto("");
	List<Pedido_detalle> ListaPedidoDeta = new ArrayList<Pedido_detalle>();

	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String ejecutarProductos = request.getParameter("ejecutar");
		String accion = request.getParameter("accion");
		DaoPedidos dao = new DaoPedidos();
		if (ejecutarProductos.equalsIgnoreCase("listar"))
			listar(request, response);
		if (ejecutarProductos.equalsIgnoreCase("listarNuevo"))
			listarNUevo(request, response);
		if (ejecutarProductos.equalsIgnoreCase("listadoPedido"))
			listadoPedido(request, response);
		if (ejecutarProductos.equalsIgnoreCase("cancelarPedido"))
			cancelarPedido(request, response);
		if (ejecutarProductos.equalsIgnoreCase("finalizarPedido"))
			finalizarPedido(request, response);
		if (ejecutarProductos.equals("ejecutarVenta")) {
			HttpSession session = request.getSession();
			Usuario usuario = (Usuario) session.getAttribute("usuario");
			switch (accion) {
			case "buscarClie":
				try {
					cli = null;
					int documentoIndentidad = Integer.parseInt(request.getParameter("dniCLiente"));
					cli = dao.BuscarCliente(documentoIndentidad);
					if (cli.getDni() != null) {
						request.setAttribute("produc", listaProducto);
						request.setAttribute("listaventas", ListaPedidoDeta);
						request.setAttribute("cliente", cli);
						request.getSession().setAttribute("TIPO", "ajs-success");
						request.getSession().setAttribute("MENSAJE",
								"Cliente : " + cli.getNombre() + " " + cli.getApellidos());
					} else {
						request.setAttribute("listaventas", ListaPedidoDeta);
						request.getSession().setAttribute("TIPO", "ajs-error");
						request.getSession().setAttribute("MENSAJE", "Numero de Documento Incorrecto");
					}
				} catch (Exception e) {
					request.setAttribute("listaventas", ListaPedidoDeta);
					request.getSession().setAttribute("TIPO", "ajs-error");
					request.getSession().setAttribute("MENSAJE", "Porfavor ingresa un numero de Documento");
				}
				break;

			case "agregarProduc":
				try {
					Pedido_detalle peDeta = new Pedido_detalle();
					Producto producto = new Producto();
					double precio = Double.parseDouble(request.getParameter("precioProducto"));
					producto.setCodProducto(Integer.parseInt(request.getParameter("productoCodigo")));
					producto.setNombreProducto(request.getParameter("nameProducto"));
					peDeta.setProducto(producto);
					peDeta.setCantidad(Integer.parseInt(request.getParameter("cantidadProducto")));
					peDeta.setPrecioVenta(Double.parseDouble(request.getParameter("precioTotalProd")));
					System.out.println(producto.getCodProducto());
					ListaPedidoDeta.add(peDeta);
					request.setAttribute("listaventas", ListaPedidoDeta);
					request.setAttribute("cliente", cli);

				} catch (Exception e) {
					e.printStackTrace();
				}
				break;

			case "registrarVenta":
				try {
					if (ListaPedidoDeta.size() != 0) {
						Pedido pedi = new Pedido();
						pedi.setCliente(cli);
						pedi.setUsuario(usuario);
						pedi.setMonto(Double.parseDouble(request.getParameter("totalPedcio1")));
						int salida = dao.AgregarPedido(pedi);
						for (int i = 0; i < ListaPedidoDeta.size(); i++) {
							Pedido_detalle deta = new Pedido_detalle();
							deta.setPedido(pedi);
							deta.setProducto(ListaPedidoDeta.get(i).getProducto());
							deta.setCantidad(ListaPedidoDeta.get(i).getCantidad());
							deta.setPrecioVenta(ListaPedidoDeta.get(i).getPrecioVenta());
							int ejecu = dao.AgregarDetallePedido(deta);
						}
						ListaPedidoDeta.clear();
						cli = null;

						if (salida != 0) {
							request.getSession().setAttribute("TIPO", "ajs-success");
							request.getSession().setAttribute("MENSAJE", "Venta Registrada con Exito");
							
						} else {
							request.getSession().setAttribute("TIPO", "ajs-error");
							request.getSession().setAttribute("MENSAJE", "Error en el proceso de Venta");
						}
					} else {
						request.getSession().setAttribute("TIPO", "ajs-error");
						request.getSession().setAttribute("MENSAJE", "Porfavor seleccion algun producto");
					}
					
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;

			case "eliminarProducto":
				try {
					int productoId = Integer.parseInt(request.getParameter("productoId"));

					Iterator<Pedido_detalle> iterator = ListaPedidoDeta.iterator();
					while (iterator.hasNext()) {
						Pedido_detalle detalle = iterator.next();
						if (detalle.getProducto().getCodProducto() == productoId) {
							iterator.remove();
							break;
						}
					}

					request.setAttribute("produc", listaProducto);
					request.setAttribute("cliente", cli);
					request.setAttribute("listaventas", ListaPedidoDeta);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;

			case "cancelar":
				try {

					ListaPedidoDeta.clear();
					cli = null;

					request.setAttribute("produc", listaProducto);
					request.setAttribute("cliente", cli);
					request.setAttribute("listaventas", ListaPedidoDeta);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;

			default:
				break;
			}

			request.setAttribute("produc", listaProducto);
			request.setAttribute("cliente", cli);
			request.setAttribute("listaventas", ListaPedidoDeta);

			response.sendRedirect("servletpedido?ejecutar=listar");
		}
	}

	private void finalizarPedido(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		Usuario usuario = (Usuario) session.getAttribute("usuario");
		DaoPedidos dao = new DaoPedidos();
		if (usuario != null) {
			try {
				int idPedido = Integer.parseInt(request.getParameter("codPedidoFina"));
				int estadoPedido = Integer.parseInt(request.getParameter("estapedidofin"));
				if(estadoPedido != 3) {
					if (estadoPedido != 2) {
						int salida = dao.FinalizarPedido(idPedido);
						request.getSession().setAttribute("TIPO", "ajs-success");
						request.getSession().setAttribute("MENSAJE", "El pedido ha sido finalizado correctamente");
					}else {
						request.getSession().setAttribute("TIPO", "ajs-error");
						request.getSession().setAttribute("MENSAJE", "El pedido esta cancelado");
					}
				}else {
					request.getSession().setAttribute("TIPO", "ajs-error");
					request.getSession().setAttribute("MENSAJE", "El pedido ya ha sido finalizado");
				}
				
				response.sendRedirect("servletpedido?ejecutar=listadoPedido&incial=");
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			request.getSession().setAttribute("TIPO", "ajs-error");
			request.getSession().setAttribute("MENSAJE", "Porfavor ingrese un usuario");
			response.sendRedirect("index.jsp");
		}
	}

	private void cancelarPedido(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		Usuario usuario = (Usuario) session.getAttribute("usuario");
		DaoPedidos dao = new DaoPedidos();
		if (usuario != null) {
			try {
				int idPedido = Integer.parseInt(request.getParameter("codpedidoCancel"));
				int estadoPedido = Integer.parseInt(request.getParameter("estapedidoCancel"));
				if(estadoPedido != 3) {
					if (estadoPedido != 2) {
						int salida = dao.CancelarPedido(idPedido);
						request.getSession().setAttribute("TIPO", "ajs-error");
						request.getSession().setAttribute("MENSAJE", "El pedido ha sido cancelado correctamente");
					}else {
						request.getSession().setAttribute("TIPO", "ajs-error");
						request.getSession().setAttribute("MENSAJE", "El pedido ya estaba cancelado");
					}
				}else {
					request.getSession().setAttribute("TIPO", "ajs-error");
					request.getSession().setAttribute("MENSAJE", "El pedido ya ha sido finalizado");
				}
				
				response.sendRedirect("servletpedido?ejecutar=listadoPedido&incial=");
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			request.getSession().setAttribute("TIPO", "ajs-error");
			request.getSession().setAttribute("MENSAJE", "Porfavor ingrese un usuario");
			response.sendRedirect("index.jsp");
		}
		
	}

	private void listadoPedido(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		Usuario usuario = (Usuario) session.getAttribute("usuario");
		DaoPedidos dao = new DaoPedidos();
		if (usuario != null) {
			try {
				String inicial = request.getParameter("incial");
				List<Pedido> listaPed = dao.ListadoPedido(inicial);
				request.setAttribute("listaPed", listaPed);
				request.getRequestDispatcher("ListarPedidos.jsp").forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			request.getSession().setAttribute("TIPO", "ajs-error");
			request.getSession().setAttribute("MENSAJE", "Porfavor ingrese un usuario");
			response.sendRedirect("index.jsp");
		}
		
	}

	private void listarNUevo(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		Usuario usuario = (Usuario) session.getAttribute("usuario");
		if (usuario != null) {
			try {
				ListaPedidoDeta.clear();
				cli = null;
				request.setAttribute("produc", listaProducto);
				request.getRequestDispatcher("RegistrarPedidos.jsp").forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			response.sendRedirect("index.jsp");
		}
	}

	private void listar(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		Usuario usuario = (Usuario) session.getAttribute("usuario");
		if (usuario != null) {
			try {
				request.setAttribute("produc", listaProducto);
				request.setAttribute("cliente", cli);
				request.setAttribute("listaventas", ListaPedidoDeta);
				request.getRequestDispatcher("RegistrarPedidos.jsp").forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			response.sendRedirect("index.jsp");
		}
	}

}
