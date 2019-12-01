<H1 align="center"><font size ="10" face="helvetica" color="#3399FF"><a href="index.jsp">Strickland Propane</a></font></H1>   
<%
	String userName = (String) session.getAttribute("authenticatedUser");
	if (userName != null)
		out.println("<h3 align=\"center\">Signed in as: "+userName+"</h3>");
%>   
<hr>
