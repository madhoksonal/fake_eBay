<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Browse QnA</title>
</head>
<body>
    Hello
	<%
	try {
        
		//Get the database connection
		Class.forName("com.mysql.jdbc.Driver"); 
		ApplicationDB db = new ApplicationDB();	
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fakeEbay", "root", "beetroot");

        Statement st = con.createStatement();
	    ResultSet rs;
	    rs = st.executeQuery("select * from question_answer");
	   %>
        <table>
            <tr>
            <th>Question ID</th>
            <th>Question</th>
            <th>Answer</th>
            <th>User ID</th>
            <th>Rep ID</th>
            </tr>
            <% while(rs.next()){ %>
            <tr>
             <td> <%= rs.getString("question_id") %></td>
             <td> <%= rs.getString("question") %></td>
             <td> <%= rs.getString("answer") %></td>
             <td> <%= rs.getString("user_account_id") %></td>
             <td> <%= rs.getString("rep_account_id") %></td>
             </tr>
             <% } %>
        </table>
		%<


		//close the connection.
            rs.close();
            st.close();
			con.close();
	} catch (Exception e) {
	out.print(e);
	out.print("Could not login.");
	}
    finally{
        out.println("");
    }
    %>

</body>
</html>


  