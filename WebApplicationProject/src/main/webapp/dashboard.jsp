<%-- 
    Document   : dashboard
    Created on : 26 mar 2023, 14:17:16
    Author     : PC
--%>

<%@page import="java.util.List"%>
<%@page import="DAO.PostDAO"%>
<%@page import="DAO.UserDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <link href="DataTables/datatables.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="styles/style.css">
    <link rel="stylesheet" href="styles/footer.css">
    <link rel="stylesheet" href="styles/dashboard.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
</head>
<%
    if (request.getSession(false) == null || request.getSession(false).getAttribute("usuario") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    UserDAO userlog=(UserDAO)session.getAttribute("usuario");
    PostDAO publicaciones=new PostDAO();
%>
<header>
  <nav class="navbar navbar-expand-lg p-0 fixed-top border-bottom" style="background:#9fbc3f;">
    <div class="container d-flex justify-content-between">
        <a class="navbar-brand"><img src="./assets/POV (1).png" width="90px"></a>
        <form action="BuscarPostServ" method="GET" class="d-flex">
          <i class="fa-solid fa-magnifying-glass me-3 pt-2"></i>
          <input name="keysearch" id="busquedaBox" class="form-control me-2" style="width:600px;" type="text" placeholder="¿Que deseas buscar?" aria-label="Search">
          <button class="btn btn-outline-success" id="botonSearch" type="submit"> <i class="fa-solid fa-magnifying-glass"></i> Buscar</button>
        </form>
          <button class="btn bgbutton" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasWithBothOptions" aria-controls="offcanvasWithBothOptions"><img src="./assets/sidebar-icon.png" class="bgimg"></button>
    </div>
  </nav>
  <nav class="navbar navbar-expand-lg fixed-top" style="margin-top: 6rem; background: #e7ff96;"><div class="container-fluid">
    <a class="navbar-brand">Categorías</a>
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link" href="dashboard.jsp">TODAS</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="ToCatServ?cat=1">CAFÉ</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="ToCatServ?cat=2">TÉ</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="ToCatServ?cat=3">MATCHA</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="ToCatServ?cat=4">CAFÉ HELADO</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="ToCatServ?cat=5">LATTE</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="ToCatServ?cat=6">DESAYUNO</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="ToCatServ?cat=7">CITA</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="ToCatServ?cat=8">AESTHETIC</a>
        </li>
      </ul>
  </nav>
</header>

<body class="bodycover">
    <div class="offcanvas offcanvas-start offcanvas-style" data-bs-scroll="true" data-bs-backdrop="true" tabindex="-1" id="offcanvasWithBothOptions" aria-labelledby="offcanvasWithBothOptionsLabel">
      <div class="offcanvas-header">
        
        <img class="logomenu" style="position: relative; left: 25%; right: 25%;"src="./assets/POV (1).png">
        
      </div>
      <div>
   
          <a href="Profile.jsp"><img class="rounded-circle mb-4" style="display: block;margin: auto;" width="100px" height="100px" src="<%
              String imagen=userlog.getImg();
              int index=imagen.indexOf("uploaded_imgs");
              String result="";
              if(index!=-1){
                result=imagen.substring(index);
                out.println(result.replace("\\","/"));
              }
                                    %>"></a>
        
      </div>
                                    <p style="text-align: center;"><%
            out.println(userlog.getNick());
        %></p>
      <form>
        <button class="btn sbbtn" type="submit" formaction="dashboard.jsp">Dashboard</button>
        <button class="btn sbbtn" type="submit" formaction="buscar.jsp">Busqueda</button>
      <button class="btn sbbtn" type="submit" formaction="publicar.jsp">Publicar</button>
      <button class="btn sbbtn" type="submit" formaction="Profile.jsp">Perfil</button>
      <button class="fixed-bottom btn sbbtn" type="submit" formaction="cerrarsesion">Cerrar sesión</button>
      </form>
      
    </div>
      <section style="margin-top: 9.5rem; margin-bottom: 2.5rem">
    <div>
        <table id="tablapublicaciones">
            <thead>
                <tr>
                    <th style="border:none;"></th>
                </tr>
            </thead>
            <tbody>
                <%
                    for(PostDAO elemento:publicaciones.GetPosts()){
                %>
                <tr>
            <td>
                
                <div class="projcard-container">
                    
                    <div class="projcard projcard-customcolor">
                
                <div class="projcard-innerbox">
                    
                    <img class="projcard-img" src="<%
                        if(!elemento.getImagen().isEmpty()){
                                String imagen2=elemento.getImagen();
                                int index2=imagen2.indexOf("post_imgs");
                                String result2="";
                                if(index2!=-1){
                                    result2=imagen2.substring(index2);
                                    out.println(result2.replace("\\","/"));
                                }
                        }
                        else
                        out.print("./assets/POV (1).png");
                    %>" />
                    <div class="projcard-textbox">
                        <div class="projcard-title"><%out.print(elemento.getTitulo());%></div>
                        <div class="projcard-subtitle"><%out.print(elemento.getUsername());%></div>
                        <div class="projcard-bar"></div>
                        <div class="projcard-description"><%out.print(elemento.getTexto());%></div>
                        <div class="projcard-tagbox">
                            <span class="projcard-tag"><%out.print(elemento.getTagname());%></span>
                            <p><%out.print(elemento.getFecha());%></p>
                        </div>
                    </div>
                        
                </div>
                        
            </div>
        </div>
            </td>
                </tr>
                    <%}
                %>
            </tbody>
        </table>
    </div>
      </section>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
    <script src="DataTables/datatables.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#tablapublicaciones').DataTable({
                "paging":true,
                "pagingType":"full_numbers",
                "dom": '<"top"lp>rt<"bottom"lp><"clear">',
                "language": {
                    "emptyTable": "Aún no hay publicaciones, ¡sé el primero!",
                    "paginate": {
                        "previous": "Anterior",
                        "next": "Siguiente",
                        "first": "Inicio",
                        "last":"Final"
                    }
                },
                "ordering":false,
                "searching":false,
                "lengthChange":false,
                "pageLength":10
            });
        });
    </script>
</body>
<footer class="fixed-bottom">
  <div class="text-center p-1 " style="background-color: #d5d5b9;">
    <iframe class="ifFooter" src="footer.html" frameborder="0"></iframe>
  </div>
</footer>
</html>