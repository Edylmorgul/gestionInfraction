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
						<th style="text-align:center !important">Date</th>
						<th style="text-align:center !important">Lieu</th>
						<th style="text-align:center !important">Vehicule</th>
						<th style="text-align:center !important">Immatriculation</th>						
						<th style="text-align:center !important">Montant</th>
						<th style="text-align:center !important">Détails</th>
						<th style="text-align:center !important">Envoyer</th>				
					</tr>
				</thead>
				<tbody>
					<% for(C_Amende a : liste){%>
						<!-- N'afficher que les amendes validées et pas encore envoyées -->
						<%if(a.getValide() == 1 && a.getEnvoye() == 0) {%>
							<tr> 
								<td style="text-align:center !important"><%=a.getInstant()%></td>
								<td style="text-align:center !important"><%=a.getVille()%></td>
								<td style="text-align:center !important"><%=a.getTypeVehi().getLibelle()%></td>
	 							<%if(a.getImm() == null){%><td style="text-align:center !important">Non renseigné</td><%}else{%><td style="text-align:center !important"><%=a.getImm()%></td><%}%>
	         					<td style="text-align:center !important"><%=String.format("%.2f",a.getMontant())+Global.euro%></td>
	         					<td style="text-align:center !important"><div class="btn"><a href="${pageContext.request.contextPath}/DetaillerAmende?id=<%=a.getId()%>">Détails</a></div></td>
	         					<td style="text-align:center !important"><div class="btn"><a href="${pageContext.request.contextPath}/EnvoyerCourrier?id=<%=a.getId()%>">Envoyer</a></div></td>         				  	         					         			         				
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