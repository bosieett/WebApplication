<%-- 
    Document   : perfil
    Created on : 26 mar 2023, 14:17:44
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
    <title>Editando</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <link rel="stylesheet" href="styles/style.css">
    <link rel="stylesheet" href="styles/footer.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
</head>
<%  if (request.getSession(false) == null || request.getSession(false).getAttribute("usuario") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        UserDAO userlog=(UserDAO)session.getAttribute("usuario");
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

    <section class="py-6">
      <div class="perfil-container pt-5">
        <img class="img-perfil" src="<%out.print(result);%>">        
      </div>

      <div class="card-body">    
          <form method="POST" action="EditUserServlet"  enctype="multipart/form-data" id="edituserform">
            <div class="container pt-2" style="width: 450px;">
                
                <!-- Nombre Edit -->
                <div class="form-group" id="grupo__nombre">
                  <label for="nombre" class="formulario__label">Nombres:</label>
                   <div class="formulario__grupo-input">
                       <input
                        id="nombre"
                        type="text"
                        class="form-control"
                        placeholder="Introduzca su nombre"
                        name="user_edit_name"
                        value="<%out.print(userlog.getNombre());%>"
                        required
                        />
                       <i class="formulario__validacion-estado fa-solid fa-circle-xmark"></i>
                   </div>
                   <p class="formulario__input-error"> El nombre/s solo puede contener letras y espacios</p>
                </div>
                
                <!-- Apellido Paterno -->        
                <div class="form-group" id="grupo__apellidoP">
                  <label for="apPaterno" class="formulario__label">Apellido paterno:</label>
                  <div class="formulario__grupo-input">
                    <input
                      id="apPaterno"
                      type="text"
                      class="form-control"
                      placeholder="Apellido paterno"
                      name="user_edit_appaterno"
                      value="<%out.print(userlog.getAppaterno());%>"
                      required
                    />
                    <i class="formulario__validacion-estado fa-solid fa-circle-xmark"></i>
                  </div>
                  <p class="formulario__input-error"> El Apellido Paterno solo puede contener letras y espacios.</p>
                </div>
                      
                <!-- Apellido Materno -->
                <div class="form-group" id="grupo__apellidoM">
                  <label for="apMaterno" class="formulario__label">Apellido materno:</label>
                  <div class="formulario__grupo-input">
                    <input
                      id="apMaterno"
                      type="text"
                      class="form-control"
                      placeholder="Apellido materno"
                      name="user_edit_apmaterno"
                      value="<%out.print(userlog.getApmaterno());%>"
                      required
                    />
                    <i class="formulario__validacion-estado fa-solid fa-circle-xmark"></i>
                  </div>
                  <p class="formulario__input-error"> El Apellido Materno solo puede contener letras y espacios.</p>    
                </div>
                      
                <!-- Fecha de Nacimiento -->
                <div class="form-group">
                  <label for="dateNac" class="formulario__label">Fecha de nacimiento:</label>
                  <input
                    id="dateNac"
                    type="date"
                    class="form-control"
                    max="2023-03-29"
                    name="user_edit_fechanac"
                    value="<%out.print(userlog.getFechanac());%>"
                    required
                  />
                </div>
                    
                <!-- Correo -->
                <div class="form-group" id="grupo__correo">
                    <label for="correo" class="formulario__label">Correo electrónico:</label>
                    <div class="formulario__grupo-input">
                        <input
                          id="correo"
                          type="text"
                          class="form-control"
                          placeholder="usuario@organizacion.com"
                          name="user_edit_email"
                          value="<%out.print(userlog.getEmail());%>"
                          required
                        />
                        <i class="formulario__validacion-estado fa-solid fa-circle-xmark"></i>
                    </div>
                    <p class="formulario__input-error"> El correo solo puede contener letra, numeros, puntos, guiones y guion bajo.</p>
                </div>
                          
                <!-- Imagen -->
                <div class="form-group">
                  <label for="imagen" class="formulario__label">Imagen de perfil:</label>
                  <input
                    id="imagen"
                    type="file"
                    class="form-control"
                    placeholder="Nombre de la imagen"
                    name="user_edit_img"
                    id="id_edit_img"
                  />
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
                      value="<%out.print(userlog.getContrasenia());%>"
                      name="user_edit_pass"
                      required
                    />
                    <i class="formulario__validacion-estado fa-solid fa-circle-xmark"></i>
                  </div>
                  <p class="formulario__input-error"> La contraseña debe contener minimo una mayuscula, minuscula ,un numero y un punto.</p>
                </div>
                 
                <!-- Confirmar Contraseña -->
                <div class="form-group" id="grupo__password2">
                  <label for="password2" class="formulario__label">Confirmar contraseña:</label>
                  <div class="formulario__grupo-input">
                    <input
                      id="password2"
                      type="password"
                      class="form-control"
                      placeholder="******"
                      name="user_edit_confpass"
                      value="<%out.print(userlog.getContrasenia());%>"
                      required
                    />
                    <i class="formulario__validacion-estado fa-solid fa-circle-xmark"></i>
                  </div>
                  <p class="formulario__input-error"> Ambas contraseñas deben ser iguales.</p>
                </div>
                      
                <div class="formulario__mensaje" id="formulario__mensaje">
                    <p><i class="fa-solid fa-triangle-exclamation"></i><b>Error:</b> Por favor rellene los datos faltantes.</p>
                </div>
                
                <div class="formulario__grupo formulario__grupo-btn-registrar">
                    <button id="botonlocote" type="submit"  class="btn btn-success" style="margin-top: 15px; position: relative; left: 35%;">Editar Perfil</button>
                    <p class="formulario__mensaje-exito" id="formulario__mensaje-exito">Te has registrado exitosamente</p>
                </div>
                      
            </div>
          </form>
      </div>
    </section>
    <script>
        document.getElementById("edituserform").addEventListener("submit", function(event) {
            var imagenInput = document.getElementById("id_edit_img");
            console.log(imagenInput);
            var imagenSeleccionada = imagenInput.files[0];
            console.log(imagenSeleccionada);
            if (!imagenSeleccionada) {
                var confirmacion1 = confirm("¿Estás segur@ que no quieres cambiar la foto?");
                if(!confirmacion1)
                    event.preventDefault();
            }
            
            var confirmacion2 = confirm("¿Estás segur@ que quieres editar con la información ingresada?");
   
   
            if (!confirmacion2) {
                event.preventDefault(); // Cancela el envío del formulario
            }
        });
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
    <script src="https://kit.fontawesome.com/1ad5ce1703.js" crossorigin="anonymous"></script>
    <script src="validacionesProfile.js"></script>
</body>
<footer class="fixed-bottom">
  <div class="text-center p-1 " style="background-color: #d5d5b9;">
    <iframe class="ifFooter" src="footer.html" frameborder="0"></iframe>
  </div>
</footer>
</html>