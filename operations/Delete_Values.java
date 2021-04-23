package operations;


import common.DB_Connection;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class Delete_Values {
    public void delete_value(int delete_id){
        DB_Connection obj_DB_Connection=new DB_Connection();
        Connection connection=obj_DB_Connection.get_connection();
        PreparedStatement ps=null;
        try {
            String querry="delete from staffs where id=?";
            ps=connection.prepareStatement(querry);
            ps.setInt(1, delete_id);;
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }
    public void delete_staff(int delete_id){
        DB_Connection obj_DB_Connection=new DB_Connection();
        Connection connection=obj_DB_Connection.get_connection();
        PreparedStatement ps=null;
        try {
            String querry="delete from staffs where id=?";
            ps=connection.prepareStatement(querry);
            ps.setInt(1, delete_id);;
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}
