<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Checking login...</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		Class.forName("com.mysql.jdbc.Driver");
		ApplicationDB db = new ApplicationDB();	
		//Connection con = db.getConnection();
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fakeEbay","root", "D1am0nd4");
		
		//HttpSession session = request.getSession();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the HelloWorld.jsp
		String thisEmail = request.getParameter("email");
		String thisPW = request.getParameter("password");

	    Statement st = con.createStatement();
	    ResultSet rs;
	    rs = st.executeQuery("select * from customerRep where email='" + thisEmail + "' and password='" + thisPW + "'");
	    if (rs.next()) {
	        session.setAttribute("email", thisEmail); // the username will be stored in the session
	        out.println("Welcome " + thisEmail);
			else {
				out.println("Successfully logged in!");
				break;
			}
	    } else {
	    	con.close();
	        out.println("Invalid log-in. <a href='auction-login.jsp'>Try again.</a>");
	    }
	%>
		
	
	<form action="custRep/browse-qna.jsp">
		<input type="submit" value="Browse QnA"/>
	</form>
	<form action="sales-report.jsp">
		<input type="submit" value="Search Keyword in Questions"/>
	</form>
	<form action="sales-report.jsp">
		<input type="submit" value="Edit account information"/>
	</form>
	<form action="sales-report.jsp">
		<input type="submit" value="Remove bids"/>
	</form>
	<form action="sales-report.jsp">
		<input type="submit" value="Remove auctions"/>
	</form>
		
		<a href="auction-login.jsp">Auction Login</a>
		<a href="logout.jsp">Logout</a>

	%<
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Could not login.");
	}
%>

	
</body>
</html>
