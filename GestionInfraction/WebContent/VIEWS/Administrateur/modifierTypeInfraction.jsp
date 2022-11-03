<%@ page import="Model.BEANS.C_TypeInfraction" %>
<!-- Header - informations -->
<%@include file="../Layout/header.jsp" %>
	
	<% 
		C_TypeInfraction i = (C_TypeInfraction)request.getAttribute("typeInfraction");
	%>
	
	<header>
		<!-- Titre -->
        <h1>Modification type infraction</h1>
        <div class="lineTitre"></div>
	</header>
	
	<!-- Affichage pop-up -->
	<%@include file="../Layout/modal.jsp" %>
	
	<div class="text-center">
		<p>Vous pouvez ici modifier les informations d'un type d'infraction !</p>
	</div>
	
	<!-- Formulaire type infraction -->
	<div id="formulaire">
		<div class="container d-flex justify-content-center">			
		<div class="card col-md-8">				
			<div class="card-header text-center">Formulaire</div>
			<div class="card-body bg-light">
				<form class="form-horizontal" method="POST" role="form">
					<div class="form-group my-3">
                    	<div class="row justify-content-between">                   	
                    		<!-- Libelle -->
                    		<div class="col-sm-6">
                    			<label class="col-sm-6 control-label" for="libelle">Libellé : <span class="requis"> *</span></label>  
                    			<div class="col-md-8">
                        			<input type="text" class="form-control" name="libelle" id="libelle" value="<%=i.getLibelle()%>" required maxlength="100">  
                        			<small id="libelleErreur"></small>
                    			</div> 
                    		</div>
                    		                   		
                    		<!-- Montant -->
                    		<div class="col-sm-6">
                    			<label class="col-sm-6 control-label" for="montant">Montant : <span class="requis"> *</span></label>  
                    			<div class="col-md-4">
                        			<input type="number" class="form-control" step=0.01 min=0 name="montant" id="montant" value=<%=i.getMontant()%> required maxlength="20">  
                        			<small id="montantErreur"></small>
                    			</div>
                    		</div>                   		
                    	</div>
                    </div>
                    
                    <!-- Description -->
                    <div class="form-group my-3">
                    	<label class="col-sm-6 control-label" for="description">Description : <span class="requis"> *</span></label>  
                    	<div class="col-md-6">
                        	<textarea class="form-control" id="description" name="description" id="description" required rows="3"><%=i.getDescription()%></textarea>
                        	<small id="descriptionErreur"></small>
                    	</div>
                    </div>
					
           			<!-- Submit -->
                    <div class="form-group text-center my-3">
                        <button type="submit" id="submit" name="submit" class="btn btn-primary">Modifier</button>
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
		let formulaire = document.querySelector("#formulaire");
		let libelle = document.querySelector("#libelle");
		let description = document.querySelector("#description");
		let erreur = document.querySelector(".erreur");
		let modal = document.querySelector("#modal");
		let modalText = document.querySelector("#modalText");
		let libelleErreur = document.querySelector("#libelleErreur");
		let descriptionErreur = document.querySelector("#descriptionErreur");
		let montantErreur = document.querySelector("#montantErreur");
		let btnFermer = document.querySelector("#btnFermer");
		
		// Fonction pour fermer modal manuellement
		btnFermer.addEventListener('click', () => {
			modal.classList.add("hidden");
			modal.style.display = "none";
		});
		
		// Fonction pour submit formulaire
		formulaire.addEventListener('submit', (e) =>{
			e.preventDefault();
			modalText.value = "";
			 
			// Vérification des champs
			var champLibelle, champDescription, champMontant;
				
			// Libelle
			if(checkIsEmpty(libelle.value)){
				libelle.style.border = "2px dashed red";
				libelleErreur.innerHTML ="Valeur incorrecte !";
				champLibelle = 1;
			}
				
			else{
				libelle.style.border = "1px solid #ced4da";
				libelleErreur.innerHTML ="";
				champLibelle = 0;
			}
				
			// Description
			if(checkIsEmpty(description.value)){
				description.style.border = "2px dashed red";
				descriptionErreur.innerHTML ="Valeur incorrecte !";
				champDescription = 1;
			}
				
			else{
				description.style.border = "1px solid #ced4da";
				descriptionErreur.innerHTML ="";
				champDescription = 0;
			}
			
			// Montant
			if(checkIsEmpty(montant.value) || checkIsNegative(montant.value)){
				montant.style.border = "2px dashed red";
				montantErreur.innerHTML ="Montant incorrect !";
				champMontant = 1;
			}
			
			else{
				montant.style.border = "1px solid #ced4da";
				montantErreur.innerHTML ="";
				champMontant = 0;
			}
			
			if(champLibelle == 0 && champDescription == 0 && champMontant == 0){
				var param = "libelle=" + escape(libelle.value);
				param += "&description=" + escape(description.value);
				param += "&montant=" + escape(montant.value);
				
				var xhr = new XMLHttpRequest();
				xhr.onreadystatechange = () => {
					if(xhr.readyState === 4 && xhr.status === 200) {
						// Si modification réussie
						if((xhr.responseText) === "0"){							
							// Redirection vers liste infraction
		                    document.location.href = '${pageContext.request.contextPath}/ListerInfraction';
						}
						
						// Formulaire vide
						else if((xhr.responseText) === "1"){
							erreur.innerHTML ="Veuillez remplir le formulaire !";
						}
						
						// Montant non valide
						else if((xhr.responseText) === "2"){
							erreur.innerHTML ="Veuillez inscrire un montant valide !";
						}
						
						// Modification échouée
						else if((xhr.responseText) === "3"){
							erreur.innerHTML ="";
							modalText.innerHTML = "Modification échouée !";
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
				xhr.open("POST", "ModifierInfraction", true);
				xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
				xhr.send(param);
			}
		});			
	</script>
	
	<!-- Footer - informations -->
	<%@include file="../Layout/footer.jsp" %>