<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Ray's Grocery</title>
</head>
<body>

<h1>Search for the products you want to buy:</h1>

<form method="get" action="listprod.jsp">
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>

<%
	// Get product name to search for
	String name = request.getParameter("productName");
	boolean hasParameter = false;
	String sql = "";

	if (name == null)
		name = "";

	if (name.equals("")) 
	{
		out.println("<h2>All Products</h2>");
		sql = "SELECT productId, productName, productPrice FROM Product";
	} 
	else 
	{
		out.println("<h2>Products containing '" + name + "'</h2>");
		hasParameter = true;
		sql = "SELECT productId, productName, productPrice FROM Product WHERE productName LIKE ?";
		name = '%' + name + '%';
	}
	
	String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_wbarlow;";
	String uid = "wbarlow";
	String pw = "81776940";
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();

	try
	{	// Load driver class
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	}
	catch (java.lang.ClassNotFoundException e)
	{
		out.println("ClassNotFoundException: " +e);
	}

	try ( Connection con = DriverManager.getConnection(url, uid, pw);) 
	{			
		PreparedStatement pstmt = con.prepareStatement(sql);
		if (hasParameter)
			pstmt.setString(1, name);

		ResultSet rst = pstmt.executeQuery();
		out.println("<font size =\"3"+"\"face =\"Helvetica"+"\">");
		out.print("<table class =\"table"+"\"border=\"2"+"\"><tbody><tr>"+
		"<th class=\"col-md-1"+"\"></th>"+
		"<th>Product Name</th>" +
		"<th>Price</th></tr>");
		
		while (rst.next()) 
		{
			out.print("<tr><td class =\"col-md-1"+"\"><a href =\"addcart.jsp?id=" + rst.getInt(1) + "&name=" + rst.getString(2)
			+ "&price=" + rst.getDouble(3) + "\">Add to Cart</a></td>" +
			"<td><a href=\"product.jsp?id=" + rst.getInt(1) + "&pName=" + rst.getString(2)
			+ "&pPrice=" + rst.getDouble(3) + "\">"+rst.getString(2)+"</a></td>"+
			"<td>"+currFormat.format(rst.getDouble(3))+"</td></tr>");
		
	
		}
		out.println("</tbody></table></font>");
	} 
	catch (SQLException ex) 
	{
		out.println(ex);
	} 	
%>
</body>
</html>