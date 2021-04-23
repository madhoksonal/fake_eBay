package common;




import java.sql.Connection;
import java.sql.DriverManager;

/*
*        Tables
*
*   user_equipments_relation
*
*   users
*
*   equipments
*
* */

public class DB_Connection  {

    private String staffs = "staffs";
    public static void main(String[] args) {
        DB_Connection obj_DB_Connection=new DB_Connection();
        System.out.println(obj_DB_Connection.get_connection());

    }
    public Connection get_connection(){
        Connection connection=null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/fakeEbay","root", "Chiki@98");
        } catch (Exception e) {
            System.out.println(e);
        }
        return connection;
    }

    public String getStaffs() {
        return staffs;
    }

    public void setStaffs(String users) {
        this.staffs = staffs;
    }

}