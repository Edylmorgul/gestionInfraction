<!-- Header - informations -->
<%@include file="../Layout/header.jsp" %>
	<header>
		<!-- Titre -->
        <h1>Erreur</h1>
        <div class="lineTitre"></div>
	</header>

	<div class="text-center">
		<p> Votre compte a été desactivé, veuillez contacter l'administrateur ! </p>
	</div>
	
	<!-- Retour -->
	<div class="text-center my-3">
      <button type="button" onclick="window.location.href='${pageContext.request.contextPath}/GererErreur'" class="btn btn-primary">Accueil</button>
    </div> 
    
	<!-- Footer - informations -->
	<%@include file="../Layout/footer.jsp" %>