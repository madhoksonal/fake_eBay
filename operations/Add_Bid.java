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


@WebServlet("/Add_Bid")
public class Add_Bid extends HttpServlet {

    private Connection conn;
    private Statement stmt;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Edit_Values obj_edit_value =new Edit_Values();

        RequestDispatcher dispatcher = request.getRequestDispatcher("/login.jsp");  //

        String item_idd = request.getParameter("item_id");
        String bid_pricee = request.getParameter("bid_price");
        String hidden_pricee = request.getParameter("hidden_price");

        String buyer_id = request.getParameter("buyer_id");
        String item_name = request.getParameter("item_name");

        int item_id = Integer.parseInt(item_idd);
        int bid_price = Integer.parseInt(bid_pricee);
        int hidden_price = Integer.parseInt(hidden_pricee);


        Auction_Bean obj_auciton_Bean =new Auction_Bean();
        DB_Connection obj_DB_Connection = new DB_Connection();
        Connection connection = obj_DB_Connection.get_connection();
        PreparedStatement ps = null;
        boolean insertStatus = false;
        try {

            String query = "insert into item_bids(item_name,buyer_ref_no,bid_price,hidden_price,item_id) values(?,?,?,?,?)";
            ps = connection.prepareStatement(query);
            ps.setString(1,item_name);
            ps.setString(2, buyer_id);
            ps.setInt(3, bid_price);
            ps.setInt(4, hidden_price);
            ps.setInt(5, item_id);

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
            request.setAttribute("message_success",  " Bid add successfully "); //  message
        }else{
            request.setAttribute("status",  "error"); //  status
            request.setAttribute("message_error",  "  Bid not add successfully "); //  message
        }

            /*} catch (Exception e) {
                e.printStackTrace();
            }*/

        // response.sendRedirect("/technician/index.jsp");
        dispatcher = request.getRequestDispatcher("/bid_items.jsp");  //
        dispatcher.forward(request, response);

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        System.out.println("dpget");
        HttpSession session = request.getSession(true); // reuse existing // session if exist // or create one

        RequestDispatcher dispatcher = request.getRequestDispatcher("/bid_items.jsp");  //

        try {
            dispatcher = request.getRequestDispatcher("/bid_items.jsp");  //
            dispatcher.forward(request, response);
        }
        catch (Exception e){

            request.setAttribute("message"," Some Connection Error  occure please try again "); //  message
            // response.sendRedirect("/technician/index.jsp");
            dispatcher = request.getRequestDispatcher("/bid_items.jsp");  //
            dispatcher.forward(request, response);
        }
    }
}