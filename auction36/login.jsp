<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>eBay but not eBay</title>
	</head>
	
	<body>
	<center> 
		<b> Log In </b>
		<br>
		<form method="post" action="check-login.jsp">
		<table>
			<tr>
				<td>E-mail</td><td><input type="text" name="email"></td>
			</tr>
			<tr>
				<td>Password</td><td><input type="text" name="password"></td>
			</tr>
		</table>
		Login As:
			<input type="radio" name="command" value="endUser" checked/>Regular User
			<input type="radio" name="command" value="AdminStaff"/>Admin
			<input type="radio" name="command" value="CustomerRep"/>Customer Rep.
			<br>
		<input type="submit" value="Sign In">
		</form>
		<br>
		<b> Create New Account </b>
		<br>
		<form method="post" action="create-user.jsp">
			<table>
				<tr>    
					<td>Username</td><td><input type="text" name="username"></td>
				</tr>
				<tr>    
					<td>E-mail</td><td><input type="text" name="email"></td>
				</tr>
				<tr>
					<td>Password</td><td><input type="text" name="password"></td>
				</tr>
			
			</table>
			<input type="submit" value="Create Account">
		</form>
	<br>
	</center>

</body> 
</html>
