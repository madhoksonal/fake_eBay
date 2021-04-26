<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.time.LocalDate"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Buyer Alert Page</title>
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

<h2>Buyer's Alert Page</h2>
	<%
	if ((session.getAttribute("email") == null)) {
	%>
	You are not logged in.
	<br />
	<a href="login.jsp">Please Login.</a>
	<%
	} else {
	try {

		//Get the database connection
		Class.forName("com.mysql.jdbc.Driver");
		ApplicationDB db = new ApplicationDB();
		//Connection con = db.getConnection();
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fakeEbay", "root", "root");
		
		String auction_id = request.getParameter("auction_id");

		//get email for session 
		String email = (String) session.getAttribute("email");
	
		String getBuysTable = "SELECT * FROM Buys b WHERE b.account_id = (SELECT e.account_id FROM endUser e WHERE e.email = '" + email + "')";
		Statement stmt = con.createStatement();
		ResultSet result = stmt.executeQuery(getBuysTable);

		result = stmt.executeQuery(getBuysTable);

		if (result.next()) {
			
		%>
		
		
		<table>
			<tr>
				<td>Auction ID</td>
				<td>Upper Bid Limit Reached:</td>
				
			</tr>
			<tr>
				<td><%=result.getString("b.auction_id")%></td>
				<td><% if (result.getInt("b.upper_limit_reached") == 1) { %> True 
				<% } else if (result.getInt("b.upper_limit_reached") == 0) { %> False <% } %>  </td>
			
			</tr>
			<% 

				while (result.next()) {
				%>
			<tr>
			<td><%=result.getString("b.auction_id")%></td>
			<td><% if (result.getInt("b.upper_limit_reached") == 1) { %> True 
				<% } else if (result.getInt("b.upper_limit_reached") == 0) { %> False <% } %>  </td>
			</tr>
			<%
			}
				%>
			</table>
	
			<%
			

		} 
		
		else {
			out.println("No alerts yet.");
		}
	}
	
	
	catch (Exception ex) {
		out.println(ex);
		out.println("No Alerts to be seen.");
	}
	}
	
	%>
	</body>
	</html>	


		