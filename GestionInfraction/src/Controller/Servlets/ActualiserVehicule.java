package Controller.Servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.BEANS.C_TypeVehicule;

/**
 * Servlet implementation class ActualiserVehicule
 */
@WebServlet("/ActualiserVehicule")
public class ActualiserVehicule extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ActualiserVehicule() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
		
		// 0. Variables
		
		// 1. Liste des types véhicules
		String tmp = "" +
			"<thead>" +
				"<tr>" + 
					"<th style=\"text-align:center !important\">Libelle</th>" +
					"<th style=\"text-align:center !important\">Description</th>" +
					"<th style=\"text-align:center !important\" class=\"col-md-1\">Modifier</th>" +
					"<th style=\"text-align:center !important\" class=\"col-md-1\">Supprimer</th>" +
				"</tr>" +
			"</thead>" +
			"<tbody>";
				for(C_TypeVehicule v : C_TypeVehicule.lister()) {
					tmp += 
					"<tr>" + 
						"<td style=\"text-align:center !important\">" + v.getLibelle() + "</td>" +
						"<td style=\"text-align:center !important\">" + v.getDescription() + "</td>" +       				  	         				
						"<td style=\"text-align:center !important\"><div class=\"btn\"><a href=\"./ModifierVehicule?id=" + v.getId() + "\">Modifier</a></div></td>" +
						"<td style=\"text-align:center !important\"><div class=\"btn\"><a href=\"./SupprimerVehicule?id=" + v.getId() + "\">Supprimer</a></div></td>" +
					"</tr>";
				}
		tmp += "</tbody>";
				
		// 2. Envoyer données	    
		response.getWriter().write(tmp);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}
