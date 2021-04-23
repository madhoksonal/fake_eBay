package operations;

import common.Auction_Bean;
import common.DB_Connection;
import common.Items_Bean;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class Read_Values {


    public static void main(String[] args) {
        Read_Values obj_Read_Values=new Read_Values();
    }

    public List get_items(){
        DB_Connection obj_DB_Connection=new DB_Connection();
        Connection connection=obj_DB_Connection.get_connection();
        PreparedStatement ps=null;
        ResultSet rs=null;
        List list=new ArrayList();
        try {
            String querry="select * from items WHERE delete_status=?";
            ps=connection.prepareStatement(querry);
            ps.setBoolean(1, false);
            rs=ps.executeQuery();
            while(rs.next()){
                Items_Bean items_bean =new Items_Bean();
                items_bean.setId(rs.getInt("id"));
                items_bean.setName(rs.getString("name"));
                items_bean.setRefno(rs.getString("refno"));
                items_bean.setStarting_price(rs.getInt("starting_price"));
                items_bean.setHidden_price(rs.getInt("hidden_price"));
                items_bean.setSold_status(rs.getBoolean("sold_status"));
                items_bean.setDeleteStatus(rs.getBoolean("delete_status"));
                list.add(items_bean);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    public List get_auctions(){
        DB_Connection obj_DB_Connection=new DB_Connection();
        Connection connection=obj_DB_Connection.get_connection();
        PreparedStatement ps=null;
        ResultSet rs=null;
        List list=new ArrayList();
        try {
            String querry="select * from auctions WHERE delete_status=?";
            ps=connection.prepareStatement(querry);
            ps.setBoolean(1, false);
            rs=ps.executeQuery();
            while(rs.next()){
                Auction_Bean auction_bean =new Auction_Bean();
                auction_bean.setId(rs.getInt("id"));
                auction_bean.setName(rs.getString("name"));
                auction_bean.setClosing_date(rs.getString("closing_date"));
                auction_bean.setDeleteStatus(rs.getBoolean("delete_status"));
                list.add(auction_bean);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }



}
