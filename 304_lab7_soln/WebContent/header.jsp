<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<H1 align="center"><font face="courier" color="#000000"><a href="index.jsp">Propane & Propane Accessories</a></font></H1>      

	<nav>
	<h3 align="center"> 
		<a href="login.jsp">Login</a>|
		<a href="listprod.jsp">Begin Shopping</a>|
		<a href="listorder.jsp">List All Orders</a>|
		<a href="customer.jsp">Customer Info</a>|
		<a href="admin.jsp">Administrators</a>|
		<a href="logout.jsp">Log out</a>
		<%
		try
		{	// Load driver class
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		}
		catch (java.lang.ClassNotFoundException e)
		{
			out.println("ClassNotFoundException: " +e);
		}
		String url1 = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_wbarlow;";
		String uid1 = "wbarlow";
		String pw1 = "81776940";
		String customerId = (String)session.getAttribute("customerId");
		String sql1 = "select firstName, lastName from customer where customerId=? ";
		try (Connection con = DriverManager.getConnection(url1, uid1, pw1);) {
			PreparedStatement pstmt = con.prepareStatement(sql1);
			pstmt.setString(1, customerId);
			ResultSet rst = pstmt.executeQuery();
			while(rst.next()){
				out.println("<a href=\"customer.jsp\"text-align=\"left\">Logged in as: " + rst.getString(1) + " " + rst.getString(2) + "</a>");
			}
		} catch (SQLException ex) {
			out.println(ex);
		}
		%>
	</h3>
	</nav>
	<hr>
