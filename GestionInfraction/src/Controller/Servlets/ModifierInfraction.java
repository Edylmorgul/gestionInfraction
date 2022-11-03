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
import Model.BEANS.C_ChefBrigade;
import Model.BEANS.C_TypeInfraction;
import Model.BEANS.Global;

/**
 * Servlet implementation class ModifierInfraction
 */
@WebServlet("/ModifierInfraction")
public class ModifierInfraction extends HttpServlet {
	private static final long serialVersionUID = 1L;
	C_TypeInfraction infra = null;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ModifierInfraction() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    // Vérifier champs vide
    private boolean estVide(String montant) {
     	
    	if(montant == null || montant.equals(""))
			return true;
    	    	
    	return false;
    }
    
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
		// 0. Variables
		
		// 1. Récupérer id type infraction
		String strId = request.getParameter("id");
		int id = Integer.parseInt(strId);
				
		// 2. Récupérer données type infraction
		infra = new C_TypeInfraction();
		infra = infra.trouver(id);
		
		request.setAttribute("typeInfraction", infra);
		request.getRequestDispatcher("VIEWS/Administrateur/modifierTypeInfraction.jsp").forward(request, response);	
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
		
		// 1. Récupération session courante
		HttpSession session = request.getSession();
		C_Administrateur admin = (C_Administrateur) session.getAttribute("administrateur");
		C_ChefBrigade chef = (C_ChefBrigade) session.getAttribute("chefBrigade");
		
		// 1.1 Administrateur
		if(admin!= null) {			
			// 2. Paramètres
			String libelle = request.getParameter("libelle");
			String description = request.getParameter("description");
			String strMontant = request.getParameter("montant");			
			
			// 3. Vérifier champs vide
			if(estVide(libelle, description, strMontant)) {
				out.print("1");
				out.close();
			}
			
			// 4. Vérifier si nombre négatif
			else if(estNegatif(strMontant)) {
				out.print("2");
				out.close();
			}
			
			// 5. Modification des données
			else {
				// 5.1 Conversion données
				double montant = Global.tryParseDouble(strMontant);
				
				// 5.2 Modification de l'objet				
				if(admin.modifierTypeInfraction(infra, libelle, description, montant)) {
					out.print("0");
					out.close();
				}
				
				else {
					out.print("3");
					out.close();
				}
			}
		}
		
		// 1.2 Chef brigade
		else {			
			// 2. Paramètres
			C_TypeInfraction infra = new C_TypeInfraction();
			String strId = request.getParameter("id");
			String strMontant = request.getParameter("montant");
			
			// 3. Vérifier champs vide
			if(estVide(strMontant)) {
				out.print("1");
				out.close();
			}
			
			// 4. Vérifier si nombre négatif
			else if(estNegatif(strMontant)) {
				out.print("2");
				out.close();
			}
			
			// 5. Modification des données
			else {
				// 5.1 Conversion données
				int id = Global.tryParseInt(strId);
				double montant = Global.tryParseDouble(strMontant);
				infra = infra.trouver(id);
				
				// 5.2 Modification de l'objet				
				if(chef.modifierMontantTypeInfracton(infra, montant)) {
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
}
