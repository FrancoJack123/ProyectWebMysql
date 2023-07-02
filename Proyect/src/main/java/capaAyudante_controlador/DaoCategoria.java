package capaAyudante_controlador;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import capa_datos.MysqlBDConexion;
import entidad.Categoria;
import interfaces.InterfaceCategoria;

public class DaoCategoria implements InterfaceCategoria {

	@Override
	public List<Categoria> ListadoCategoria() {
		List<Categoria> listaCategoria = new ArrayList<Categoria>();
		Connection c = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		try {
			c = MysqlBDConexion.getConexion();
			String sql = "SELECT * FROM CATEGORIA;";
			pstm = c.prepareStatement(sql);
			rs = pstm.executeQuery();
			
			while (rs.next()) {
				Categoria categ = new Categoria();
				
				categ.setCod_categoria(rs.getInt("COD_CATEGORIA"));
				categ.setNombreCategoria(rs.getString("NOMBRE_CATEGORIA"));
				
				listaCategoria.add(categ);
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
		return listaCategoria;
	}

	@Override
	public int agregarCategoria(Categoria categoria) {
		int salida = -1;
		Connection c = null;
		PreparedStatement pstm = null;
		try {
			c = MysqlBDConexion.getConexion();
			String sql = "INSERT INTO CATEGORIA (NOMBRE_CATEGORIA) VALUES (?);";
			pstm = c.prepareStatement(sql);
			pstm.setString(1, categoria.getNombreCategoria());
			
			salida =  pstm.executeUpdate();
					
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (c!= null)
					c.close();
				if (pstm != null)
					pstm.close();
			} catch (Exception e2) {

			}
		}
		return salida;
	}

	@Override
	public int editarCategoria(Categoria categoria) {
		int salida = -1;
		Connection c = null;
		PreparedStatement pstm = null;
		try {
			c = MysqlBDConexion.getConexion();
			String sql = "UPDATE CATEGORIA SET NOMBRE_CATEGORIA =? WHERE COD_CATEGORIA =?;";
			pstm = c.prepareStatement(sql);
			pstm.setInt(2, categoria.getCod_categoria());
			pstm.setString(1, categoria.getNombreCategoria());
			
			salida =  pstm.executeUpdate();
					
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (c!= null)
					c.close();
				if (pstm != null)
					pstm.close();
			} catch (Exception e2) {

			}
		}
		return salida;
	}

}
