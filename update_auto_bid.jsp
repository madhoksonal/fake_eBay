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
<style>
body {
  margin: 0;
  font-family: Arial, Helvetica, sans-serif;
}

.topnav {
  overflow: hidden;
  background-color: #333;
}

.topnav a {
  float: left;
  color: #f2f2f2;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
  font-size: 17px;
}

.topnav a:hover {
  background-color: #ddd;
  color: black;
}

.topnav a.active {
  background-color: #4CAF50;
  color: white;
}
</style>
</head>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<body>

<div class="topnav">
  <a class="active" href="#home">Create Account/Log In</a>
  <a href="buyer-set-upper-bid.jsp">Buyer Auto Bid</a>
  <a href="#contact">Seller</a>
  <a href="logout.jsp">Log Out</a>
</div>

<div style="padding-left:16px">
  <h2>Welcome to eBuy - your friendly neighborhood eBay!</h2>
  <p></p>
</div>

<%
	try {
		
		//Get the database connection
		Class.forName("com.mysql.jdbc.Driver");
		ApplicationDB db = new ApplicationDB();	
		//Connection con = db.getConnection();
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fakeEbay", "root", "root");

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		//Get parameters from the HTML form at the HelloWorld.jsp
		String user = request.getParameter("userName"); //idk how to get the username/email of who is logged on currently //this could cause security issues 
															//users can affect others' accounts if they know their usernames 
		String upperLimit = request.getParameter("upperLimit"); 
		int upperLimitInt = Integer.parseInt(upperLimit); 
		
		System.out.println(upperLimitInt);
		
		//Make an insert statement for the endUser table:
				String update = "UPDATE endUser" + " SET upper_bid_limit =" + upperLimitInt + " WHERE login_name ='" + user + "'";
		
		stmt.executeUpdate(update);
		
		out.print("Upper Bit limit set! for " + user);
		
		/*
		String newEmail = request.getParameter("email");
		String newUser = request.getParameter("username");
		String newPW = request.getParameter("password");


		//Make an insert statement for the Sells table:
		String insert = "INSERT INTO accounts(login_name, email, password, upper_bid_limit)"
				+ "VALUES (?, ?, ?, NULL)";
		
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, newUser);
		ps.setString(2, newEmail);
		ps.setString(3, newPW);
		//Run the query against the DB
		ps.executeUpdate();

		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		

		out.print("Account created!");
		*/
	} catch (Exception ex) {
		out.print(ex);
		out.print("Upper Bid limit not set");
	}
%>
