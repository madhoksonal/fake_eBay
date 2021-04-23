package operations;

import common.DB_Connection;

import java.sql.Connection;
import java.sql.PreparedStatement;


public class Insert_Values {

    public Insert_Values() {
    }

    public void insert_values(String fullname, String username, String password) {
        DB_Connection obj_DB_Connection = new DB_Connection();
        Connection connection = obj_DB_Connection.get_connection();
        PreparedStatement ps = null;
        try {
            String query = "insert into users(fullname,username,password) values(?,?,?)";
            ps = connection.prepareStatement(query);
            ps.setString(1, fullname);
            ps.setString(2, username);
            ps.setString(3, password);
            ps.executeUpdate();
        } catch (Exception e) {
            System.err.println(e);
        }
    }


}