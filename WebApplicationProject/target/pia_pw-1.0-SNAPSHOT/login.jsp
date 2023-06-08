<%-- 
    Document   : login
    Created on : 26 mar 2023, 14:16:41
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar sesión</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <link rel="stylesheet" href="styles/style.css">
    <link rel="stylesheet" href="styles/footer.css">
</head>
<%
    if (request.getSession(false).getAttribute("usuario") != null) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
%>
<header>
    <nav class="navbar navbar-expand-lg p-0 fixed-top border-bottom" style="background:#9fbc3f;">
      <div class="container d-flex justify-content-between">
          <a class="navbar-brand"><img src="./assets/POV (1).png" width="90px"></a> 
         
      </div>
    </nav>
  </header>
  <body class="bodycover">
      <div class="offcanvas offcanvas-start offcanvas-style" data-bs-scroll="true" data-bs-backdrop="true" tabindex="-1" id="offcanvasWithBothOptions" aria-labelledby="offcanvasWithBothOptionsLabel">
        <div class="offcanvas-header">
          
          <img class="logomenu" style="position: relative; left: 25%; right: 25%;"src="./assets/POV (1).png">
          
        </div>
        
      </div>
  
    <div class="d-flex justify-content-center" style="padding-top: 7rem;">
    <img src="https://cdn.pixabay.com/photo/2017/08/16/11/49/green-tea-latte-2647523_960_720.jpg" width="45%" height="45%" alt="Perros con ropa de detective">
    <div class="card" style="background: #B7C880;">
    <div class="card-header" style="background: #748A2F;">
      Iniciar sesión
  </div>
<div class="card-body">    
   
  <form method="POST" action="LoginServ">
      
      <%
        Object err =request.getAttribute("err");
        if (err=="1"){
        %>
        <div class="alert alert-danger" role="alert">
             <% String msg = request.getAttribute("err_message").toString();
             out.print(msg);
             %>
             </div>
             <% } %>
      <div class="form-group">
            <label>Nombre de usuario:</label>
            <input
              type="text"
              class="form-control"
              placeholder="Usuario123"
              name="nickname"
              required
            />
          </div>
          <div class="form-group">
            <label>Contraseña:</label>
            <input
              type="password"
              class="form-control"
              placeholder="******"
              name="password"
              required
            />
          </div>
          <button type="submit" class="btn btn-success" style="margin-top: 15px; position: relative; left: 35%;">Iniciar sesión</button>
        </form>

        <form action="registro.jsp">
          <button type="submit" class="btn btn-success" style="margin-top: 15px; position: relative; left: 35%;">Registrarse</button>
        </form>
</div>

</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
</body>
<footer class="fixed-bottom">
  <div class="text-center p-1 " style="background-color: #d5d5b9;">
    <iframe class="ifFooter" src="footer.html" frameborder="0"></iframe>
  </div>
</footer>
</html>