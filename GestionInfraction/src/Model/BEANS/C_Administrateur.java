package Model.BEANS;

import java.util.List;

public class C_Administrateur extends C_Utilisateur{
	
	private static final long serialVersionUID = 1L;
	
	// Attributs
	
	// Constructeurs
	public C_Administrateur() {
		super();
	}
	
	public C_Administrateur(String mdp, String nom, String prenom, String email, int role, String brigade) {
		super(mdp, nom, prenom, email, role, brigade);
	}
	
	// GET - SET
	
	// Methodes
	@Override
	public boolean creer() {
		return Global.getFactory().getAdministrateurDAO().creer(this);
	}

	@Override
	public boolean supprimer() {
		return super.supprimer();
	}

	@Override
	public boolean modifier() {
		return super.modifier();			
	}
	
	@Override
	public C_Administrateur trouver(int id) {
		return Global.getFactory().getAdministrateurDAO().rechercher(id);	
	}

	public static List<C_Administrateur> lister() {
		return Global.getFactory().getAdministrateurDAO().lister();
	}
	
	// Methode pour créer compte utilisateur
	public boolean creerCompte(String mdp, String nom, String prenom, String email
			, int typeUtilisateur, String typeBrigadier) {
		
		// Policier
		if(typeUtilisateur == 1) {
			C_Policier pol = new C_Policier(mdp, nom, prenom, email, typeUtilisateur, typeBrigadier);
			return pol.creer();
		}
		
		// Chef brigade
		else if(typeUtilisateur == 2) {
			C_ChefBrigade chef = new C_ChefBrigade(mdp, nom, prenom, email, typeUtilisateur, typeBrigadier);
			return chef.creer();
		}
		
		// Percepteur
		else{
			C_Percepteur percept = new C_Percepteur(mdp, nom, prenom, email, typeUtilisateur, typeBrigadier);
			return percept.creer();
		}		
	}
	
	// Methode pour modifier compte utilisateur
	public boolean modifierCompte(C_Utilisateur uti, String mdp, String nom, String prenom
			, int typeUtilisateur, String typeBrigadier) {
		
		// Vérifier si policier
		if(typeUtilisateur == 1)
			uti.setBrigade(typeBrigadier);
		
		else
			uti.setBrigade(null);
				
		uti.setNom(nom);
		uti.setPrenom(prenom);
		uti.setMdp(mdp);
		uti.setRole(typeUtilisateur);
		return uti.modifier();
	}
	
	// Methode pour creer type infraction
	public boolean creerTypeInfraction(String libelle, String description, double montant) {
		C_TypeInfraction infra = new C_TypeInfraction(libelle, description, montant);
		infra.setuCrea(this.getId());
		return infra.creer();
	}
	
	// Methode pour modifier type infraction
	public boolean modifierTypeInfraction(C_TypeInfraction infra, String libelle, String description, double montant) {
		infra.setLibelle(libelle);
		infra.setDescription(description);
		infra.setMontant(montant);
		infra.setuSupp(this.getId());
		return infra.modifier();
	}
	
	// Methode pour supprimer type infraction
	public boolean supprimerTypeInfraction(C_TypeInfraction infra) {
		infra.setuSupp(this.getId());
		return infra.supprimer();
	}
	
	// Methode pour creer type vehicule
	public boolean creerTypeVehicule(String libelle, String description) {
		C_TypeVehicule vehi = new C_TypeVehicule(libelle, description);
		return vehi.creer();
	}
	
	// Methode pour modifier type vehicule
	public boolean modifierTypeVehicule(C_TypeVehicule vehi, String libelle, String description) {
		vehi.setLibelle(libelle);
		vehi.setDescription(description);
		return vehi.modifier();
	}
	
	// Methode pour supprimer type vehicule
	public boolean supprimerVehicule(C_TypeVehicule vehi) {
		return vehi.supprimer();
	}
	
	// Methode pour activer utilisateur
	public boolean activerUtilisateur(C_Utilisateur uti) {
		uti.setActif(1);
		return uti.modifier();
	}
	
	// Methode pour desactiver utilisateur
	public boolean desactiverUtilisateur(C_Utilisateur uti) {
		uti.setActif(0);
		return uti.modifier();
	}
}
