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
import Model.BEANS.Global;

/**
 * Servlet implementation class AjouterInfraction
 */
@WebServlet("/AjouterInfraction")
public class AjouterInfraction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AjouterInfraction() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    // Vérifier champs vide
    private boolean estVide(String libelle, String description, String montant) {
    	
    	if(libelle == null || libelle.equals(""))
    		return true;
    	
    	if(description == null || description.equals(""))
    		return true;
    	
    	if(montant == null || montant.equals(""))
			return true;
    	    	
    	return false;
    }
    
    // Vérification nombre negatif
    private boolean estNegatif(String strMontant) {
    	
    	double montant = Global.tryParseDouble(strMontant);
    	
    	if(montant <= 0)
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
		C_Administrateur admin = null;
		response.setContentType("text/javascript");
		response.setCharacterEncoding("UTF-8");
		response.setHeader("Access-Control-Allow-Origin", "*");
		PrintWriter out = response.getWriter();
		
		// 1. Paramètres
		String libelle = request.getParameter("libelle");
		String description = request.getParameter("description");
		String strMontant = request.getParameter("montant");
		
		// 2. Vérifier champs vide
		if(estVide(libelle, description, strMontant)) {
			out.print("1");
			out.close();
		}
		
		// 3. Vérifier si nombre négatif
		else if(estNegatif(strMontant)) {
			out.print("2");
			out.close();
		}
		
		// 4. Envoi des données
		else {
			// 4.1 Convertir éléments
			double montant = Global.tryParseDouble(strMontant);	
			
			// 1. Récupérer session administrateur
			HttpSession session = request.getSession();
			admin = (C_Administrateur) session.getAttribute("administrateur");
			
			// 4.2 Création type infraction			
			if(admin.creerTypeInfraction(libelle, description, montant)) {
				out.print("0");
				out.close();
			}
			
			else {
				out.print("3");
				out.close();
			}
		}		
	}
}
