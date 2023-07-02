package capaAyudante_controlador;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import capa_datos.MysqlBDConexion;
import entidad.Clientes;
import interfaces.InterfaceCliente;

public class DaoCliente implements InterfaceCliente {

	@Override
	public List<Clientes> ListadoCliente(String inicial) {
		List<Clientes> listaClientes =  new ArrayList<Clientes>();
		Connection c = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		try {
			c = MysqlBDConexion.getConexion();
			String sql = "CALL BuscarClientePorInicial(?);";
			pstm = c.prepareStatement(sql);
			pstm.setString(1, inicial);
			rs = pstm.executeQuery();
			
			while (rs.next()) {
				Clientes cliente = new Clientes();
				
				cliente.setCod_cliente(rs.getInt("COD_CLIENTE"));
				cliente.setNombre(rs.getString("NOMBRES"));
				cliente.setApellidos(rs.getString("APELLIDOS"));
				cliente.setDni(rs.getString("DNI"));
				cliente.setTelefono(rs.getString("TELEFONO"));
				cliente.setCorreo(rs.getString("CORREO"));
				cliente.setDireccion(rs.getString("DIRECCION"));
				
				listaClientes.add(cliente);
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
		
		return listaClientes;
	}

	@Override
	public int agregarClientes(Clientes cliente) {
		int salida = -1;
		Connection c = null;
		PreparedStatement pstm = null;
		try {
			c = MysqlBDConexion.getConexion();
			String sql ="CALL AgregarCliente(?, ?, ?, ?, ?, ?);";
			pstm = c.prepareStatement(sql);
			pstm.setString(1, cliente.getNombre());
			pstm.setString(2, cliente.getApellidos());
			pstm.setString(3, cliente.getDni());
			pstm.setString(4, "+51 " + cliente.getTelefono());
			pstm.setString(5, cliente.getCorreo() + "@gmail.com");
			pstm.setString(6, cliente.getDireccion());
			
			salida = pstm.executeUpdate() + 2;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstm != null)
					pstm.close();
			} catch (SQLException e1) {
			}
			try {
				if (c != null)
					c.close();
			} catch (SQLException e) {
			}
		}
		
		return salida;
	}

	@Override
	public int actualizarClientes(Clientes cliente) {
		int salida = -1;
		Connection c = null;
		PreparedStatement pstm = null;
		try {
			c = MysqlBDConexion.getConexion();
			String sql = "CALL ActualizarCliente(?, ?, ?, ?, ?, ?, ?);";
			pstm = c.prepareStatement(sql);
			pstm.setInt(1, cliente.getCod_cliente());
			pstm.setString(2, cliente.getNombre());
			pstm.setString(3, cliente.getApellidos());
			pstm.setString(4, cliente.getDni());
			pstm.setString(5, "+51 " + cliente.getTelefono());
			pstm.setString(6, cliente.getCorreo() + "@gmail.com");
			pstm.setString(7, cliente.getDireccion());
			
			salida = pstm.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstm != null)
					pstm.close();
				if (c != null)
					c.close();
			} catch (Exception e2) {
			}
		}
		return salida;
	}

}
