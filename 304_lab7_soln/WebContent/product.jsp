<%@ page import="java.util.HashMap"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp"%>

<html>
<head>
<title>Ray's Grocery - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

	<%@ include file="header.jsp"%>

	<%
		// Get product name to search for
		// TODO: Retrieve and display info for the product
		String productId = request.getParameter("id");
		String pName = request.getParameter("pName");
		String pPrice = request.getParameter("pPrice");
		NumberFormat currFormat = NumberFormat.getCurrencyInstance();

		String sql = "select * from product where productId = ?";
		try (Connection con = DriverManager.getConnection(url, uid, pw);) {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, productId);
			ResultSet rst = pstmt.executeQuery();
			// TODO: If there is a productImageURL, display using IMG tag
			out.println("<img src=\"img/1.jpg"+"\">");
			// TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
			out.print("<img src=\"displayImage.jsp?id="+productId+"\">");
			while (rst.next()) {
				
				out.println("<h1 align=\"center" + "\"></h1>" + "<h2>" + rst.getString("productName") + "</h2>"
						+ "<table><tbody><tr><th>Id:</th>"
						+ "<td>" + productId + "</td><tr>" + "<tr><th>Price:</th>");
				out.print("<td>" + currFormat.format(rst.getDouble(3)) + "</td></tr></tbody></table>"
						+ "<h3><a href =\"addcart.jsp?id=" + rst.getInt(1) + "&name=" + rst.getString(2) + "&price="
						+ rst.getDouble(3) + "\">Add to Cart</a></h3>" + "<h3><a href=\"listprod.jsp"
						+ "\">Continue Shopping</a></h3></td>");

			}
		}



		
	%>

</body>
</html>

