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
	
	Log In
		<br>
		<form method="post" action="check-account-login.jsp">
			<table>
				<tr>    
					<td>E-mail</td><td><input type="text" name="email"></td>
				</tr>
				<tr>
					<td>Password</td><td><input type="text" name="password"></td>
				</tr>
			
			</table>
			<input type="submit" value="Sign in">
		</form>
		<br>
	
	Create New Account
	<br>
		<form method="post" action="account-creation.jsp">
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
	
	<hr class="dashed">
		Admin Login:
		<br>
			<form method="post" action="check-admin-login.jsp">
			
			<table> 
				<tr>    
					<td>E-mail</td><td><input type="text" name="email"></td>
				</tr>
				<tr>
					<td>Password</td><td><input type="text" name="password"></td>
				</tr>

			</table>
				<input type="submit" value="Login">
			</form>
		<br>
		
		Customer Rep Login:
		<br>
			<form method="post" action="check-rep-login.jsp">
			
			<table> 
				<tr>    
					<td>E-mail</td><td><input type="text" name="email"></td>
				</tr>
				<tr>
					<td>Password</td><td><input type="text" name="password"></td>
				</tr>

			</table>
				<input type="submit" value="Login">
			</form>
		<br>

</body> 
</html>
