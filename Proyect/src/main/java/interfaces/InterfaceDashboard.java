package interfaces;

import entidad.DasshboardCards;
import entidad.DashboardSemanaCliente;
import entidad.DashboardSemanaPedido;

public interface InterfaceDashboard {
	public int Cards(DasshboardCards dash);
	public int SemanaCliente(DashboardSemanaCliente semanClien);
	public int SemanaPedido(DashboardSemanaPedido semanPedi);
}
