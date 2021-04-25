<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.time.LocalDate"%>
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
		<a href="login.jsp">Please Login.</a>
		<%} else {
			try {

				//Get the database connection
				ApplicationDB db = new ApplicationDB();
				Connection con = db.getConnection();

				//Create a SQL statement
				Statement stmt = con.createStatement();
				
				
				String str = "SELECT * FROM Sells s, Product p WHERE s.product_id = p.product_id";

				ResultSet result = stmt.executeQuery(str);
				
				if (result.next()) {
			    	%>
			    	<table>
			    	<tr>    
						<td>Auction Id</td>
						<td>Product Id</td>
						<td>Brand</td>
						<td>Model</td>
						<td>Initial Price</td>
						<td>OS</td>
						<td>Screen Size</td>
						<td>Condition</td>
						<td>Category</td>
						<td>Status</td>
					</tr>
					<tr>    
							<td><%= result.getString("s.auction_id") %></td>
							<td><%= result.getString("s.product_id") %></td>
							<td><%= result.getString("p.brand") %></td>
							<td><%= result.getString("p.model") %></td>
							<td><%= result.getString("s.initial_price") %></td>
							<td><%= result.getString("p.operating_system") %></td>
							<td><%= result.getString("p.screen_size") %></td>
							<td><%= result.getString("p.cond") %></td>
							<td><%= result.getString("p.category") %></td>
							<%
							LocalDate today = LocalDate.now();
					    	String start_day = (String)result.getString("s.start_date");
					    	String close_day = (String)result.getString("s.closing_date");
					    	LocalDate start = LocalDate.parse(start_day);
					    	LocalDate close = LocalDate.parse(close_day);
					    	
					    	boolean status = today.isBefore(close) & today.isAfter(start);
			    	
					    	if (status == true){
					    		%><td style = "color:green;"> ACTIVE </td>
						    	<%
					    		
					    	} else if (status == false){
					    		%><td style = "color:red;"> CLOSED </td>
						    	<%
					    		
					    	}
					%>
							<!--  <td><a href= 'auction-details.jsp'> See auction</a></td>-->
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
							<td><%= result.getString("s.product_id") %></td>
							<td><%= result.getString("p.brand") %></td>
							<td><%= result.getString("p.model") %></td>
							<td><%= result.getString("s.initial_price") %></td>
							<td><%= result.getString("p.operating_system") %></td>
							<td><%= result.getString("p.screen_size") %></td>
							<td><%= result.getString("p.cond") %></td>
							<td><%= result.getString("p.category") %></td>
					
			    	<%
			    	
			    	 start_day = (String)result.getString("s.start_date");
			    	 close_day = (String)result.getString("s.closing_date");
			    	 start = LocalDate.parse(start_day);
			    	 close = LocalDate.parse(close_day);
			    	
			    	 status = today.isBefore(close) & today.isAfter(start);
			    	
			    	if (status == true){
			    		%><td style = "color:green;"> ACTIVE </td>
				    	<%
			    		
			    	} else if (status == false){
			    		%><td style = "color:red;"> CLOSED </td>
				    	<%
			    		
			    	}
					%>
							<!--  <td><a href= 'auction-details.jsp'> See auction</a></td>-->
							<td>
								<form method='post' action="auction-details.jsp">
									<input type="hidden" name="auction_id" value="<%= result.getString("s.auction_id") %>">
									<input type="submit" value="See Auction">
								</form>
							</td>
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
				out.print("Error.");
			}
		}
		%>
			
	</body>
</html>
