<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Ray's Grocery</title>
</head>
<body>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<%@ include file="header.jsp"%>
<h3>Search for the products you want to buy:</h3>

<form method="get" action="listprod.jsp">
<div class="input-group">
	<input type="text" name="productName" size="50" placeholder="Search">
	<select name="productCategory"class="form-control">
		<option value="noValue" hidden>Select Category</option>
		<option value="Propane">Propane</option>
		<option value="Accessories">Accessories</option>
	</select>
	<select name="sort"class="form-control">
		<option value="noValue" hidden>Sort by</option>
		<option value="alph">Alphabetical</option>
		<option value="pop">Popular</option>
		<option value="priceA">Price Ascending</option>
		<option value="priceD">Price Descending</option>
	</select>
	<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</div>
</form>

<%
	// Get product name to search for
	String name = request.getParameter("productName");
	String category = request.getParameter("productCategory");
	String sortedBy = request.getParameter("sort");
	int sorted = 0;
	int cat = 0;
	if (name == null)
		name = "";
	if (category == null)
		category = "";
	if (sortedBy == null)
		sortedBy = "";
	if (category.equals("Propane"))
		cat = 1;
	else if (category.equals("Accessories"))
		cat = 2;
	if (sortedBy.equals("alph"))
		sorted = 1;
	else if (sortedBy.equals("pop"))
		sorted = 2;
	else if (sortedBy.equals("priceA"))
		sorted = 3;
	else if (sortedBy.equals("priceD"))
		sorted = 4;
	boolean hasParameter = false;
	String sql = "";
	
	if (name.equals("") && cat == 0) 
	{
		out.println("<h2>All Products</h2>");
		sql = "";
	} else if (name.equals("")) {
		out.println("<h2>All Products in Cateogry: '" + category + "'</h2>");
		hasParameter = true;
		sql = "WHERE categoryId = ?" ;
	} else if (cat == 0){
		out.println("<h2>All Categories Contaning '" + name + "'</h2>");
		hasParameter = true;
		sql = "WHERE productName LIKE ?";
		name = '%' + name + '%';
	}
	else 
	{
		out.println("<h2>Products in Category: '" + category + "', Containing '" + name + "'</h2>");
		hasParameter = true;
		sql = "WHERE categoryId = ? AND productName LIKE ?";
		name = '%' + name + '%';
	}
	
	if (sorted == 1)
		sql = "SELECT productId, productName, productPrice FROM product " + sql + " ORDER BY productName;";
	else if (sorted == 2) {
		sql = "SELECT product.productId, productName, productPrice, SUM(quantity) AS quantity FROM orderproduct, product " + sql;
		if (name.equals("") && cat == 0)
			sql = sql + " WHERE product.productId = orderproduct.productId GROUP BY product.productId, productName, productPrice ORDER BY quantity DESC;";
		else 
			sql = sql + " AND product.productId = orderproduct.productId GROUP BY product.productId, productName, productPrice ORDER BY quantity DESC;";
	}
	else if (sorted == 3)
		sql = "SELECT productId, productName, productPrice FROM product " + sql + " ORDER BY productPrice ASC;";
	else if (sorted == 4)
		sql = "SELECT productId, productName, productPrice FROM product " + sql + " ORDER BY productPrice DESC;";
	else 
		sql = "SELECT productId, productName, productPrice FROM product " + sql + ";";
	
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
		if (hasParameter && cat == 0)
			pstmt.setString(1, name);
		else if (hasParameter && name.equals(""))
			pstmt.setInt(1, cat);
		else if (hasParameter){
			pstmt.setInt(1, cat);
			pstmt.setString(2, name);
		}
		
		System.out.println(sql);
		ResultSet rst = pstmt.executeQuery();
		out.println("<font size =\"3"+"\"face =\"Helvetica"+"\">");
		out.print("<table class =\"table"+"\"border=\"2"+"\"><tbody><thead class=\"thead-dark\"><tr>"+
		"<th class=\"col-md-1"+"\"></th>"+
		"<th>Product Name</th>" +
		"<th>Price</th></tr></thead>");
		
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