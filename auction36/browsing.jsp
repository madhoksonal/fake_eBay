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
		<%
		if ((session.getAttribute("email") == null)) {
		%>
		You are not logged in. <br/>
		<a href="auction-login.jsp">Please Login.</a>
		<%} else {
			%>
			<h1> Search for an auction here! </h1>
			<br>
			<!-- Query Options
			0) All auctions
			1) Name (Model)
			2) Brand
			3) Operating System
			4) Price
			5) Screensize // lowkey want to get rid of weight 
			6) Type 
			7) Condition
			 -->
			 
			 See all available auctions!
			 <form action="webpage.jsp">
			 	<input type="submit" value="See all Products." />
			 </form>
			 <br>
			 
			 
			 Search by Brand, Model, or Operating System!
			 <form method='post' action="webpage.jsp">
			 	</form><td>Keyword:</td><td><input type="text" name="text_search"></td>
			   	<br>
			 	<input type="radio" name="command" value="model"/>Model
			 	<input type="radio" name="command" value="brand"/>Brand
			 	<input type="radio" name="command" value="operating_system"/> Operating System
			 	<br>
			 	<input type="submit" value="submit" />
			 </form>
			 <br>
			 
			 
			  Search by Screen Size!
			 <form method='post' action="webpage.jsp">
			 	<select name="size" size=1>
					<option value="15">15 and higher</option>
					<option value="13">13 and lower</option>
					<option value="8.0">$8.0 and under</option>
				</select>&nbsp;<br> <input type="submit" value="submit">
			 </form>
			 <br>
			 
			 
			 Return to <a href= 'webpage.jsp'> Homepage</a>
			<%
			}%>
			
	</body>
</html>
