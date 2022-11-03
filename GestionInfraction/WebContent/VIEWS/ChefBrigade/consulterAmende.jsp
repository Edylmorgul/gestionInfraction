<%@ page import="Model.BEANS.C_Amende" %>
<%@ page import="Model.BEANS.Global" %>
<%@ page import="java.util.List"%>
<!-- Header - informations -->
<%@include file="../Layout/header.jsp" %>
	<!-- Liste amende servlet -->
	<% 
		List<C_Amende> liste = (List)request.getAttribute("liste");
	%>
	
	<header>
		<!-- Titre -->
        <h1>Consultation des amendes</h1>
        <div class="lineTitre"></div>
	</header>
	
	<!-- Test si liste vide -->
	<% if(liste == null || liste.isEmpty()) {%>
		<h2> Aucune amende n'est présente sur le site ! </h2>
	<%}
	
	else{%>    	
		<!-- Tableau amende -->
		<div class="container">
			<table class="table col-md-6">
				<thead> 
					<tr> 
						<th style="text-align:center !important"></th>
						<th style="text-align:center !important">Policier</th>
						<th style="text-align:center !important"></th>
						<th style="text-align:center !important"></th>
						<th style="text-align:center !important">Date</th>
						<th style="text-align:center !important">Lieu</th>
						<th style="text-align:center !important">Vehicule</th>
						<th style="text-align:center !important">Immatriculation</th>						
						<th style="text-align:center !important">Montant</th>
						<th style="text-align:center !important">Détails</th>
						<th style="text-align:center !important">Statut</th>	
						<th style="text-align:center !important"></th>				
					</tr>
				</thead>
				<tbody>
					<% for(C_Amende a : liste){%>
						<%boolean erreur = false; %>
						<!-- N'afficher que les amendes pas encore validées(les autres seronts supprimées en cas d'invalidation) -->
						<%if(a.getValide() != 1) {%>
							<!-- Vérifier si informations essentiels présentes pour envoi de courrier -->					
							<tr> 
								<%if(a.getContrevenant().getRue() == null || a.getContrevenant().getNumero() == 0 || a.getContrevenant().getPays() == null || a.getContrevenant().getCodePostal() == 0){%>
									<%erreur = true;%>
									<td><span class='fas fa-exclamation-triangle' title="Informations contrevenant insuffisantes" style='font-size:40px;color:red' id="alertMessage"></span></td>
								<%}
								else{%>
									<td></td>
								<%}%>
								<td style="text-align:center !important"><%=a.getPolicier().getNom()%></td>
								<td style="text-align:center !important"><%=a.getPolicier().getPrenom()%></td>
								<td style="text-align:center !important"><%=a.getPolicier().getMatricule()%></td>
								<td style="text-align:center !important"><%=a.getInstant()%></td>
								<td style="text-align:center !important"><%=a.getVille()%></td>
								<td style="text-align:center !important"><%=a.getTypeVehi().getLibelle()%></td>
	 							<%if(a.getImm() == null){%><td style="text-align:center !important">Non renseigné</td><%}else{%><td style="text-align:center !important"><%=a.getImm()%></td><%}%>
	         					<td style="text-align:center !important"><%=String.format("%.2f",a.getMontant())+Global.euro%></td>
	         					<td style="text-align:center !important"><div class="btn"><a href="${pageContext.request.contextPath}/DetaillerAmende?id=<%=a.getId()%>">Détails</a></div></td>
	         					<%if(erreur){%>
	         						<td style="text-align:center !important"><div class="btn"><a href="${pageContext.request.contextPath}/ModifierAmende?id=<%=a.getId()%>">Ajouter</a></div></td>
	         					<%}
	         					else{%>
	         						<td style="text-align:center !important"><div class="btn"><a href="${pageContext.request.contextPath}/ValiderAmende?id=<%=a.getId()%>">Valider</a></div></td>
	         					<%}%>	         					
	         					<td style="text-align:center !important"><div class="btn"><a href="${pageContext.request.contextPath}/InvaliderAmende?id=<%=a.getId()%>">Invalider</a></div></td>	         				  	         					         			         				
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
	
	<!-- Footer - informations -->
	<%@include file="../Layout/footer.jsp" %>