<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
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
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		Statement stmt = con.createStatement();

		//Get parameters
		String account_id = session.getAttribute("account_id").toString();
		String model = request.getParameter("model");
		
		//Make an insert statement for the Sells table:
		String insert = "INSERT INTO Wishlist_Alert(account_id, model) "
				+ "VALUES (?, ?)";
		
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, account_id);
		
		if (model == null){
			ps.setString(2, null);
		} else{
			ps.setString(2, model);
		}
		
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
