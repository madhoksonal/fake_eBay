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
  <a href="buyer-auto-bid.jsp">Buyer Auto Bid</a>
  <a href="#contact">Seller</a>
  <a href="logout.jsp">Log Out</a>
</div>

<div style="padding-left:16px">
  <h2>Welcome to eBuy - your friendly neighborhood eBay!</h2>
  <p></p>
</div>
		
		<hr class="dashed">
		
		
		Set Secret Upper Limit for Buyer 	
		<br> 
		<br> 
<form action="update_auto_bid.jsp" >
 <label for="user">Enter your Username</label><br>
   <input type="text" id="userName" name="userName" ><br>
    <label for="bidLimit">Set your Upper Bid Limit</label><br>
     <input type="text" id="upperLimit" name="upperLimit"><br><br>
  <input type="submit" value="Set Upper Limit">
</form> 
	
</body>
</html>