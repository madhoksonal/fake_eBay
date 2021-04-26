<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
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
  <a class="active" href="webpage.jsp">Home</a>

</div>


<div style="padding-left:16px">
  <h2>Welcome to eBuy - your friendly neighborhood eBay!</h2>
  <p></p>
</div>

	<%
		if ((session.getAttribute("email") == null)) {
		%>
		You are not logged in. <br/>
		<%} else {
			try {
		
		//Get the database connection
		Class.forName("com.mysql.jdbc.Driver");
		ApplicationDB db = new ApplicationDB();	
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fakeEbay", "root", "root");

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		//get product ID
		String auctionID = request.getParameter("auctionID"); 
		int auctionIDInt = Integer.parseInt(auctionID); 
	
		
		
		//set upper limit for specific product ID 
		String upperLimit = request.getParameter("upperLimit"); 
		int upperLimitInt = Integer.parseInt(upperLimit); 
			
		
		//get email for session 
		String email = (String) session.getAttribute("email");
		
		//Make an update statement for the Buys table:
		String update = "UPDATE Buys" + " SET upper_bid_limit = " + upperLimitInt + 
		" WHERE (account_id = (SELECT e.account_id FROM endUser e WHERE e.email = '" + email + "')) AND auction_id = " + auctionIDInt;
		
		stmt.executeUpdate(update);
		
		out.print("Upper Bit limit set! for " + email);
		
		
	
	} catch (Exception ex) {
		out.print(ex);
		out.print("Upper Bid limit not set");
	}
}
%>