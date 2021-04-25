<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.time.LocalDate"%>
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

		//Create a SQL statement
		Statement stmt = con.createStatement();

		String auction_id = request.getParameter("auction_id");

		String query = "SELECT * FROM Product p JOIN Sells s USING(product_id) WHERE auction_id = " + auction_id;

		ResultSet result = stmt.executeQuery(query);
		
		
		
	%>
	<h2>Auction Details</h2>
	<%
	if (result.next()) {
	%>
	<table>
		<tr>
			<td>Auction Id</td>
			<td><%=result.getString("s.auction_id")%></td>
		</tr>
		<tr>
			<td>Product Id</td>
			<td><%=result.getString("p.product_id")%></td>
		</tr>
		<tr>
			<td>Brand</td>
			<td><%=result.getString("p.brand")%></td>
		</tr>
		<tr>
			<td>Model</td>
			<td><%=result.getString("p.model")%></td>
		</tr>
		<tr>
			<td>Initial Price</td>
			<td><%=result.getString("s.initial_price")%></td>
		</tr>
		<tr>
			<td>OS</td>
			<td><%=result.getString("p.operating_system")%></td>
		</tr>
		<tr>
			<td>Screen Size</td>
			<td><%=result.getString("p.screen_size")%></td>
		</tr>
		<tr>
			<td>Condition</td>
			<td><%=result.getString("p.cond")%></td>
		</tr>
		<tr>
			<td>Category</td>
			<td><%=result.getString("p.category")%></td>
		</tr>
		<tr>
			<td>Start Date & Time</td>
			<td><%=result.getString("s.start_date")%> @ <%=result.getString("s.start_time")%></td>
		</tr>
		<tr>
			<td>End Date & Time</td>
			<td><%=result.getString("s.closing_date")%> @ <%=result.getString("s.closing_time")%></td>
		</tr>
		<tr>
			<td>Status</td>


			<%
			
			int secret_minimum = result.getInt("s.secret_minimum");
			///////////////////////////////////////////////////////////////////
			LocalDate today = LocalDate.now();
			String start_day = (String) result.getString("s.start_date");
			String close_day = (String) result.getString("s.closing_date");
			LocalDate start = LocalDate.parse(start_day);
			LocalDate close = LocalDate.parse(close_day);
			///////////////////////////////////////////////////////////////////
			Statement stmt5 = con.createStatement();

			String getMaxBid = "SELECT b.account_id, b.upper_bid_limit, MAX(b.current_bid) FROM Buys b WHERE auction_id ="
					+ auction_id;
			/////////////////////////////////////////////

			boolean status = today.isBefore(close) & today.isAfter(start);

			if (status == true) {
			%><td style="color: green;">ACTIVE</td>
		</tr>
		<%
		} else if (status == false) {
		%><td style="color: red;">CLOSED</td>
		</tr>
		<%
		/////////////////////////////////////////////////////
		%><tr>
			<td>Winner:</td>
			<%
			//checking for winner
		
			result = stmt5.executeQuery(getMaxBid);
					
			if (result.next()) {
			int maxBid = result.getInt("MAX(b.current_bid)");

			if (secret_minimum > maxBid) {
				//no one is winner
				%><td>No one is the winner.</td>
				</tr>
				<%
		} else if (secret_minimum < maxBid) {
				//alert the winner
				%><td>Winner Chosen! <%=result.getString("b.account_id")%></td>
				</tr>
				<%
		}
				else{
					%><td>Winner to be determined.</td>
					</tr>
					<%
			
		}

		}
		}
		%>
	</table>
	<%
	} else {
	con.close();
	out.println("Error retrieving auction details.");
	}
	%>
	<br>
	<form method='post' action="auction-details.jsp">
		<!-- Can send the auction_id somewhere -->
		<input type="hidden" name="auction_id"
			value="<%=result.getString("s.auction_id")%>"> <input
			type="submit" value="Place bid">
	</form>
	<br>
	<br>
	<b>Current Bids:</b>
	<%
	Statement stmt2 = con.createStatement();

	String history_query = "SELECT * FROM Buys b JOIN Sells s USING (auction_id) WHERE auction_id = " + auction_id
			+ " ORDER BY b.current_bid DESC";

	result = stmt2.executeQuery(history_query);

	if (result.next()) {
	%>
	<table>
		<tr>
			<td>Account ID</td>
			<td>Current Bid</td>
			<td>Upper Bid Limit</td>
		</tr>
		<tr>
			<td><%=result.getString("b.account_id")%></td>
			<td><%=result.getString("b.current_bid")%></td>
			<td><%=result.getString("b.upper_bid_limit")%></td>

		</tr>
		<%
		//parse out the results
		while (result.next()) {
		%>
		<tr>
			<td><%=result.getString("b.account_id")%></td>
			<td><%=result.getString("b.current_bid")%></td>
			<td><%=result.getString("b.upper_bid_limit")%></td>
		</tr>
		<%
		}
		//db.closeConnection(con);
		%>
	</table>
	<%
	} else {
	%>
	<br> No bids yet!
	<br>
	<%
	}
	%>
	<br>
	<b>Similar Auctions Within The Last Month:</b>
	<p>These auctions are based on similar Brands or similar Category.</p>
	<%
	String brand = "";
	String category = "";

	Statement stmt3 = con.createStatement();
	String query3 = "SELECT * FROM Product p JOIN Sells s USING(product_id) WHERE auction_id = " + auction_id;
	result = stmt.executeQuery(query3);
	if (result.next()) {
		brand = (String) result.getString("p.brand");
		category = (String) result.getString("p.category");
	} else {
		out.println("Error");
	}

	String this_month = LocalDate.now().toString();
	String last_month = LocalDate.now().minusMonths(1).toString();

	Statement stmt4 = con.createStatement();

	String template_query = "SELECT * FROM Sells s JOIN Product p USING (product_id) WHERE s.start_date < '" + last_month
			+ "' AND s.closing_date > '" + this_month + "'";

	String similar_brand = template_query + " AND p.brand = '" + brand + "'";
	String similar_category = template_query + " AND p.category = '" + category + "'";
	String similar_query = similar_brand + " UNION " + similar_category;
	result = stmt3.executeQuery(similar_query);

	if (result.next()) {
	%>
	<table>
		<tr>
			<td>Auction Id</td>
			<td>Brand</td>
			<td>Model</td>
			<td>Category</td>
		</tr>
		<tr>
			<td><%=result.getString("auction_id")%></td>
			<td><%=result.getString("brand")%></td>
			<td><%=result.getString("model")%></td>
			<td><%=result.getString("category")%></td>
			<td>
				<form method='post' action="auction-details.jsp">
					<input type="hidden" name="auction_id"
						value="<%=result.getString("auction_id")%>"> <input
						type="submit" value="See Auction">
				</form>
			</td>
		</tr>
		<%
		//parse out the results

		while (result.next()) {
		%>
		<tr>
			<td><%=result.getString("auction_id")%></td>
			<td><%=result.getString("brand")%></td>
			<td><%=result.getString("model")%></td>
			<td><%=result.getString("category")%></td>
			<td>
				<form method='post' action="auction-details.jsp">
					<input type="hidden" name="auction_id"
						value="<%=result.getString("auction_id")%>"> <input
						type="submit" value="See Auction">
				</form>
			</td>
		</tr>
		<%
		}
		%>
	</table>
	<%
	} else {
	con.close();
	out.println("No Similar Items");
	}

	con.close();
	} catch (Exception ex) {
	out.print(ex);
	out.print("Error.");
	}
	}
	%>
</body>
</html>