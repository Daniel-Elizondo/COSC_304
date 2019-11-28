<!DOCTYPE html>
<html>
<head>
        <title>Ray's Grocery Main Page</title>
</head>
<body>
<h1 align="center"><font size = '5' face = 'helvetica'>Welcome to Hank's Propane and Propane Accessories</font></h1>
<h2 align = "center"><img alt="" src="img/propane01.jpg"></h2>
<h2 align="center"><font size = '3' face = 'helvetica'><a href="login.jsp">Login</a></font></h2>

<h2 align="center"><font size = '3' face = 'helvetica'><a href="listprod.jsp">Begin Shopping</a></font></h2>

<h2 align="center"><font size = '3' face = 'helvetica'><a href="listorder.jsp">List All Orders</a></font></h2>

<h2 align="center"><font size = '3' face = 'helvetica'><a href="customer.jsp">Customer Info</a></font></h2>

<h2 align="center"><font size = '3' face = 'helvetica'><a href="admin.jsp">Administrators</a></font></h2>

<h2 align="center"><font size = '3' face = 'helvetica'><a href="logout.jsp">Log out</a></font></h2>

<%
// TODO: Display user name that is logged in (or nothing if not logged in)	
String customerId = (String)session.getAttribute("customerId");
out.print(customerId);
%>
</body>
</head>


