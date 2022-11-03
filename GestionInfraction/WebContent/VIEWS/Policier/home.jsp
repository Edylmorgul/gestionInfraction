<%@ page import="Model.BEANS.C_Policier" %>
<!-- Header - informations -->
<%@include file="../Layout/header.jsp" %>
<%
    C_Policier pol = null;
    if (session.getAttribute("policier") != null)
        pol = (C_Policier) session.getAttribute("policier");
        
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
        				<a class="nav-link" href="${pageContext.request.contextPath}/AjouterAmende"><i class="fas fa-car-crash mx-2"></i>Amende</a>
      				</li>
    			</ul>
  			</div>
  			
  			<div class="navbar-form navbar-right mx-5">
  				<button type="button" onclick="window.location.href='${pageContext.request.contextPath}/Deconnexion'" class="btn btn-primary">Déconnexion</button>
  			</div>
		</nav>
		
		<!-- Titre -->
        <h1>Bienvenue : <%=pol.getPrenom().substring(0, 1)%>. <%=pol.getNom() %></h1>
        <div class="lineTitre"></div> 
	</header>
	
	<div class="text-center">
		<p>Bienvenue sur votre portail personnel ! Procéder à la création d'une amende routière. <br>
		Toutes les contraventions devront ensuite être validées par votre supérieur respectif. En cas de problème, contactez-le, le cas échéant !</p>
	</div>
	
	<!-- Footer - informations -->
	<%@include file="../Layout/footer.jsp" %>