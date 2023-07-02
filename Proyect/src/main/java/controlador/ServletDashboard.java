package controlador;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import capaAyudante_controlador.DaoDashboard;
import entidad.DashboardSemanaCliente;
import entidad.DashboardSemanaPedido;
import entidad.DasshboardCards;

/**
 * Servlet implementation class ServletDashboard
 */
@WebServlet("/servletdashboa")
public class ServletDashboard extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DaoDashboard daoDas = new DaoDashboard();
		try {
			DasshboardCards dash = new DasshboardCards();
			DashboardSemanaCliente semaClien = new DashboardSemanaCliente();
			DashboardSemanaPedido semaPed = new DashboardSemanaPedido();
			int salida = daoDas.Cards(dash);
			int sem =  daoDas.SemanaCliente(semaClien);
			int seman = daoDas.SemanaPedido(semaPed);
			request.setAttribute("dash", dash);
			request.setAttribute("seman", semaClien);
			request.setAttribute("semanPedi", semaPed);
			request.getRequestDispatcher("Dashboard.jsp").forward(request, response);
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

}
