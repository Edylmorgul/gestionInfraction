package Controller.Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.BEANS.C_Amende;
import Model.BEANS.C_Policier;
import Model.BEANS.C_TypeInfraction;
import Model.BEANS.C_TypeVehicule;
import Model.BEANS.Global;

/**
 * Servlet implementation class AjouterAmende
 */
@WebServlet("/AjouterAmende")
public class AjouterAmende extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private C_Policier pol = null;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AjouterAmende() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    // Vérifier champs vide
    private boolean estVide(String lieu,
    		String commentaire, String[] tabInfraction) {
    	
    	if(lieu == null || lieu.equals(""))
			return true;
    	
    	if(commentaire == null || commentaire.equals(""))
			return true;
    	
    	if(tabInfraction == null || tabInfraction.length == 0)
    		return true;
    	    	
    	return false;
    }
    
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
		//0. Variables
		List<C_TypeInfraction> listeInfraction = new LinkedList<>();
		List<C_TypeVehicule> listeVehicule = new LinkedList<>();
						
		// 1. Récupérer session policier
		HttpSession session = request.getSession();
		pol = (C_Policier) session.getAttribute("policier");
				
		// 2. Envoi des données à la page jsp
		listeInfraction = C_TypeInfraction.lister();
		listeVehicule = C_TypeVehicule.lister();
		request.setAttribute("typeInfraction", listeInfraction);
		request.setAttribute("typeVehicule", listeVehicule);
		request.getRequestDispatcher("/VIEWS/Policier/ajouterAmende.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		
		// 0. Variables
		C_Amende amende = null;
		C_TypeVehicule vehicule = null;
		C_TypeInfraction infra = null;
		response.setContentType("text/javascript");
		response.setCharacterEncoding("UTF-8");
		response.setHeader("Access-Control-Allow-Origin", "*");
		PrintWriter out = response.getWriter();
		String[] tab = null;
				
		// 1. Paramètres amende
		String lieu = request.getParameter("lieu");
		String immatriculation = request.getParameter("immatriculation");
		String commentaire = request.getParameter("commentaire");
		String strTypeVehicule = request.getParameter("typeVehicule");
		String[] tabInfraction = request.getParameterValues("tabInfraction");
		tabInfraction = tabInfraction[0].split(",");
		
		// 1.1 Paramètres utilisateur(optionnel)
		String nom = request.getParameter("nom");
		String prenom = request.getParameter("prenom");
		String pays = request.getParameter("pays");
		String strCodePostal = request.getParameter("codePostal");
		String ville = request.getParameter("ville");
		String rue = request.getParameter("rue");
		String strNumero = request.getParameter("numero");
		String boite = request.getParameter("boite");
		
		// 1.1.2 Mise en majuscule de l'immatriculation
		immatriculation = immatriculation.toUpperCase();
		
		// 2. Vérifier champs vide
		if(estVide(lieu, commentaire, tabInfraction)) {
			tab = new String[1];
			tab[0] = "1";
			String tabString = Arrays.toString(tab);
    		tabString  =tabString.replace("[", "");
    		tabString = tabString.replace("]", "");
    		out.print(tabString);
			out.close();
		}
				
		// 3. Vérifier si nombre négatif (si pas vide)
		else if(estNegatif(strCodePostal, strNumero)) {
			tab = new String[1];
			tab[0] = "2";
			String tabString = Arrays.toString(tab);
    		tabString  =tabString.replace("[", "");
    		tabString = tabString.replace("]", "");
    		out.print(tabString);
			out.close();
		}
						
		// 4. Envoi des données
		else {
			// 4.1 Convertir éléments
			int codePostal = 0;
			int numero = 0;
			if(!estVide(strCodePostal))
				codePostal = Global.tryParseInt(strCodePostal);
						
			if(!estVide(strNumero))
		    	numero = Global.tryParseInt(strNumero);	
			
	    	int typeVehicule = Global.tryParseInt(strTypeVehicule);
	    	
	    	// 4.2 Obtenir type vehicule
	    	vehicule = new C_TypeVehicule();
	    	vehicule = vehicule.trouver(typeVehicule);
	    	
	    	// 4.3 Création amende
	    	amende = new C_Amende(vehicule, pol, immatriculation, pays, lieu, commentaire);
	    	
	    	// 4.4 Obtenir liste infraction
	    	for(int i = 0; i<tabInfraction.length; i++) {
	    		// 4.4.1 Convertir string en int
	    		int id = Global.tryParseInt(tabInfraction[i]);
	    		
	    		// 4.4.2 Rechercher l'infraction
	    		infra = new C_TypeInfraction();
	    		infra = infra.trouver(id);
	    		
	    		// 4.4.3 Ajouter dans liste infraction amende
	    		amende.ajouterInfraction(infra);
	    	}
	    	
	    	// 5. Calcul du montant total de l'amende
	    	amende.calculerTotalAmende();
	    		    	
	    	// 6. Création objet interne contrevenant
	    	C_Amende.C_Contrevenant con = amende.new C_Contrevenant(nom, prenom, pays, ville, codePostal, rue, numero, boite);
	    	amende.setContrevenant(con);
	    				
	    	if(amende.creer()) {
	    		tab = new String[2];
	    		tab[0] = "0";
	    		tab[1] = String.valueOf(amende.getMontant());
	    		String tabString = Arrays.toString(tab);
	    		tabString = tabString.replace("[", "");
	    		tabString = tabString.replace("]", "");
	    		out.print(tabString);
	    		out.close();
	    	}
	    				
	    	else {
	    		tab = new String[1];
	    		tab[0] = "3";
	    		String tabString = Arrays.toString(tab);
	    		tabString  =tabString.replace("[", "");
	    		tabString = tabString.replace("]", "");
	    		out.print(tabString);
	    		out.close();
	    	}
		}				
	}
}
