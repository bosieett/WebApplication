/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import DAO.UserDAO;
import clases.Usuario;
import jakarta.servlet.RequestDispatcher;
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

@WebServlet(name = "RegServ", urlPatterns = {"/RegServ"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024*2,  // 10 KB
        maxFileSize = 1024 * 1024*10,       // 300 KB
        maxRequestSize = 1024 * 1024 *50   // 1 MB 
)
public class RegServ extends HttpServlet {


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
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out=response.getWriter();
        String nickname= request.getParameter("nick");
        String password=request.getParameter("pass");
        
        String nombre=request.getParameter("nombre");
        String appaterno=request.getParameter("appaterno");
        String apmaterno=request.getParameter("apmaterno");
        String email=request.getParameter("email");
        String fechanac=request.getParameter("nacfecha");
        /*request.setAttribute("err","2");
        request.setAttribute("fechanac3",fechanac);
        RequestDispatcher rd=request.getRequestDispatcher("registro.jsp");
                rd.forward(request, response);*/
        Part filepart=request.getPart("img");
        String filename=extractFileName(filepart);
        String JorgePath="C:\\Users\\jorge\\OneDrive\\Documentos\\Repositorio PW1\\ProgramacionWeb1\\NETBEANS\\pia_pw\\src\\main\\webapp\\uploaded_imgs";
        String KevinPath="C:\\Users\\PC\\OneDrive\\Escritorio\\PW1 2\\ProgramacionWeb1\\NETBEANS\\pia_pw\\src\\main\\webapp\\uploaded_imgs";
        String savePath=JorgePath+File.separator+filename;
        
        
        UserDAO reg=new UserDAO();
        int valid=reg.Registro(nombre, appaterno, apmaterno, email, fechanac, nickname, password, savePath);
            if(valid==1){
                File fileSaveDir=new File(savePath);
                filepart.write(savePath+File.separator);
                request.setAttribute("suc", "1");
                request.setAttribute("suc_message","Usuario registrado correctamente");
                RequestDispatcher rd=request.getRequestDispatcher("registro.jsp");
                rd.forward(request, response); 
            }
            if(valid==2){
                System.out.println("ERROR");
                request.setAttribute("err", "3");
                request.setAttribute("err_message","Ese usuario ya está registrado");
                RequestDispatcher rd=request.getRequestDispatcher("registro.jsp");
                rd.forward(request, response); 
            }
            if(valid==3){
                System.out.println("ERROR");
                request.setAttribute("err", "4");
                request.setAttribute("err_message","Ese correo ya está registrado");
                RequestDispatcher rd=request.getRequestDispatcher("registro.jsp");
                rd.forward(request, response); 
            }
            if(valid==6){
                System.out.println("ERROR");
                request.setAttribute("err", "2");
                request.setAttribute("err_message","No se pudo crear el usuario");
                RequestDispatcher rd=request.getRequestDispatcher("registro.jsp");
                rd.forward(request, response); 
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