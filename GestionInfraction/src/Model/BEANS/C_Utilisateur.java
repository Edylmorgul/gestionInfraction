package Model.BEANS;

import java.io.Serializable;
import java.util.LinkedList;
import java.util.List;

import org.mindrot.jbcrypt.BCrypt;

public class C_Utilisateur implements Serializable{

	private static final long serialVersionUID = 1L;
	
	// Attributs
	protected int id = 0;
	protected String matricule = "";
	protected String mdp = "";
	protected String nom ="";
	protected String prenom ="";
	protected String email = "";
	protected int role = 0;
	protected String brigade = "";
	protected int actif = 0;
	
	// Constructeurs
	public C_Utilisateur() {}
	
	public C_Utilisateur(String mdp, String nom, String prenom, String email, int role, String brigade) {
		this.mdp = mdp;
		this.nom = nom;
		this.prenom = prenom;
		this.email = email;
		this.role = role;
		this.brigade = brigade;
		this.actif = 1; // Par défaut compte actif
	}
	
	public C_Utilisateur(int id, String matricule, String mdp, String nom, String prenom, String email, int role, String brigade) {
		this.id = id;
		this.matricule = matricule;
		this.mdp = mdp;
		this.nom = nom;
		this.prenom = prenom;
		this.email = email;
		this.role = role;
		this.brigade = brigade;
		this.actif = 1; // Par défaut compte actif
	}

	// GET - SET
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNom() {
		return nom;
	}

	public void setNom(String nom) {
		this.nom = nom;
	}

	public String getPrenom() {
		return prenom;
	}

	public void setPrenom(String prenom) {
		this.prenom = prenom;
	}

	public String getMatricule() {
		return matricule;
	}

	public void setMatricule(String matricule) {
		this.matricule = matricule;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getMdp() {
		return mdp;
	}

	public void setMdp(String mdp) {
		this.mdp = mdp;
	}
	
	public int getRole() {
		return role;
	}
	
	public void setRole(int role) {
		this.role = role;
	}
	
	public String getBrigade() {
		return brigade;
	}
	
	public void setBrigade(String brigade) {
		this.brigade = brigade;
	}
	
	public int getActif() {
		return actif;
	}
	
	public void setActif(int actif) {
		this.actif = actif;
	}
	
	// Methodes
	public boolean creer() {
		this.email = this.email.toLowerCase();
		return Global.getFactory().getUtilisateurDAO().creer(this);
	}
	
	public boolean modifier() {
		return Global.getFactory().getUtilisateurDAO().modifier(this);
	}
	
	public boolean supprimer() {
		return Global.getFactory().getUtilisateurDAO().supprimer(this);
	}
	
	public C_Utilisateur trouver(int id) {
		return Global.getFactory().getUtilisateurDAO().rechercher(id);
	}
	
	public static List<? extends C_Utilisateur> lister(){
		return Global.getFactory().getUtilisateurDAO().lister();
	}
	
	// Crypter le mot de passe
	public static String crypterMdp(String mdp) {
		return BCrypt.hashpw(mdp, BCrypt.gensalt());
	}
		
	// Obtenir mot de passe crypté
	@SuppressWarnings("unchecked")
	public static String recupCryptMdp(String matricule){
		List<C_Utilisateur> liste = new LinkedList<>();
		String mdp = null;
				
		liste = (List<C_Utilisateur>) lister();
				
		for(int i = 0; i < liste.size(); i++) {
			if(liste.get(i).matricule.equals(matricule)) {
				mdp = liste.get(i).getMdp();
				break;
			}
		}
				
		return mdp;
	}
	
	// Vérifier si email déjà présent
	@SuppressWarnings("unchecked")
	public static boolean emailExiste(String email) {
		List<C_Utilisateur> list = new LinkedList<>();
			
		list = (List<C_Utilisateur>) lister();
			
		for(int i = 0; i < list.size(); i++) {
			if(list.get(i).email.equals(email)) {
				return true;
			}
		}
					
		return false;
	}
	
	// Connexion à un compte utilisateur
	@SuppressWarnings("unchecked")
	public static C_Utilisateur connexion(String matricule, String mdp) {
		List<C_Utilisateur> list = new LinkedList<>();
		C_Utilisateur uti = null;
			
		list = (List<C_Utilisateur>) lister();
			
		for(int i = 0; i < list.size(); i++) {
			if(list.get(i).matricule.equals(matricule) && list.get(i).mdp.equals(mdp)) {
				uti = list.get(i);
				break;
			}
		}
		
		return uti;
	}
	
	// Description actif
    public String getNomActif() {
    	if(this.actif == 1)
    		return "Oui";
    	else
    		return "Non";
    }
    
    // Description role
    public String getNomRole() {
    	if(this.role == 1)
    		return "Policier";
    	else if(this.role == 2)
    		return "Brigadier chef";
    	else if(this.role == 3)
    		return "Percepteur";
    	else if(this.role == 4)
    		return "Administrateur";
    	else
    		return "Aucun";
    }
    
    // Description brigade
    public String getNomBrigade() {
    	if(this.brigade != null) {
    		return brigade;
    	}
    	else
    		return "Aucune";
    }
}
