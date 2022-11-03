package Model.DAO;

import Model.BEANS.*;

public class FactoryDAO {
	
	// Administrateur
	public DAO<C_Administrateur> getAdministrateurDAO(){
		return new D_Administrateur();
	}
	
	// Amende
	public DAO<C_Amende> getAmendeDAO(){
		return new D_Amende();
	}
	
	// Chef de brigade
	public DAO<C_ChefBrigade> getChefBrigadeDAO(){
		return new D_ChefBrigade();
	}
	
	// Percepteur
	public DAO<C_Percepteur> getPercepteurDAO(){
		return new D_Percepteur();
	}

	// Personne
	public DAO<C_Utilisateur> getUtilisateurDAO(){
		return new D_Utilisateur();
	}
	
	// Policier
	public DAO<C_Policier> getPolicierDAO(){
		return new D_Policier();
	}
	
	// Type infraction
	public DAO<C_TypeInfraction> getTypeInfractionDAO(){
		return new D_TypeInfraction();
	}
	
	// Type vehicule
	public DAO<C_TypeVehicule> getTypeVehiculeDAO(){
		return new D_TypeVehicule();
	}
}
