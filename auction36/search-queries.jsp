<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Search Results</title>
	</head>
	<body>
		<%
		if ((session.getAttribute("email") == null)) {
		%>
		You are not logged in. <br/>
		<a href="auction-login.jsp">Please Login.</a>
		<%} else {
			try {
				Class.forName("com.mysql.jdbc.Driver");
				ApplicationDB db = new ApplicationDB();	
				//Connection con = db.getConnection();
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fakeEbay","root", "D1am0nd4");

				//Create a SQL statement
				Statement stmt = con.createStatement();
				String command = request.getParameter("command");
				String text_search = request.getParameter("text_search");
				String price = request.getParameter("price_search");
				String size = request.getParameter("screen_search");
				String condition = request.getParameter("condition");
				String type = request.getParameter("type");
				String sorting = request.getParameter("sort_by");
				
				String query = " ";
				
				if (text_search != null){
					if (sorting != null){
						query = "SELECT * FROM Sells s, Product p WHERE s.product_id = p.product_id and p." + command + " LIKE '"+ text_search +"' ORDER BY " + command + " " + sorting;
					}else{
						query = "SELECT * FROM Sells s, Product p WHERE s.product_id = p.product_id and p." + command + " LIKE '"+ text_search +"'";
					}
				} else if (price != null){
					if (command.equals("max")){
						query = "SELECT * FROM Sells s, Product p WHERE s.product_id = p.product_id and s.initial_price < " + price;				
					} else if (command.equals("min")) {
						query = "SELECT * FROM Sells s, Product p WHERE s.product_id = p.product_id and s.initial_price >= " + price;
					}
					if (sorting != null){
						query = query + " ORDER BY s.initial_price " + sorting;
					}
					
				} else if (size != null){
					if (command.equals("max")){
						query = "SELECT * FROM Sells s, Product p WHERE s.product_id = p.product_id and p.screen_size < " + size;				
					} else if (command.equals("min")) {
						query = "SELECT * FROM Sells s, Product p WHERE s.product_id = p.product_id and p.screen_size = " + size;
					}
					if (sorting != null){
						query = query + " ORDER BY p.screen_size " + sorting;
					}
				} else if (condition != null){
					query = "SELECT * FROM Sells s, Product p WHERE s.product_id = p.product_id and p.condition =  '"+ condition +"'";
				} else if (type != null){
					String arg = " ";
					
					if (type.equals("Laptop")){
						arg = "isLaptop";
					} else if (type.equals("Desktop")){
						arg = "isDesktop";
					} else if (type.equals("Tablet")){
						arg = "isTablet";
					}
					query = "SELECT * FROM Sells s, Product p WHERE s.product_id = p.product_id AND p." + arg + " = 1";
				}

				ResultSet result = stmt.executeQuery(query);
				
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
				out.print("Error.");
			}
		}
		%>
			
	</body>
</html>
