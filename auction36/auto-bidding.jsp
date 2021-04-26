<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
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
  <a class="active" href="alert-page-buyer.jsp">Buyer's Alert Page</a>

</div>

</head>

<body>

		<h2>Welcome to eBuy - your friendly neighborhood eBay!</h2>
		<p></p>
	</div>
	
	<h2>Auto Bidding</h2>


	<%
	if ((session.getAttribute("email") == null)) {
	%>
	You are not logged in.
	<br />
	<%
	} else {
	try {
		

		//Get the database connection
		Class.forName("com.mysql.jdbc.Driver");
		
		ApplicationDB db = new ApplicationDB();
	
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fakeEbay", "root", "root");
		
		int current_bid_int;

		//get email for session 
		String email = (String) session.getAttribute("email");
		//get product ID
		String auctionID = request.getParameter("auction_ID");
		int auctionIDInt = Integer.parseInt(auctionID);
		

		Statement stmt = con.createStatement();
		
		//table with all current bids for the specific product id 
		String getMaxBid = "SELECT b.account_id, b.upper_bid_limit, MAX(b.current_bid) FROM Buys b WHERE b.auction_id = "
		+ auctionIDInt;
	
		ResultSet result = stmt.executeQuery(getMaxBid);
				
				
		if (result.next()) {
			
		int maxBid = result.getInt("MAX(b.current_bid)");

		String getCurrentBids = "SELECT b.account_id, b.upper_bid_limit, b.current_bid FROM Buys b WHERE b.auction_id = "
		+ auctionIDInt;
		
		Statement stmt2 = con.createStatement();
		result = stmt2.executeQuery(getCurrentBids); 
		
		Statement stmt3 = con.createStatement();
		String update = "UPDATE Buys b SET b.current_bid = b.current_bid+1 WHERE b.auction_id = " + auctionIDInt;

		Statement stmt4 = con.createStatement();
		String upperLimitSetAlert = "UPDATE Buys b SET b.upper_limit_reached = TRUE WHERE b.auction_id = " + auctionIDInt; 
		
		while (result.next()) {

		if (maxBid > result.getInt("b.current_bid") && maxBid < result.getInt("b.upper_bid_limit")) {
			
			stmt3.executeUpdate(update);
			
			current_bid_int = result.getInt("b.current_bid");
			out.print(" Automatic Increment set for " + email + "!");

		}
		
		else if (maxBid > result.getInt("b.current_bid") && maxBid > result.getInt("b.upper_bid_limit")) {
			
			stmt4.executeUpdate(upperLimitSetAlert);
			out.print(" Someone bid more than your upper limit."); 
			
		}
		else {
			stmt3.executeUpdate(update);
			
			current_bid_int = result.getInt("b.current_bid");
			out.print(" Automatic Increment set for " + email + "!");
		}


			}

		} else {
			
			con.close();
		}

	}

	catch (Exception ex) {
		out.println(ex);
		out.println("Auto bidding not set");
	}
	}
	%>