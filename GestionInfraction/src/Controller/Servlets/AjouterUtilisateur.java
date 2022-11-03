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
import Model.BEANS.C_Utilisateur;
import Model.BEANS.Global;

/**
 * Servlet implementation class AjouterUtilisateur
 */
@WebServlet("/AjouterUtilisateur")
public class AjouterUtilisateur extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AjouterUtilisateur() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    // Vérifier champs vide
    private boolean estVide(String mdp, String nom, String prenom,
    		String email, String mdpConfirm) {
    	
    	if(mdp == null || mdp.equals(""))
    		 return true;
    	
    	if(nom == null || nom.equals(""))
    		return true;
		   	
    	if(prenom == null || prenom.equals(""))
    		return true;
    	
    	if(email == null || email.equals(""))
    		return true;   	
    	
    	if(mdpConfirm == null || mdpConfirm.equals(""))
    		return true;
    	    	
    	return false;
    }
    
    // Vérifier regexp
    private String estValide(String email, String mdp) {
    	
    	String erreur = null;
    	
    	if(!email.matches(Model.BEANS.Global.getEmailPattern()))
    		erreur = "email";
    	
    	if(!mdp.matches(Model.BEANS.Global.getPasswordPattern()))
    		erreur = "mdp";
    	
    	return erreur;
    }
    
    // Confirmation mot de passe
    private boolean estExact(String mdp, String mdpConfirm) {
    	
    	boolean erreur = false;   	
    	if(!mdp.equals(mdpConfirm)) {
			erreur = true;
		}
    	
    	return erreur;
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
		String nom = request.getParameter("nom");
		String prenom = request.getParameter("prenom");
		String email = request.getParameter("email");
		String mdp = request.getParameter("mdp");
		String mdpConfirm = request.getParameter("mdpConfirm");
		String strTypeUtilisateur = request.getParameter("typeUtilisateur");
		String typeBrigadier = request.getParameter("typeBrigadier");
		email = email.toLowerCase();
			
		// 2. Vérifier champs vide
		if(estVide(mdp, nom, prenom, email, mdpConfirm)) {
			out.print("1");
			out.close();
		}
						
		// 3. Vérifier validité des champs(regexp)
		else if(estValide(email, mdp) != null) {
			out.print(estValide(email, mdp));
			out.close();
		}
						
		// 4. Vérifier les mots de passes
		else if(estExact(mdp, mdpConfirm)) {
			out.print("2");
			out.close();
		}			
			
		// 5. Vérifier si email déjà présent
		else if(C_Utilisateur.emailExiste(email)) {
			out.print("3");
			out.close();
		}
			
		// 6. Envoi des données
		else {
			// 6.1 Convertir éléments
			int typeUtilisateur = Global.tryParseInt(strTypeUtilisateur);	
				
			// 6.2 Crypter mdp				
			mdp = C_Utilisateur.crypterMdp(mdp);
			
			// 6.3 Récupération session courante
			HttpSession session = request.getSession();
			admin = (C_Administrateur) session.getAttribute("administrateur");
			
			// 6.4 Création du compte
			if(admin.creerCompte(mdp, nom, prenom, email, typeUtilisateur, typeBrigadier)) {
				out.print("0");
				out.close();
			}
			
			else {
				out.print("4");
				out.close();
			}
		}
	}
}