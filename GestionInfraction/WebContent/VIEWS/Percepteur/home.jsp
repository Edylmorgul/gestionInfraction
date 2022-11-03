<%@ page import="Model.BEANS.C_Percepteur" %>
<!-- Header - informations -->
<%@include file="../Layout/header.jsp" %>
<%
    C_Percepteur percept = null;
    if (session.getAttribute("percepteur") != null)
        percept = (C_Percepteur) session.getAttribute("percepteur");
        
    else 
        response.sendRedirect("../Home/index.jsp");
%>
	<header>	
		<!-- Navbar -->
		<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
  			<a class="navbar-brand mx-3" href="#">Gestion d'infraction</a>
  			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
    			<span class="navbar-toggler-icon"></span>
  			</button>
  			
  			<!-- Option navbar -->
  			<div class="collapse navbar-collapse" id="navbarNav">
    			<ul class="navbar-nav">			     			
      				<li class="nav-item">
        				<a class="nav-link" href="${pageContext.request.contextPath}/ListerAmendeValide"><i class="fas fa-file-alt mx-2"></i>Consulter amende</a>
      				</li>
    			</ul>
  			</div>
  			
  			<div class="navbar-form navbar-right mx-5">
  				<button type="button" onclick="window.location.href='${pageContext.request.contextPath}/Deconnexion'" class="btn btn-primary">Déconnexion</button>
  			</div>
		</nav>
		
		<!-- Titre -->
        <h1>Bienvenue : <%=percept.getPrenom().substring(0, 1)%>. <%=percept.getNom() %></h1>
        <div class="lineTitre"></div> 
	</header>
	
	<div class="text-center">
		<p>Bienvenue sur votre portail personnel ! Vous pouvez consulter les amendes validées afin d'en prévenir les contrevenants. <br>
		En cas de problème, contactez votre supérieur !</p>
	</div>
	
	<!-- Footer - informations -->
	<%@include file="../Layout/footer.jsp" %>