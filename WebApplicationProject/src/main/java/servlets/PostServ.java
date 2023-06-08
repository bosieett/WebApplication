/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import DAO.PostDAO;
import DAO.UserDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
/**
 *
 * @author PC
 */
@WebServlet(name = "PostServ", urlPatterns = {"/PostServ"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024*2,  // 10 KB
        maxFileSize = 1024 * 1024*10,       // 300 KB
        maxRequestSize = 1024 * 1024 *50   // 1 MB 
)
public class PostServ extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out=response.getWriter();
        
        String JorgePath="C:\\Users\\jorge\\OneDrive\\Documentos\\Repositorio PW1\\ProgramacionWeb1\\NETBEANS\\pia_pw\\src\\main\\webapp\\post_imgs";
        String KevinPath="C:\\Users\\PC\\OneDrive\\Escritorio\\PW1 2\\ProgramacionWeb1\\NETBEANS\\pia_pw\\src\\main\\webapp\\post_imgs";
        String savePath="";
        
        HttpSession session=request.getSession();
        UserDAO userlog=(UserDAO)session.getAttribute("usuario");
        PostDAO post=new PostDAO();
        post.setTitulo(request.getParameter("post_title"));
        post.setTexto(request.getParameter("post_text"));
        post.setCategoria(request.getParameter("post_cat"));
        post.setUsuario(userlog.getUserid());
        
        Part filepart=request.getPart("post_img");
        if(filepart!=null && filepart.getSize()>0){
            String filename= extractFileName(filepart);
            
            savePath=JorgePath+File.separator+filename;
            
            post.setImagen(savePath);
        }
        else{
            post.setImagen("");
        }
        if(post.postear(post)){
            if(filepart!=null && filepart.getSize()>0){
                File fileSaveDir=new File(savePath);
                filepart.write(savePath+File.separator);
            }
            request.setAttribute("suc", "2");
            request.setAttribute("suc_message","¡Tu publicación está hirviendo!");
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Se publicó con exito');");
            out.println("window.location.replace('publicar.jsp');");
            out.println("</script>");
        }
        else{
            System.out.println("ERROR");
                request.setAttribute("err", "5");
                request.setAttribute("err_message","No se logró publicar, consulta con soporte técnico");
                out.println("<script type=\"text/javascript\">");
                out.println("alert('No se pudo publicar');");
                out.println("window.location.replace('publicar.jsp');");
                out.println("</script>");
        }
    }
    
    private String extractFileName(Part part){
        String contentDisp=part.getHeader("content-disposition");
        String[] items=contentDisp.split(";");
        for(String s:items){
            if(s.trim().startsWith("filename"))
            {
                return s.substring(s.indexOf("=")+2, s.length()-1);
            }
        }
        return "";
        }
}