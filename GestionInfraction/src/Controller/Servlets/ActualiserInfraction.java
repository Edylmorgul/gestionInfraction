package Controller.Servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.BEANS.C_TypeInfraction;

/**
 * Servlet implementation class ActualiserInfraction
 */
@WebServlet("/ActualiserInfraction")
public class ActualiserInfraction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ActualiserInfraction() {
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
		response.setHeader("Access-Control-Allow-Origin", "*");
		
		// 0. Variables
		
		// 1. Liste des types véhicules
		String tmp = "" +
			"<thead>" +
				"<tr>" + 
					"<th style=\"text-align:center !important\">Libelle</th>" +
					"<th style=\"text-align:center !important\">Description</th>" +
					"<th style=\"text-align:center !important\">Montant</th>" +
					"<th style=\"text-align:center !important\" class=\"col-md-1\">Modifier</th>" +
					"<th style=\"text-align:center !important\" class=\"col-md-1\">Supprimer</th>" +
				"</tr>" +
			"</thead>" +
			"<tbody>";
				for(C_TypeInfraction i : C_TypeInfraction.lister()) {
					tmp += 
						"<tr>" + 
							"<td style=\"text-align:center !important\">" + i.getLibelle() + "</td>" +
							"<td style=\"text-align:center !important\">" + i.getDescription() + "</td>" +    
							"<td style=\"text-align:center !important\">" + i.getMontant() + "</td>" +
							"<td style=\"display:none\">" + i.getNomDateFin() + "</td>";
							if(i.getdFin() == null) {
								tmp +="<td style=\"text-align:center !important\"><div class=\"btn\"><a href=\"./ModifierInfraction?id=" + i.getId() + "\">Modifier</a></div></td>";
								tmp +="<td style=\"text-align:center !important\"><div class=\"btn\"><a href=\"./SupprimerInfraction?id=" + i.getId() + "\">Supprimer</a></div></td>";
							}
						
							else {
								tmp +="<td style=\"text-align:center !important\"><div class=\"btn disableLink\"><a href=\"./ModifierInfraction?id=" + i.getId() + "\">Modifier</a></div></td>";
								tmp +="<td style=\"text-align:center !important\"><div class=\"btn disableLink\"><a href=\"./SupprimerInfraction?id=" + i.getId() + "\">Supprimer</a></div></td>";
							}
						tmp += "</tr>";										
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
