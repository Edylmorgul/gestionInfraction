package Controller.Servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;

import Model.BEANS.C_Administrateur;
import Model.BEANS.C_ChefBrigade;
import Model.BEANS.C_Percepteur;
import Model.BEANS.C_Policier;
import Model.BEANS.C_Utilisateur;

/**
 * Servlet implementation class Connexion
 */
@WebServlet("/Connexion")
public class Connexion extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Connexion() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    // Vérifier champs vide
    private boolean estVide(String matricule, String mdp) {
    	   	
    	if(matricule == null || matricule.equals(""))
    		return true;
    	
    	if(mdp == null || mdp.equals(""))
    		return true;
    	    	
    	return false;
    }
    
    // Vérification des mots de passe
    private boolean verifierMdp(String mdp, String cryptMdp) {
		if (BCrypt.checkpw(mdp, cryptMdp))
			return true;
		else
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
		doGet(request, response);
		
		// 0. Variables
		C_Utilisateur uti = null;
		C_Policier pol = null;
		C_Administrateur admin = null;
		C_Percepteur percept = null;
		C_ChefBrigade chef = null;
		boolean verifMdp = false;
		String cryptMdp = null;
		String matricule = null;
		String mdp = null;		
		
		// 1. Vérifier submit
		if(request.getParameter("submit") != null) {
			matricule = request.getParameter("matricule");
			mdp = request.getParameter("mdp");
			
			// 2. Vérifier champs vide
			if(estVide(matricule, mdp)) {
				request.setAttribute("erreur", "Veuillez remplir les champs !");
				request.getRequestDispatcher("/VIEWS/Home/index.jsp").forward(request, response);
			}
			
			else {
				// 3. Récupérer mot de passe de l'utilisateur (si présent)
				cryptMdp = C_Utilisateur.recupCryptMdp(matricule);
				
				if(cryptMdp == null) {
					request.setAttribute("erreur", "Aucun compte trouvé !");
					request.getRequestDispatcher("/VIEWS/Home/index.jsp").forward(request, response);
				}
				
				else {
					// 4. Test du mot de passe
					verifMdp = verifierMdp(mdp, cryptMdp);			
					if(!verifMdp) {
						request.setAttribute("erreur", "Mauvais mot de passe !");
						request.getRequestDispatcher("/VIEWS/Home/index.jsp").forward(request, response);
					}
					
					else {
						// 5. Récupération informations utilisateur
						uti = new C_Utilisateur();
						uti = C_Utilisateur.connexion(matricule, cryptMdp);
						
						// 6. Déterminer type de compte pour session
						if(uti != null) {
							
							// 6.1 Vérifier si compte actif ou pas
							if(uti.getActif() == 1) {
								HttpSession session = request.getSession();
								
								// 6.2 Policier
								if(uti.getRole() == 1) {
									pol = new C_Policier();
									pol.setId(uti.getId());
									pol.setNom(uti.getNom());
									pol.setPrenom(uti.getPrenom());
									pol.setEmail(uti.getEmail());
									pol.setMatricule(uti.getMatricule());
									pol.setMdp(uti.getMdp());
									pol.setRole(uti.getRole());
									pol.setBrigade(uti.getBrigade());
									
									session.setAttribute("policier", pol);
									response.sendRedirect("VIEWS/Policier/home.jsp");
								}
								
								// 6.3 Brigadier chef
								else if(uti.getRole() == 2) {
									chef = new C_ChefBrigade();
									chef.setId(uti.getId());
									chef.setNom(uti.getNom());
									chef.setPrenom(uti.getPrenom());
									chef.setEmail(uti.getEmail());
									chef.setMatricule(uti.getMatricule());
									chef.setMdp(uti.getMdp());
									chef.setRole(uti.getRole());
									chef.setBrigade(uti.getBrigade());
									
									session.setAttribute("chefBrigade", chef);
									response.sendRedirect("VIEWS/ChefBrigade/home.jsp");
								}
								
								// 6.4 Precepteur
								else if(uti.getRole() == 3) {
									percept = new C_Percepteur();
									percept.setId(uti.getId());
									percept.setNom(uti.getNom());
									percept.setPrenom(uti.getPrenom());
									percept.setEmail(uti.getEmail());
									percept.setMatricule(uti.getMatricule());
									percept.setMdp(uti.getMdp());
									percept.setRole(uti.getRole());
									percept.setBrigade(uti.getBrigade());
									
									session.setAttribute("percepteur", percept);
									response.sendRedirect("VIEWS/Percepteur/home.jsp");
								}
								
								// 6.5 Administrateur
								else {
									admin = new C_Administrateur();
									admin.setId(uti.getId());
									admin.setNom(uti.getNom());
									admin.setPrenom(uti.getPrenom());
									admin.setEmail(uti.getEmail());
									admin.setMatricule(uti.getMatricule());
									admin.setMdp(uti.getMdp());
									admin.setRole(uti.getRole());
									admin.setBrigade(uti.getBrigade());
									
									session.setAttribute("administrateur", admin);
									response.sendRedirect("VIEWS/Administrateur/home.jsp");
								}
							}
							
							// 6.5 Rediriger vers page inactif si compte inactif
							else
								response.sendRedirect("VIEWS/Home/inactif.jsp");													
						}
						
						// 7. Si problème ==> erreur
						else {
							request.setAttribute("erreur", "Une erreur est survenue durant la connexion !");
							request.getRequestDispatcher("/VIEWS/Home/index.jsp").forward(request, response);
						}						
					}				
				}
			}
		}
	}
}
