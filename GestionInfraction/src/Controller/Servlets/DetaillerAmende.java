package Controller.Servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.BEANS.C_Amende;
import Model.BEANS.C_ChefBrigade;

/**
 * Servlet implementation class DetaillerAmende
 */
@WebServlet("/DetaillerAmende")
public class DetaillerAmende extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DetaillerAmende() {
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
		C_Amende amende = null;
		
		// 1. Récupérer session courante
		HttpSession session = request.getSession();
		C_ChefBrigade chef = (C_ChefBrigade) session.getAttribute("chefBrigade");
		
		// 2. Récupérer id amende
		String strId = request.getParameter("id");
		int id = Integer.parseInt(strId);
		amende = new C_Amende();
		amende = amende.trouver(id);
		
		// 3. Récupérer liste infractions amende
		
		// 4. Redirection selon type de session courante
		// 4.1 Chef brigade
		if(chef != null) {
			request.setAttribute("amende", amende);
			request.getRequestDispatcher("/VIEWS/ChefBrigade/detaillerAmende.jsp").forward(request, response);
		}
		
		// 4.2 Percepteur
		else {
			request.setAttribute("amende", amende);
			request.getRequestDispatcher("/VIEWS/Percepteur/detaillerAmende.jsp").forward(request, response);
		}	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}
