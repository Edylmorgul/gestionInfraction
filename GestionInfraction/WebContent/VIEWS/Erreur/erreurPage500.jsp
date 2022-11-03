<!-- Header - informations -->
<%@include file="../Layout/header.jsp"%>
<% response.setStatus(500); %>
	<header>
		<!-- Titre -->
        <h1>Erreur 500</h1>
        <div class="lineTitre"></div>
	</header>
	
	<div class="text-center">
		<p> Bonjour, une erreur est survenue sur le serveur !<br>
		Veuillez retourner à la page d'accueil et contacter l'administrateur ! ==> <a href="${pageContext.request.contextPath}/GererErreur">Accueil</a> </p>
	</div>
	
	<!-- Footer - informations -->
	<%@include file="../Layout/footer.jsp" %>