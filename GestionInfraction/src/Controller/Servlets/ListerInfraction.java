package Controller.Servlets;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.BEANS.C_Administrateur;
import Model.BEANS.C_TypeInfraction;

/**
 * Servlet implementation class ListerInfraction
 */
@WebServlet("/ListerInfraction")
public class ListerInfraction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListerInfraction() {
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
		List<C_TypeInfraction> liste = new LinkedList<>();
		
		// 1. Récupération session en cours
		HttpSession session = request.getSession();
		C_Administrateur admin = (C_Administrateur) session.getAttribute("administrateur");
		
		// 2. Redirection selon type de session courante
		// 2.1 Administrateur
		if(admin != null) {
			liste = (List<C_TypeInfraction>) C_TypeInfraction.lister();
			request.setAttribute("liste", liste);
			request.getRequestDispatcher("/VIEWS/Administrateur/gererTypeInfraction.jsp").forward(request, response);
		}
		
		// 2.2 Chef brigade
		else {
			liste = (List<C_TypeInfraction>) C_TypeInfraction.lister();
			request.setAttribute("liste", liste);
			request.getRequestDispatcher("/VIEWS/ChefBrigade/gererTypeInfraction.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}
