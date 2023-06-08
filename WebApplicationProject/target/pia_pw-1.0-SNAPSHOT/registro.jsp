<%-- 
    Document   : registro
    Created on : 26 mar 2023, 14:17:09
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrarse</title>
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
  <nav class="navbar text-uppercase p-0" style="background:#9fbc3f;">
    <div class="container d-flex">
        <a class="navbar-brand"><img src="./assets/POV (1).png" width="90px"></a>
        </div>
  </nav>
</header>
<body class="bodycover">
    <div class="d-flex justify-content-center p-2">
    <img src="https://cdn.pixabay.com/photo/2017/08/16/11/49/green-tea-latte-2647523_960_720.jpg" width="45%" height="45%" alt="Perros con ropa de detective">
  <div class="card" style="background: #B7C880;">
    <div class="card-header" style="background: #748A2F;">
      Registro de usuario
  </div>
<div class="card-body">    
  <form method="POST" action="RegServ" enctype="multipart/form-data" id="registroForm">
       
      <%
        Object err =request.getAttribute("err");
        if (err=="2"||err=="3"||err=="4"){
        %>
        <div class="alert alert-danger" role="alert">
             <% String msg = request.getAttribute("err_message").toString();
             out.print(msg);
             %>
             </div>
             <% }
        Object suc =request.getAttribute("suc");
        if (suc=="1"){
        %>
        <div class="alert alert-success" role="alert">
             <% String msg = request.getAttribute("suc_message").toString();
             out.print(msg);
             %>
             </div>
             <% } %>
        <div class="form-group" id="grupo__nombre">
          <label for="nombre" class="formulario__label">Nombres:</label>
          <div class="formulario__grupo-input">
              <input 
                id="nombre"
                type="text"
                class="form-control"
                placeholder="Introduzca su nombre"
                name="nombre"
                required
                />
              <i class="formulario__validacion-estado fa-solid fa-circle-xmark"></i>
          </div>
          <p class="formulario__input-error"> El nombre/s solo puede contener letras y espacios</p>
        </div>
        
        <!--ApellidoPaterno-->
        <div class="form-group" id="grupo__apellidoP">
          <label for="apellidoPaterno" class="formulario__label">Apellido paterno:</label>
          <div class="formulario__grupo-input">
            <input
              id="apellidoPaterno"
              type="text"
              class="form-control"
              placeholder="Apellido paterno"
              name="appaterno"
              required
            />
            <i class="formulario__validacion-estado fa-solid fa-circle-xmark"></i>
          </div>
          <p class="formulario__input-error"> El Apellido Paterno solo puede contener letras y espacios.</p>
        </div>
        
        <!-- ApellidoMaterno -->
        <div class="form-group" id="grupo__apellidoM">
          <label for="apellidoMaterno" class="formulario__label">Apellido materno:</label>
          <div class="formulario__grupo-input">
            <input
              id="apellidoMaterno"
              type="text"
              class="form-control"
              placeholder="Apellido materno"
              name="apmaterno"
              required
            />
            <i class="formulario__validacion-estado fa-solid fa-circle-xmark"></i>
          </div>
          <p class="formulario__input-error"> El Apellido Materno solo puede contener letras y espacios.</p>
        </div>
        
        <!-- Fecha de nacimiento -->
        <div class="form-group">
          <label>Fecha de nacimiento:</label>
          <input
            type="date"
            class="form-control"
            name="nacfecha"
            max="2023-03-29"
            required
          />
        </div>
        
        <!-- Correo -->
        <div class="form-group" id="grupo__correo">
            <label for="correo" class="formulario__label">Correo electrónico:</label>
            <div class="formulario__grupo-input">
                <input
                  id="correo"
                  type="email"
                  class="form-control"
                  placeholder="usuario@organizacion.com"
                  name="email"
                  required
                />
                <i class="formulario__validacion-estado fa-solid fa-circle-xmark"></i>
            </div>
            <p class="formulario__input-error"> El correo solo puede contener letra, numeros, puntos, guiones y guion bajo.</p>
          </div>
        
        <!-- Imagen de perfil -->
        <div class="form-group">
          <label>Imagen de perfil:</label>
          <input
            type="file"
            class="form-control"
            placeholder="Nombre de la imagen"
            name="img"
            required  
          />
        </div>
        
        <!-- Nombre de usuario -->
        <div class="form-group" id="grupo__usuario">
            <label for="usuario" class="formulario__label">Nombre de usuario:</label>
            <div class="formulario__grupo-input">
                <input
                  id="usuario"
                  type="text"
                  class="form-control"
                  placeholder="Usuario123"
                  name="nick"
                  required
                />
                <i class="formulario__validacion-estado fa-solid fa-circle-xmark"></i>
            </div>
            <p class="formulario__input-error"> El usuario tiene que ser de 4 a 16 digitos y solo puede contener numeros, letras y guion bajo.</p>
        </div>
        
        <!-- Contraseña -->
        <div class="form-group" id="grupo__password">
            <label for="password" class="formulario__label">Contraseña:</label>
            <div class="formulario__grupo-input">
                <input
                  id="password"
                  type="password"
                  class="form-control"
                  placeholder="******"
                  name="pass"
                  required
                />
                <i class="formulario__validacion-estado fa-solid fa-circle-xmark"></i>
            </div>
            <p class="formulario__input-error"> La contraseña debe contener minimo una mayuscula, minuscula ,un numero y un punto.</p>
        </div>
        
        <!-- Confirmar contraseña -->
        <div class="form-group" id="grupo__password2">
            <label for="password2" class="formulario__label">Confirmar contraseña:</label>
            <div class="formulario__grupo-input">
                <input
                  id="password2"
                  type="password"
                  class="form-control"
                  placeholder="******"
                  name="confpass"
                  required
                />
                <i class="formulario__validacion-estado fa-solid fa-circle-xmark"></i>
            </div>
            <p class="formulario__input-error"> Ambas contraseñas deben ser iguales.</p>
        </div>
        
        <div class="formulario__mensaje" id="formulario__mensaje">
            <p><i class="fa-solid fa-triangle-exclamation"></i><b>Error:</b> Por favor rellene los datos faltantes.</p>
        </div>
        
        <!-- Boton de registrarse -->
        <div class="formulario__grupo formulario__grupo-btn-registrar">     
            <button type="submit" class="btn btn-success formulario__btn" style="margin-top: 15px; position: relative; left: 35%;">Registrarse</button>
            <p class="formulario__mensaje-exito" id="formulario__mensaje-exito">Te has registrado exitosamente</p>
        </div>
    </form>
        <form action="login.jsp">
            <button type="submit" class="btn btn-success formulario__btn" style="margin-top: 15px; position: relative; left: 35%;">¿Ya tienes cuenta?</button>
        </form>
</div>

</div>
</div>
        <script src="https://kit.fontawesome.com/1ad5ce1703.js" crossorigin="anonymous"></script>
        <script src="validacionesRegister.js"></script>
</body>
<footer class="fixed-bottom">
  <div class="text-center p-1 " style="background-color: #d5d5b9;">
    <iframe class="ifFooter" src="footer.html" frameborder="0"></iframe>
  </div>
</footer>
</html>