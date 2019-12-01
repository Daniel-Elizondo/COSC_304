<%
/**
A JSP file that encapsulates all database access.

Public methods:
- public void getConnection() throws SQLException
- public ResultSet executeQuery(String query) throws SQLException
- public void executeUpdate(String query) throws SQLException
- public void closeConnection() throws SQLException  
**/
%>
<%@ page import="java.sql.*"%>
<%!
	// User id, password, and server information
	private String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_wbarlow;";
	private String uid = "wbarlow";
	private String pw = "81776940";

	// Connection
	private Connection con = null;
%>
<%!
	public void getConnection() throws SQLException 
	{
		try
		{	// Load driver class
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		}
		catch (java.lang.ClassNotFoundException e)
		{
			throw new SQLException("ClassNotFoundException: " +e);
		}
	
		con = DriverManager.getConnection(url, uid, pw);
	}
   
	public void closeConnection()
	{
		try {
			if (con != null)
				con.close();
			con = null;	
		}
		catch (SQLException e)
		{ /* Ignore connection close error */ }
	}
	public int insertCustInfo(String firstName, String lastName, String email, String phoneNum, String address, String city, String state, String postCode, String country, String username, String password) throws SQLException{
		try{
		getConnection();
		String sql = "INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setString(1, firstName);
		pstmt.setString(2, lastName);
		pstmt.setString(3, email);
		pstmt.setString(4, phoneNum);
		pstmt.setString(5, address);
		pstmt.setString(6, city);
		pstmt.setString(7, state);
		pstmt.setString(8, postCode);
		pstmt.setString(9, country);
		pstmt.setString(10, username);
		pstmt.setString(11, password);
		pstmt.executeUpdate();
		closeConnection();
		return 1;
		} catch (SQLException e){
			return 0;
		}
	
	}
	
%>