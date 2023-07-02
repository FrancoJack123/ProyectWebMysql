package capaAyudante_controlador;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import capa_datos.MysqlBDConexion;
import entidad.Clientes;
import entidad.Pedido;
import entidad.Pedido_detalle;
import entidad.Producto;
import entidad.Usuario;
import interfaces.InterfacePedido;

public class DaoPedidos implements InterfacePedido{

	@Override
	public Clientes BuscarCliente(int documentoDni) {
		Clientes cliente = new Clientes();
		Connection c = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		try {
			c = MysqlBDConexion.getConexion();
			String sql = "SELECT * FROM CLIENTE WHERE DNI = ?;";
			pstm = c.prepareStatement(sql);
			pstm.setInt(1, documentoDni);
			rs = pstm.executeQuery();
			while (rs.next()) {
				cliente.setCod_cliente(rs.getInt(1));
				cliente.setNombre(rs.getString(2));
				cliente.setApellidos(rs.getString(3));
				cliente.setDireccion(rs.getString("DIRECCION"));
				cliente.setDni(rs.getString(4));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (c != null)
					c.close();
				if (pstm != null)
					pstm.close();
			} catch (Exception e2) {

			}
		}
		return cliente;
	}

	@Override
	public Producto BuscarProducto(int codigo) {
		Producto prod = new Producto();
		Connection c = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		try {
			c = MysqlBDConexion.getConexion();
			String sql = "SELECT * FROM PRODUCTOS WHERE COD_PRODUCTO = ?;";
			pstm = c.prepareStatement(sql);
			pstm.setInt(1, codigo);
			rs = pstm.executeQuery();
			while (rs.next()) {
				prod.setCodProducto(rs.getInt(1));
				prod.setNombreProducto(rs.getString(3));
				prod.setStock(rs.getInt(4));
				prod.setPrecio(rs.getDouble(6));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (c != null)
					c.close();
				if (pstm != null)
					pstm.close();
			} catch (Exception e2) {

			}
		}
		return prod;
	}

	@Override
	public int AgregarPedido(Pedido ped) {
		int salida = -1;
		Connection c = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		try {
			c = MysqlBDConexion.getConexion();
			String sql = "CALL RegistrarPedido(?, ?, ?);";
			pstm = c.prepareStatement(sql);
			pstm.setInt(1, ped.getCliente().getCod_cliente());
			pstm.setInt(2, ped.getUsuario().getIdUsuario());
			pstm.setDouble(3, ped.getMonto());
			rs = pstm.executeQuery();
			while (rs.next()) {
				ped.setCodPedido(rs.getInt(1));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (c != null)
					c.close();
				if (pstm != null)
					pstm.close();
			} catch (Exception e2) {

			}
		}
		return salida;
	}

	@Override
	public int AgregarDetallePedido(Pedido_detalle pedDeta) {
		int salida = -1;
		Connection c = null;
		PreparedStatement pstm = null;
		try {
			c = MysqlBDConexion.getConexion();
			String sql = "CALL CrearDetallePedido(?, ?, ?, ?);";
			pstm = c.prepareStatement(sql);
			pstm.setInt(1, pedDeta.getPedido().getCodPedido());
			pstm.setInt(2, pedDeta.getProducto().getCodProducto());
			pstm.setInt(3, pedDeta.getCantidad());
			pstm.setDouble(4, pedDeta.getPrecioVenta());
			salida = pstm.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (c != null)
					c.close();
				if (pstm != null)
					pstm.close();
			} catch (Exception e2) {

			}
		}
		return salida;
	}

	@Override
	public List<Pedido> ListadoPedido(String inicial) {
		List<Pedido> listaPedido =  new ArrayList<Pedido>();
		Connection c = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		try {
			c = MysqlBDConexion.getConexion();
			String sql = "CALL ListarPedidosPorCliente(?);";
			pstm = c.prepareStatement(sql);
			pstm.setString(1, inicial);
			rs = pstm.executeQuery();
			
			while (rs.next()) {
				Pedido ped = new Pedido();
				Clientes cli = new Clientes();
				Usuario usu = new Usuario();
				
				ped.setCodPedido(rs.getInt(1));
				cli.setCod_cliente(rs.getInt(2));
				cli.setNombre(rs.getString(3));
				ped.setCliente(cli);
				usu.setIdUsuario(4);
				ped.setUsuario(usu);
				ped.setMonto(rs.getDouble(5));
				ped.setEstado(rs.getString(6));
				listaPedido.add(ped);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (c != null)
					c.close();
				if (pstm != null)
					pstm.close();
			} catch (Exception e2) {

			}
		}
		
		return listaPedido;
	}

	@Override
	public int CancelarPedido(int codped) {
		int salida = -1;
		Connection c = null;
		PreparedStatement pstm = null;
		try {
			c = MysqlBDConexion.getConexion();
			String sql = "CALL CambiarEstadoCancelar(?);";
			pstm = c.prepareStatement(sql);
			pstm.setInt(1, codped);
			salida = pstm.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (c != null)
					c.close();
				if (pstm != null)
					pstm.close();
			} catch (Exception e2) {

			}
		}
		return salida;
	}

	@Override
	public int FinalizarPedido(int codped) {
		int salida = -1;
		Connection c = null;
		PreparedStatement pstm = null;
		try {
			c = MysqlBDConexion.getConexion();
			String sql = "CALL CambiarEstadoFinalizado(?);";
			pstm = c.prepareStatement(sql);
			pstm.setInt(1, codped);
			salida = pstm.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (c != null)
					c.close();
				if (pstm != null)
					pstm.close();
			} catch (Exception e2) {

			}
		}
		return salida;
	}

}
