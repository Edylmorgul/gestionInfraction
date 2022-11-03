<%@ page import="java.util.List"%>
<%@ page import="Model.BEANS.C_Amende" %>
<%@ page import="Model.BEANS.C_TypeInfraction" %>
<%@ page import="Model.BEANS.C_TypeVehicule" %>
<!-- Header - informations -->
<%@include file="../Layout/header.jsp" %>
	<header>
		<!-- Titre -->
        <h1>Contravention</h1>
        <div class="lineTitre"></div>
	</header>
	
	<% 
		List<C_TypeInfraction> typeInfraction = (List)request.getAttribute("typeInfraction");
		List<C_TypeVehicule> typeVehicule = (List)request.getAttribute("typeVehicule");
	%>
	
	<!-- Affichage pop-up -->
	<%@include file="../Layout/modal.jsp" %>
	
	<!-- Modal montant -->
	<div class="modal fade" id="modalMontant" tabindex="-1" role="dialog" aria-hidden="true">
  		<div class="modal-dialog">
    		<div class="modal-content">
      			<div class="modal-header">
        			<h3 class="modal-title" id="modalLabel">Montant total amende</h3>
      			</div>
      			<div class="modal-body">
      				<p class="text-center">Enregistrement réussi !</p>
      				<p class="text-center" id="modalTextMontant"></p>   			
      			</div>
      			<div class="modal-footer">
        			<button type="button" class="btn btn-block" id="btnFermerMontant" data-dismiss="modal">Fermer</button>
      			</div>
    		</div>
  		</div>
	</div>
		
	<!-- Formulaire contravention (général) -->
	<div id="formulaire"> 
		<div class="container d-flex justify-content-center">			
		<div class="card col-md-8">				
			<div class="card-header text-center">Formulaire</div>
			<div class="card-body bg-light">
				<form class="form-horizontal" method="POST" role="form">	
					
					<div class="form-group my-3">
						<div class="row justify-content-between">
							<!-- Lieu d'infraction -->
							<div class="col-sm-6">
								<label class="col-sm-6 control-label" for="lieu"><span class="fas fa-city mx-1"></span>Où :<span class="requis"> *</span></label>  
                    			<div class="col-md-7">
                        			<input type="text" class="form-control" name="lieu" id="lieu" required placeholder="Charleroi" maxlength="100">  
                        			<small id="lieuErreur"></small>
                    			</div>
							</div>
							
							<!-- Numéro de plaque du véhicule (si immatriculé) -->
							<div class="col-sm-6">
								<label class="col-sm-10 control-label" for="numPlaque"><span class="fas fa-key mx-1"></span>Immatriculation :(si immatriculé)</label>  
                    			<div class="col-md-7">
                        			<input type="text" class="form-control" name="immatriculation" id="immatriculation" placeholder="1-ABC-003" maxlength="20">  
                        			<small id="immatriculationErreur"></small>
                    			</div>
							</div>
						</div>
					</div>			                                                    							                                 						
					   
					<!-- Commentaire -->
					<div class="form-group my-3">
						<label class="control-label" for="commentaire"><span class="far fa-comment-dots mx-1"></span>Commentaire : <span class="requis"> *</span></label> 
                    	<div class="col-md-8">
                        	<textarea class="form-control" id="commentaire" name="commentaire" id="commentaire" required placeholder="Description infractions..." rows="3"></textarea>
                        	<small id="commentaireErreur"></small>
                    	</div> 
					</div>                             						
					
					<!-- Choix infraction(s) -->	
					<div class="form-group my-3">

	           			<div class="my-1">
	           			<span> Assurabilité du véhicule : </span><span id="assurabilite">non-recherchée.</span>
	           			</div>
						<div class="col-md-3 my-3" id="formSelect">
							<label class="col-sm-12 control-label" for="typeInfraction"><span class="fas fa-minus-circle mx-1"></span>Choix infraction(s):</label>		
							<small id="typeInfractionErreur"></small>			   
                       		<select class="mb-2" name="typeInfraction" id="typeInfraction" multiple="multiple">
                        		<% for(C_TypeInfraction infra : typeInfraction){%>
                        			<%if(infra.getdFin() == null){%>
                        				<option value=<%=infra.getId()%>><%=infra.getLibelle()%></option>
                        			<%}%>			
                        		<%}%>   
	           				</select>
	           				
						</div>
						<small id="message">Cliquer sur les infractions ci-dessous pour les supprimer.</small>
						<ul id="listeInfraction" class="mb-4">
						
						</ul>							                   	
					</div>	
					
					
									   						                                                                   
                    <!-- Choix vehicule -->   
                    <div class="form-group my-3">
                    	<div class="col-md-3 my-3">
	                    	<label class="col-sm-12 control-label" for="typeVehicule"><span class="fas fa-car mx-1"></span>Type de véhicule :</label>
	                    	<select class="mb-5" name="typeVehicule" id="typeVehicule">
                        		<% for(C_TypeVehicule vehi : typeVehicule){%>
                        			<option value=<%=vehi.getId()%>><%=vehi.getLibelle()%></option>
                        		<%}%>  
            				</select>
   						</div>
                    </div> 
                    
                    <!-- Informations du contrevenant -->
                    <h5 class="card-subtitle mb-2 text-center">Informations contrevenant (si présent)</h5> 
                    <h6 class="card-subtitle mb-2 my-3"><span class="fas fa-address-card mx-1"></span>Personne : </h6>                  
                    <div class="form-group my-3">
                    	<div class="row justify-content-between">                   	
                    		<!-- Nom -->
                    		<div class="col-sm-6">
                    			<label class="col-sm-6 control-label" for="nom">Nom :</label>  
                    			<div class="col-md-7">
                        			<input type="text" class="form-control" name="nom" id="nom" maxlength="100">
                        			<small id="nomErreur"></small>  
                    			</div> 
                    		</div>
                    		                   		
                    		<!-- Prenom -->
                    		<div class="col-sm-6">
                    			<label class="col-sm-6 control-label" for="prenom">Prenom :</label>  
                    			<div class="col-md-7">
                        			<input type="text" class="form-control" name="prenom" id="prenom" maxlength="100"> 
                        			<small id="prenomErreur"></small> 
                    			</div>
                    		</div>                   		
                    	</div>
                    </div>                
                    
                    <h6 class="card-subtitle mb-2 my-3"><span class="fas fa-home mx-1"></span>Adresse : </h6>                    	
                    <!-- Pays -->    
                    <div class="form-group my-3">											   						
                    	<label class="col-sm-6 control-label" for="pays">Pays :</label>  
                    	<div class="col-md-4">
                        	<input type="text" class="form-control" name="pays" id="pays" maxlength="100">  
                        	<small id="paysErreur"></small>
                    	</div>
                    </div>	
                    
                    <div class="form-group my-3">
                    	<div class="row justify-content-between">
                    		<!-- Code postal -->
                    		<div class="col-sm-6">
                    			<label class="col-sm-6 control-label" for="codePostal">Code postal :</label>  
                    			<div class="col-md-7">
                        			<input type="number" class="form-control" name="codePostal" id="codePostal" min=0 maxlength="5"> 
                        			<small id="codePostalErreur"></small> 
                    			</div> 
                    		</div>
                    		
                    		<!-- Ville --> 
                    		<div class="col-sm-6">
                    			<label class="col-sm-6 control-label" for="ville">Ville :</label>  
                    			<div class="col-md-7">
                        			<input type="text" class="form-control" name="ville" id="ville" maxlength="100"> 
                        			<small id="villeErreur"></small> 
                    			</div> 
                    		</div>                    		
                    	</div>
                    </div> 
                    
                    <!-- Rue -->
                     <div class="form-group my-3">                     	                    		
                    	<label class="col-sm-6 control-label" for="rue">Rue :</label>  
                    	<div class="col-md-6">
                    		<input type="text" class="form-control" name="rue" id="rue" maxlength="100"> 
                    		<small id="rueErreur"></small> 
                   		</div>                    												   						                    	
                    </div>
                    
                     <div class="form-group my-3">
                     	<div class="row justify-content-between">
                     		<!-- Numero -->
                     		<div class="col-sm-6">
                    			<label class="col-sm-6 control-label" for="numero">Numero :</label>  
                    			<div class="col-md-7">
                        			<input type="number" class="form-control" name="numero" id="numero" min=0 maxlength="5">  
                        			<small id="numeroErreur"></small>
                    			</div> 
                    		</div>
                    		
                     		<!-- Boite -->
                     		<div class="col-sm-6">
                     			<label class="col-sm-6 control-label" for="boite">Boite :</label>  
                    			<div class="col-md-7">
                        			<input type="text" class="form-control" name="boite" id="boite" maxlength="10">
                        			<small id="boiteErreur"></small>  
                    			</div>
                     		</div>                    		
                     	</div>
                     </div>  
                                                                                                   		                 				           	                              												  						   										 						   				   						  											   						  						  					                        
                    <!-- Submit -->
                    <div class="form-group text-center my-3">
                        <button type="submit" id="submit" name="submit" class="btn btn-primary">Ajouter</button>
                    </div>                               
				</form>
				<div class="erreur"></div>
			</div>
		</div>	
	</div>
	</div>
	
	<div class="my-3"></div>
	
	<!-- Partie JS -->
	<script type="text/javascript">
	let listeInfraction = document.querySelector("#listeInfraction");
	let formulaire = document.querySelector("#formulaire");
	let lieu = document.querySelector("#lieu");
	let immatriculation = document.querySelector("#immatriculation");
	let commentaire = document.querySelector("#commentaire");
	let typeInfraction = document.querySelector("#typeInfraction");
	let typeVehicule = document.querySelector("#typeVehicule");
	let nom = document.querySelector("#nom");
	let prenom = document.querySelector("#prenom");
	let pays = document.querySelector("#pays");
	let codePostal = document.querySelector("#codePostal");
	let ville = document.querySelector("#ville");
	let rue = document.querySelector("#rue");
	let numero = document.querySelector("#numero");
	let boite = document.querySelector("#boite");
	let lieuErreur = document.querySelector("#lieuErreur");
	let immatriculationErreur = document.querySelector("#immatriculationErreur");
	let commentaireErreur = document.querySelector("#commentaireErreur");
	let typeInfractionErreur = document.querySelector("#typeInfractionErreur");
	let nomErreur = document.querySelector("#nomErreur");
	let prenomErreur = document.querySelector("#prenomErreur");
	let paysErreur = document.querySelector("#paysErreur");
	let codePostalErreur = document.querySelector("#codePostalErreur");
	let villeErreur = document.querySelector("#villeErreur");
	let rueErreur = document.querySelector("#rueErreur");
	let numeroErreur = document.querySelector("#numeroErreur");
	let boiteErreur = document.querySelector("#boiteErreur");
	let erreur = document.querySelector(".erreur");
	let modalTextMontant = document.querySelector("#modalTextMontant");
	let modalMontant = document.querySelector("#modalMontant");
	let btnFermerMontant = document.querySelector("#btnFermerMontant");
	let message = document.querySelector("#message");
	
	
	var selectValeurs = [];
	var tailleSelect = typeInfraction.options.length;
	var ajoutInfraction = 0;
	
	// Cacher message supprimer de base
	$("#message").hide();
	
	// Obtenir les infractions choisies
	// Quand-même plus simple avec du JQUERY
	$("#typeInfraction").click(function(){ 
		$("#message").show();
    	$("#typeInfraction :selected").each(function(){
    		// Ajouter valeur tableau selectValeurs
    		selectValeurs.push($(this).val());
    		// Retirer élément selectionné du select
    		$(this).remove();
    		$('#listeInfraction').append(
    					$('<li class=\"link\">' + $(this).text() + '\</li>').on(
    							'click', (e) => {
    									// Retirer élément choisi li
    									$(e.target).remove();
    									// Ajouter élément choisi option
    									$('#typeInfraction').append($('<option>', {
    										value: $(this).val(),
    									    text: $(this).text()
    									}));
    									// Supprimer valeur tableau selectValeurs
    									var index = selectValeurs.indexOf($(this).val());
    									selectValeurs.splice(index, 1);
    									
    									// Si option présente ==> Afficher
    									if(typeInfraction.options.length != 0){
    										$("#formSelect").show();
    									}
    									
    									if(typeInfraction.options.length == tailleSelect){
    							    		$("#message").hide();
    							    	}
    									
    									
    								}
    							));	
    	});
    	if (document.getElementById('assurabilite').textContent == 'non-recherchée.'
			&& document.getElementById('listeInfraction').getElementsByTagName("li")[0].innerHTML != "Défaut d'assurance"
			&& document.querySelector("#listeInfraction").childElementCount == 1)
		{
			var xhr = new XMLHttpRequest();
			xhr.onreadystatechange = () => {
				if(xhr.readyState === 4 && xhr.status === 200) {
					if (xhr.responseText === "0")
					{
						document.getElementById('assurabilite').style.color = "#008800";
						document.getElementById('assurabilite').textContent = "Le véhicule est en ordre d'assurance."
					}
					else if (xhr.responseText === "2")
					{
						document.getElementById('assurabilite').style.color = "#ff0000";
						document.getElementById('assurabilite').textContent = "Le véhicule n'est pas en ordre d'assurance."
					}
					else 
					{
						document.getElementById('assurabilite').style.color = "#ff0000";
						document.getElementById('assurabilite').title = "L'immatriculation est manquante."
					}
					
				}
			};
			xhr.open("POST", "VerifierAssurance", true);
			xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
			xhr.send("immatriculation="+escape(immatriculation.value));
		}
    	
    	// Si select option vide ==> Cacher
    	if(typeInfraction.options.length == 0){
    		$("#formSelect").hide();
		}
	});
	
	// Fonction pour fermer modal manuellement
	btnFermer.addEventListener('click', () => {
		modal.classList.add("hidden");
		modal.style.display = "none";
	});
	
	// Fonction pour fermer modal montant manuellement
	btnFermerMontant.addEventListener('click', () => {
		modalMontant.classList.add("hidden");
		modalMontant.style.display = "none";
		
		// Redirection vers ajouterAmende
        document.location.href = '${pageContext.request.contextPath}/AjouterAmende';
	});
	
	// Fonction pour submit formulaire
	formulaire.addEventListener('submit', (e) =>{
		e.preventDefault();
		modalText.value = "";
		
		// Vérification des champs(obligatoire)
		var champLieu, champCommentaire, champInfraction;
		
		// Vérification des champs(optionnel)
		var champCodePostal = 0, champNumero = 0;
		
		// Lieu
		if(checkIsEmpty(lieu.value)){
			lieu.style.border = "2px dashed red";
			lieuErreur.innerHTML ="Veuillez indiquer un lieu !";
			champLieu = 1;
		}
		
		else{
			lieu.style.border = "1px solid #ced4da";
			lieuErreur.innerHTML ="";
			champLieu = 0;
		}
		
		// Commentaire
		if(checkIsEmpty(commentaire.value)){
			commentaire.style.border = "2px dashed red";
			commentaireErreur.innerHTML ="Veuillez indiquer un commentaire !";
			champCommentaire = 1;
		}
		
		else{
			commentaire.style.border = "1px solid #ced4da";
			commentaireErreur.innerHTML ="";
			champCommentaire = 0;
		}
		
		// Type infractions
		if(Array.isArray(selectValeurs) && selectValeurs.length == 0){
			typeInfraction.style.border = "2px dashed red";
			typeInfractionErreur.innerHTML ="Vous devez choisir une infraction !";
			champInfraction = 1;
		}
		
		else{
			typeInfraction.style.border = "1px solid #ced4da";
			typeInfractionErreur.innerHTML ="";
			champInfraction = 0;
		}
		
		// ---------- Partie contrevenant optionnel -----------------------------				
		// Code postal
		if(!checkIsEmpty(codePostal.value)){
			if(checkIsNegative(codePostal.value)){
				codePostal.style.border = "2px dashed red";
				codePostalErreur.innerHTML ="Code postal incorrect !";
				champCodePostal = 1;
			}
			
			else{
				codePostal.style.border = "1px solid #ced4da";
				codePostalErreur.innerHTML ="";
				champCodePostal = 0;
			}
		}
		
		// Numero
		if(!checkIsEmpty(numero.value)){
			if(checkIsNegative(numero.value)){
				numero.style.border = "2px dashed red";
				numeroErreur.innerHTML ="Numero incorrect !";
				champNumero = 1;
			}
			
			else{
				numero.style.border = "1px solid #ced4da";
				numeroErreur.innerHTML ="";
				champNumero = 0;
			}
		}
		
		// Call ajax si aucun problème
		if(champLieu == 0 && champCommentaire == 0 && champInfraction == 0
			&& champCodePostal == 0 && champNumero == 0){
			
			var param = "lieu=" + escape(lieu.value);
			param += "&immatriculation=" + escape(immatriculation.value);
			param += "&commentaire=" + escape(commentaire.value);
			param += "&tabInfraction=" + escape(selectValeurs);
			param += "&typeVehicule=" + escape(typeVehicule.value);
			param += "&nom=" + escape(nom.value);
			param += "&prenom=" + escape(prenom.value);
			param += "&pays=" + escape(pays.value);
			param += "&codePostal=" + escape(codePostal.value);
			param += "&ville=" + escape(ville.value);
			param += "&rue=" + escape(rue.value);
			param += "&numero=" + escape(numero.value);
			param += "&boite=" + escape(boite.value);
			
			var xhr = new XMLHttpRequest();
			xhr.onreadystatechange = () => {
				if(xhr.readyState === 4 && xhr.status === 200) {
					var tabChaine = (xhr.responseText);
					var chaine = tabChaine.split(","); // Diviser la chaine recue par le séparateur ","
					// Si enregistrement réussi
					if(chaine[0] === "0"){
						// Effacement du formulaire
												
						// Afficher modal montant
						modalTextMontant.innerHTML = "Montant total : " + chaine[1] +"\u20ac" ;
						modalMontant.classList.add("show");
						modalMontant.style.display = "block";												
					}
					
					// Formulaire vide
					else if(chaine[0] === "1"){
						erreur.innerHTML ="Veuillez remplir le formulaire !";
					}
					
					// Montant non valide
					else if(chaine[0] === "2"){
						erreur.innerHTML ="Veuillez inscrire des valeurs numériques valides !";
					}
					
					// Enregistrement échoué
					else if(chaine[0] === "3"){
						erreur.innerHTML ="";
						modalText.innerHTML = "Enregistrement échoué !";
						modal.classList.add("show");
						modal.style.display = "block";
	                    
	                    setTimeout(() => {
	                    	modal.classList.add("hidden");
	    					modal.style.display = "none";
	                    }, 3000);
					}
					
					// Si erreurs diverses
					else{
						erreur.innerHTML ="";
						modalText.innerHTML = "Une erreur inconnue est survenue dans le système !";
						modal.classList.add("show");
						modal.style.display = "block";
	                    
	                    setTimeout(() => {
	                    	modal.classList.add("hidden");
	    					modal.style.display = "none";
	                    }, 3000);
					}
				}
			};
			xhr.open("POST", "AjouterAmende", true);
			xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
			xhr.send(param);
		}		
	});	
	</script>
    
	<!-- Footer - informations -->
	<%@include file="../Layout/footer.jsp" %>