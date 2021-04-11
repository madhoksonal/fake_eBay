<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>eBay but not eBay</title>
<style>
body {
  margin: 0;
  font-family: Arial, Helvetica, sans-serif;
}

.topnav {
  overflow: hidden;
  background-color: #333;
}

.topnav a {
  float: left;
  color: #f2f2f2;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
  font-size: 17px;
}

.topnav a:hover {
  background-color: #ddd;
  color: black;
}

.topnav a.active {
  background-color: #4CAF50;
  color: white;
}
</style>
</head>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<body>

<div class="topnav">
  <a class="active" href="#home">Create Account/Log In</a>
  <a href="buyer-set-upper-bid.jsp">Buyer</a>
  <a href="#contact">Seller</a>
  <a href="logout.jsp">Log Out</a>
</div>

<div style="padding-left:16px">
  <h2>Welcome to eBuy - your friendly neighborhood eBay!</h2>
  <p></p>
</div>

	Log In
		<br>
		<form method="post" action="check-account-login.jsp">
			<table>
				<tr>    
					<td>E-mail</td><td><input type="text" name="email"></td>
				</tr>
				<tr>
					<td>Password</td><td><input type="text" name="password"></td>
				</tr>
			
			</table>
			<input type="submit" value="Sign in">
		</form>
		<br>
	
	Create New Account
	<br>
		<form method="post" action="account-creation.jsp">
			<table>
				<tr>    
					<td>Username</td><td><input type="text" name="username"></td>
				</tr>
				<tr>    
					<td>E-mail</td><td><input type="text" name="email"></td>
				</tr>
				<tr>
					<td>Password</td><td><input type="text" name="password"></td>
				</tr>
			
			</table>
			<input type="submit" value="Create Account">
		</form>
	<br>
	
	<hr class="dashed">
		Admin Login:
		<br>
			<form method="post" action="check-admin-login.jsp">
			
			<table> 
				<tr>    
					<td>E-mail</td><td><input type="text" name="email"></td>
				</tr>
				<tr>
					<td>Password</td><td><input type="text" name="password"></td>
				</tr>

			</table>
				<input type="submit" value="Login">
			</form>
		<br>
		
		Customer Rep Login:
		<br>
			<form method="post" action="check-rep-login.jsp">
			
			<table> 
				<tr>    
					<td>E-mail</td><td><input type="text" name="email"></td>
				</tr>
				<tr>
					<td>Password</td><td><input type="text" name="password"></td>
				</tr>

			</table>
				<input type="submit" value="Login">
			</form>
		<br>
		
		
		<%
		Class.forName("com.mysql.jdbc.Driver");
		ApplicationDB db = new ApplicationDB();	
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fakeEbay", "root", "root");
/*

// insert code for SQL statements to set upper limit bid 
//get the upper limit bid from the endUserAccount who is corresponded to the auction event 

try {

		//Get the database connection
		Class.forName("com.mysql.jdbc.Driver");
		ApplicationDB db = new ApplicationDB();	
		//Connection con = db.getConnection();
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fakeEbay?autoReconnect=true&useSSL=false", "root", "root");
		
		//HttpSession session = request.getSession();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the HelloWorld.jsp
		String upperBidLimit = request.getParameter("upperLimit");
		//String thisPW = request.getParameter("password");

		
	    Statement st = con.createStatement();
	    ResultSet rs;
	    rs = st.executeQuery("select * from Product where email='" + thisEmail + "' and password='" + thisPW + "'");
	    if (rs.next()) {
	        session.setAttribute("email", thisEmail); // the username will be stored in the session
	        //out.println("Welcome " + thisEmail);
	        con.close();
	        //out.println("<a href='logout.jsp'>Log out</a>");
	        response.sendRedirect("webpage.jsp");
	    } else {
	    	con.close();
	        out.println("Invalid log-in. <a href='auction-login.jsp'>Try again.</a>");
	    }
	    
	
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		//con.close();
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Could not login.");
	}
*/





// insert code for SQL statement to check the id for the item and then check the max of bid price for that id 
	//if it is a higher bid, increment the buyer's bid until his maximum upper limit 
	
	
	
// insert code for if a new bid is higher than previous bid & that previous bidder had an upper limit of x & the new bidder has chosen a number 
// that is x + 1, then 
			// send an alert button to the previous bidder 
				

//insert code for (if time == closingTime , then check if seller has reserve (get from SQL DB))
	//if true: reserve is higher than the last bid --> no one wins
	//if false: whoever has the higher bid is the winner (MAX of bids for that item) --> alert them with javascript alert 
	
	

%>
		
		

</body> 
<script>
   var pressedButton = document.getElementsByTagName("button")[0];
   pressedButton.addEventListener("click", function (event) {
      alert("You have pressed the button..........")
   })
   
   
</script>
</html>


