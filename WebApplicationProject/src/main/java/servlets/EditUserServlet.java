/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import DAO.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;

/**
 *
 * @author PC
 */
@WebServlet(name = "EditUserServlet", urlPatterns = {"/EditUserServlet"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024*2,  // 10 KB
        maxFileSize = 1024 * 1024*10,       // 300 KB
        maxRequestSize = 1024 * 1024 *50   // 1 MB 
)
public class EditUserServlet extends HttpServlet {

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
        response.setContentType("text/html");
        PrintWriter out=response.getWriter();
        String JorgePath="C:\\Users\\jorge\\OneDrive\\Documentos\\Repositorio PW1\\ProgramacionWeb1\\NETBEANS\\pia_pw\\src\\main\\webapp\\uploaded_imgs";
        String KevinPath="C:\\Users\\PC\\OneDrive\\Escritorio\\PW1 2\\ProgramacionWeb1\\NETBEANS\\pia_pw\\src\\main\\webapp\\uploaded_imgs";
        String savePath="";
       UserDAO userlog = (UserDAO)request.getSession(false).getAttribute("usuario");
       UserDAO useredit=new UserDAO();
       useredit.setNick(userlog.getNick());
       useredit.setNombre(request.getParameter("user_edit_name"));
       useredit.setAppaterno("user_edit_appaterno");
       useredit.setApmaterno("user_edit_apmaterno");
       useredit.setFechanac("user_edit_fechanac");
       useredit.setEmail("user_edit_email");
       useredit.setImg("user_edit_img");
       useredit.setContrasenia("user_edit_pass");
       Part filepart=request.getPart("user_edit_img");
       if(filepart!=null && filepart.getSize()>0){
            String filename= extractFileName(filepart);
            
            savePath=JorgePath+File.separator+filename;
            
            useredit.setImg(savePath);
       }
       else{
            out.println("<script type=\"text/javascript\">");
            out.println("var confirmacion = confirm('Tu foto va a seguir siendo la misma, ¿Deseas continuar?');");
            out.println("if (!confirmacion) {");
            out.println("    return;");
            out.println("}");
            out.println("</script>");
           useredit.setImg(userlog.getImg());
       }
       out.println("<script type=\"text/javascript\">");
            out.println("var confirmacion2 = confirm('¿Estás segur@ de estos cambios?');");
            out.println("if (!confirmacion2) {");
            out.println("    return;");
            out.println("}");
            out.println("</script>");
       if(userlog.EditUser(useredit)){
            if(filepart!=null && filepart.getSize()>0){
                File fileSaveDir=new File(savePath);
                filepart.write(savePath+File.separator);
            }
            request.getSession(false).setAttribute("usuario", userlog);
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Se editó correctamente');");
            out.println("window.location.replace('Profile.jsp');");
            out.println("</script>");
        }
        else{
            System.out.println("ERROR");
            out.println("<script type=\"text/javascript\">");
            out.println("alert('No se pudo editar');");
            out.println("window.location.replace('perfiledit.jsp');");
            out.println("</script>");
        }
       
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
        String JorgePath="C:\\Users\\jorge\\OneDrive\\Documentos\\Repositorio PW1\\ProgramacionWeb1\\NETBEANS\\pia_pw\\src\\main\\webapp\\uploaded_imgs";
        String KevinPath="C:\\Users\\PC\\OneDrive\\Escritorio\\PW1 2\\ProgramacionWeb1\\NETBEANS\\pia_pw\\src\\main\\webapp\\uploaded_imgs";
        String savePath="";
       UserDAO userlog = (UserDAO)request.getSession(false).getAttribute("usuario");
       UserDAO useredit=new UserDAO();
       useredit.setNick(userlog.getNick());
       useredit.setNombre(request.getParameter("user_edit_name"));
       useredit.setAppaterno(request.getParameter("user_edit_appaterno"));
       useredit.setApmaterno(request.getParameter("user_edit_apmaterno"));
       useredit.setFechanac(request.getParameter("user_edit_fechanac"));
       useredit.setEmail(request.getParameter("user_edit_email"));
       useredit.setImg(request.getParameter("user_edit_img"));
       useredit.setContrasenia(request.getParameter("user_edit_pass"));
       Part filepart=request.getPart("user_edit_img");
       if(filepart!=null && filepart.getSize()>0){
            String filename= extractFileName(filepart);
            
            savePath=JorgePath+File.separator+filename;
            
            useredit.setImg(savePath);
       }
       else{
           useredit.setImg(userlog.getImg());
       }
       if(userlog.EditUser(useredit)){
            if(filepart!=null && filepart.getSize()>0){
                File fileSaveDir=new File(savePath);
                filepart.write(savePath+File.separator);
            }
            request.getSession(false).setAttribute("usuario", userlog);
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Se editó correctamente');");
            out.println("window.location.replace('Profile.jsp');");
            out.println("</script>");
        }
        else{
            System.out.println("ERROR");
            out.println("<script type=\"text/javascript\">");
            out.println("alert('No se pudo editar');");
            out.println("window.location.replace('perfiledit.jsp');");
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
