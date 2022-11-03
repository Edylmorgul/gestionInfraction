<%@ page import="Model.BEANS.C_TypeVehicule" %>
<%@ page import="java.util.List"%>
<!-- Header - informations -->
<%@include file="../Layout/header.jsp" %>
	<!-- Liste type vehicule servlet -->
	<% 
		List<C_TypeVehicule> liste = (List)request.getAttribute("liste");
	%>
	
	<header>
		<!-- Titre -->
        <h1>Consultation des vehicules</h1>
        <div class="lineTitre"></div>
	</header>
	
	<!-- Affichage pop-up -->
	<%@include file="../Layout/modal.jsp" %>
		
	<!-- Tableau type vehicule -->
	<div class="container">
		<table class="table col-md-6" id="tableVehicule">
			<thead> 
				<tr> 
					<th class="col-md-3" style="text-align:center !important">Libellé</th>
					<th class="col-md-3" style="text-align:center !important">Description</th>
					<th style="text-align:center !important" class="col-md-1">Modifier</th>
					<th style="text-align:center !important" class="col-md-1">Supprimer</th>											
				</tr>
			</thead>
			<tbody>
				<% for(C_TypeVehicule v : liste){%>
					<tr> 
						<td style="text-align:center !important"><%=v.getLibelle()%></td>
						<td style="text-align:center !important"><%=v.getDescription()%></td>
	         			<td style="text-align:center !important"><div class="btn"><a href="${pageContext.request.contextPath}/ModifierVehicule?id=<%=v.getId()%>">Modifier</a></div></td>
	         			<td style="text-align:center !important"><div class="btn"><a href="${pageContext.request.contextPath}/SupprimerVehicule?id=<%=v.getId()%>">Supprimer</a></div></td>	         				  	         					         			         				
					</tr>					
				<%}%> 
			</tbody>
		</table>
	</div>	
	
	<!-- Ajouter un type de vehicule -->
	<div class="text-center">
		<p>Vous pouvez ajouter un type de vehicule via cette option :</p>
	</div>
	
	<div class="text-center my-3">
      <button type="button" class="btn btn-primary" id="btnFormulaire">Formulaire</button>
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
                        			<input type="text" class="form-control" name="libelle" id="libelle" required maxlength="100">  
                        			<small id="libelleErreur"></small>
                    			</div> 
                    		</div>
                    		                   		
                    		<!-- Description -->
                    		<div class="col-sm-6">
                    			<label class="col-sm-6 control-label" for="description">Description : <span class="requis"> *</span></label>  
                    			<div class="col-md-10">
                        			<textarea class="form-control" name="description" id="description" required rows="3"></textarea>
                        			<small id="descriptionErreur"></small>
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
	
	<div class="text-center my-3">
      <button type="button" class="btn btn-primary" id="btnCacherForm">Cacher</button>
    </div>
    
    <div class="text-center my-3">
      <button type="button" class="btn btn-primary" onclick="window.location.href='${pageContext.request.contextPath}/GererRetour'">Retour</button>
    </div>
    
    <div class="my-3"></div>
    
    <!-- Partie JS -->
	<script type="text/javascript">
		let btnFormulaire = document.querySelector("#btnFormulaire");
		let formulaire = document.querySelector("#formulaire");
		let btnCacherForm = document.querySelector("#btnCacherForm");
		let libelle = document.querySelector("#libelle");
		let description = document.querySelector("#description");
		let erreur = document.querySelector(".erreur");
		let modal = document.querySelector("#modal");
		let modalText = document.querySelector("#modalText");
		let libelleErreur = document.querySelector("#libelleErreur");
		let descriptionErreur = document.querySelector("#descriptionErreur");
		let btnFermer = document.querySelector("#btnFermer");
		let tableVehicule = document.querySelector("#tableVehicule");
		
		// Elements cachés de base
		formulaire.hidden = true;
		btnCacherForm.hidden = true;
		
		// Refresh automatique lors de l'utilisation bouton back navigation
		window.addEventListener( "pageshow", function ( event ) {
  			var historyTraversal = event.persisted || 
                         ( typeof window.performance != "undefined" && 
                              window.performance.navigation.type === 2 );
  			if ( historyTraversal ) {
    			window.location.reload();
  			}
		});
		
		// Fonction pour fermer modal manuellement
		btnFermer.addEventListener('click', () => {
			modal.classList.add("hidden");
			modal.style.display = "none";
		});
		
		// Fonction pour afficher formulaire
		btnFormulaire.addEventListener('click', () =>{
			formulaire.hidden = false;
			btnCacherForm.hidden = false;
			btnFormulaire.hidden = true;			
		});
		
		// Fonction pour cacher formulaire
		btnCacherForm.addEventListener('click', () =>{
			formulaire.hidden = true;
			btnCacherForm.hidden = true;
			btnFormulaire.hidden = false;			
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
						// Si enregistrement réussi
						if((xhr.responseText) === "0"){
							// Effacement du formulaire
							libelle.value = "";
							description.value = "";
							
							// Affichage du message pop-up
							erreur.innerHTML ="";
							modalText.innerHTML = "Enregistrement réussi !";
							modal.classList.add("show");
							modal.style.display = "block";
		                    
		                 	// Cacher modal après un certain délai
		                    setTimeout(() => {
		                    	modal.classList.add("hidden");
		    					modal.style.display = "none";
		                    }, 3000);		
		            		     
		                 	/*$.ajax({		             
		                 		Type: "GET",
		                 		url:"ActualiserVehicule",
		                 		dataType: "text",
		                 		
		                 		success : function(data){
		                 			console.log(data);
		                 			data = JSON.parse(data);
		                 			for(var i=0; i<data.length; i++){
		                 				var tableRow = 
		   									"<tr>" 
		   										+ "<td>" + data[i].libelle + "</td>" 
		   										+ "<td>" + data[i].description +  "</td>"   
		   									+ "</tr>"
		   								$(tableRow).appendTo("#tableVehicule tbody");
		                 			}
		                 		},
		                 		error: function(xhr, ajaxOptions, thrownError) {
		                 			console.log(xhr.statusText);
		                 	        console.log(xhr.responseText);
		                 	        console.log(xhr.status);
		                 	        console.log(thrownError);
		                 	       console.warn(xhr.responseText)
		                 	    }
		                 	});*/
		                    $('#tableVehicule').load('ActualiserVehicule').fadeIn("slow");		                 	
						}
						
						// Formulaire vide
						else if((xhr.responseText) === "1"){
							erreur.innerHTML ="Veuillez remplir le formulaire !";
						}
						
						// Enregistrement échoué
						else if((xhr.responseText) === "2"){
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
				xhr.open("POST", "AjouterVehicule", true);
				xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
				xhr.send(param);
			}
		});			
	</script>
	
	<!-- Footer - informations -->
	<%@include file="../Layout/footer.jsp" %>