package Model.BEANS;

import java.util.LinkedList;
import java.util.List;

public class C_ChefBrigade extends C_Utilisateur{
	
	private static final long serialVersionUID = 1L;
	
	// Attributs
	List<C_Policier> listePolicier = null;
	List<C_Amende> listeAmende = null;
	
	// Constructeurs
	public C_ChefBrigade() {
		super();
		this.listePolicier = new LinkedList<>();
		this.listeAmende = new LinkedList<>();
	}
	
	public C_ChefBrigade(String mdp, String nom, String prenom, String email, int role, String brigade) {
		super(mdp, nom, prenom, email, role, brigade);
		this.listePolicier = new LinkedList<>();
		this.listeAmende = new LinkedList<>();
	}
	
	// GET - SET
	public List<C_Policier> getListePol(){
		return listePolicier;
	}
	
	public void setListePol(List<C_Policier> listePol) {
		this.listePolicier = listePol;
	}
	
	public List<C_Amende> getListeAmende(){
		return listeAmende;
	}
	
	public void setListeAmende(List<C_Amende> listeAmende) {
		this.listeAmende = listeAmende;
	}
	
	// Methodes
	@Override
	public boolean creer() {
		return Global.getFactory().getChefBrigadeDAO().creer(this);
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
	public C_ChefBrigade trouver(int id) {
		return Global.getFactory().getChefBrigadeDAO().rechercher(id);	
	}

	public static List<C_ChefBrigade> lister() {
		return Global.getFactory().getChefBrigadeDAO().lister();
	}
	
	public void ajouterPolicier(C_Policier pol) {
		listePolicier.add(new C_Policier(this, pol.getId(), pol.getMatricule(), pol.getMdp(), pol.getNom(), pol.getPrenom(), pol.getEmail(), pol.getRole()));
	}	
	
	public void ajouterAmende(C_Amende amende) {
		listeAmende.add(new C_Amende(amende.getId(), amende.getTypeVehi(), amende.getPolicier(), amende.getContrevenant()
				,amende.getImm(), amende.getInstant(), amende.getVille(), amende.getMontant()
				, amende.getCommentaire(), amende.getValide(), amende.getEnvoye()));
	}
	
	// Methode pour valider amende
	public boolean validerAmende(C_Amende amende) {
		amende.setValide(1);
		return amende.modifier();
	}
	
	// Methode pour invalider amende(supprimer)
	public boolean invaliderAmende(C_Amende amende) {
		return amende.supprimer();
	}
	
	// Methode pour modifier montant type infraction
	public boolean modifierMontantTypeInfracton(C_TypeInfraction infra, double montant) {
		infra.setuSupp(this.getId());
		infra.setMontant(montant);
		return infra.modifier();
	}
}
