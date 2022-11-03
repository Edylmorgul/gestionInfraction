package Controller.Servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.BEANS.C_Administrateur;
import Model.BEANS.C_TypeInfraction;

/**
 * Servlet implementation class SupprimerInfraction
 */
@WebServlet("/SupprimerInfraction")
public class SupprimerInfraction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SupprimerInfraction() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		// 0. Variable
		C_TypeInfraction infra = new C_TypeInfraction();
		
		// 1. Récupération session courante
		HttpSession session = request.getSession();
		C_Administrateur admin = (C_Administrateur) session.getAttribute("administrateur");
				
		// 2. Reception type infraction
		String strId = request.getParameter("id");
		int id = Integer.parseInt(strId);
		infra = infra.trouver(id);
				
		// 3. Supprimer type infraction
		if(admin.supprimerTypeInfraction(infra))
			response.sendRedirect("ListerInfraction");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}
