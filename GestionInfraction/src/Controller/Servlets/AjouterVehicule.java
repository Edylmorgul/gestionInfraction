package Controller.Servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.BEANS.C_Administrateur;

/**
 * Servlet implementation class AjouterVehicule
 */
@WebServlet("/AjouterVehicule")
public class AjouterVehicule extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AjouterVehicule() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    // Vérifier champs vide
    private boolean estVide(String libelle, String description) {
    	
    	if(libelle == null || libelle.equals(""))
    		return true;
    	
    	if(description == null || description.equals(""))
    		return true;
    	
    	return false;
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		
		// 0. Variables
		response.setContentType("text/javascript");
		response.setCharacterEncoding("UTF-8");
		response.setHeader("Access-Control-Allow-Origin", "*");
		PrintWriter out = response.getWriter();
		C_Administrateur admin = null;
	    
	    // 1. Paramètres
	    String libelle = request.getParameter("libelle");
		String description = request.getParameter("description");
		
		// 2. Vérifier champs vide
		if(estVide(libelle, description)) {
			out.print("1");
			out.close();
		}
		
		// 3. Envoi des données
		else {
			// 3.1 Récupération session courante
			HttpSession session = request.getSession();
			admin = (C_Administrateur) session.getAttribute("administrateur");
			
			// 3.2 Création type vehicule			
			if(admin.creerTypeVehicule(libelle, description)) {
				out.print("0");
				out.close();
			}
				
			else {
				out.print("2");
				out.close();
			}
		}
	}
}
