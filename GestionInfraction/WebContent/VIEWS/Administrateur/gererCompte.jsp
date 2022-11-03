<%@ page import="Model.BEANS.C_Utilisateur" %>
<%@ page import="java.util.List"%>
<!-- Header - informations -->
<%@include file="../Layout/header.jsp" %>
	<!-- Liste utilisateur servlet -->
	<% 
		List<C_Utilisateur> liste = (List)request.getAttribute("liste");
	%>
	
	<header>
		<!-- Titre -->
        <h1>Gestion utilisateur(s)</h1>
        <div class="lineTitre"></div>
	</header>
	
	<!-- Affichage pop-up -->
	<%@include file="../Layout/modal.jsp" %>
	
	<!-- Options tri utilisateur -->
	<div class="container">
		<div class="row">
			<p>Trier par type utilisateur :</p>
			<!-- Choix type utilisateur -->
			<div class="col-sm-6">
				<select name="trierTypeUtilisateur" id="trierTypeUtilisateur">
					<option value="Tout">Tout</option>
        			<option value="Policier">Policier</option>
        			<option value="Brigadier chef">Brigadier chef</option>
        			<option value="Percepteur">Percepteur</option>
        			<option value="Administrateur">Administrateur</option>
    			</select>    	
			</div>
		
			<div class="form-group my-5">
            	<button id="btnTri" name="btnTri" class="btn btn-primary">Trier</button>
           	</div>       		
		</div>
	</div>                                  	
    	
	<!-- Tableau Utilisateurs -->
	<div class="container">
		<table class="table" id="tableUtilisateur">
			<thead> 
				<tr> 
					<th style="text-align:center !important">Nom</th>
					<th style="text-align:center !important">Prenom</th>
					<th style="text-align:center !important">Matricule</th>
					<th style="text-align:center !important">Email</th>
					<th style="text-align:center !important">Role</th>
					<th style="text-align:center !important">Brigade</th>
					<th style="text-align:center !important">Actif</th>						
					<th style="text-align:center !important" class="col-md-1">Modifier</th>
					<th style="text-align:center !important" class="col-md-1">Statut</th>											
				</tr>
			</thead>
			<tbody>
				<% for(C_Utilisateur u : liste){%>
					<tr> 
						<td style="text-align:center !important"><%=u.getNom()%></td>
	 					<td style="text-align:center !important"><%=u.getPrenom()%></td>
	 					<td style="text-align:center !important"><%=u.getMatricule()%></td>
	         			<td style="text-align:center !important"><%=u.getEmail()%></td>
	         			<td style="text-align:center !important"><%=u.getNomRole()%></td>
	         			<td style="text-align:center !important"><%=u.getNomBrigade()%></td> 	
	         			<td style="text-align:center !important"><%=u.getNomActif()%></td>         				  	         				
	         			<td><div class="btn"><a href="${pageContext.request.contextPath}/ModifierUtilisateur?id=<%=u.getId()%>">Modifier</a></div></td>
	         			<%
	         				if(u.getActif() == 1){%>
	         					<td style="text-align:center !important"><div class="btn"><a href="${pageContext.request.contextPath}/DesactiverUtilisateur?id=<%=u.getId()%>">Désactiver</a></div></td>
	         				<%}
	         				else{%>
	         					<td style="text-align:center !important"><div class="btn"><a href="${pageContext.request.contextPath}/ActiverUtilisateur?id=<%=u.getId()%>">Activer</a></div></td>
	         			<%}%>
					</tr>					
				<%}%> 
			</tbody>
		</table>
	</div>	
	
	<!-- Ajouter un utilisateur -->
	<div class="text-center">
		<p>Vous pouvez ajouter un utilisateur via cette option :</p>
	</div>
	
	<div class="text-center my-3">
      <button type="button" class="btn btn-primary" id="btnFormulaire">Formulaire</button>
    </div>
    
    <!-- Formulaire utilisateur -->
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
                    			<div class="col-md-8">
                        			<input type="text" class="form-control" name="nom" id="nom" required maxlength="100">  
                        			<small id="nomErreur"></small>
                    			</div> 
                    		</div>
                    		                   		
                    		<!-- Prenom -->
                    		<div class="col-sm-6">
                    			<label class="col-sm-6 control-label" for="prenom">Prenom : <span class="requis"> *</span></label>  
                    			<div class="col-md-8">
                        			<input type="text" class="form-control" name="prenom" id="prenom" required maxlength="100">
                        			<small id="prenomErreur"></small>  
                    			</div>
                    		</div>                   		
                    	</div>
                    </div>
                    
                    <div class="form-group my-3">
						<div class="row justify-content-between">
							<!-- Mot de passe -->
							<div class="col-sm-6">
								<label class="col-sm-10 control-label" for="mdp">Mot de passe : <span class="requis"> *</span></label>  
                    			<div class="col-md-8">
                        			<input type="password" class="form-control" name="mdp" id="mdp" required placeholder="maj - min + chiffre" maxlength="100">
                        			<small id="mdpErreur"></small>  
                    			</div>
							</div>
							
							<!-- Confirmer mot de passe -->
							<div class="col-sm-6">
								<label class="col-sm-12 control-label" for="mdpConfirm">Confirmer mot de passe : <span class="requis"> *</span></label>  
                    			<div class="col-md-8">
                        			<input type="password" class="form-control" name="mdpConfirm" id="mdpConfirm" required maxlength="100">  
                    			</div> 
							</div>
						</div>
					</div>               
					
					<!-- Email -->
					<div class="form-group my-3">																	
						<label class="col-sm-6 control-label" for="email">Email : <span class="requis"> *</span></label>  
                    	<div class="col-md-5">
                        	<input type="email" class="form-control" name="email" id="email" required placeholder="echec@outlook.com" maxlength="50"> 
                        	<small id="emailErreur"></small>
                    	</div>												
					</div>		
			
					<div class="form-group my-3">
						<div class="row justify-content-between">
							<!-- Choix role -->
							<div class="col-sm-6">
								<label class="col-sm-12 control-label" for="typeUtilisateur">Type de compte :</label>
								<select name="typeUtilisateur" id="typeUtilisateur">
        							<option value=1>Policier</option>
        							<option value=2>Brigadier chef</option>
        							<option value=3>Percepteur</option>
    							</select> 
							</div>
							
							<!-- Choix brigade(seulement si policier choisi) -->
							<div class="col-sm-6" id="selectBrigadier">
								<label class="col-sm-12 control-label" for="typeBrigadier">Son supérieur(si policier choisi) :</label>
								<select name="typeBrigadier" id="typeBrigadier">
									<% for(C_Utilisateur u : liste){%>
										<%if(u.getRole() == 2 && u.getActif() == 1){%>
											<option value=<%=u.getMatricule()%>><%=u.getMatricule()%></option>
										<%}%>                      				
                        			<%}%>
        							<option value=-1>Aucun</option>
    							</select>
							</div>
						</div>
					</div>
					
           			<!-- Submit -->
                    <div class="form-group text-center my-3">
                        <button type="submit" id="btnSubmit" name="submit" class="btn btn-primary">Ajouter</button>
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
		let nom = document.querySelector("#nom");
		let prenom = document.querySelector("#prenom");
		let mdp = document.querySelector("#mdp");
		let mdpConfirm = document.querySelector("#mdpConfirm");
		let email = document.querySelector("#email");
		let typeUtilisateur = document.querySelector("#typeUtilisateur");
		let typeBrigadier = document.querySelector("#typeBrigadier");
		let erreur = document.querySelector(".erreur");
		let modal = document.querySelector("#modal");
		let modalText = document.querySelector("#modalText");
		let nomErreur = document.querySelector("#nomErreur");
		let prenomErreur = document.querySelector("#prenomErreur");
		let mdpErreur = document.querySelector("#mdpErreur");
		let emailErreur = document.querySelector("#emailErreur");
		let btnTri = document.querySelector("#btnTri");
		let trierTypeUtilisateur = document.querySelector("#trierTypeUtilisateur");
		let tableUtilisateur = document.querySelector("#tableUtilisateur");
		let btnFermer = document.querySelector("#btnFermer");
		let selectBrigadier = document.querySelector("#selectBrigadier");
			
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
				
		// Fonction trier tableau par type utilisateur choisi
		btnTri.addEventListener('click', () => {
			let tbody = document.querySelector("tbody");
			let tr = tbody.querySelectorAll("tr");
			// Récupèrer type utilisateur choisi
			var type = trierTypeUtilisateur.value;
			var role;
				
			for (i = 0; i < tr.length; i++){
				// Récupèration des rôles
				role = tr[i].querySelectorAll("td")[4].innerHTML;
				// Si role différent du type choisi ==> Cacher
				if(role != type){
					tr[i].style.display = "none";
				}
					
				// Sinon ==> Afficher
				else{
					tr[i].style.display = "table-row";
				}
					
				// Par défaut
				if(type === "Tout"){
					tr[i].style.display = "table-row";
				}
			}
		});
		
		// Fonction pour activer/desactiver le choix du brigadier en fonction du type d'utilisateur choisi
		typeUtilisateur.addEventListener('change', () => {
		    if(typeUtilisateur.value == 1){ // Si policier
		    	selectBrigadier.style.display = "block";
		    }
		    
		    else{
		    	selectBrigadier.style.display = "none";
		    }
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
			var champNom, champPrenom, champMdp, champEmail;
			
			// Nom
			if(checkIsEmpty(nom.value)){
				nom.style.border = "2px dashed red";
				nomErreur.innerHTML ="Valeur incorrecte !";
				champNom = 1;
			}
			
			else{
				nom.style.border = "1px solid #ced4da";
				nomErreur.innerHTML ="";
				champNom = 0;
			}
			
			// Prenom
			if(checkIsEmpty(prenom.value)){
				prenom.style.border = "2px dashed red";
				prenomErreur.innerHTML ="Valeur incorrecte !";
				champPrenom = 1;
			}
			
			else{
				prenom.style.border = "1px solid #ced4da";
				prenomErreur.innerHTML ="";
				champPrenom = 0;
			}
			
			// Mot de passe
			if(checkIsEmpty(mdp.value) || checkPassword(mdp.value) == false){
				mdp.style.border = "2px dashed red";
				mdpErreur.innerHTML ="Doit contenir : majuscule - minuscule + chiffre !";
				champMdp = 1;
			}
			
			else{
				mdp.style.border = "1px solid #ced4da";
				mdpErreur.innerHTML ="";
				champMdp = 0;
				
				// Confirmation mot de passe
				if(checkIsEmpty(mdpConfirm.value) || mdp.value != mdpConfirm.value){
					mdp.style.border = "2px dashed red";
					mdpErreur.innerHTML ="Mot de passe différent !";
					mdpConfirm.style.border = "2px dashed red";
					champMdp = 1;
				}
				
				else{
					mdp.style.border = "1px solid #ced4da";
					mdpErreur.innerHTML ="";
					mdpConfirm.style.border = "1px solid #ced4da";
					champMdp = 0;
				}
			}
			
			// Email
			if(checkIsEmpty(email.value) || checkEmail(email.value) == false){
				email.style.border = "2px dashed red";
				emailErreur.innerHTML ="Email incorrecte !";
				champEmail = 1;
			}	
			
			else{
				email.style.border = "1px solid #ced4da";
				emailErreur.innerHTML ="";
				champEmail = 0;
			}
			
			// Vérification si chef choisi
			if(typeUtilisateur.value == 1 && typeBrigadier.value == -1){
				erreur.innerHTML ="";
				modalText.innerHTML = "Vous devez choisir un chef !";
				modal.classList.add("show");
				modal.style.display = "block";
                
                setTimeout(() => {
                	modal.classList.add("hidden");
					modal.style.display = "none";
                }, 3000);
			}
			
			else{
				// Call ajax si aucun problème
				if(champNom == 0 && champPrenom == 0 && champMdp == 0 && champEmail == 0){
					var param = "nom=" + escape(nom.value);
					param += "&prenom=" + escape(prenom.value);
					param += "&mdp=" + escape(mdp.value);
					param += "&mdpConfirm=" + escape(mdpConfirm.value);
					param += "&email=" + escape(email.value);
					param += "&typeUtilisateur=" + escape(typeUtilisateur.value);
					param += "&typeBrigadier=" + escape(typeBrigadier.value);
					
					var xhr = new XMLHttpRequest();
					xhr.onreadystatechange = () => {
						if(xhr.readyState === 4 && xhr.status === 200) {
							// Si enregistrement réussi
							if((xhr.responseText) === "0"){
								// Effacement du formulaire
								nom.value = "";
								prenom.value = "";
								mdp.value ="";
								mdpConfirm.value ="";
								email.value = "";
								
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
			                 	
			                 	
			                 	// JQUERY pour refresh ==> solution plus simple que JS classique
			                    $('#tableUtilisateur').load('ActualiserUtilisateur').fadeIn("slow");		             
							}
							
							// Formulaire vide
							else if((xhr.responseText) === "1"){
								erreur.innerHTML ="Veuillez remplir le formulaire !";
							}
							
							// Validité des champs							
							else if((xhr.responseText) === "mdp"){
								erreur.innerHTML ="Veuillez entrer un mot de passe correct !";
							}
							
							else if((xhr.responseText) === "email"){
								erreur.innerHTML ="Veuillez entrer un email correct !";
							}
							
							// Vérification des mots de passe
							else if((xhr.responseText) === "2"){
								erreur.innerHTML ="Attention, mot de passe différent !";
							}
							
							// Vérification email
							else if((xhr.responseText) === "3"){
								erreur.innerHTML ="Cet email est déjà présent !";
							}
							
							// Enregistrement échoué
							else if((xhr.responseText) === "4"){
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
					xhr.open("POST", "AjouterUtilisateur", true);
					xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
					xhr.send(param);
				}
			}						
		});		
	</script>
	
	<!-- Footer - informations -->
	<%@include file="../Layout/footer.jsp" %>