package Model.DAO;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.MultivaluedMap;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.jersey.core.util.MultivaluedMapImpl;

import Model.BEANS.C_Utilisateur;

public class D_Utilisateur extends DAO<C_Utilisateur>{
	
	// Chemin de base postMan ==> http://localhost:8080/GestionInfractionApi/rest/pathPrincipal/pathSecondaire
	
	public D_Utilisateur() {
		
	}
	
	@Override
	public boolean creer(C_Utilisateur obj) {
		MultivaluedMap<String, String> params = new MultivaluedMapImpl();
	    params.add("mdp", obj.getMdp());
	    params.add("nom", obj.getNom());
	    params.add("prenom", obj.getPrenom());
	    params.add("email", obj.getEmail());
	    params.add("role", String.valueOf(obj.getRole()));
	    params.add("brigade", obj.getBrigade());
	    String response =
	    	webResource
	            .path("Utilisateur")
	            .accept(MediaType.APPLICATION_JSON)
	            .type("application/x-www-form-urlencoded")
	            .post(String.class, params);
	    ObjectMapper mapper = new ObjectMapper();
	    Boolean erreur = false;
	    try {
	      erreur = mapper.readValue(response, new TypeReference<Boolean>() {});
	    } catch (IOException e) {
	      e.printStackTrace();
	    }
	    return erreur;
	}

	@Override
	public boolean modifier(C_Utilisateur obj) {
	    MultivaluedMap<String, String> params = new MultivaluedMapImpl();
	    params.add("id", String.valueOf(obj.getId()));
	    params.add("mdp", obj.getMdp());
	    params.add("nom", obj.getNom());
	    params.add("prenom", obj.getPrenom());
	    params.add("email", obj.getEmail());
	    params.add("role", String.valueOf(obj.getRole()));
	    params.add("brigade", obj.getBrigade());
	    params.add("actif", String.valueOf(obj.getActif()));
	    String response =
	        webResource
	            .path("Utilisateur")
	            .accept(MediaType.APPLICATION_JSON)
	            .type("application/x-www-form-urlencoded")
	            .put(String.class, params);
	    ObjectMapper mapper = new ObjectMapper();
	    Boolean erreur = false;
	    try {
	      erreur = mapper.readValue(response, new TypeReference<Boolean>() {});
	    } catch (IOException e) {
	      e.printStackTrace();
	    }
	    return erreur;
	}

	@Override
	public boolean supprimer(C_Utilisateur obj) {
		String response =
		        webResource
		        	.path("Utilisateur/" + obj.getId())
		            .accept(MediaType.APPLICATION_JSON)
		            .delete(String.class);
		    ObjectMapper mapper = new ObjectMapper();
		    Boolean erreur = false;
		    try {
		      erreur = mapper.readValue(response, new TypeReference<Boolean>() {});
		    } catch (IOException e) {
		      e.printStackTrace();
		    }
		return erreur;
	}

	@Override
	public C_Utilisateur rechercher(int id) {
	    String response =
	        webResource
	            .path("Utilisateur/" + id)
	            .accept(MediaType.APPLICATION_JSON)
	            .get(String.class);
	    ObjectMapper mapper = new ObjectMapper();
	    C_Utilisateur u = new C_Utilisateur();
	    try {
	      u = mapper.readValue(response, new TypeReference<C_Utilisateur>() {});
	    } catch (IOException e) {
	      e.printStackTrace();
	    }
	    return u;
	}

	@Override
	public List<C_Utilisateur> lister() {
		String response =
		        webResource.path("Utilisateur/lister").accept(MediaType.APPLICATION_JSON).get(String.class);
		ObjectMapper mapper = new ObjectMapper();
		List<C_Utilisateur> liste = new LinkedList<>();
		try {
			liste = mapper.readValue(response, new TypeReference<List<C_Utilisateur>>() {});
		} catch (IOException e) {
		  e.printStackTrace();
		}
		return liste;
	}
}
