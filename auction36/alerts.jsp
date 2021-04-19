<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Search Page</title>
	</head>
	<body>
	<%	if ((session.getAttribute("email") == null)) { %>
		You are not logged in. <br/>
		<a href="auction-login.jsp">Please Login.</a>
		<%} else {%>
			<h2> Set up an alert: </h2>
			Fill out any criteria that you are interested in!
				<form method="post" action="create-alert.jsp">
				<table>
				<tr>    
					<td>Brand: </td><td><input type="text" name="brand" value = "Test"></td>
				</tr>
				<tr>    
					<td>Model: </td><td><input type="text" name="model" value = "Test"></td>
				</tr>
				<tr>
					<td>Operating System:</td><td><input type="text" name="os" value = "Test"></td>
				</tr>
				<tr>
					<td>Screen Size:</td><td><input type="text" name="screen" value = "Test"></td>
				</tr>
				<tr>
					<td>Condition:</td><td><input type="text" name="condition" value = "Test"></td>
				</tr>
				<tr>
					<td>Category:</td><td><input type="text" name="category" value = "Test"></td>
				</tr>	
			</table>
			<input type="submit" value="Create Alert">
		</form>
			<h2> Current Alerts: </h2>
			
			<!-- queue from alerts database into sells database -->
			<%
		}%>
	
	
	
	
	
	</body>
</html>
