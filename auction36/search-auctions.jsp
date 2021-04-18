<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>All Auctions</title>
	</head>
	<body>
		<%
		if ((session.getAttribute("email") == null)) {
		%>
		You are not logged in. <br/>
		<a href="auction-login.jsp">Please Login.</a>
		<%} else {
			try {

				//Get the database connection
				Class.forName("com.mysql.jdbc.Driver");
				ApplicationDB db = new ApplicationDB();	
				//Connection con = db.getConnection();
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fakeEbay","root", "D1am0nd4");
				
				//HttpSession session = request.getSession();

				//Create a SQL statement
				Statement stmt = con.createStatement();
				String command = request.getParameter("command");
				String id = request.getParameter("id");
				
				String str = " ";
				
				
				if (command.equals("all")){
					str = "SELECT * FROM Sells s, Product p WHERE s.product_id = p.product_id";
				} else if (command.equals("auction_ID")){
					str = "SELECT * FROM Sells s, Product p WHERE s.product_id = p.product_id and s.auction_ID = " + id;
				} else if (command.equals("seller_ID")){
					str = "SELECT * FROM Sells s, Product p WHERE s.product_id = p.product_id and s.account_ID = " + id;
				} else if (command.equals("buyer_ID")){
					str = "SELECT * FROM Buys b, Product p WHERE b.product_id = p.product_id and b.auction_ID = " + id;
				}
				
				
				ResultSet result = stmt.executeQuery(str);
				
				if (result.next()) {
			    	%>
			    	<table>
			    	<tr>    
						<td>Auction Id</td>
						<td>Product Id</td>
						<td>Product Model</td>
						<td>Product Brand</td>
						<td>Initial Price</td>
						<td>Screen Size</td>
					</tr>
					<tr>    
							<td><%= result.getString("s.auction_id") %></td>
							<td><%= result.getString("s.product_id") %></td>
							<td><%= result.getString("p.model") %></td>
							<td><%= result.getString("p.brand") %></td>
							<td><%= result.getString("s.initial_price") %></td>
							<td><%= result.getString("p.screen_size") %></td>
							<td><a href= 'webpage.jsp'> More Info</a></td>
							<td><a href= 'webpage.jsp'> See Current Bids</a></td>
							<td><a href= 'webpage.jsp'> Place Bid</a></td>
					</tr>
			    	<%
					//parse out the results
					
					while (result.next()) { %>
						<tr>    
							<td><%= result.getString("s.auction_id") %></td>
							<td><%= result.getString("s.product_id") %></td>
							<td><%= result.getString("p.model") %></td>
							<td><%= result.getString("p.brand") %></td>
							<td><%= result.getString("s.initial_price") %></td>
							<td><%= result.getString("p.screen_size") %></td>
							<td><a href= 'webpage.jsp'> More Info</a></td>
							<td><a href= 'webpage.jsp'> See Current Bids</a></td>
							<td><a href= 'webpage.jsp'> Place Bid</a></td>
						</tr>
					<% }
					//close the connection.
					db.closeConnection(con);
					%>
				</table>
				<%	
			    } else {
			    	con.close();
			        out.println("No results.");
			    }
				%>
			<%	
				//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
				con.close();
				
			} catch (Exception ex) {
				out.print(ex);
				out.print("Could not login.");
			}
		}
		%>
			
	</body>
</html>
