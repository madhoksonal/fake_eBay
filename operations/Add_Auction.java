package operations;

import common.DB_Connection;

import common.Auction_Bean;

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




@WebServlet("/Add_Auction")
public class Add_Auction extends HttpServlet {

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
        String auction_name = request.getParameter("auction_name");
        String closing_date = request.getParameter("closing_date");

        // end conversion

        Auction_Bean obj_auciton_Bean =new Auction_Bean();
        obj_auciton_Bean.setName(auction_name);
        obj_auciton_Bean.setClosing_date(closing_date);

        Insert_Values obj_Insert_values = new Insert_Values();
        // boolean insertstatus = obj_Insert_values.addEquipment(obj_Equipment_Bean);

        DB_Connection obj_DB_Connection = new DB_Connection();
        Connection connection = obj_DB_Connection.get_connection();
        PreparedStatement ps = null;
        boolean insertStatus = false;
        try {

            String query = "insert into auctions(name,closing_date) values(?,?)";
            ps = connection.prepareStatement(query);
            ps.setString(1,obj_auciton_Bean.getName() );
            ps.setString(2,obj_auciton_Bean.getClosing_date() );

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
            request.setAttribute("message_success",  " Auction add successfully "); //  message
        }else{
            request.setAttribute("status",  "error"); //  status
            request.setAttribute("message_error",  "  Auction not add successfully "); //  message
        }

            /*} catch (Exception e) {
                e.printStackTrace();
            }*/

        // response.sendRedirect("/technician/index.jsp");
        dispatcher = request.getRequestDispatcher("/auctions.jsp");  //
        dispatcher.forward(request, response);

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        System.out.println("dpget");
        HttpSession session = request.getSession(true); // reuse existing // session if exist // or create one

        RequestDispatcher dispatcher = request.getRequestDispatcher("/auctions.jsp");  //

        try {
            dispatcher = request.getRequestDispatcher("/auctions.jsp");  //
            dispatcher.forward(request, response);
        }
        catch (Exception e){

            request.setAttribute("message"," Some Connection Error  occure please try again "); //  message
            // response.sendRedirect("/technician/index.jsp");
            dispatcher = request.getRequestDispatcher("/auctions.jsp");  //
            dispatcher.forward(request, response);
        }
    }
}