/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package clases;

import java.io.Console;
import java.io.File;
import java.io.FileInputStream;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLData;
import java.sql.Statement;
import java.time.LocalDate;
/**
 *
 * @author PC
 */
public class Usuario {
         public String nick;
        public String contrasenia; 
        public String nombre;
        public String appaterno;
        public String apmaterno;
        public String email;
        public String fechanac;
        public String fechacrea;
        public String img;
        public int userid;
        
        ConexionSQL con = new ConexionSQL();
        Connection cn;
        
        ResultSet rs;
        
        public Usuario(){
        }
        
        public int Registro(String RegNombre, String RegApP, String RegApM,
                String RegEmail, String RegFecha, String RegNick, String RegPw, String RegImg)
        {
            int res;
            try{
                con.getConnection();
                cn = con.conectar();
                Statement st=cn.createStatement();
                Statement stuser=cn.createStatement();
                Statement stemail=cn.createStatement();
                String insert = "insert into usuario(nombre,appaterno, apmaterno,fechanac,email,imagen,nusuario,contrasenia) VALUES('"
                        +RegNombre+"','"+RegApP+"','"+RegApM+"','"+RegFecha+"','"+RegEmail+"','"+RegImg+"','"+RegNick+"','"+RegPw+"');";
                //String state = "INSERT INTO usuario(Nombre, ApellidoPaterno, ApellidoMaterno, Correo, NombreUsuario,Contrasena,FechaNacimiento) values ('" + Nombre + "','" + ApellidoP + "','" + ApellidoM + "','" + Correo + "','" + Usuario + "','" + Contraseña + "','" + Fecha + "');";
                ResultSet rs2= stuser.executeQuery("Select * from usuario where nusuario = '"+RegNick+"';");
                ResultSet rs3= stemail.executeQuery("Select * from usuario where email = '"+RegEmail+"';");
                if(rs2.next()){
                    return 2;
                }
                if(rs3.next()){
                    return 3;
                }
               /*ps.setString(9, java.time.LocalDate.now().toString());*/
                res = st.executeUpdate("insert into usuario(nombre,appaterno, apmaterno,fechanac,email,imagen,nusuario,contrasenia, fechacrea, estatusid) VALUES('"
                        +RegNombre+"','"+RegApP+"','"+RegApM+"','"+RegFecha+"','"+RegEmail+"','"+RegImg+"','"+RegNick+"','"+RegPw+"',CURDATE(), 1);");
                if (res!=0) {
                    con.desconectar();
                    return 1;
                }
            }catch(Exception e)
            {
                 System.out.println("Error : " + e);
                con.desconectar();
                return 6;
            }
             System.out.println("Error no se inserto en la DB");
            return 6;
        }
        
        public boolean login(String nickname, String password)
        {
            try{
           
             con.getConnection();
             cn = con.conectar();
            Statement st=cn.createStatement();
                String query ="Select * from usuario where BINARY nusuario = '"+nickname+"' AND BINARY contrasenia = '"+password+"';";
                //String state = "INSERT INTO usuario(Nombre, ApellidoPaterno, ApellidoMaterno, Correo, NombreUsuario,Contrasena,FechaNacimiento) values ('" + Nombre + "','" + ApellidoP + "','" + ApellidoM + "','" + Correo + "','" + Usuario + "','" + Contraseña + "','" + Fecha + "');";
                rs = st.executeQuery(query);
                if (rs.next()) {
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
           
            return false;
            }
        }
    
        public boolean login2(String nickname, String password)
        {
            try{
           
             con.getConnection();
             cn = con.conectar();
            CallableStatement cs=cn.prepareCall("{call sp_usuario(?,?,?,?,?,?,?,?,?,?)}");
                cs.setString(1, "l");
                cs.setInt(2, 0);
                cs.setString(3, "");
                cs.setString(4, "");
                cs.setString(5, "");
                cs.setString(6, "");
                cs.setString(7, "");
                cs.setString(8, "");
                cs.setString(9, nickname);
                cs.setString(10, password);
                cs.execute();
                rs = cs.getResultSet();
                if (rs.next()) {
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
           
            return false;
            }
        }
}