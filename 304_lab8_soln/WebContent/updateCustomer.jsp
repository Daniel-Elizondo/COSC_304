
<%@ include file="jdbc.jsp" %>
<%@ include file="header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>Update Info</title>
</head>
<body>
	

	<div style="margin: 0 auto; text-align: center; display: inline">
	<h1>Update Info</h1>

		<h3>Please update your information</h3>
		<form name="input"action="customer.jsp">
			
			 <input type="text" name="input"><br>
			
			<input type="submit" value="Submit"> <input type="reset" value="Reset">
		</form>
		<%
		try{
			getConnection();
			 
			String col = request.getParameter("col");
			String value = request.getParameter("input");
		
			String sql = "UPDATE customer SET ? = ? WHERE userid = ? ";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1,col );
			pstmt.setString(2, value);
			pstmt.setString(3, userName);	
			int i = pstmt.executeUpdate();
	
		
			
			
			
			
		}catch (SQLException e){
			
		}
	
		
		%>

		


	</div>

</body>
</html>

