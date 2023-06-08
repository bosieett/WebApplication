
package clases;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.time.LocalDateTime;    

public class ConexionSQL {
    
    String url = "jdbc:mysql://localhost:3306/";
    String db = "pw_pia_db";
    String user = "root";
    String pass = "sahejo10";
    String driver = "com.mysql.jdbc.Driver";
    
    Connection con;
    
    public ConexionSQL (){}
    
    public Connection conectar () throws ClassNotFoundException{
        try {
            Class.forName(driver);
            con = DriverManager.getConnection(url+db, user, pass);
        } catch (SQLException ex) {
            Logger.getLogger(ConexionSQL.class.getName()).log(Level.SEVERE, null, ex);
        }
        return con;
    }
    
    public void desconectar() {
        try {
            con.close();
        } catch (SQLException ex) {
            Logger.getLogger(ConexionSQL.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    public Connection getConnection(){
        return con;
    }
}