package Controller.Servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.BEANS.C_Administrateur;
import Model.BEANS.C_Utilisateur;

/**
 * Servlet implementation class DesactiverUtilisateur
 */
@WebServlet("/DesactiverUtilisateur")
public class DesactiverUtilisateur extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DesactiverUtilisateur() {
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
		C_Administrateur admin = null;
						
		// 1. Récupérer session courante
		HttpSession session = request.getSession();
		admin = (C_Administrateur) session.getAttribute("administrateur");
				
		// 2. Récupérer id utilisateur
		String strId = request.getParameter("id");
		int id = Integer.parseInt(strId);
						
		// 3. Récupérer info utilisateur
		C_Utilisateur uti = new C_Utilisateur();
		uti = uti.trouver(id);
						
		// 4. Modifier info utilisateur
		if(admin.desactiverUtilisateur(uti))
			response.sendRedirect("ListerUtilisateur");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}
