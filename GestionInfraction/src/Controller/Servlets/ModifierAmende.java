package Controller.Servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.BEANS.C_Amende;
import Model.BEANS.Global;

/**
 * Servlet implementation class ModifierAmende
 */
@WebServlet("/ModifierAmende")
public class ModifierAmende extends HttpServlet {
	private static final long serialVersionUID = 1L;
	C_Amende amende = null;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ModifierAmende() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    // Vérifier champs vide
    private boolean estVide(String string) {
    	if(string == null || string.equals(""))
			return true;
    	
    	return false;
    }
    
    // Vérification nombre negatif
    private boolean estNegatif(String strCodePostal, String strNumero) {
    	
    	if(!estVide(strCodePostal)) {
    		int codePostal = Global.tryParseInt(strCodePostal);
        	
        	if(codePostal <= 0)
        		return true;
    	}
    	
    	if(!estVide(strNumero)) {
        	int numero = Global.tryParseInt(strNumero);
        	
        	if(numero <= 0)
        		return true;
    	}
    	  	
    	return false;
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		// 0. Variables
				
		// 2. Récupérer id amende
		String strId = request.getParameter("id");
		int id = Integer.parseInt(strId);
		amende = new C_Amende();
		amende = amende.trouver(id);
				
		// 4. Envoyer données
		request.setAttribute("amende", amende);
		request.getRequestDispatcher("/VIEWS/ChefBrigade/modifierAmende.jsp").forward(request, response);				
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
				
		// 1. Paramètres
		String nom = request.getParameter("nom");
		String prenom = request.getParameter("prenom");
		String pays = request.getParameter("pays");
		String strCodePostal = request.getParameter("codePostal");
		String ville = request.getParameter("ville");
		String rue = request.getParameter("rue");
		String strNumero = request.getParameter("numero");
		String boite = request.getParameter("boite");
												
		// 2. Vérifier si nombre négatif (si pas vide)
		if(estNegatif(strCodePostal, strNumero)) {
		    out.print("1");
			out.close();
		}
							
		// 3. Modification des données
		else {
			// 3.1 Convertir éléments
			int codePostal = 0;
			int numero = 0;
			if(!estVide(strCodePostal))
				codePostal = Global.tryParseInt(strCodePostal);
									
			if(!estVide(strNumero))
				numero = Global.tryParseInt(strNumero);
					
			// 3.2 Modification de l'objet
			amende.getContrevenant().setNom(nom);
			amende.getContrevenant().setPrenom(prenom);
			amende.getContrevenant().setPays(pays);
			amende.getContrevenant().setCodePostal(codePostal);
			amende.getContrevenant().setVille(ville);
			amende.getContrevenant().setRue(rue);
			amende.getContrevenant().setNumero(numero);
			amende.getContrevenant().setBoite(boite);
					
			if(amende.modifier()) {
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
