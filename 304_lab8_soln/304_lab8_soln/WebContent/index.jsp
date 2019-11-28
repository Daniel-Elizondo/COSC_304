<!DOCTYPE html>
<html>
<head>
        <title>Strickland Propane</title>
</head>
<body>
<h1 align="center"><font size = '5' face = 'helvetica'>Welcome to Strickland Propane</font></h1>
<h2 align = "center"><img alt="" src="img/propane02.jpg"></h2>
<h2 align="center"><font size = '3' face = 'helvetica'><a href="login.jsp">Login</a></font></h2>

<h2 align="center"><font size = '3' face = 'helvetica'><a href="listprod.jsp">Begin Shopping</a></font></h2>

<h2 align="center"><font size = '3' face = 'helvetica'><a href="listorder.jsp">List All Orders</a></font></h2>

<h2 align="center"><font size = '3' face = 'helvetica'><a href="customer.jsp">Customer Info</a></font></h2>

<h2 align="center"><font size = '3' face = 'helvetica'><a href="admin.jsp">Administrators</a></font></h2>

<h2 align="center"><font size = '3' face = 'helvetica'><a href="logout.jsp">Log out</a></font></h2>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
	if (userName != null)
		out.println("<h3 align=\"center\">Signed in as: "+userName+"</h3>");
%>
</body>
</head>


