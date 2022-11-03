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
 * Servlet implementation class ValiderAmende
 */
@WebServlet("/ValiderAmende")
public class ValiderAmende extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ValiderAmende() {
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
		C_ChefBrigade chef = null;
		
		// 1. Récupérer session courante
		HttpSession session = request.getSession();
		chef = (C_ChefBrigade) session.getAttribute("chefBrigade");
		
		// 2. Récupérer id amende
		String strId = request.getParameter("id");
		int id = Integer.parseInt(strId);
								
		// 3. Récupérer info amende
		C_Amende amende = new C_Amende();
		amende = amende.trouver(id);
								
		// 4. Modifier info amende
		if(chef.validerAmende(amende))
			response.sendRedirect("ListerAmende");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}
