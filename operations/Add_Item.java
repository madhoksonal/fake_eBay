package operations;

import common.Auction_Bean;
import common.DB_Connection;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;



@WebServlet("/Add_Item")
public class Add_Item extends HttpServlet {

    private Connection conn;
    private Statement stmt;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(true); // reuse existing // session if exist // or create one

        Read_Values obj_Read_Values=new Read_Values();

        System.out.println("dopost");

        RequestDispatcher dispatcher = request.getRequestDispatcher("/login.jsp");  //
        // try {

        Integer user_id=(Integer)session.getAttribute("id");

        //String id=request.getParameter("id");
        String name = request.getParameter("name");
        String refno = request.getParameter("refno");
        String starting_price = request.getParameter("starting_price");
        String hidden_price = request.getParameter("hidden_price");
        String auctions_idd = request.getParameter("auctions_name");

        System.out.println("auctions_id: "+auctions_idd);

        int auctions_id = Integer.parseInt(auctions_idd);
        // end conversion
        /*Staff_Bean obj_staff_Bean=new Staff_Bean();
        Auction_Bean obj_auciton_Bean =new Auction_Bean();
        obj_auciton_Bean.setName(auction_name);
        obj_auciton_Bean.setClosing_date(closing_date);
*/
        Insert_Values obj_Insert_values = new Insert_Values();
        // boolean insertstatus = obj_Insert_values.addEquipment(obj_Equipment_Bean);

        DB_Connection obj_DB_Connection = new DB_Connection();
        Connection connection = obj_DB_Connection.get_connection();
        PreparedStatement ps = null;
        boolean insertStatus = false;
        try {

            String query = "insert into items (name,refno,starting_price, hidden_price,auction_id) values(?,?,?,?,?)";
            ps = connection.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, refno );
            ps.setString(3, starting_price );
            ps.setString(4, hidden_price );
            ps.setInt(5, auctions_id );

            int rs = ps.executeUpdate();
            System.out.print(" test ");
            if(rs>0) {
                insertStatus = true;
            }
            else{
                insertStatus = false;
                System.out.println("insert error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Got an exception!");
            System.err.println(e.getMessage());

            insertStatus = false;
            System.out.println("exception error");
        }

        if(insertStatus){
            request.setAttribute("status",  "success"); //  status
            request.setAttribute("message_success",  " Item add successfully "); //  message
        }else{
            request.setAttribute("status",  "error"); //  status
            request.setAttribute("message_error",  "  Item not add successfully "); //  message
        }

            /*} catch (Exception e) {
                e.printStackTrace();
            }*/

        // response.sendRedirect("/technician/index.jsp");
        dispatcher = request.getRequestDispatcher("/items.jsp");  //
        dispatcher.forward(request, response);

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        System.out.println("dpget");
        HttpSession session = request.getSession(true); // reuse existing // session if exist // or create one

        RequestDispatcher dispatcher = request.getRequestDispatcher("/items.jsp");  //

        try {
            dispatcher = request.getRequestDispatcher("/items.jsp");  //
            dispatcher.forward(request, response);
        }
        catch (Exception e){

            request.setAttribute("message"," Some Connection Error  occure please try again "); //  message
            // response.sendRedirect("/technician/index.jsp");
            dispatcher = request.getRequestDispatcher("/items.jsp");  //
            dispatcher.forward(request, response);
        }
    }
}