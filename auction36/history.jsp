<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.SimpleDateFormat, java.util.Date"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Auction</title>
	</head>
	<body>
		<%
		if ((session.getAttribute("email") == null)) {
		%>
		You are not logged in. <br/>
		<a href="login.jsp">Please Login.</a>
		<%} else {
			try {

				//Get the database connection
				Class.forName("com.mysql.jdbc.Driver");
				ApplicationDB db = new ApplicationDB();	
				//Connection con = db.getConnection();
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fakeEbay","root", "D1am0nd4");

				//Create a SQL statement
				Statement stmt = con.createStatement();
				
				String user_id = (String)session.getAttribute("account_id");
				
				%>
				<h1>History of Auctions and Bids</h1>
				<p> This page contains all the auctions and bids that you have participated in, regardless if they are on-going or completed.</p>
				<h2>My Auctions</h2>
				<%
				String query1 = "SELECT * FROM Product p JOIN Sells s USING (product_id) WHERE s.account_id = " + user_id;
				
				ResultSet result = stmt.executeQuery(query1);
				
				if (result.next()) {
			    	%>
			    	<table>
			    	<tr>    
						<td>Auction Id</td>
						<td>Product</td>
					</tr>
					<tr>    
							<td><%= result.getString("s.auction_id") %></td>
							<td><%= result.getString("p.model") %></td>
							<td>
								<form method='post' action="auction-details.jsp">
									<input type="hidden" name="auction_id" value="<%= result.getString("s.auction_id") %>">
									<input type="submit" value="See Auction">
								</form>
							</td>
					</tr>
			    	<%
					//parse out the results
					
					while (result.next()) { %>
						<tr>    
							<td><%= result.getString("s.auction_id") %></td>
							<td><%= result.getString("p.model") %></td>
							<td>
								<form method='post' action="auction-details.jsp">
									<input type="hidden" name="auction_id" value="<%= result.getString("s.auction_id") %>">
									<input type="submit" value="See Auction">
								</form>
							</td>
					</tr>
					<% }
					//close the connection.
					//db.closeConnection(con);
					%>
				</table>
				<%	
			    } else {
			    	con.close();
			        out.println("No results.");
			    }
				%>
				<h2>My Bids</h2>
				<%
				Statement stmt2 = con.createStatement();
				
				String query2 = "SELECT * FROM Product p JOIN Buys b USING (product_id) WHERE b.account_id = " + user_id;
				
				result = stmt2.executeQuery(query2);
				if (result.next()) {
			    	%>
			    	<table>
			    	<tr>    
						<td>Auction Id</td>
						<td>Product</td>
						<td>My Bid</td>
					</tr>
					<tr>    
							<td><%= result.getString("b.auction_id") %></td>
							<td><%= result.getString("p.model") %></td>
							<td><%= result.getString("b.current_bid") %></td>
							<td>
								<form method='post' action="auction-details.jsp">
									<input type="hidden" name="auction_id" value="<%= result.getString("b.auction_id") %>">
									<input type="submit" value="See Auction">
								</form>
							</td>
					</tr>
			    	<%
					//parse out the results
					
					while (result.next()) { %>
						<tr>    
							<td><%= result.getString("b.auction_id") %></td>
							<td><%= result.getString("p.model") %></td>
							<td><%= result.getString("b.current_bid") %></td>
							<td>
								<form method='post' action="auction-details.jsp">
									<input type="hidden" name="auction_id" value="<%= result.getString("b.auction_id") %>">
									<input type="submit" value="See Auction">
								</form>
							</td>
					</tr>
					<% }
					%>
				</table>
				<%	
			    } else {
			    	con.close();
			        out.println("No results.");
			    }
				//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
				con.close();
				
			} catch (Exception ex) {
				out.print(ex);
				out.print("Error.");
			}
		}
		%>
	</body>
</html>