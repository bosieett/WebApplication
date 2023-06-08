<%-- 
    Document   : publicar
    Created on : 26 mar 2023, 14:17:36
    Author     : PC
--%>

<%@page import="DAO.UserDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Publicacion</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <link rel="stylesheet" href="styles/style.css">
    <link rel="stylesheet" href="styles/footer.css">
</head>
<%
    if (request.getSession(false) == null || request.getSession(false).getAttribute("usuario") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    UserDAO userlog=(UserDAO)session.getAttribute("usuario");%>

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
    <section class="post py-6" style="padding-bottom:0;">
      <div class="container">
      <form method="POST" action="PostServ" enctype="multipart/form-data">
        <%
        Object err =request.getAttribute("err");
        if (err=="5"){
        %>
        <div class="alert alert-danger" role="alert">
             <% String msg = request.getAttribute("err_message").toString();
             out.print(msg);
             %>
             </div>
             <% } %>
             <%
        Object suc =request.getAttribute("suc");
        if (suc=="2"){
        %>
        <div class="alert alert-success" role="alert">
             <% String msg = request.getAttribute("suc_message").toString();
             out.print(msg);
             %>
             </div>
             <% } %>
        <div class="content">
          <img class="rounded-circle" src="<%out.println(result.replace("\\","/"));%>" alt="logo" width="100px" height="100px">
          <div class="details">
            <p><%out.print(userlog.getNick());%></p>
          </div>
        </div>
        <input
            name="post_title"
            type="text"
            class="form-control"
            placeholder="Titulo"
            maxlength="40"
            required  
          />
        
        <select class="form-select" id="inputGroupSelect01" name="post_cat">
          <option value="1">CAFÉ</option>
          <option value="2">TÉ</option>
          <option value="3">MATCHA</option>
          <option value="4">CAFÉ HELADO</option>
          <option value="5">LATTE</option>
          <option value="6">DESAYUNO</option>
          <option value="7">CITA</option>
          <option value="8">AESTHETIC</option>
        </select>
        <textarea name="post_text" placeholder="¿Qué tal estuvo tu día?" spellcheck="false" maxlength="200" required></textarea>
        <input
            name="post_img"
            type="file"
            class="form-control"
          />
        <button type="submit">Publicar</button>
      </form>
      </div>
    </section>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
</body>
<footer class="fixed-bottom">
  <div class="text-center p-1 " style="background-color: #d5d5b9;">
    <iframe class="ifFooter" src="footer.html" frameborder="0"></iframe>
  </div>
</footer>
</html>