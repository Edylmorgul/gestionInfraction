<%@ page import="Model.BEANS.C_TypeVehicule" %>
<!-- Header - informations -->
<%@include file="../Layout/header.jsp" %>
	
	<% 
		C_TypeVehicule v = (C_TypeVehicule)request.getAttribute("typeVehicule");
	%>
	
	<header>
		<!-- Titre -->
        <h1>Modification type vehicule</h1>
        <div class="lineTitre"></div>
	</header>
	
	<!-- Affichage pop-up -->
	<%@include file="../Layout/modal.jsp" %>
	
	<div class="text-center">
		<p>Vous pouvez ici modifier les informations d'un type de vehicule !</p>
	</div>
	
	<!-- Formulaire type vehicule -->
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
                        			<input type="text" class="form-control" name="libelle" id="libelle" value="<%=v.getLibelle()%>" required maxlength="100">  
                        			<small id="libelleErreur"></small>
                    			</div> 
                    		</div>
                    		                   		
                    		<!-- Description -->
                    		<div class="col-sm-6">
                    			<label class="col-sm-6 control-label" for="description">Description : <span class="requis"> *</span></label>  
                    			<div class="col-md-10">
                        			<textarea class="form-control" id="description" name="description" id="description" required rows="3"><%=v.getDescription()%></textarea>
                        			<small id="descriptionErreur"></small>
                    			</div>
                    		</div>                   		
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
			var champLibelle, champDescription;
				
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
			
			if(champLibelle == 0 && champDescription == 0){
				var param = "libelle=" + escape(libelle.value);
				param += "&description=" + escape(description.value);
				
				var xhr = new XMLHttpRequest();
				xhr.onreadystatechange = () => {
					if(xhr.readyState === 4 && xhr.status === 200) {
						// Si modification réussie
						if((xhr.responseText) === "0"){							
							// Redirection vers liste vehicule
		                    document.location.href = '${pageContext.request.contextPath}/ListerVehicule';
						}
						
						// Formulaire vide
						else if((xhr.responseText) === "1"){
							erreur.innerHTML ="Veuillez remplir le formulaire !";
						}
						
						// Modification échouée
						else if((xhr.responseText) === "2"){
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
				xhr.open("POST", "ModifierVehicule", true);
				xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
				xhr.send(param);
			}
		});			
	</script>
	
	<!-- Footer - informations -->
	<%@include file="../Layout/footer.jsp" %>