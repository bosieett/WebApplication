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
@WebServlet(name = "EditPubliServlet", urlPatterns = {"/EditPubliServlet"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024*2,  // 10 KB
        maxFileSize = 1024 * 1024*10,       // 300 KB
        maxRequestSize = 1024 * 1024 *50   // 1 MB 
)
public class EditPubliServlet extends HttpServlet {


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
        String idPost = request.getParameter("id");
        PostDAO post=new PostDAO();
        post.GetOne(idPost);
        request.getSession(false).setAttribute("postedit", post);
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
        PostDAO postedit=(PostDAO)request.getSession(false).getAttribute("postedit");
        PostDAO post=new PostDAO();
        post.setTitulo(request.getParameter("post_edit_title"));
        post.setTexto(request.getParameter("post_edit_text"));
        
        Part filepart=request.getPart("post_edit_img");
        if(filepart!=null && filepart.getSize()>0){
            String filename= extractFileName(filepart);
            
            savePath=JorgePath+File.separator+filename;
            
            post.setImagen(savePath);
        }
        else{
            post.setImagen(postedit.getImagen());
        }
        
        if(post.EditPost(postedit.getIdpost(), post.getTitulo(), post.getTexto(), post.getImagen())){
            if(filepart!=null && filepart.getSize()>0){
                File fileSaveDir=new File(savePath);
                filepart.write(savePath+File.separator);
            }
            
        }
        else{
            System.out.println("ERROR");
            out.println("<script type=\"text/javascript\">");
            out.println("alert('No se pudo editar');");
            out.println("window.location.replace('editpubli.jsp');");
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
