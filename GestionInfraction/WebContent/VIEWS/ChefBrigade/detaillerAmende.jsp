<%@ page import="Model.BEANS.C_Amende" %>
<%@ page import="Model.BEANS.Global" %>
<!-- Header - informations -->
<%@include file="../Layout/header.jsp" %>
	<!-- Liste amende servlet -->
	<% 
		C_Amende a = (C_Amende)request.getAttribute("amende");
	%>
	
	<header>
		<!-- Titre -->
        <h1>Détails</h1>
        <div class="lineTitre"></div>
	</header>
	
	<!-- Modal commentaire -->
	<div class="modal fade" id="modal" tabindex="-1" role="dialog" aria-hidden="true">
  		<div class="modal-dialog">
    		<div class="modal-content">
      			<div class="modal-header">
        			<h3 class="modal-title" id="modalLabel"> Commentaire</h3>
      			</div>
      			<div class="modal-body">
      				<p class="text-center" style="word-wrap: break-word" id="modalText"></p>   			
      			</div>
      			<div class="modal-footer">
        			<button type="button" class="btn btn-block" id="btnFermer" data-dismiss="modal">Fermer</button>
      			</div>
    		</div>
  		</div>
	</div>
	 	
	<!-- Tableau détails -->
	<div class="container">
		<table class="table col-md-6">
			<thead> 
				<tr> 
					<th style="text-align:center !important">Contrevenant</th>
					<th style="text-align:center !important"></th>
					<th style="text-align:center !important">Pays</th>
					<th style="text-align:center !important">Ville</th>
					<th style="text-align:center !important">Code postal</th>						
					<th style="text-align:center !important">Rue</th>
					<th style="text-align:center !important">Numero</th>
					<th style="text-align:center !important">Boite</th>	
					<th style="text-align:center !important">Commentaire</th>				
				</tr>
			</thead>
			<tbody>
				<tr> 
					<%if(a.getContrevenant().getNom() == null){%><td style="text-align:center !important">Non renseigné</td><%}else{%><td style="text-align:center !important"><%=a.getContrevenant().getNom()%></td><%}%>
					<%if(a.getContrevenant().getPrenom() == null){%><td style="text-align:center !important">Non renseigné</td><%}else{%><td style="text-align:center !important"><%=a.getContrevenant().getPrenom()%></td><%}%>
					<%if(a.getContrevenant().getPays() == null){%><td style="text-align:center !important">Non renseigné</td><%}else{%><td style="text-align:center !important"><%=a.getContrevenant().getPays()%></td><%}%>
					<%if(a.getContrevenant().getVille() == null){%><td style="text-align:center !important">Non renseigné</td><%}else{%><td style="text-align:center !important"><%=a.getContrevenant().getVille()%></td><%}%>
					<%if(a.getContrevenant().getCodePostal() == 0){%><td style="text-align:center !important">Non renseigné</td><%}else{%><td style="text-align:center !important"><%=a.getContrevenant().getCodePostal()%></td><%}%>
					<%if(a.getContrevenant().getRue() == null){%><td style="text-align:center !important">Non renseigné</td><%}else{%><td style="text-align:center !important"><%=a.getContrevenant().getRue()%></td><%}%>
					<%if(a.getContrevenant().getNumero() == 0){%><td style="text-align:center !important">Non renseigné</td><%}else{%><td style="text-align:center !important"><%=a.getContrevenant().getNumero()%></td><%}%>
	 				<%if(a.getContrevenant().getBoite() == null){%><td style="text-align:center !important">Non renseigné</td><%}else{%><td style="text-align:center !important"><%=a.getContrevenant().getBoite()%></td><%}%>
	         		<td style="text-align:center !important"><div class="btn"><a>Afficher</a></div></td>
	         		<td style="display:none"><%=a.getCommentaire()%></td>       				  	         					         			         				
				</tr>					
			</tbody>
		</table>
	</div>	
	
	<!-- Partie JS -->
	<script type="text/javascript">
		let modal = document.querySelector("#modal");
		let modalText = document.querySelector("#modalText");
		let tbody = document.querySelector("tbody");
		let tr = tbody.querySelectorAll("tr");
		
		var btnCommentaire;
		
		// Fonction pour fermer modal manuellement
		btnFermer.addEventListener('click', () => {
			modal.classList.add("hidden");
			modal.style.display = "none";
		});
		
		// Fonction pour afficher modal modification
		for(i = 0; i< tr.length; i++){
			btnCommentaire = tr[i].querySelectorAll("td")[8].querySelector("a");
			btnCommentaire.addEventListener('click', (e) => {
				var trTarget = e.target.parentElement.parentElement.parentElement;
				modalText.innerHTML = trTarget.querySelectorAll("td")[9].innerHTML;
				console.log(modalText);
				modal.classList.add("show");
				modal.style.display = "block";
			});
		}
				
	</script>
	
	<!-- Footer - informations -->
	<%@include file="../Layout/footer.jsp" %>