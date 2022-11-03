package Model.DAO;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.MultivaluedMap;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.jersey.core.util.MultivaluedMapImpl;

import Model.BEANS.C_Policier;

public class D_Policier extends DAO<C_Policier>{
	
	public D_Policier() {
		super();
	}

	@Override
	public boolean creer(C_Policier obj) {
		MultivaluedMap<String, String> params = new MultivaluedMapImpl();
	    params.add("mdp", obj.getMdp());
	    params.add("nom", obj.getNom());
	    params.add("prenom", obj.getPrenom());
	    params.add("email", obj.getEmail());
	    params.add("role", String.valueOf(obj.getRole()));
	    params.add("brigade", obj.getBrigade());
	    String response =
	    	webResource
	            .path("Policier")
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
	public boolean modifier(C_Policier obj) {	
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
	            .path("Policier")
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
	public boolean supprimer(C_Policier obj) {		
		String response =
		        webResource
		            .path("Policier/" + obj.getId())
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
	public C_Policier rechercher(int id) {		
	    String response =
	        webResource
	            .path("Policier/" + id)
	            .accept(MediaType.APPLICATION_JSON)
	            .get(String.class);
	    ObjectMapper mapper = new ObjectMapper();
	    C_Policier p = new C_Policier();
	    try {
	      p = mapper.readValue(response, new TypeReference<C_Policier>() {});
	    } catch (IOException e) {
	      e.printStackTrace();
	    }
	    return p;
	}

	@Override
	public List<C_Policier> lister() {		
		String response =
		        webResource.path("Policier/lister").accept(MediaType.APPLICATION_JSON).get(String.class);
		ObjectMapper mapper = new ObjectMapper();
		List<C_Policier> liste = new LinkedList<>();
		try {
			liste = mapper.readValue(response, new TypeReference<List<C_Policier>>() {});
		} catch (IOException e) {
		  e.printStackTrace();
		}
		return liste;
	}
}
