<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create Alert</title>
</head>
<body>
	<%
	try {
		Class.forName("com.mysql.jdbc.Driver");
		ApplicationDB db = new ApplicationDB();
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fakeEbay","root", "D1am0nd4");

		//Create a SQL statement
		Statement stmt = con.createStatement();
		Statement get_ID = con.createStatement();
		Statement get_account_ID = con.createStatement();

		//Get parameters
		String email = session.getAttribute("email").toString();
		String account_id = " ";
			String account_query = "SELECT account_ID FROM endUser WHERE email = '" + email +"'";
			ResultSet acc_id = get_ID.executeQuery(account_query);
		account_id = acc_id.getString("account_ID");
		out.println(account_id);
		
		String brand = request.getParameter("brand");
		String model = request.getParameter("model");
		String os = request.getParameter("os");
		String screen = request.getParameter("screen");
		String condition = request.getParameter("condition");
		String category = request.getParameter("category");
		
		String new_alert_ID = " ";
			String id_query = "SELECT MAX(alert_id) FROM endUser";
			ResultSet max_alert_ID = get_account_ID.executeQuery(id_query);
			new_alert_ID = max_alert_ID.getString("alert_id");
			Integer temp_int = Integer.parseInt(new_alert_ID) + 1;
			new_alert_ID = temp_int.toString();
			
			out.println(new_alert_ID);
			
		
		//Make an insert statement for the Sells table:
		String insert = "INSERT INTO Wishlist_Alert(account_id, alert_id, brand, model, operating_system, screen_size, condition, category)"
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, account_id);
		ps.setString(2, new_alert_ID);
		ps.setString(3, brand);
		ps.setString(4, model);
		ps.setString(5, os);
		ps.setString(6, screen);
		ps.setString(7, condition);
		ps.setString(8, category);
		
		//Run the query against the DB
		ps.executeUpdate();

		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();

		out.print("Alert created!");
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Alert could not be created.");
	}
%>
</body>
</html>
