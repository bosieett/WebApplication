/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package clases;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 *
 * @author PC
 */
public class Publicacion {
        public String usuario;
        public String titulo; 
        public String texto;
        public String imagen;
        
        ConexionSQL con = new ConexionSQL();
        Connection cn;
        
        ResultSet rs;
        
        public Publicacion(){
        }
        
        public boolean Alta(String p_titulo, String p_texto, String p_imagen,
                int p_userid, int p_catid)
        {
            try{
                con.getConnection();
                cn = con.conectar();
                CallableStatement cs= cn.prepareCall("{call sp_publicacion(?,?,?,?,?,?,?)}");
                cs.setString(1, "i");
                cs.setString(2, "");
                cs.setString(3, p_titulo);
                cs.setString(4, p_texto);
                cs.setString(5, p_imagen);
                cs.setInt(6, p_userid);
                cs.setInt(7, p_catid);
                
                cs.execute();
                
                ResultSet res = cs.getResultSet();
                if (res.next()) {
                    con.desconectar();
                    return true;
                }
                else{
                    con.desconectar();
                    return false;
                }
            }catch(Exception e)
            {
                 System.out.println("Error : " + e);
                con.desconectar();
            }
             System.out.println("Error no se inserto en la DB");
            return false;
        }
        
        public boolean Baja(String idPubli)//solo deberá ser baja logica
        {
            return false;
        }
    
}
