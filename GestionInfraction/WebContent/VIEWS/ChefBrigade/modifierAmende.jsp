<%@ page import="Model.BEANS.C_Amende" %>
<!-- Header - informations -->
<%@include file="../Layout/header.jsp" %>
	
	<% 
		C_Amende a = (C_Amende)request.getAttribute("amende");
	%>
	
	<header>
		<!-- Titre -->
        <h1>Modification amende</h1>
        <div class="lineTitre"></div>
	</header>
	
	<!-- Affichage pop-up -->
	<%@include file="../Layout/modal.jsp" %>
	
	<div class="text-center">
		<p>Vous pouvez ici rajouter les informations du contrevenant !</p>
	</div>
	
	<!-- Formulaire amende -->
	<div id="formulaire">
		<div class="container d-flex justify-content-center">			
		<div class="card col-md-8">				
			<div class="card-header text-center">Formulaire</div>
			<div class="card-body bg-light">
				<form class="form-horizontal" method="POST" role="form">
					<div class="form-group my-3">
                    	<div class="row justify-content-between">                   	
                    		<!-- Nom -->
                    		<div class="col-sm-6">
                    			<label class="col-sm-6 control-label" for="nom">Nom : <span class="requis"> *</span></label>  
                    			<div class="col-md-7">
                        			<input type="text" class="form-control" name="nom" id="nom" <%if(a.getContrevenant().getNom() == null){%>value=""<%}else{%>value=<%=a.getContrevenant().getNom()%><%}%> maxlength="100">  
                        			<small id="nomErreur"></small>
                    			</div> 
                    		</div>
                    		                   		
                    		<!-- Prenom -->
                    		<div class="col-sm-6">
                    			<label class="col-sm-6 control-label" for="prenom">Prenom : <span class="requis"> *</span></label>  
                    			<div class="col-md-7">
                        			<input type="text" class="form-control" name="prenom" id="prenom" <%if(a.getContrevenant().getPrenom() == null){%>value=""<%}else{%>value=<%=a.getContrevenant().getPrenom()%><%}%> maxlength="100"> 
                        			<small id="prenomErreur"></small>
                    			</div>
                    		</div>                   		
                    	</div>
                    </div>
                    
                    <!-- Pays -->    
                    <div class="form-group my-3">											   						
                    	<label class="col-sm-6 control-label" for="pays">Pays :</label>  
                    	<div class="col-md-4">
                        	<input type="text" class="form-control" name="pays" id="pays" <%if(a.getContrevenant().getPays() == null){%>value=""<%}else{%>value=<%=a.getContrevenant().getPays()%><%}%> maxlength="100">  
                        	<small id="paysErreur"></small>
                    	</div>
                    </div>
                    
                    <div class="form-group my-3">
                    	<div class="row justify-content-between">
                    		<!-- Code postal -->
                    		<div class="col-sm-6">
                    			<label class="col-sm-6 control-label" for="codePostal">Code postal :</label>  
                    			<div class="col-md-7">
                        			<input type="number" class="form-control" name="codePostal" id="codePostal" <%if(a.getContrevenant().getCodePostal() == 0){%>value=0<%}else{%>value=<%=a.getContrevenant().getCodePostal()%><%}%>  min=0 maxlength="5"> 
                        			<small id="codePostalErreur"></small> 
                    			</div> 
                    		</div>
                    		
                    		<!-- Ville --> 
                    		<div class="col-sm-6">
                    			<label class="col-sm-6 control-label" for="ville">Ville :</label>  
                    			<div class="col-md-7">
                        			<input type="text" class="form-control" name="ville" id="ville" <%if(a.getContrevenant().getVille() == null){%>value=""<%}else{%>value=<%=a.getContrevenant().getVille()%><%}%> maxlength="100"> 
                        			<small id="villeErreur"></small> 
                    			</div> 
                    		</div>                    		
                    	</div>
                    </div> 
                    
                    <!-- Rue -->
                     <div class="form-group my-3">                     	                    		
                    	<label class="col-sm-6 control-label" for="rue">Rue :</label>  
                    	<div class="col-md-6">
                    		<input type="text" class="form-control" name="rue" id="rue" <%if(a.getContrevenant().getRue() == null){%>value=""<%}else{%>value=<%=a.getContrevenant().getRue()%><%}%> maxlength="100"> 
                    		<small id="rueErreur"></small> 
                   		</div>                    												   						                    	
                    </div>
                    
                     <div class="form-group my-3">
                     	<div class="row justify-content-between">
                     		<!-- Numero -->
                     		<div class="col-sm-6">
                    			<label class="col-sm-6 control-label" for="numero">Numero :</label>  
                    			<div class="col-md-7">
                        			<input type="number" class="form-control" name="numero" id="numero" <%if(a.getContrevenant().getNumero() == 0){%>value=0<%}else{%>value=<%=a.getContrevenant().getNumero()%><%}%> min=0 maxlength="5">  
                        			<small id="numeroErreur"></small>
                    			</div> 
                    		</div>
                    		
                     		<!-- Boite -->
                     		<div class="col-sm-6">
                     			<label class="col-sm-6 control-label" for="boite">Boite :</label>  
                    			<div class="col-md-7">
                        			<input type="text" class="form-control" name="boite" id="boite" <%if(a.getContrevenant().getBoite() == null){%>value=""<%}else{%>value=<%=a.getContrevenant().getBoite()%><%}%> maxlength="10">
                        			<small id="boiteErreur"></small>  
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
		let nom = document.querySelector("#nom");
		let prenom = document.querySelector("#prenom");
		let pays = document.querySelector("#pays");
		let codePostal = document.querySelector("#codePostal");
		let ville = document.querySelector("#ville");
		let rue = document.querySelector("#rue");
		let numero = document.querySelector("#numero");
		let boite = document.querySelector("#boite");
		let erreur = document.querySelector(".erreur");
		let modal = document.querySelector("#modal");
		let modalText = document.querySelector("#modalText");
		let nomErreur = document.querySelector("#nomErreur");
		let prenomErreur = document.querySelector("#prenomErreur");
		let paysErreur = document.querySelector("#paysErreur");
		let codePostalErreur = document.querySelector("#codePostalErreur");
		let villeErreur = document.querySelector("#villeErreur");
		let rueErreur = document.querySelector("#rueErreur");
		let numeroErreur = document.querySelector("#numeroErreur");
		let boiteErreur = document.querySelector("#boiteErreur");
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
			var champCodePostal = 0, champNumero = 0;
				
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
			
			if(champCodePostal == 0 && champNumero == 0){
				var param = "nom=" + escape(nom.value);
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
						// Si modification réussie
						if((xhr.responseText) === "0"){							
							// Redirection vers liste infraction
		                    document.location.href = '${pageContext.request.contextPath}/ListerAmende';
						}
						
						// Montant non valide
						else if((xhr.responseText) === "1"){
							erreur.innerHTML ="Veuillez inscrire un montant valide !";
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
				xhr.open("POST", "ModifierAmende", true);
				xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
				xhr.send(param);
			}
		});			
	</script>
	
	<!-- Footer - informations -->
	<%@include file="../Layout/footer.jsp" %>