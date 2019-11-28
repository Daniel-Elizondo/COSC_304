<%@ page import="java.sql.*" %>
<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<%@ include file="auth.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
</head>
<body>

<%
// TODO: Include files auth.jsp and jdbc.jsp
%>
<%

// TODO: Write SQL query that prints out total order amount by day

String sql = "SELECT CONVERT(VARCHAR(10), orderDate, 111) AS  DateOfOrder, SUM(totalAmount) AS Total FROM ordersummary GROUP BY CONVERT(VARCHAR(10), orderDate, 111) ORDER BY DateOfOrder;";
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

if (false){ //validate if user is an admin
	out.println("<h1>Administrator Sales Report by Day</h1>");

	try ( Connection con = DriverManager.getConnection(url, uid, pw);
	        Statement stmt = con.createStatement();) 
	{				
		ResultSet rst = stmt.executeQuery(sql);	
		out.println("<table class=\"table\" border=\"1\">"
				+ "<tbody><tr><th>Order Date</th><th>Total Order Amount</th></tr>");
		while(rst.next()){
			out.println("<tr><td>" + rst.getString(1) + "</td>");
			out.println("<td>" + currFormat.format(rst.getDouble(2)) + "</td></tr>");
		}
		out.println("</tbody></table>");
	}
	catch (SQLException ex) 
	{ 	out.println(ex); 
	}
} else {
	out.println("<h1>Please Login Into System</h1>");
	out.println("<p>You have not been authorized to access the URL " + request.getRequestURL() + "</p>");
	
	out.println("<h2 align=\"center\">Click <a href=\"login.jsp\">here </a>to go to the login page.</h2>");
	
}
%>

</body>
</html>



