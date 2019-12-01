<%@ page import="java.util.HashMap"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp"%>

<html>
<head>
<title>Propane & Propane Accesories</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

	<%@ include file="header.jsp"%>

	<%
		try
		{	// Load driver class
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		}
		catch (java.lang.ClassNotFoundException e)
		{
			out.println("ClassNotFoundException: " +e);
		}
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
						+ "<table class =\"table"+"\"border=\"2"+"><tbody><tr><th>Id:</th>"
						+ "<td>" + productId + "</td><tr>" + "<tr><th>Price:</th>");
				
				
				out.print("<td>" + currFormat.format(rst.getDouble(3)) + "</td></tr></tbody></table>"
						+ "<h3><a href =\"addcart.jsp?id=" + rst.getInt(1) + "&name=" + rst.getString(2) + "&price="
						+ rst.getDouble(3) + "\">Add to Cart</a></h3>" + "<h3><a href=\"listprod.jsp"
						+ "\">Continue Shopping</a></h3></td>");

			}
			String submittedReview = request.getParameter("submittedReview");
			boolean subR = Boolean.parseBoolean(submittedReview);
			if (!subR){
				out.println("<h2>Leave a review!</h2>");
				out.println("<form method=\"get\" action=\"product.jsp\">"
							+ "<textarea rows=\"10\" cols\"40\" maxlength=\"1000\" name=\"prodReview\">What do you think of the product?</textarea>"
							+ "<p>How many stars do you give this product?</p>"
							+ "<select name=\"rating\" class=\"form-control\" style=\"width: 35px !important;\">"
							+ "<option value=\"1\">1</option>"
							+ "<option value=\"2\">2</option>"
							+ "<option value=\"3\">3</option>"
							+ "<option value=\"4\">4</option>"
							+ "<option value=\"5\">5</option></select>"
							+ "<input type=\"hidden\" name=\"submittedReview\" value=\"true\">"
							+ "<input type=\"submit\" value=\"Submit\"><input type=\"reset\" value=\"Reset\">"
							+ "</form>");
				String custId = (String)session.getAttribute("customerId");
				String prodId = (String)session.getAttribute("productId");
				String prodReview = request.getParameter("prodReview");
				String rating = request.getParameter("rating");
				String sql2 = "INSERT INTO review(reviewRating, customerId, productId, reviewComment) VALUES (?,?,?,?);";
				PreparedStatement pstmt2 = con.prepareStatement(sql2);
				pstmt2.setString(1,rating);
				pstmt2.setString(2,custId);
				pstmt2.setString(3,prodId);
				pstmt2.setString(4,prodReview);
				pstmt2.executeUpdate();
			} else {
				out.println("<h2>thank you for leaving a review!</h2>");
			}
			PreparedStatement pstmt3 = con.prepareStatement("SELECT reviewComment, reviewRating FROM review WHERE productId = " + (String)session.getAttribute("productId"));
			ResultSet rs2 = pstmt3.executeQuery();
			out.println("<h2>Customer reviews</h2>");
			int count = 0;
			int totalReviews = 0;
			while (rs2.next()){
				out.println("<p>" + rs2.getString(1) + "</p>");
				count++;
				totalReviews += rs2.getInt(2);
				//
			}
			if (count == 0){
				out.println("<p>No custoemr reviews</p>");
			} else {
				out.println("<p>Average customer review: " + (totalReviews/count) + "</p>");
			}
		}
		
		
		
	%>

</body>
</html>

