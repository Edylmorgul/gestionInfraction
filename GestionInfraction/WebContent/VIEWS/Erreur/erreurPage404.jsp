<!-- Header - informations -->
<%@include file="../Layout/header.jsp"%>
<% response.setStatus(404); %>
	<header>
		<!-- Titre -->
        <h1>Erreur 404</h1>
        <div class="lineTitre"></div>
	</header>
	
	<div class="text-center">
		<p> Bonjour, erreur page non trouvée !<br>
		Veuillez retourner à la page d'accueil et contacter l'administrateur ! ==> <a href="${pageContext.request.contextPath}/GererErreur">Accueil</a> </p>
	</div>
	
	<!-- Footer - informations -->
	<%@include file="../Layout/footer.jsp" %>