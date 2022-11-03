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
	
	<!-- Modal modification -->
	<div class="modal fade" id="modal" tabindex="-1" role="dialog" aria-hidden="true">
  		<div class="modal-dialog">
    		<div class="modal-content">
      			<div class="modal-header">
        			<h3 class="modal-title" id="modalLabel"> Modification</h3>
      			</div>
      			<div class="modal-body">
      				<div id="formulaire">
      					<div class="container d-flex justify-content-center">
      						<form class="form-horizontal" method="POST" role="form">
        						<div class="form-group">
        							<label class="col-sm-12 control-label" for="matricule">Nouveau montant : <span class="requis"> *</span></label>  
                    				<div class="col-md-12">
                        				<input type="number" class="form-control" step=0.01 name="montant" id="montant" min=0 required maxlength="20"> 
                        				<small id="montantErreur"></small> 
                    				</div>
        						</div>
        						<!-- Submit -->
                    			<div class="form-group text-center my-3">
                        			<button type="submit" id="btnSubmit" name="submit" class="btn btn-primary">Modifier</button>
                    			</div>   
                    			<p class="text-center" id="modalText"></p>          
        					</form>
      					</div>
      				</div>     			
      			</div>
      			<div class="modal-footer">
        			<button type="button" class="btn btn-block" id="btnFermer" data-dismiss="modal">Fermer</button>
      			</div>
    		</div>
  		</div>
	</div>
	
	<!-- Test si liste vide -->
	<% if(liste == null || liste.isEmpty()) {%>
		<h2> Aucune infraction n'est présente sur le site ! </h2>
	<%}
	
	else{%>    	
		<!-- Tableau infraction -->
		<div class="container">
			<table class="table" id="tableInfraction">
				<thead> 
					<tr> 
						<th style="text-align:center !important">Libellé</th>
						<th style="text-align:center !important">Description</th>
						<th style="text-align:center !important">Montant</th>
						<th style="text-align:center !important">Modifier</th>										
					</tr>
				</thead>
				<tbody>
					<% for(C_TypeInfraction i : liste){%>
						<%if(i.getdFin() == null){%>
							<tr> 
								<td style = "display:none"><%=i.getId()%></td>
								<td style="text-align:center !important"><%=i.getLibelle()%></td>
								<td style="text-align:center !important"><%=i.getDescription()%></td>
								<td style="text-align:center !important"><%=String.format("%.2f",i.getMontant())+Global.euro%></td>
	         					<td style="text-align:center !important"><div class="btn"><a>Modifier</a></div></td>      				  	         					         			         				
							</tr>
						<%}%>					
					<%}%> 
				</tbody>
			</table>
		</div>	
	<%}%>
	
	<div class="text-center my-3">
      <button type="button" class="btn btn-primary" onclick="window.location.href='${pageContext.request.contextPath}/GererRetour'">Retour</button>
    </div>
	
	<!-- Partie JS -->
	<script type="text/javascript">
		let modal = document.querySelector("#modal");
		let modalText = document.querySelector("#modalText");
		let btnFermer = document.querySelector("#btnFermer");
		let formulaire = document.querySelector("#formulaire");
		let tableInfraction = document.querySelector("#tableInfraction");
		let tbody = document.querySelector("tbody");
		let tr = tbody.querySelectorAll("tr");
		let montant = document.querySelector("#montant");
		let btnSubmit = document.querySelector("#btnSubmit");
		
		var btnModifier, idVal, libelleVal, descriptionVal, montantVal;
		
		// Fonction pour afficher modal modification
		for(i = 0; i< tr.length; i++){
			btnModifier = tr[i].querySelectorAll("td")[4].querySelector("a");
			btnModifier.addEventListener('click', (e) => {
				montant.value = 0;
				var trTarget = e.target.parentElement.parentElement.parentElement;
				idVal = trTarget.querySelectorAll("td")[0].innerHTML;
				libelleVal = trTarget.querySelectorAll("td")[1].innerHTML;
				descriptionVal = trTarget.querySelectorAll("td")[2].innerHTML;
				montantVal = trTarget.querySelectorAll("td")[3].innerHTML;
				modal.classList.add("show");
				modal.style.display = "block";
			});
		}
			
		// Fonction pour fermer modal manuellement
		btnFermer.addEventListener('click', () => {
			modal.classList.add("hidden");
			modal.style.display = "none";
		});
		
		// Fonction pour submit formulaire
		formulaire.addEventListener('submit', (e) =>{
			e.preventDefault();
			modalText.value = "";
			btnSubmit.style.display = "block";
			
			// Vérification des champs
			var champMontant;
			
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
			
			if(champMontant == 0){
				var param = "id=" + escape(idVal);
				param += "&montant=" + escape(montant.value);
				
				var xhr = new XMLHttpRequest();
				xhr.onreadystatechange = () => {
					if(xhr.readyState === 4 && xhr.status === 200) {
						// Si modification réussie
						if((xhr.responseText) === "0"){							
							// Affichage du message pop-up
							btnSubmit.style.display = "none";
							modalText.innerHTML ="";
							modalText.innerHTML = "Modification réussie !";
		                    
		                 	// Cacher modal après un certain délai
		                    setTimeout(() => {
		                    	modal.classList.add("hidden");
		    					modal.style.display = "none";
		                    }, 3000);
		                 	
		                 	// Refresh du tableau 
		                    location.reload();
						}
						
						// Formulaire vide
						else if((xhr.responseText) === "1"){
							modalText.innerHTML ="Veuillez remplir le formulaire !";
						}
						
						// Montant non valide
						else if((xhr.responseText) === "2"){
							modalText.innerHTML ="Veuillez inscrire un montant valide !";
						}
						
						// Modification échouée
						else if((xhr.responseText) === "3"){
							modalText.innerHTML ="";
							modalText.innerHTML = "Modification échouée !";
						}
						
						// Si erreurs diverses
						else{
							modalText.innerHTML ="";
							modalText.innerHTML = "Une erreur inconnue est survenue dans le système !";
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