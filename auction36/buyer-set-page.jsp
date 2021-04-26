<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Buyer: Set Bid Limit and Auto Bidding</title>
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

<center>
<div style="padding-left:16px">
  <h2>Welcome to eBuy - your friendly neighborhood eBay!</h2>
  <p></p>
</div>
	<h3>Set Secret Upper Limit for Buyer</h3>
		<br> 
		<hr class="dashed">	
		
<form action="buyer-set-upper-bid.jsp" >
    <label for="auctionID">Input the Auction ID</label><br>
     <input type="text" id="auctionID" name="auctionID"><br><br>
    <label for="bidLimit">Set your Upper Bid Limit for this auction</label><br>
     <input type="text" id="upperLimit" name="upperLimit"><br><br>
  <input type="submit" value="Set Upper Limit">
</form> 

<br>
<br> 
		<hr class="dashed">	

	<form action="auto-bidding.jsp" >
    <label for="automaticBidding">Would you like to have automatic bidding? <br> We will place a higher bid automatically for your 
    bid until your upper limit if you input the Auction ID and click yes. </label><br>
      <label for="auction_ID">Input the Auction ID</label><br>
     <input type="text" id="auction_ID" name="auction_ID"><br><br>
  <input type="submit" value="Yes">
</form> 

</center>
	
</body>
</html>