<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
%>

<%

// TODO: Print Customer information
String sql = "select * from customer where customerId=? ";
String customerId = (String)session.getAttribute("customerId");
try (Connection con = DriverManager.getConnection(url, uid, pw);) {
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, customerId);
	ResultSet rst = pstmt.executeQuery();
	while(rst.next()){
		//9
		out.print("<tr><th>Id</th><td>"+rst.getInt("customerId")+"</td></tr>"+
		"<tr><th>First Name</th>"+
		"<td>"+rst.getString("firstName")+"</td></tr>"+
		"<tr><th>Last Name</th>"+
		"<td>"+rst.getString("lastName")+"</td></tr>"+
		"<tr><th>Email</th>"+
		"<td>"+rst.getString("email")+"</td></tr>"+
		"<tr><th>Phone Number</th>"+
		"<td>"+rst.getString("phonenum")+"</td></tr>"+
		"<tr><th>Address</th>"+
		"<td>"+rst.getString("address")+"</td></tr>"+
		"<tr><th>City</th>"+
		"<td>"+rst.getString("city")+"</td></tr>"+
		"<tr><th>State</th>"+
		"<td>"+rst.getString("state")+"</td></tr>"+
		"<tr><th>Postal Code</th>"+
		"<td>"+rst.getString("postalCode")+"</td></tr>"+
		"<tr><th>Country</th>"+
		"<td>"+rst.getString("country")+"</td></tr>");
	}
	
}

// Make sure to close connection
%>

</body>
</html>

