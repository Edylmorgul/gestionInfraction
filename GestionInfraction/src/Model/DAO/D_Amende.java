package Model.DAO;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.MultivaluedMap;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.jersey.core.util.MultivaluedMapImpl;

import Model.BEANS.C_Amende;

public class D_Amende extends DAO<C_Amende>{
	
	public D_Amende() {
		super();
	}

	@Override
	public boolean creer(C_Amende obj) {
		MultivaluedMap<String, String> params = new MultivaluedMapImpl();
	    params.add("typeVehicule", String.valueOf(obj.getTypeVehi().getId()));
	    params.add("immatriculation", obj.getImm());
	    params.add("lieu", obj.getVille());
	    params.add("montant", String.valueOf(obj.getMontant()));
	    params.add("policier", String.valueOf(obj.getPolicier().getId()));
	    params.add("commentaire", obj.getCommentaire());
	    params.add("nom", obj.getContrevenant().getNom());
	    params.add("prenom", obj.getContrevenant().getPrenom());
	    params.add("pays", obj.getContrevenant().getPays());
	    params.add("ville", obj.getContrevenant().getVille());
	    params.add("codePostal", String.valueOf(obj.getContrevenant().getCodePostal()));
	    params.add("rue", obj.getContrevenant().getRue());
	    params.add("numero", String.valueOf(obj.getContrevenant().getNumero()));
	    params.add("boite", obj.getContrevenant().getBoite());
	    params.add("listeInfraction", String.valueOf(obj.getListeInfra()));
	    
	    String response =
	    	webResource
	            .path("Amende")
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
	public boolean modifier(C_Amende obj) {
		MultivaluedMap<String, String> params = new MultivaluedMapImpl();
		params.add("id", String.valueOf(obj.getId()));
	    params.add("policier", String.valueOf(obj.getPolicier().getId()));
	    params.add("commentaire", obj.getCommentaire());
	    params.add("nom", obj.getContrevenant().getNom());
	    params.add("prenom", obj.getContrevenant().getPrenom());
	    params.add("pays", obj.getContrevenant().getPays());
	    params.add("ville", obj.getContrevenant().getVille());
	    params.add("codePostal", String.valueOf(obj.getContrevenant().getCodePostal()));
	    params.add("rue", obj.getContrevenant().getRue());
	    params.add("numero", String.valueOf(obj.getContrevenant().getNumero()));
	    params.add("boite", obj.getContrevenant().getBoite());
	    params.add("valide", String.valueOf(obj.getValide()));
	    params.add("envoye", String.valueOf(obj.getEnvoye()));
	    String response =
	        webResource
	            .path("Amende")
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
	public boolean supprimer(C_Amende obj) {
		String response =
		        webResource
		            .path("Amende/" + obj.getId())
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
	public C_Amende rechercher(int id) {
	    String response =
	        webResource
	            .path("Amende/" + id)
	            .accept(MediaType.APPLICATION_JSON)
	            .get(String.class);
	    ObjectMapper mapper = new ObjectMapper();
	    C_Amende a = new C_Amende();
	    try {
	      a = mapper.readValue(response, new TypeReference<C_Amende>() {});
	    } catch (IOException e) {
	      e.printStackTrace();
	    }
	    return a;
	}

	@Override
	public List<C_Amende> lister() {
		String response =
		        webResource.path("Amende/lister").accept(MediaType.APPLICATION_JSON).get(String.class);
		ObjectMapper mapper = new ObjectMapper();
		List<C_Amende> liste = new LinkedList<>();
		try {
			liste = mapper.readValue(response, new TypeReference<List<C_Amende>>() {});
		} catch (IOException e) {
		  e.printStackTrace();
		}
		return liste;
	}
	
	public boolean verifierAssurance(String immatriculation) {
		MultivaluedMap<String, String> params = new MultivaluedMapImpl();
	    params.add("immatriculation", immatriculation);
	    String response =
		    	webResource
		            .path("Amende/verifierAssurance")
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
}
