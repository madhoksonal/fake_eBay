<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Alerts</title>
	</head>
	<body>
	<%	if ((session.getAttribute("email") == null)) { %>
		You are not logged in. <br/>
		<a href="login.jsp">Please Login.</a>
		<%} else {%>
		<h2> Wishlist </h2>
			<h3> Add model to wishlist for an alert! </h3>
				<form method="post" action="create-alert.jsp">
				<table>
				<tr>    
					<td>Model: </td><td><input type="text" name="model" value = "iMac"></td>
				</tr>	
			</table>
			<input type="submit" value="Create Alert">
		</form>
			<%
		}
		try {
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			Statement stmt = con.createStatement();
			String user_id = (String)session.getAttribute("account_id");
			
			String query = "SELECT * FROM Wishlist_Alert w, Product p JOIN Sells s USING (product_id) WHERE w.model = p.model AND w.account_id = " + user_id;
			ResultSet result = stmt.executeQuery(query);
			
			if (result.next()) {
		    	%>
		    	<h3> Matches found! </h3>
		    	<table>
		    	<tr>
		    		<td>Auction Id</td>
		    		<td>Wished For</td>
	    		</tr>
		    	<tr>
		    		<td><%= result.getString("s.auction_id") %></td>
		    		<td><%= result.getString("w.model") %></td>
		    		<td>
						<form method='post' action="auction-details.jsp">
							<input type="hidden" name="auction_id" value="<%= result.getString("auction_id") %>">
							<input type="submit" value="See Auction">
						</form>
					</td>
		    		
		    	</tr><%
	    	
			    while (result.next()) {  %>
			    	<tr>
			    		<td><%= result.getString("s.auction_id") %></td>
			    		<td><%= result.getString("w.model") %></td>
			    		<td>
							<form method='post' action="auction-details.jsp">
								<input type="hidden" name="auction_id" value="<%= result.getString("auction_id") %>">
								<input type="submit" value="See Auction">
							</form>
						</td>
					</tr>
		    	</table>
		    	
		<% 
		    	}
			 } else {
			    	con.close();
			    	%><h3> No matches to wishlist... :( </h3><%
			    	}
			
		con.close();	
		
		} catch (Exception ex) {
			out.print(ex);
			out.print("Error.");
		}
			%>
	
	
	
	</body>
</html>
