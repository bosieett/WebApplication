/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import clases.ConexionSQL;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author PC
 */
public class PostDAO {
    private String usuario;
    private String titulo; 
    private String texto;
    private String imagen;
    private String categoria;
    private String tagname;
    private String idpost;
    private String username;
    private String fecha;
    
    ConexionSQL con = new ConexionSQL();
    Connection cn;
    ResultSet rs;
        
    public PostDAO() {
        usuario="";
        titulo="";
        texto="";
        imagen="";
        categoria="";
        idpost="";
        username="";
        tagname="";
        fecha="";
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getTexto() {
        return texto;
    }

    public void setTexto(String texto) {
        this.texto = texto;
    }

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public String getIdpost() {
        return idpost;
    }

    public void setIdpost(String idpost) {
        this.idpost = idpost;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getTagname() {
        return tagname;
    }

    public void setTagname(String tagname) {
        this.tagname = tagname;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }
    
    public boolean postear(PostDAO post){
        int res=0;
        try{
            con.getConnection();
            cn = con.conectar();
            CallableStatement st=cn.prepareCall("{call sp_publicacion('i',0,?,?,?,?,?)}");
            st.setString(1, post.getTitulo());
            st.setString(2, post.getTexto());
            st.setString(3, post.getImagen());
            st.setString(4, post.getUsuario());
            st.setString(5, post.getCategoria());
            st.execute();
            res = st.getUpdateCount();
            if (res!=0) {
                con.desconectar();
                return true;
                }
            }catch(Exception e){
                System.out.println("Error : " + e);
                con.desconectar();
                return false;
            }
        System.out.println("Error no se inserto en la DB");
        return false;
    }
    public List<PostDAO> GetPosts(){
        List<PostDAO> tabla= new ArrayList<>();
        try{
            con.getConnection();
            cn = con.conectar();
            CallableStatement st=cn.prepareCall("{call sp_publicacion('s',0,NULL,NULL,NULL,NULL,NULL)}");
            st.execute();
            rs= st.getResultSet();
            while(rs.next()){
                PostDAO post=new PostDAO();
                post.setTagname(rs.getString("categoria.categoria"));
                post.setTitulo(rs.getString("publicacion.titulo"));
                post.setUsername(rs.getString("usuario.nusuario"));
                post.setFecha(rs.getString("publicacion.fechapubli"));
                post.setTexto(rs.getString("publicacion.texto"));
                post.setImagen(rs.getString("publicacion.imagen"));
                post.setIdpost(rs.getString("publicacion.idpubli"));
                tabla.add(post);
            }
        }
        catch(Exception e){
            System.out.println("Error : " + e);
            con.desconectar();
            return null;
        }
        return tabla;
    };
    public List<PostDAO> GetPostsUser(String userid){
        List<PostDAO> tabla= new ArrayList<>();
        try{
            con.getConnection();
            cn = con.conectar();
            CallableStatement st=cn.prepareCall("{call sp_publicacion('u',0,NULL,NULL,NULL,?,NULL)}");
            st.setInt(1, Integer.parseInt(userid));
            st.execute();
            rs= st.getResultSet();
            while(rs.next()){
                PostDAO post=new PostDAO();
                post.setTagname(rs.getString("categoria.categoria"));
                post.setTitulo(rs.getString("publicacion.titulo"));
                post.setUsername(rs.getString("usuario.nusuario"));
                post.setFecha(rs.getString("publicacion.fechapubli"));
                post.setTexto(rs.getString("publicacion.texto"));
                post.setImagen(rs.getString("publicacion.imagen"));
                post.setIdpost(rs.getString("publicacion.idpubli"));
                tabla.add(post);
            }
        }
        catch(Exception e){
            System.out.println("Error : " + e);
            con.desconectar();
            return null;
        }
        return tabla;
    };
    
    public List<PostDAO> GetPostsByCat(int catid){
        List<PostDAO> tabla= new ArrayList<>();
        try{
            con.getConnection();
            cn = con.conectar();
            CallableStatement st=cn.prepareCall("{call sp_publicacion('c',0,NULL,NULL,NULL,NULL,?)}");
            st.setInt(1, catid);
            st.execute();
            rs= st.getResultSet();
            while(rs.next()){
                PostDAO post=new PostDAO();
                post.setTagname(rs.getString("categoria.categoria"));
                post.setTitulo(rs.getString("publicacion.titulo"));
                post.setUsername(rs.getString("usuario.nusuario"));
                post.setFecha(rs.getString("publicacion.fechapubli"));
                post.setTexto(rs.getString("publicacion.texto"));
                post.setImagen(rs.getString("publicacion.imagen"));
                post.setIdpost(rs.getString("publicacion.idpubli"));
                tabla.add(post);
            }
        }
        catch(Exception e){
            System.out.println("Error : " + e);
            con.desconectar();
            return null;
        }
        return tabla;
    };
    public List<PostDAO> GetPostsSearch(String keyword){
        List<PostDAO> tabla= new ArrayList<>();
        try{
            con.getConnection();
            cn = con.conectar();
            CallableStatement st=cn.prepareCall("{call sp_publicacion('b',0,NULL,?,NULL,NULL,NULL)}");
            st.setString(1, keyword);
            st.execute();
            rs= st.getResultSet();
            while(rs.next()){
                PostDAO post=new PostDAO();
                post.setTagname(rs.getString("categoria.categoria"));
                post.setTitulo(rs.getString("publicacion.titulo"));
                post.setUsername(rs.getString("usuario.nusuario"));
                post.setFecha(rs.getString("publicacion.fechapubli"));
                post.setTexto(rs.getString("publicacion.texto"));
                post.setImagen(rs.getString("publicacion.imagen"));
                post.setIdpost(rs.getString("publicacion.idpubli"));
                tabla.add(post);
            }
        }
        catch(Exception e){
            System.out.println("Error : " + e);
            con.desconectar();
            return null;
        }
        return tabla;
    };
    public List<PostDAO> GetPostsASearch(String keyword, String cat, String fechain, String fechafin){
        List<PostDAO> tabla= new ArrayList<>();
        try{
            con.getConnection();
            cn = con.conectar();
            CallableStatement st=cn.prepareCall("{call sp_advancedsearch(?,?,?,?,?)}");
            if(!"".equals(keyword)){
            st.setString(1, keyword);
            st.setString(2, keyword);
            }
            else{
                st.setNull(1, java.sql.Types.NULL);
                st.setNull(2, java.sql.Types.NULL);
            }
            if(!"0".equals(cat)){
                st.setInt(3, Integer.parseInt(cat));
            }
            else{
                st.setNull(3,java.sql.Types.NULL);
            }
            if(!"".equals(fechain))
            st.setString(4, fechain);
            else
                st.setNull(4,java.sql.Types.NULL);
            if(!"".equals(fechafin))
            st.setString(5, fechafin);
            else
                st.setNull(5,java.sql.Types.NULL);
            st.execute();
            rs= st.getResultSet();
            while(rs.next()){
                PostDAO post=new PostDAO();
                post.setTagname(rs.getString("categoria.categoria"));
                post.setTitulo(rs.getString("publicacion.titulo"));
                post.setUsername(rs.getString("usuario.nusuario"));
                post.setFecha(rs.getString("publicacion.fechapubli"));
                post.setTexto(rs.getString("publicacion.texto"));
                post.setImagen(rs.getString("publicacion.imagen"));
                post.setIdpost(rs.getString("publicacion.idpubli"));
                tabla.add(post);
            }
        }
        catch(Exception e){
            System.out.println("Error : " + e);
            con.desconectar();
            return null;
        }
        return tabla;
    };
    public void GetOne(String postid){
        try{
            con.getConnection();
            cn = con.conectar();
            CallableStatement st=cn.prepareCall("{call sp_publicacion('g',?,NULL,NULL,NULL,NULL,NULL)}");
            st.setInt(1, Integer.parseInt(postid));
            st.execute();
            rs= st.getResultSet();
            if(rs.next()){
                this.setTagname(rs.getString("categoria.categoria"));
                this.setTitulo(rs.getString("publicacion.titulo"));
                this.setUsername(rs.getString("usuario.nusuario"));
                this.setFecha(rs.getString("publicacion.fechapubli"));
                this.setTexto(rs.getString("publicacion.texto"));
                this.setImagen(rs.getString("publicacion.imagen"));
                this.setIdpost(rs.getString("publicacion.idpubli"));
            }
        }
        catch(Exception e){
            System.out.println("Error : " + e);
            con.desconectar();
        }
        
    }
    public boolean DeletePost(String postid){
        int res=0;
        try{
            con.getConnection();
            cn = con.conectar();
            CallableStatement st=cn.prepareCall("{call sp_publicacion('d',?,NULL,NULL,NULL,NULL,NULL)}");
            st.setInt(1, Integer.parseInt(postid));
            st.execute();
            res= st.getUpdateCount();
            if(res!=0){
                return true;
            }
        }
        catch(Exception e){
            System.out.println("Error : " + e);
            con.desconectar();
        }
        return false;
    }
    public boolean EditPost(String postid, String p_titulo, String p_texto, String p_imagen){
        int res=0;
        try{
            con.getConnection();
            cn = con.conectar();
            CallableStatement st=cn.prepareCall("{call sp_publicacion('e',?,?,?,?,NULL,NULL)}");
            st.setInt(1, Integer.parseInt(postid));
            st.setString(2, p_titulo);
            st.setString(3, p_texto);
            st.setString(4, p_imagen);
            st.execute();
            res= st.getUpdateCount();
            if(res!=0){
                con.desconectar();
                return true;
            }
        }
        catch(Exception e){
            System.out.println("Error : " + e);
            con.desconectar();
        }
        return false;
    }
}
