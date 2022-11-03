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
import Model.BEANS.C_TypeVehicule;

/**
 * Servlet implementation class ModifierVehicule
 */
@WebServlet("/ModifierVehicule")
public class ModifierVehicule extends HttpServlet {
	private static final long serialVersionUID = 1L;
	C_TypeVehicule vehi = null;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ModifierVehicule() {
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
		
		// 1. Récupérer id type véhicule
		String strId = request.getParameter("id");
		int id = Integer.parseInt(strId);
				
		// 2. Récupérer données type véhicule
		vehi = new C_TypeVehicule();
		vehi = vehi.trouver(id);
				
		// 3. Envoyer données vers page
		request.setAttribute("typeVehicule", vehi);
		request.getRequestDispatcher("VIEWS/Administrateur/modifierTypeVehicule.jsp").forward(request, response);
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
		
		// 3. Modification des données
		else {
			// 3.1 Récupération session courante
			HttpSession session = request.getSession();
			admin = (C_Administrateur) session.getAttribute("administrateur");
			
			// 3.2 Modification de l'objet			
			if(admin.modifierTypeVehicule(vehi, libelle, description)) {
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
