package Model.DAO;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.MultivaluedMap;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.jersey.core.util.MultivaluedMapImpl;

import Model.BEANS.C_ChefBrigade;

public class D_ChefBrigade extends DAO<C_ChefBrigade>{
	
	public D_ChefBrigade() {
		super();
	}

	@Override
	public boolean creer(C_ChefBrigade obj) {
		MultivaluedMap<String, String> params = new MultivaluedMapImpl();
	    params.add("mdp", obj.getMdp());
	    params.add("nom", obj.getNom());
	    params.add("prenom", obj.getPrenom());
	    params.add("email", obj.getEmail());
	    params.add("role", String.valueOf(obj.getRole()));
	    params.add("brigade", obj.getBrigade());
	    String response =
	    	webResource
	            .path("ChefBrigade")
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
	public boolean modifier(C_ChefBrigade obj) {	
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
	            .path("ChefBrigade")
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
	public boolean supprimer(C_ChefBrigade obj) {		
		String response =
		        webResource
		            .path("ChefBrigade/" + obj.getId())
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
	public C_ChefBrigade rechercher(int id) {		
	    String response =
	        webResource
	            .path("ChefBrigade/" + id)
	            .accept(MediaType.APPLICATION_JSON)
	            .get(String.class);
	    ObjectMapper mapper = new ObjectMapper();
	    C_ChefBrigade c = new C_ChefBrigade();
	    try {
	      c = mapper.readValue(response, new TypeReference<C_ChefBrigade>() {});
	    } catch (IOException e) {
	      e.printStackTrace();
	    }
	    return c;
	}

	@Override
	public List<C_ChefBrigade> lister() {		
		String response =
		        webResource.path("ChefBrigade/lister").accept(MediaType.APPLICATION_JSON).get(String.class);
		ObjectMapper mapper = new ObjectMapper();
		List<C_ChefBrigade> liste = new LinkedList<>();
		try {
			liste = mapper.readValue(response, new TypeReference<List<C_ChefBrigade>>() {});
		} catch (IOException e) {
		  e.printStackTrace();
		}
		return liste;
	}
}
