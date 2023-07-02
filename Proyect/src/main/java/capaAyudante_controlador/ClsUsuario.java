package capaAyudante_controlador;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import capa_datos.MysqlBDConexion;
import entidad.Cargo;
import entidad.Usuario;
import interfaces.InterfacesUsuarios;

public class ClsUsuario implements InterfacesUsuarios {

	@Override
	public int iniciarSesion(Usuario usu) {
		Connection c = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		int r = 0;

		try {
			c = MysqlBDConexion.getConexion();
			String sql = "SELECT U.COD_USUARIO, U.NOMBRES, U.APELLIDOS, U.ACTIVO, C.COD_CARGO, C.DESC_CARGO\r\n"
					+ "FROM USUARIO U\r\n"
					+ "JOIN CARGO C ON U.COD_CARGO = C.COD_CARGO\r\n"
					+ "WHERE U.NOMBRE_USUARIO = ? AND U.CONTRASENA = ?;";
			pstm = c.prepareStatement(sql);
			pstm.setString(1, usu.getNombreUsuario());
			pstm.setString(2, usu.getClave());
			rs = pstm.executeQuery();
			while (rs.next()) {
				r = r + 1;
				Cargo ca = new Cargo();
				usu.setIdUsuario(rs.getInt("COD_USUARIO"));
				usu.setNombre((rs.getString("NOMBRES")));
				usu.setApellidos(rs.getString("APELLIDOS"));
				usu.setActivo(rs.getInt("ACTIVO"));
				ca.setIdCargo(Integer.parseInt(rs.getString("COD_CARGO")));
				ca.setNombreCargo(rs.getString("DESC_CARGO"));
				usu.setCargo(ca);
			}
			if (r == 1) {
				return 1;
			} else
				return 0;

		} catch (Exception e) {
			return 0;
		}

		finally {
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
	}

	@Override
	public List<Usuario> ListadoUsuarios(String inicial) {
		List<Usuario> listaUsuarios = new ArrayList<Usuario>();
		Connection c = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		try {
			c = MysqlBDConexion.getConexion();
			String sql = "CALL BuscarUsuarioInic(?);";
			pstm = c.prepareStatement(sql);
			pstm.setString(1, inicial);
			rs = pstm.executeQuery();
			Usuario usuario = null;
			Cargo car = null;

			while (rs.next()) {
				usuario = new Usuario();
				car = new Cargo();

				usuario.setIdUsuario(rs.getInt("COD_USUARIO"));
				usuario.setNombre(rs.getString("NOMBRES"));
				usuario.setApellidos(rs.getString("APELLIDOS"));
				usuario.setTelefono(rs.getString("TELEFONO"));
				usuario.setCorreo(rs.getString("CORREO"));
				car.setIdCargo(rs.getInt("COD_CARGO"));
				car.setNombreCargo(rs.getString("DESC_CARGO"));
				usuario.setCargo(car);

				listaUsuarios.add(usuario);
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
		return listaUsuarios;
	}

	@Override
	public int agregarUsuario(Usuario usua) {
		int salida = -1;
		Connection c = null;
		PreparedStatement pstm = null;
		try {
			c = MysqlBDConexion.getConexion();
			String sql = "CALL RegistrarUsuario( ?, ?, ?, ?, ?, ?, ?);";
			pstm = c.prepareStatement(sql);
			pstm.setString(1, usua.getNombre());
			pstm.setString(2, usua.getApellidos());
			pstm.setString(3, "+51 " + usua.getTelefono());
			pstm.setString(4, usua.getCorreo() + "@gmail.com");
			pstm.setString(5, usua.getNombreUsuario());
			pstm.setString(6, usua.getClave());
			pstm.setInt(7, usua.getCargo().getIdCargo());
			
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
	public int actualizarUsuario(Usuario usuar) {
		int salida = -1;
		Connection c = null;
		PreparedStatement pstm = null;
		try {
			c = MysqlBDConexion.getConexion();
			String sql = "CALL ActualizarUsuario(?, ?, ?, ?, ?, ?);";
			pstm = c.prepareStatement(sql);
			pstm.setInt(1, usuar.getIdUsuario());
			pstm.setString(2, usuar.getNombre());
			pstm.setString(3, usuar.getApellidos());
			pstm.setString(4, "+51 " + usuar.getTelefono());
			pstm.setString(5, usuar.getCorreo() + "@gmail.com");
			pstm.setInt(6, usuar.getCargo().getIdCargo());
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

	@Override
	public int desactivarUsuario(int idUsuario) {
		int salida = 0;
		Connection c = null;
		PreparedStatement pstm = null;
		try {
			c = MysqlBDConexion.getConexion();
			String sql = "CALL DesactivarUsuario(?);";
			pstm = c.prepareStatement(sql);
			pstm.setInt(1, idUsuario);
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

	@Override
	public List<Usuario> ListadoUsuarioInactivos() {
		List<Usuario> ListarUsuarioInactivos = new ArrayList<Usuario>();
		Connection c = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		try {
			c = MysqlBDConexion.getConexion();
			String sql="CALL ListarUsuariosInactivos();";
			pstm = c.prepareStatement(sql);
			rs = pstm.executeQuery();
			while (rs.next()) {
				Usuario usu = new Usuario();
				Cargo car= new Cargo();
				
				usu.setIdUsuario(rs.getInt("COD_USUARIO"));
				usu.setNombre(rs.getString("NOMBRES"));
				usu.setApellidos(rs.getString("APELLIDOS"));
				usu.setTelefono(rs.getString("TELEFONO"));
				usu.setCorreo(rs.getString("CORREO"));
				car.setIdCargo(rs.getInt("COD_CARGO"));
				car.setNombreCargo(rs.getString("DESC_CARGO"));
				usu.setCargo(car);
				
				ListarUsuarioInactivos.add(usu);		
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
		return ListarUsuarioInactivos;
	}

	@Override
	public int activarUsuario(int idUsuario) {
		int salida = -1;
		Connection c = null;
		PreparedStatement pstm = null;
		try {
			c = MysqlBDConexion.getConexion();
			String sql = "CALL ActivarUsuario(?);";
			pstm = c.prepareStatement(sql);
			pstm.setInt(1, idUsuario);
			
			salida = pstm.executeUpdate() + 2;
			
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
