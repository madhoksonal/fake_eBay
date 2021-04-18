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
			0) All auctions Done
			1) Name (Model) DONE
			2) Brand DONE
			3) Operating System DONE
			4) Price DONE
			5) Screensize// DONE // lowkey want to get rid of weight 
			6) Type 
			7) Condition //DONE
			 -->
			 
			 Look at Auctions:
			 <form action="all-auctions.jsp">
			 	<input type="submit" name="all" value="All active options." />
			 </form>
			 <br>
			 <form action="all-auctions.jsp"> <!--  update this later -->
			 	<input type="text" name="user_history" value = "Enter auction id">
			 	<input type="submit" name="by_quction"  value="See history for specific auction." />
			 </form>
			 <br>
			 <form action="all-auctions.jsp"> <!--  update this later -->
			 	<input type="text" name="user_history" value = "Enter user id">
			 	<input type="submit" name="by_user"  value="See history for specific user." />
			 </form>
			 <br>
			 
			 
			 Search by Brand, Model, or Operating System!
			 <form method='post' action="search-queries.jsp">
			 	<input type="text" name="text_search">
			   	<br>
			 	<input type="radio" name="command" value="model"/>Model
			 	<input type="radio" name="command" value="brand"/>Brand
			 	<input type="radio" name="command" value="operating_system"/> Operating System
			 	<br>
			 	<input type="submit" value="submit" />
			 </form>
			 <br>
			 
			  Search by Initial Price! <!-- will return anything lower that the search price -->
			 <form method='post' action="search-queries.jsp">
			 <input type="text" name="price_search" value="0.00" >
			 <br>
			 <input type="radio" name="command" value="min"/>Minimum
			 <input type="radio" name="command" value="max"/>Maximum
			 <br>
			 	<input type="submit" value="submit" />
			 </form>
			 <br>
			 
			 
			  Search by Screen Size!
			 <form method='post' action="search-queries.jsp">
			 <input type="text" name="screen_search" value="13" >
			 <br>
			 <input type="radio" name="command" value="min"/>Minimum
			 <input type="radio" name="command" value="max"/>Maximum
			 <br>
			 	<input type="submit" value="submit" />
			 </form>
			 <br>
			 
			 Search by Condition!
			 <form method='post' action="search-queries.jsp">
			 	<select name="condition" size=1>
					<option value="Brand New">Brand New</option>
					<option value="Like New">Like New</option>
					<option value="Very Good">Very Good</option>
					<option value="Good">Good</option>
					<option value="Used">Used</option>
				</select>&nbsp;<br> <input type="submit" value="submit">
			 </form>
			 <br>
			 
			 Search by Product Type!
			 <form method='post' action="search-queries.jsp">
			 	<select name="type" size=1>
					<option value="Laptop">Laptop</option>
					<option value="Tablet">Tablet</option>
					<option value="Desktop">Desktop</option>
				</select>&nbsp;<br> <input type="submit" value="submit">
			 </form>
			 <br>
			 
			 Return to <a href= 'webpage.jsp'> Homepage</a>
			 
			<%
			}%>
			
	</body>
</html>
