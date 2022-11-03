<!-- Header - informations -->
<%@include file="../Layout/header.jsp" %>
	<header>	
		<!-- Navbar -->
		<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
  			<a class="navbar-brand mx-3" href="#">Gestion d'infraction</a>
  			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="true" aria-label="Toggle navigation">
    			<span class="navbar-toggler-icon"></span>
  			</button>
  			
  			<!-- Formulaire connexion -->
  			<form class="navbar-form navbar-right" action="${pageContext.request.contextPath}/Connexion" method="POST">
             <div class="input-group input-group-sm" style="max-width: 480px;">
                  <input class="form-control form-horizontal mx-1" placeholder="Matricule..." name="matricule" type="text" required maxlength="50">
                  <input class="form-control form-horizontal" placeholder="Mot de passe..." name="mdp" type="password" required maxlength="50">
                  <div class="input-group-btn mx-2" style="max-width:120px;">
                       <button type="submit" class="btn btn-primary" data-toggle="dropdown" value="submit" name="submit">Connexion</button>
                   </div>
              </div>              
        </form>
		</nav>
		<div class="erreurNav">${erreur}</div>
		
		<!-- Titre -->
        <h1>Infraction routière</h1>
        <p> Application de gestion d'infraction routière ! </p>
        <div class="lineTitre"></div> 
	</header>
	
	<!-- Presentation -->
	<section class="presentation">
		<p> 
			Bienvenue agent sur votre application de gestion d'infraction routière ! </br>
			Veuillez s'il vous plait vous connecter afin de profiter de vos fonctionnalité !
		 </p>
	</section>
	
	<!-- Bloc design pour rendre le site sous une forme plus "policière" ==> Ce n'est que du design, rien de fonctionnel ici -->
	<div class="container">
		<div class="card-deck mb-3 text-center">
			<div class="card mb-4 box-shadow" style="border-color: #0d6efd;">
				<div class="card-header" style="background-color: #0d6efd;">
					<h4 class="my-0 font-weight-normal">Statistiques</h4>
				</div>
				<div class ="card-body">
					<p> Voir les statistiques sur les infractions routières </p>
					<ul class="list-unstyled mt-3 mb-4">
						<li> Accidents </li>
						<li> Morts </li>
						<li> Vehicules </li>
						<li> Amendes </li>
					</ul>
					<button type="button" class="btn btn-lg btn-block btn-outline-primary"> Statistiques </button>
				</div>
			</div>
			<div class="card mb-4 box-shadow" style="border-color: #0d6efd;">
				<div class="card-header" style="background-color: #0d6efd;">
					<h4 class="my-0 font-weight-normal">Postes vacants</h4>
				</div>
				<div class ="card-body">
					<p> Envie d'évoluer dans votre métier ? Voici les postes vacants disponibles.
						Selon certaines conditions et ton expériences, certains postes te seront peut-être disponibles !
					</p>
					
					<button type="button" class="btn btn-lg btn-block btn-outline-primary"> Postes disponibles </button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- Footer - informations -->
	<%@include file="../Layout/footer.jsp" %>