package capaAyudante_controlador;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import capa_datos.MysqlBDConexion;
import entidad.Categoria;
import entidad.Producto;
import interfaces.InterfaceProducto;

public class DaoProducto implements InterfaceProducto{

	@Override
	public List<Producto> ListadoProducto(String inicial) {
		List<Producto> listarProducto = new ArrayList<Producto>();
		Connection c = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		try {
			c = MysqlBDConexion.getConexion();
			String sql = "CALL BuscarProductoPorInicial(?);";
			pstm = c.prepareStatement(sql);
			pstm.setString(1, inicial);
			rs = pstm.executeQuery();
			
			while (rs.next()) {
				Producto produc= new Producto();
				Categoria categ = new Categoria();
				
				produc.setCodProducto(rs.getInt("COD_PRODUCTO"));
				produc.setNombreProducto(rs.getString("NOMBRE_PRODUCTO"));
				produc.setStock(rs.getInt("STOCK"));
				produc.setFechadeVencimiento(rs.getDate("FECHA_VENCIMIENTO"));
				produc.setPrecio(rs.getDouble("PRECIO"));
				categ.setNombreCategoria(rs.getString("NOMBRE_CATEGORIA"));
				categ.setCod_categoria(rs.getInt("COD_CATEGORIA"));
				produc.setCategoria(categ);
				
				listarProducto.add(produc);
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
		return listarProducto;
	}

	@Override
	public List<Producto> ListadoProductoInactivos() {
		List<Producto> listarProductosInac = new ArrayList<Producto>();
		Connection c = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		try {
			c = MysqlBDConexion.getConexion();
			String sql = "CALL BuscarProductoInactivos();";
			pstm = c.prepareStatement(sql);
			rs = pstm.executeQuery();
			
			while (rs.next()) {
				Producto produc = new Producto();
				Categoria categ = new Categoria();
				
				produc.setCodProducto(rs.getInt("COD_PRODUCTO"));
				produc.setNombreProducto(rs.getString("NOMBRE_PRODUCTO"));
				produc.setStock(rs.getInt("STOCK"));
				produc.setFechadeVencimiento(rs.getDate("FECHA_VENCIMIENTO"));
				produc.setPrecio(rs.getDouble("PRECIO"));
				categ.setNombreCategoria(rs.getString("NOMBRE_CATEGORIA"));
				categ.setCod_categoria(rs.getInt("COD_CATEGORIA"));
				produc.setCategoria(categ);
				
				listarProductosInac.add(produc);
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
		
		return listarProductosInac;
	}
	
	@Override
	public int agregarProducto(Producto product) {
		int salida = -1;
		Connection c = null;
		PreparedStatement pstm = null;
		try {
			c = MysqlBDConexion.getConexion();
			String sql = "CALL AgregarProducto(?, ?, ?, ?, ?);";
			pstm = c.prepareStatement(sql);
			pstm.setInt(1, product.getCategoria().getCod_categoria());
			pstm.setString(2, product.getNombreProducto());
			pstm.setInt(3, product.getStock());
			pstm.setDate(4, new Date(product.getFechadeVencimiento().getTime() + 24 * 60 * 60 * 1000));
			pstm.setDouble(5, product.getPrecio());
			
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
	public int editarProducto(Producto product) {
		int salida = -1;
		Connection c = null;
		PreparedStatement pstm = null;
		try {
			c = MysqlBDConexion.getConexion();
			String sql = "CALL ActualizarProducto(?, ?, ?, ?, ?, ?);";
			pstm = c.prepareStatement(sql);
			pstm.setInt(1, product.getCodProducto());
			pstm.setInt(2, product.getCategoria().getCod_categoria());
			pstm.setString(3, product.getNombreProducto());
			pstm.setInt(4, product.getStock());
			pstm.setDate(5, new Date(product.getFechadeVencimiento().getTime() + 24 * 60 * 60 * 1000));
			pstm.setDouble(6, product.getPrecio());
			
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
	public int desactivarProducto(int idProducto) {
		int salida = -1;
		Connection c = null;
		PreparedStatement pstm = null;
		try {
			c = MysqlBDConexion.getConexion();
			String sql = "CALL DesactivarProducto(?);";
			pstm = c.prepareStatement(sql);
			pstm.setInt(1, idProducto);
			
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
	public int activarProducto(Producto product) {
		int salida = -1;
		Connection c = null;
		PreparedStatement pstm = null;
		try {
			c = MysqlBDConexion.getConexion();
			String sql = "CALL ActivarProducto(?, ?);";
			pstm = c.prepareStatement(sql);
			pstm.setInt(1, product.getCodProducto());
			pstm.setInt(2, product.getStock());
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
