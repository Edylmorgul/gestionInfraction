package Controller.Servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.BEANS.C_Administrateur;
import Model.BEANS.C_ChefBrigade;
import Model.BEANS.C_Policier;

/**
 * Servlet implementation class RetournerHome
 */
@WebServlet("/GererRetour")
public class GererRetour extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GererRetour() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		// 0. Variables		
		HttpSession session = request.getSession();
		C_Administrateur admin = (C_Administrateur) session.getAttribute("administrateur");
		C_Policier pol = (C_Policier) session.getAttribute("policier");
		C_ChefBrigade chef = (C_ChefBrigade) session.getAttribute("chefBrigade");
		
		// 1. Obtenir session courant
		// 1.1 Administrateur
		if(admin != null)
			response.sendRedirect("VIEWS/Administrateur/home.jsp");
		
		// 1.2 Policier
		else if(pol != null)
			response.sendRedirect("VIEWS/Policier/home.jsp");
		
		// 1.3 Chef brigade
		else if(chef != null)
			response.sendRedirect("VIEWS/ChefBrigade/home.jsp");
		
		// 1.4 Percepteur
		else
			response.sendRedirect("VIEWS/Percepteur/home.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}
