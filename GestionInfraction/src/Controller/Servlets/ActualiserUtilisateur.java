package Controller.Servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.BEANS.C_Utilisateur;

/**
 * Servlet implementation class ActualiserUtilisateur
 */
@WebServlet("/ActualiserUtilisateur")
public class ActualiserUtilisateur extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ActualiserUtilisateur() {
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
						
		// 1. Liste des utilisateurs
		String tmp = "" +
			"<thead>" +
				"<tr>" + 
					"<th style=\"text-align:center !important\">Nom</th>" +
					"<th style=\"text-align:center !important\">Prénom</th>" +
					"<th style=\"text-align:center !important\">Matricule</th>" +
					"<th style=\"text-align:center !important\">Email</th>" +
					"<th style=\"text-align:center !important\">Role</th>" +
					"<th style=\"text-align:center !important\">Brigade</th>" +
					"<th style=\"text-align:center !important\">Actif</th>" +						
					"<th style=\"text-align:center !important\" class=\"col-md-1\">Modifier</th>" +
					"<th style=\"text-align:center !important\" class=\"col-md-1\">Statut</th>" +										
				"</tr>" +
			"</thead>" +
			"<tbody>";
		for(C_Utilisateur u : C_Utilisateur.lister()) {
			tmp += 
			"<tr>" + 
				"<td style=\"text-align:center !important\">" + u.getNom() + "</td>" +
				"<td style=\"text-align:center !important\">" + u.getPrenom() + "</td>" +
				"<td style=\"text-align:center !important\">" + u.getMatricule() + "</td>" +
				"<td style=\"text-align:center !important\">" + u.getEmail() + "</td>" +
				"<td style=\"text-align:center !important\">" + u.getNomRole() + "</td>" +
				"<td style=\"text-align:center !important\">" + u.getNomBrigade() + "</td>" + 	
				"<td style=\"text-align:center !important\">" + u.getNomActif() + "</td>" +         				  	         				
				"<td><div class=\"btn\"><a href=\"./ModifierUtilisateur?id=" + u.getId() + "\">Modifier</a></div></td>";
			if(u.getActif() == 1){
				tmp +="<td style=\"text-align:center !important\"><div class=\"btn\"><a href=\"./DesactiverUtilisateur?id=" + u.getId() + "\">Désactiver</a></div></td>";
			}
			else{
				tmp +="<td style=\"text-align:center !important\"><div class=\"btn\"><a href=\"./ActiverUtilisateur?id=" + u.getId() + "\">Activer</a></div></td>";
			}
			tmp += "</tr>";
		}
		tmp += "</tbody>";
		
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
