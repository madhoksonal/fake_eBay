<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Homepage</title>
	</head>
	<body>
		Home page!!!
		
		You have successfully logged in.

		<!--  
		<% try {
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected radio button from the index.jsp
			String user = request.getParameter("username");
			//out.print(user);

			
			/** how to import username/email from auction-login.jsp????**/
			/** need to be able to share this will all the pages????**/
		%>
		
		Make an HTML table to show the results in: -->
		
		<!-- <%out.print(user);%>
		<br>
		<button type="reset" onclick="location.href = '/auction36/auction-login.jsp';">Log out</button>
		
		<% db.closeConnection(con); %>
			
		<%} catch (Exception e) {
			out.print(e);
		}%>
	-->

	</body>
</html>