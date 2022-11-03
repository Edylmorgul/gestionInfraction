package Model.DAO;

import java.net.URI;

import javax.ws.rs.core.UriBuilder;

public class InfractionConnection {

	public static URI getBaseUri() {
		return UriBuilder.fromUri("http://localhost:8080/GestionInfractionApi/rest").build();
	}
}
