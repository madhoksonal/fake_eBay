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

	Log In
	<br>
		<form method="post" action="account-login.jsp">
		<table> 
		
			<input type="text" name="email" value="Email"/> 
			<input type="text" name="pw" value="Password"/>
			<input type="submit" value="Login"/>

		</table>
		</form>
	<br>
	
	Create New Account
	<br>
		<form method="post" action="account-creation.jsp">
		<table> 
		
		  <input type="text" name="usern" value="Login Name"/> 
		  <input type="text" name="email" value="Email"/> 
		  <input type="text" name="pw" value="Password"/>
		  <input type="submit" value="Login"/>

		</table>
		</form>
	<br>

</body> 
</html>
