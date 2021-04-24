<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Admin Log-in</title>
</head>
<body>
	<%
	try {
        
		//Get the database connection
		Class.forName("com.mysql.jdbc.Driver"); 
		ApplicationDB db = new ApplicationDB();	
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fakeEbay", "root", "beetroot");

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the HelloWorld.jsp
		String thisEmail = request.getParameter("email");
		String thisPW = request.getParameter("password");
		
		out.println(thisEmail+thisPW);
		
		String q = "SELECT email FROM adminStaff WHERE password = '" + thisPW + "'";
		
		ResultSet result = stmt.executeQuery(q);
		boolean bool = result.wasNull();
		if (!bool){
			out.println("Invalid log-in. <a href='auction-login.jsp'>Try again.</a>");
		}
		
		while(result.next()){
			String checking = result.getString("email");
			out.println(checking+"...");
			if (!checking.equals(thisEmail)){
				out.println("Invalid log-in. <a href='auction-login.jsp'>Try again.</a>");
			}
		}

	q = "SELECT * FROM accounts";
	result = stmt.executeQuery(q);
	%>
	


	<table>
		<tr>    
			<td>Login-Name</td>
			<td>Email</td>
			<td>Password</td>
		</tr>
			<%
			//parse out the results
			while (result.next()) { %>
				<tr>    
					<td><%= result.getString("login_name") %></td>
					<td><%= result.getString("email") %></td>
					<td><%= result.getString("password") %></td>
				</tr>

		<% } %>
		
	</table>
	<%
	//close the connection.
		con.close();
	} catch (Exception ex) {
	out.print(ex);
	out.print("Could not login.");
	}
%>

<a href="auction-login.jsp">Auction Login</a>
<a href="logout.jsp">Logout</a>
</body>
</html>
