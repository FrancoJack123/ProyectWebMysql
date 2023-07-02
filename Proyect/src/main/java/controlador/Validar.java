/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import capaAyudante_controlador.ClsUsuario;
import entidad.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Moreno Jack
@WebServlet("/serveletUsu")
 */
@WebServlet("/validar")
public class Validar extends HttpServlet {

    Usuario usu = new Usuario();
    ClsUsuario cslu = new ClsUsuario();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Validar</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Validar at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String usuar, clave;

            usuar = request.getParameter("usua");
            clave = request.getParameter("contra");

            Usuario s = new Usuario();

            s.setNombreUsuario(usuar);
            s.setClave(clave);
            ClsUsuario slu = new ClsUsuario();
            int sali = slu.iniciarSesion(s);
            
            if (sali > 0) {
            	if(s.getActivo() == 1) {
            		if(s.getCargo().getIdCargo() == 1) {
            			String desac = "";
            			request.getSession().setAttribute("usuario", s);
            			request.getSession().setAttribute("desactivado", desac);
                    	request.getRequestDispatcher("servletdashboa").forward(request, response);
            		}else {
						String desac = "disabled";
            			request.getSession().setAttribute("usuario", s);
            			request.getSession().setAttribute("desactivado", desac);
                    	request.getRequestDispatcher("servletdashboa").forward(request, response);
            		}
            	}else {
            		request.getSession().setAttribute("TIPO", "ajs-error");
            		request.getSession().setAttribute("MENSAJE", "Usted esta temporalmente inactivo");
                    request.getRequestDispatcher("index.jsp").forward(request, response);
            	}
            	
            } else {
            	request.getSession().setAttribute("TIPO", "ajs-error");
            	request.getSession().setAttribute("MENSAJE", "Credenciales incorrectas");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
