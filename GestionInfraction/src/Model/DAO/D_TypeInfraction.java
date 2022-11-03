package Model.DAO;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.MultivaluedMap;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.jersey.core.util.MultivaluedMapImpl;

import Model.BEANS.C_TypeInfraction;

public class D_TypeInfraction extends DAO<C_TypeInfraction>{
	
	public D_TypeInfraction() {
		super();
	}

	@Override
	public boolean creer(C_TypeInfraction obj) {
		MultivaluedMap<String, String> params = new MultivaluedMapImpl();
	    params.add("libelle", obj.getLibelle());
	    params.add("montant", String.valueOf(obj.getMontant()));
	    params.add("description", obj.getDescription());
	    params.add("uCrea", String.valueOf(obj.getuCrea()));
	    String response =
	    	webResource
	            .path("TypeInfraction")
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
	public boolean modifier(C_TypeInfraction obj) {
		MultivaluedMap<String, String> params = new MultivaluedMapImpl();
	    params.add("id", String.valueOf(obj.getId()));
	    params.add("libelle", obj.getLibelle());
	    params.add("montant", String.valueOf(obj.getMontant()));
	    params.add("description", obj.getDescription());
	    params.add("uSupp", String.valueOf(obj.getuSupp()));
	    String response =
	        webResource
	            .path("TypeInfraction")
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
	public boolean supprimer(C_TypeInfraction obj) {
		MultivaluedMap<String, String> params = new MultivaluedMapImpl();
		params.add("uSupp", String.valueOf(obj.getuSupp()));
		String response =
		        webResource
		            .path("TypeInfraction/" + obj.getId())
		            .accept(MediaType.APPLICATION_JSON)
		            .type("application/x-www-form-urlencoded")
		            .delete(String.class, params);
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
	public C_TypeInfraction rechercher(int id) {
	    String response =
	        webResource
	            .path("TypeInfraction/" + id)
	            .accept(MediaType.APPLICATION_JSON)
	            .get(String.class);
	    ObjectMapper mapper = new ObjectMapper();
	    C_TypeInfraction i = new C_TypeInfraction();
	    try {
	      i = mapper.readValue(response, new TypeReference<C_TypeInfraction>() {});
	    } catch (IOException e) {
	      e.printStackTrace();
	    }
	    return i;
	}

	@Override
	public List<C_TypeInfraction> lister() {
		String response =
		        webResource.path("TypeInfraction/lister").accept(MediaType.APPLICATION_JSON).get(String.class);
		ObjectMapper mapper = new ObjectMapper();
		List<C_TypeInfraction> liste = new LinkedList<>();
		try {
			liste = mapper.readValue(response, new TypeReference<List<C_TypeInfraction>>() {});
		} catch (IOException e) {
		  e.printStackTrace();
		}
		return liste;
	}
}
