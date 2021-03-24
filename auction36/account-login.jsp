<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Account Log-in</title>
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
		
		String q = "SELECT email FROM accounts WHERE password = '" + thisPW + "'";
		out.println("\n"+thisPW);
		out.println("result set");
		ResultSet result = stmt.executeQuery(q);
		if (result.wasNull()){
			out.print("Account does not exist.");
		}
		out.println("account exist");
		while(result.next()){
			String checking = result.getString("email");
			out.println("\n"+checking+"\n"+thisEmail);
			if (checking.equals(thisEmail)){
				con.close();
				out.println("password correct");
				response.sendRedirect("webpage.jsp");
				out.println("not redirected");
			}else{
				out.print("Password does not match. Please try again.");
				con.close();
			}
		}
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		//con.close();
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Could not login.");
	}
%>
</body>
</html>