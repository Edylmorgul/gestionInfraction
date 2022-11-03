package Model.DAO;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.MultivaluedMap;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.jersey.core.util.MultivaluedMapImpl;

import Model.BEANS.C_TypeVehicule;

public class D_TypeVehicule extends DAO<C_TypeVehicule>{
	
	public D_TypeVehicule() {
		super();
	}

	@Override
	public boolean creer(C_TypeVehicule obj) {
		MultivaluedMap<String, String> params = new MultivaluedMapImpl();
	    params.add("libelle", obj.getLibelle());
	    params.add("description", obj.getDescription());
	    String response =
	    	webResource
	            .path("TypeVehicule")
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
	public boolean modifier(C_TypeVehicule obj) {
		MultivaluedMap<String, String> params = new MultivaluedMapImpl();
	    params.add("id", String.valueOf(obj.getId()));
	    params.add("libelle", obj.getLibelle());
	    params.add("description", obj.getDescription());
	    String response =
	        webResource
	            .path("TypeVehicule")
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
	public boolean supprimer(C_TypeVehicule obj) {
		String response =
		        webResource
		            .path("TypeVehicule/" + obj.getId())
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
	
	/*@Override
	public boolean supprimer(C_TypeVehicule obj) {

		try {
			webResource
	        .path("TypeVehicule/" + obj.getId())
	        .accept(MediaType.APPLICATION_JSON)
	        .delete();
			
			return true;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		    
		return false;
	}*/

	@Override
	public C_TypeVehicule rechercher(int id) {
	    String response =
	        webResource
	            .path("TypeVehicule/" + id)
	            .accept(MediaType.APPLICATION_JSON)
	            .get(String.class);
	    ObjectMapper mapper = new ObjectMapper();
	    C_TypeVehicule v = new C_TypeVehicule();
	    try {
	      v = mapper.readValue(response, new TypeReference<C_TypeVehicule>() {});
	    } catch (IOException e) {
	      e.printStackTrace();
	    }
	    return v;
	}

	@Override
	public List<C_TypeVehicule> lister() {
		String response =
		        webResource.path("TypeVehicule/lister").accept(MediaType.APPLICATION_JSON).get(String.class);
		ObjectMapper mapper = new ObjectMapper();
		List<C_TypeVehicule> liste = new LinkedList<>();
		try {
			liste = mapper.readValue(response, new TypeReference<List<C_TypeVehicule>>() {});
		} catch (IOException e) {
		  e.printStackTrace();
		}
		return liste;
	}
}
