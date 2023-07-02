package capaAyudante_controlador;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import capa_datos.MysqlBDConexion;
import entidad.DashboardSemanaCliente;
import entidad.DashboardSemanaPedido;
import entidad.DasshboardCards;
import interfaces.InterfaceDashboard;

public class DaoDashboard implements InterfaceDashboard{

	@Override
	public int Cards(DasshboardCards dash) {
		int salida = -1;
		Connection c = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		try {
			c = MysqlBDConexion.getConexion();
			String sql = "CALL ListarDashboard();";
			pstm = c.prepareStatement(sql);
			rs = pstm.executeQuery();
			while (rs.next()) {
				salida = salida + 1;
				dash.setUsuarioTotal(rs.getInt(1));
				dash.setHoyUsuario(rs.getInt(2));
				dash.setUsuarioInactivos(rs.getInt(3));
				dash.setClienteTotal(rs.getInt(4));
				dash.setClienteHoy(rs.getInt(5));
				dash.setClienteInactivos(0);
				dash.setProductosTotal(rs.getInt(6));
				dash.setHoyproductos(rs.getInt(7));
				dash.setProductosInactivos(rs.getInt(8));
			}
			if (salida == 1) {
				return 1;
			} else
				return 0;
			
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
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
	}

	@Override
	public int SemanaCliente(DashboardSemanaCliente semanClien) {
		int salida = -1;
		Connection c = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		try {
			c=MysqlBDConexion.getConexion();
			String sql = "call ObtenerClientesRegistradosPorDia();";
			pstm = c.prepareStatement(sql);
			rs = pstm.executeQuery();
			while (rs.next()) {
				semanClien.setLunes(rs.getInt(1));
				semanClien.setMartes(rs.getInt(2));
				semanClien.setMier(rs.getInt(3));
				semanClien.setJueve(rs.getInt(4));
				semanClien.setVierne(rs.getInt(5));
				semanClien.setSabado(rs.getInt(6));
				semanClien.setDomin(rs.getInt(7));
			}
			if (salida == 1) {
				return 1;
			} else
				return 0;
			
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
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
	}

	@Override
	public int SemanaPedido(DashboardSemanaPedido semanPedi) {
		int salida = -1;
		Connection c = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		try {
			c=MysqlBDConexion.getConexion();
			String sql = "CALL ObtenerPedidosRegistradosPorDia();";
			pstm = c.prepareStatement(sql);
			rs = pstm.executeQuery();
			while (rs.next()) {
				semanPedi.setLunes(rs.getInt(1));
				semanPedi.setMartes(rs.getInt(2));
				semanPedi.setMier(rs.getInt(3));
				semanPedi.setJueve(rs.getInt(4));
				semanPedi.setVierne(rs.getInt(5));
				semanPedi.setSabado(rs.getInt(6));
				semanPedi.setDomin(rs.getInt(7));
			}
			if (salida == 1) {
				return 1;
			} else
				return 0;
			
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
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
	}

}
