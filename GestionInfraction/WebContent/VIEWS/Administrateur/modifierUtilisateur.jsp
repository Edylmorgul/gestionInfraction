<%@ page import="Model.BEANS.C_Utilisateur" %>
<%@ page import="java.util.List"%>
<!-- Header - informations -->
<%@include file="../Layout/header.jsp" %>

	<%
		List<C_Utilisateur> liste = (List)request.getAttribute("liste");
		C_Utilisateur u = (C_Utilisateur)request.getAttribute("utilisateur");
	%>

	<header>
		<!-- Titre -->
        <h1>Modification utilisateur</h1>
        <div class="lineTitre"></div>
	</header>
	
	<!-- Affichage pop-up -->
	<%@include file="../Layout/modal.jsp" %>
	
	<div class="text-center">
		<p>Vous pouvez ici modifier les informations de l'utilisateur !</p>
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
                        			<input type="text" class="form-control" name="nom" id="nom" value=<%=u.getNom()%> required maxlength="100"> 
                        			<small id="nomErreur"></small> 
                    			</div> 
                    		</div>
                    		                   		
                    		<!-- Prenom -->
                    		<div class="col-sm-6">
                    			<label class="col-sm-6 control-label" for="prenom">Prenom : <span class="requis"> *</span></label>  
                    			<div class="col-md-8">
                        			<input type="text" class="form-control" name="prenom" id="prenom" value=<%=u.getPrenom()%> required maxlength="100"> 
                        			<small id="prenomErreur"></small> 
                    			</div>
                    		</div>                   		
                    	</div>
                    </div>
					
					<!-- Mot de passe -->
					<div class="form-group my-3">																					
						<div class="col-sm-6">
							<label class="col-sm-6 control-label" for="mdp">Mot de passe : <span class="requis"> *</span></label>  
                    		<div class="col-md-8">
                        		<input type="password" class="form-control" name="mdp" id="mdp" required maxlength="100"> 
                        		<small id="mdpErreur"></small> 
                    		</div> 
						</div>
					</div>
			
					<div class="form-group my-3">
						<div class="row justify-content-between">
							<!-- Choix role -->
							<div class="col-sm-6">
								<label class="col-sm-12 control-label" for="typeUtilisateur">Type de compte :</label>
								<p>Rôle actuel : <%=u.getNomRole()%></p>
								<select name="typeUtilisateur" id="typeUtilisateur">
        							<option value=1>Policier</option>
        							<option value=2>Brigadier chef</option>
        							<option value=3>Percepteur</option>
    							</select> 
							</div>
							
							<!-- Choix brigade(seulement si policier choisi) -->
							<div class="col-sm-6" id="selectBrigadier">
								<label class="col-sm-12 control-label" for="typeBrigadier">Son supérieur(si policier choisi) :</label>
								<p>Chef actuel : <%=u.getNomBrigade()%></p>
								<select name="typeBrigadier" id="typeBrigadier">
        							<% for(C_Utilisateur uti : liste){%>
										<%if(uti.getRole() == 2 && uti.getActif() == 1 && uti.getId() != u.getId()){%>
											<option value=<%=uti.getMatricule()%>><%=uti.getMatricule()%></option>
										<%}%>                      				
                        			<%}%>
        							<option value=-1>Aucun</option>
    							</select>
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
		let mdp = document.querySelector("#mdp");
		let typeUtilisateur = document.querySelector("#typeUtilisateur");
		let typeBrigadier = document.querySelector("#typeBrigadier");
		let erreur = document.querySelector(".erreur");
		let modal = document.querySelector("#modal");
		let modalText = document.querySelector("#modalText");
		let nomErreur = document.querySelector("#nomErreur");
		let prenomErreur = document.querySelector("#prenomErreur");
		let mdpErreur = document.querySelector("#mdpErreur");
		let emailErreur = document.querySelector("#emailErreur");
		let selectBrigadier = document.querySelector("#selectBrigadier");
		let btnFermer = document.querySelector("#btnFermer");
		
		// Fonction pour fermer modal manuellement
		btnFermer.addEventListener('click', () => {
			modal.classList.add("hidden");
			modal.style.display = "none";
		});
		
		// Fonction pour activer/desactiver le choix du brigadier en fonction du type d'utilisateur choisi
		typeUtilisateur.addEventListener('change', () => {
		    //alert(typeUtilisateur.value);
		    if(typeUtilisateur.value == 1){ // Si policier
		    	selectBrigadier.style.display = "block";
		    }
		    
		    else{
		    	selectBrigadier.style.display = "none";
		    }
		}); 
		 	// Fonction pour submit formulaire
			formulaire.addEventListener('submit', (e) =>{
				e.preventDefault();
				modalText.value = "";
				 
				// Vérification des champs
				var champNom, champPrenom, champMdp;
				
				// Nom
				if(checkIsEmpty(nom.value) || checkName(nom.value) == false){
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
				if(checkIsEmpty(prenom.value) || checkName(prenom.value) == false){
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
					if(champNom == 0 && champPrenom == 0 && champMdp == 0){
						var param = "nom=" + escape(nom.value);
						param += "&prenom=" + escape(prenom.value);
						param += "&mdp=" + escape(mdp.value);
						param += "&typeUtilisateur=" + escape(typeUtilisateur.value);
						param += "&typeBrigadier=" + escape(typeBrigadier.value);
						
						var xhr = new XMLHttpRequest();
						xhr.onreadystatechange = () => {
							if(xhr.readyState === 4 && xhr.status === 200) {
								// Si modification réussie
								if((xhr.responseText) === "0"){								
				                 	// Redirection vers liste utilisateur
				                    document.location.href = '${pageContext.request.contextPath}/ListerUtilisateur';
								}
								
								// Formulaire vide
								else if((xhr.responseText) === "1"){
									erreur.innerHTML ="Veuillez remplir le formulaire !";
								}
								
								// Validité des champs
								else if((xhr.responseText) === "nom"){
									erreur.innerHTML ="Veuillez entrer un nom correct !";
								}
								
								else if((xhr.responseText) === "prenom"){
									erreur.innerHTML ="Veuillez entrer un prenom correct !";						
								}
								
								else if((xhr.responseText) === "mdp"){
									erreur.innerHTML ="Veuillez entrer un mot de passe correct !";
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
					xhr.open("POST", "ModifierUtilisateur", true);
					xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
					xhr.send(param);
				}
			}			
		});			
	</script>
	
	<!-- Footer - informations -->
	<%@include file="../Layout/footer.jsp" %>