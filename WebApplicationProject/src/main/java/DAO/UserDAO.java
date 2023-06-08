/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import clases.ConexionSQL;
import jakarta.servlet.http.HttpSession;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.logging.Logger;

/**
 *
 * @author PC
 */
public class UserDAO {
        private String nick;
        private String contrasenia; 
        private String nombre;
        private String appaterno;
        private String apmaterno;
        private String email;
        private String fechanac;
        private String fechacrea;
        private String img;
        private String userid;
        
        ConexionSQL con = new ConexionSQL();
        Connection cn;
        
        ResultSet rs;
    
    public UserDAO() {
        nick="";
        contrasenia="";
        nombre="";
        appaterno="";
        apmaterno="";
        email="";
        fechanac="";
        fechacrea="";
        img="";
        userid="";
    }

    public String getNick() {
        return nick;
    }

    public String getContrasenia() {
        return contrasenia;
    }

    public String getNombre() {
        return nombre;
    }

    public String getAppaterno() {
        return appaterno;
    }

    public String getApmaterno() {
        return apmaterno;
    }

    public String getEmail() {
        return email;
    }

    public String getFechanac() {
        return fechanac;
    }

    public String getFechacrea() {
        return fechacrea;
    }

    public String getImg() {
        return img;
    }

    public String getUserid() {
        return userid;
    }

    public void setNick(String nick) {
        this.nick = nick;
    }

    public void setContrasenia(String contrasenia) {
        this.contrasenia = contrasenia;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setAppaterno(String appaterno) {
        this.appaterno = appaterno;
    }

    public void setApmaterno(String apmaterno) {
        this.apmaterno = apmaterno;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setFechanac(String fechanac) {
        this.fechanac = fechanac;
    }

    public void setFechacrea(String fechacrea) {
        this.fechacrea = fechacrea;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }
    
    public int Registro(String RegNombre, String RegApP, String RegApM,
                String RegEmail, String RegFecha, String RegNick, String RegPw, String RegImg)
        {
            int res;
            try{
                con.getConnection();
                cn = con.conectar();
                CallableStatement st=cn.prepareCall("{call sp_usuario(?,?,?,?,?,?,?,?,?,?)}");
                CallableStatement stuser=cn.prepareCall("{call sp_usuario('v',NULL,NULL,NULL,NULL,NULL,NULL,NULL,?,NULL)}");
                CallableStatement stemail=cn.prepareCall("{call sp_usuario('b',NULL,NULL,NULL,NULL,NULL,?,NULL,NULL,NULL)}");
                st.setString(1, "r");
                st.setNull(2, java.sql.Types.NULL);
                st.setString(3, RegNombre);
                st.setString(4, RegApP);
                st.setString(5, RegApM);
                st.setString(6, RegFecha);
                st.setString(7, RegEmail);
                st.setString(8, RegImg);
                st.setString(9, RegNick);
                st.setString(10, RegPw);
                
                stuser.setString(1, RegNick);
                
                stemail.setString(1, RegEmail);
                
                stuser.execute();
                ResultSet rs2= stuser.getResultSet();
                if(rs2.next()){
                    return 2;
                }
                stemail.execute();
                ResultSet rs3= stemail.getResultSet();
                if(rs3.next()){
                    return 3;
                }
                st.execute();
                res = st.getUpdateCount();
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
                cs.setNull(2, java.sql.Types.NULL);
                cs.setNull(3, java.sql.Types.NULL);
                cs.setNull(4, java.sql.Types.NULL);
                cs.setNull(5, java.sql.Types.NULL);
                cs.setNull(6, java.sql.Types.NULL);
                cs.setNull(7, java.sql.Types.NULL);
                cs.setNull(8, java.sql.Types.NULL);
                cs.setString(9, nickname);
                cs.setString(10, password);
                cs.execute();
                rs = cs.getResultSet();
                if (rs.next()) {
                    this.setUserid(rs.getString("iduser"));
                    this.setNombre(rs.getString("nombre"));
                    this.setAppaterno(rs.getString("appaterno"));
                    this.setApmaterno(rs.getString("apmaterno"));
                    this.setFechanac(rs.getString("fechanac"));
                    this.setEmail(rs.getString("email"));
                    this.setImg(rs.getString("imagen"));
                    this.setNick(rs.getString("nusuario"));
                    this.setContrasenia(rs.getString("contrasenia"));
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
        public boolean EditUser(UserDAO user){
            int res=0;
            try{
           
             con.getConnection();
             cn = con.conectar();
            CallableStatement cs=cn.prepareCall("{call sp_usuario('u',0,?,?,?,?,?,?,?,?)}");
                cs.setString(1, user.getNombre());
                cs.setString(2, user.getAppaterno());
                cs.setString(3, user.getApmaterno());
                cs.setString(4, user.getFechanac());
                cs.setString(5, user.getEmail());
                cs.setString(6, user.getImg());
                cs.setString(7,user.getNick());
                cs.setString(8, user.getContrasenia());
                cs.execute();
                res = cs.getUpdateCount();
                if (res!=0) {
                    this.setNombre(user.getNombre());
                    this.setAppaterno(user.getAppaterno());
                    this.setApmaterno(user.getApmaterno());
                    this.setFechanac(user.getFechanac());
                    this.setEmail(user.getEmail());
                    this.setImg(user.getImg());
                    this.setContrasenia(user.getContrasenia());
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
            return false;
            }
        }
}