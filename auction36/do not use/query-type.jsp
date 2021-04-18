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

				//Get the database connection
				Class.forName("com.mysql.jdbc.Driver");
				ApplicationDB db = new ApplicationDB();	
				//Connection con = db.getConnection();
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fakeEbay","root", "D1am0nd4");
				
				//HttpSession session = request.getSession();

				//Create a SQL statement
				Statement stmt = con.createStatement();
				String type = request.getParameter("type");
				
				String arg = " ";
				
				if (type.equals("Laptop")){
					arg = "isLaptop";
				} else if (type.equals("Desktop")){
					arg = "isDesktop";
				} else if (type.equals("Tablet")){
					arg = "isTablet";
				}
				
				//String option = request.getParameter("command");
				
				String query = "SELECT * FROM AuctionEvent a, Product p WHERE a.product_id = p.product_id AND p." + arg + " = 1";			 
				//String str = "SELECT * FROM AuctionEvent a, Product p WHERE a.product_id = p.product_id";

				ResultSet result = stmt.executeQuery(query);
				%>
				
				
				<table>
				<tr>    
					<td>Product Id</td>
					<td>Product Model</td>
					<td>Product Brand</td>
				</tr>
					<%
					//parse out the results
					while (result.next()) { %>
						<tr>    
							<td><%= result.getString("a.product_id") %></td>
							<td><%= result.getString("p.model") %></td>
							<td><%= result.getString("p.brand") %></td>
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
