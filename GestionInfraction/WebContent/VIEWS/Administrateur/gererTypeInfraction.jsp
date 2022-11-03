<%@ page import="Model.BEANS.C_TypeInfraction" %>
<%@ page import="Model.BEANS.Global" %>
<%@ page import="java.util.List"%>
<!-- Header - informations -->
<%@include file="../Layout/header.jsp" %>
	<!-- Liste type infraction servlet -->
	<% 
		List<C_TypeInfraction> liste = (List)request.getAttribute("liste");
	%>
	
	<header>
		<!-- Titre -->
        <h1>Consultation des types d'infractions</h1>
        <div class="lineTitre"></div>
	</header>
	
	<!-- Affichage pop-up -->
	<%@include file="../Layout/modal.jsp" %>
	
	<!-- Options tri actif -->
	<div class="container">
		<div class="row">
			<p>Trier par infraction actif ou non :</p>
			<!-- Choix type infraction -->
			<div class="col-sm-6">
				<select name="trierTypeInfraction" id="trierTypeInfraction">
					<option value=1>Tout</option>
        			<option selected value=2>Actif</option>
        			<option value=3>Non actif</option>
    			</select>    	
			</div>
		
			<div class="form-group my-5">
            	<button id="btnTri" name="btnTri" class="btn btn-primary">Trier</button>
           	</div>       		
		</div>
	</div>
	   	
	<!-- Tableau infraction -->
	<div class="container">
		<table class="table col-md-6" id="tableInfraction">
			<thead> 
				<tr> 
					<th class="col-md-3" style="text-align:center !important">Libellé</th>
					<th class="col-md-5" style="text-align:center !important">Description</th>
					<th class="col-md-2" style="text-align:center !important">Montant</th>
					<th style="text-align:center !important" class="col-md-1">Modifier</th>
					<th style="text-align:center !important" class="col-md-1">Supprimer</th>											
				</tr>
			</thead>
			<tbody>
				<% for(C_TypeInfraction i : liste){%>
					<!-- Ne pas permettre de modifier les anciennes infractions -->				
					<tr> 
						<td style="text-align:center !important"><%=i.getLibelle()%></td>
						<td style="text-align:center !important"><%=i.getDescription()%></td>
						<td style="text-align:center !important"><%=String.format("%.2f",i.getMontant())+Global.euro%></td>
						<td style="display:none"><%=i.getNomDateFin()%></td>
						<%if(i.getdFin() == null){%>
							<td><div class="btn"><a href="${pageContext.request.contextPath}/ModifierInfraction?id=<%=i.getId()%>">Modifier</a></div></td>
	         				<td><div class="btn"><a href="${pageContext.request.contextPath}/SupprimerInfraction?id=<%=i.getId()%>">Supprimer</a></div></td>
						<%}
						else {%>
	         				<td><div class="btn disableLink"><a href="${pageContext.request.contextPath}/ModifierInfraction?id=<%=i.getId()%>">Modifier</a></div></td>
	         				<td><div class="btn disableLink"><a href="${pageContext.request.contextPath}/SupprimerInfraction?id=<%=i.getId()%>">Supprimer</a></div></td>
	         			<%}%>         				  	         					         			         				
					</tr>													
				<%}%> 
			</tbody>
		</table>
	</div>	
	
	<!-- Ajouter un type infraction -->
	<div class="text-center">
		<p>Vous pouvez ajouter un type d'infraction via cette option :</p>
	</div>
	
	<div class="text-center my-3">
      <button type="button" class="btn btn-primary" id="btnFormulaire">Formulaire</button>
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
                        			<input type="text" class="form-control" name="libelle" id="libelle" required maxlength="100">  
                        			<small id="libelleErreur"></small>
                    			</div> 
                    		</div>
                    		                   		
                    		<!-- Montant -->
                    		<div class="col-sm-6">
                    			<label class="col-sm-6 control-label" for="montat">Montant : <span class="requis"> *</span></label>  
                    			<div class="col-md-4">
                        			<input type="number" class="form-control" step=0.01 min=0 name="montant" id="montant" required maxlength="20">  
                        			<small id="montantErreur"></small>
                    			</div>
                    		</div>                   		
                    	</div>
                    </div>
                    
                    <!-- Description -->
                    <div class="form-group my-3">
                    	<label class="col-sm-6 control-label" for="description">Description : <span class="requis"> *</span></label>  
                    	<div class="col-md-6">
                        	<textarea class="form-control" id="description" name="description" id="description" required rows="3"></textarea>
                        	<small id="descriptionErreur"></small>
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
    
    <!-- Partie JS -->
	<script type="text/javascript">
		let btnFormulaire = document.querySelector("#btnFormulaire");
		let formulaire = document.querySelector("#formulaire");
		let btnCacherForm = document.querySelector("#btnCacherForm");
		let libelle = document.querySelector("#libelle");
		let description = document.querySelector("#description");
		let montant = document.querySelector("#montant");
		let erreur = document.querySelector(".erreur");
		let modal = document.querySelector("#modal");
		let modalText = document.querySelector("#modalText");
		let libelleErreur = document.querySelector("#libelleErreur");
		let montantErreur = document.querySelector("#montantErreur");
		let descriptionErreur = document.querySelector("#descriptionErreur");
		let tableInfraction = document.querySelector("#tableInfraction");
		let btnFermer = document.querySelector("#btnFermer");
		let btnTri = document.querySelector("#btnTri");
		let trierTypeInfraction = document.querySelector("#trierTypeInfraction");
		
		// Elements cachés de base
		formulaire.hidden = true;
		btnCacherForm.hidden = true;
		
		// Fonction pour activer tri
		var activerTri = () => {
			let tbody = document.querySelector("tbody");
			let tr = tbody.querySelectorAll("tr");
			// Récupèrer valeur choisie
			var val = trierTypeInfraction.value;
			for (i = 0; i < tr.length; i++){
				// Tout
				if(val == 1){
					tr[i].style.display = "table-row";
				}
					
				// Actif
				else if(val == 2){
					if(tr[i].querySelectorAll("td")[3].innerHTML == "Non"){
						tr[i].style.display = "table-row";
					}
					
					else{
						tr[i].style.display = "none";
					}
				}
					
				// Non actif
				else{
					if(tr[i].querySelectorAll("td")[3].innerHTML !== "Non"){
						tr[i].style.display = "table-row";
					}	
					
					else{
						tr[i].style.display = "none";
					}
				}
			}
		}
		
		activerTri();
		
		// Refresh automatique lors de l'utilisation bouton back navigation
		window.addEventListener( "pageshow", function ( event ) {
  			var historyTraversal = event.persisted || 
                         ( typeof window.performance != "undefined" && 
                              window.performance.navigation.type === 2 );
  			if ( historyTraversal ) {
    			window.location.reload();
  			}
		});
		
		// Fonction trier tableau par actif ou non
		btnTri.addEventListener('click', () => {			
			activerTri();
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
						// Si enregistrement réussi
						if((xhr.responseText) === "0"){
							// Effacement du formulaire
							libelle.value = "";
							description.value = "";
							montant.value = "";
							
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
		                 	
		                 	// Refresh du tableau 
		                    $('#tableInfraction').load('ActualiserInfraction').fadeIn("slow");
						}
						
						// Formulaire vide
						else if((xhr.responseText) === "1"){
							erreur.innerHTML ="Veuillez remplir le formulaire !";
						}
						
						// Montant non valide
						else if((xhr.responseText) === "2"){
							erreur.innerHTML ="Veuillez inscrire un montant valide !";
						}
						
						// Enregistrement échoué
						else if((xhr.responseText) === "3"){
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
				xhr.open("POST", "AjouterInfraction", true);
				xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
				xhr.send(param);
			}
		});			
	</script>
		
	<div class="my-3"></div>
	
	<!-- Footer - informations -->
	<%@include file="../Layout/footer.jsp" %>