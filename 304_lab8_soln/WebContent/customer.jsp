<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
</head>
<body>
<%@ include file="header.jsp"%>
<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>


<%

// Print Customer information
String sql = "select customerId, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password FROM Customer WHERE userid = ?";

NumberFormat currFormat = NumberFormat.getCurrencyInstance();

try 
{	

	
	
	
	getConnection();
	PreparedStatement pstmt = con.prepareStatement(sql, ResultSet.CONCUR_UPDATABLE);
	pstmt.setString(1, userName);	
	ResultSet rst = pstmt.executeQuery();
	
	
	if (rst.next())
	{
		out.println("<table class=\"table\" border=\"1\">");
		out.println("<tr><th>Id</th><td>"+rst.getString(1)+"</td></tr>");	
		out.println("<tr><th>First Name</th><td>"+rst.getString(2)+"<a href=\"updateCustomer.jsp?col="+rst.getString(2)+"\"> update</a></td></tr>");
		out.println("<tr><th>Last Name</th><td>"+rst.getString(3)+"<a href=\"updateCustomer.jsp?col="+rst.getString(3)+"\">update</a></td></tr>");
		out.println("<tr><th>Email</th><td>"+rst.getString(4)+"<a href=\"updateCustomer.jsp?col="+rst.getString(4)+"\"> update</a></td></tr>");
		out.println("<tr><th>Phone</th><td>"+rst.getString(5)+"<a href=\"updateCustomer.jsp?col="+rst.getString(5)+"\"> update</a></td></tr>");
		out.println("<tr><th>Address</th><td>"+rst.getString(6)+"<a href=\"updateCustomer.jsp?col="+rst.getString(6)+"\"> update</a></td></tr>");
		out.println("<tr><th>City</th><td>"+rst.getString(7)+"<a href=\"updateCustomer.jsp?col="+rst.getString(7)+"\">update</a></td></tr>");
		out.println("<tr><th>State</th><td>"+rst.getString(8)+"<a href=\"updateCustomer.jsp?col="+rst.getString(8)+"\">update</a></td></tr>");
		out.println("<tr><th>Postal Code</th><td>"+rst.getString(9)+"<a href=\"updateCustomer.jsp?col="+rst.getString(9)+"\"> update</a></td></tr>");
		out.println("<tr><th>Country</th><td>"+rst.getString(10)+"<a href=\"updateCustomer.jsp?col="+rst.getString(10)+"\"> update</a></td></tr>");
		out.println("<tr><th>User id</th><td>"+rst.getString(11)+"<a href=\"updateCustomer.jsp?col="+rst.getString(11)+"\">update</a></td></tr>");		
		out.println("</table>");
		
	}
	/*
	"<h3><a href=\"addcart.jsp?id="+prodId+ "&name=" + rst.getString(2)
								+ "&price=" + rst.getDouble(3)+"\">Add to Cart</a></h3>"
	out.println("<td><a href=\"updateCustomer.jsp?id="+rst.getString(1)+"\"</a></td></tr>");
	<a href=\"updateCustomer.jsp\">update</a>
	out.println("<table class=\"table\" border=\"1\">");
		out.println("<tr><th>Id</th><td>"+rst.getString(1)+"</td></tr>");	
		out.println("<tr><th>First Name</th><td>"+rst.getString(2)+"</td></tr>");
		out.println("<tr><th>Last Name</th><td>"+rst.getString(3)+"</td></tr>");
		out.println("<tr><th>Email</th><td>"+rst.getString(4)+"</td></tr>");
		out.println("<tr><th>Phone</th><td>"+rst.getString(5)+"</td></tr>");
		out.println("<tr><th>Address</th><td>"+rst.getString(6)+"</td></tr>");
		out.println("<tr><th>City</th><td>"+rst.getString(7)+"</td></tr>");
		out.println("<tr><th>State</th><td>"+rst.getString(8)+"</td></tr>");
		out.println("<tr><th>Postal Code</th><td>"+rst.getString(9)+"</td></tr>");
		out.println("<tr><th>Country</th><td>"+rst.getString(10)+"</td></tr>");
		out.println("<tr><th>User id</th><td>"+rst.getString(11)+"</td></tr>");		
		out.println("</table>");
		
	out.println("<td><a href=\"product.jsp?id="+id+"\"<font color=\"" + color + "\">" + rst.getString(2) + "</font></td>"
	+ "<td><font color=\"" + color + "\">" + itemCategory + "</font></td>"
	+ "<td><font color=\"" + color + "\">" + currFormat.format(rst.getDouble(3))
	+ "</font></td></tr>");
	*/
}
catch (SQLException ex) 
{ 	out.println(ex); 
}
finally
{	
	closeConnection();	
}
%>

</body>
</html>

