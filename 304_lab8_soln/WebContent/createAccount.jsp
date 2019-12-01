<%@ page import="java.sql.*"%>
<%@ include file="jdbc.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>Create Account</title>
</head>
<body>
	<%@ include file="header.jsp"%>

	<div style="margin: 0 auto; text-align: center; display: inline">
	<h1>Create a new account</h1>

		<h3>Please enter the following information:</h3>
		<%
			String firstName = request.getParameter("firstName");
			String lastName = request.getParameter("lastName");
			String email = request.getParameter("email");
			String phoneNum = request.getParameter("phoneNum");
			String address = request.getParameter("address");
			String city = request.getParameter("city");
			String state = request.getParameter("state");
			String postCode = request.getParameter("postCode");
			String country = request.getParameter("country");
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			if (request.getParameter("Submit") != null) {
				insertCustInfo(firstName, lastName, email, phoneNum, address, city, state, postCode, country, username, password);
			
			}
		%>

		<form name="input" action="customer.jsp">
			First Name: <input type="text" name="firstName"><br>
			Last Name: <input type="text" name="lastName"><br>
			Email: <input type="text" name="email"> <br> Phone
			Number: <input type="text" name="phoneNum"><br> Address:
			<input type="text" name="address"><br> City: <input
				type="text" name="city"><br> State: <input type="text"
				name="state"><br> Postal Code: <input type="text"
				name="postCode"><br> Country: <input type="text"
				name="country"><br> Username: <input type="text"
				name="username"><br> Password: <input type="text"
				name="password"><br> <input type="submit"
				value="Submit"> <input type="reset" value="Reset">
		</form>


	</div>

</body>
</html>

