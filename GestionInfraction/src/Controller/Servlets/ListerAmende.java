package Controller.Servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.BEANS.C_Amende;
import Model.BEANS.C_ChefBrigade;
import Model.BEANS.C_Policier;

/**
 * Servlet implementation class ListerAmende
 */
@WebServlet("/ListerAmende")
public class ListerAmende extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListerAmende() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		// 0. Variables
		
		// 1. Récupération session en cours
		HttpSession session = request.getSession();
		C_ChefBrigade chef = (C_ChefBrigade) session.getAttribute("chefBrigade");
		chef.getListeAmende().clear();
		chef.getListePol().clear();
		
		// 2. Récupérer policier appartenant au chef correspondant
		for(C_Policier pol : C_Policier.lister()) {
			if(pol.getBrigade() != null) {
				if(pol.getBrigade().equals(chef.getMatricule())) {
					chef.ajouterPolicier(pol);
					// 2.1. Récupérer amende correspondant aux policiers pour le chef de brigade
					for(C_Amende amende : C_Amende.lister()) {
						if(pol.getId() == amende.getPolicier().getId()) {
							chef.ajouterAmende(amende);
						}					
					}
				}
			}			
		}
		
		// 3. Envoyer les données
		request.setAttribute("liste", chef.getListeAmende());
		request.getRequestDispatcher("/VIEWS/ChefBrigade/consulterAmende.jsp").forward(request, response);		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}
