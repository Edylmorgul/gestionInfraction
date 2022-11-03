package Controller.Servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.BEANS.C_Amende;

/**
 * Servlet implementation class VerifierAssurance
 */
@WebServlet("/VerifierAssurance")
public class VerifierAssurance extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public VerifierAssurance() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    private boolean estVide(String string) {
    	if(string == null || string.equals(""))
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
						
		// 1. Paramètres
		String immatriculation = request.getParameter("immatriculation");
		
		// 1.2 Mise en majuscule de l'immatriculation
		immatriculation = immatriculation.toUpperCase();
		
		// 2. Vérifier champs vide
		if(estVide(immatriculation)) {
		    out.print("1");
			out.close();
		}
		
		// 3. Si champ non vide ==> vérifier si immatriculation présente ou pas
		else {
			// 3.1 Si assurée
			if(C_Amende.verifierAssurance(immatriculation)) {
				out.print("0");
				out.close();
			}
			
			// 3.2 Si pas
			else {
				out.print("2");
				out.close();
			}
		}
	}
}
