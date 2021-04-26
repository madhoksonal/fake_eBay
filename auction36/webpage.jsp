<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Homepage</title>
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
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<body>

	<div class="topnav">
		<a class="active" href="webpage.jsp">Home</a> <a class="active"
			href='browsing.jsp'>Browse auctions and products.</a> <a
			class="active" href='history.jsp'>View history of auctions +
			bids.</a> <a class="active" href='alerts.jsp'>Wishlist</a> <a
			class="active" href='buyer-set-page.jsp'>Buyer: Set Bid/Auto Bid</a> <a class="active"
			href='alert-page-buyer.jsp'>Buyer: Check Bid Alerts</a> <a
			class="active" href='logout.jsp'>Log out.</a>



	</div>
</head>
<body>
	<%
	if ((session.getAttribute("email") == null)) {
	%>
	You are not logged in.
	<br />
	<a href="login.jsp">Please Login.</a>
	<%
	} else {
	%>
	You are logged in.
	<br> Currently logged in:
	<%=session.getAttribute("email")%>
	<br> User_ID:
	<%=session.getAttribute("account_id")%>
	<br>


	<%
	}
	%>

</body>
</html>