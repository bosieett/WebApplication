<%-- 
    Document   : buscar
    Created on : 26 mar 2023, 14:18:07
    Author     : PC
--%>

<%@page import="DAO.PostDAO"%>
<%@page import="DAO.UserDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Busqueda</title>
     <link href="DataTables/datatables.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <link rel="stylesheet" href="styles/style.css">
    <link rel="stylesheet" href="styles/footer.css">
    <link rel="stylesheet" href="styles/dashboard.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
</head>
<header>
  <nav class="navbar navbar-expand-lg p-0 fixed-top border-bottom" style="background:#9fbc3f;">
    <div class="container d-flex justify-content-between">
        <a class="navbar-brand"><img src="./assets/POV (1).png" width="90px"></a> 
          <button class="btn bgbutton" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasWithBothOptions" aria-controls="offcanvasWithBothOptions"><img src="./assets/sidebar-icon.png" class="bgimg"></button>
    </div>
  </nav>
</header>
<%
    if (request.getSession(false) == null || request.getSession(false).getAttribute("usuario") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    UserDAO userlog=(UserDAO)session.getAttribute("usuario");
    PostDAO publicaciones = new PostDAO();
                    ;%>
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
    <section style="margin-bottom:6rem; margin-top:8.5rem">
        <form action='AdvancedSearchServ' method="GET" style="text-align: center;">
    <div class="form-group" style="text-align: center; margin-bottom: 1rem;">
      <input style="
  width:600px; display:inline;" type="search" class="form-control" id="inputKeyword" name="keywordname" placeholder="¿Qué deseas buscar?">
   
   
      <label for="inputState">Categoria</label>
      <select style="
              width:600px; display:inline;"  id="inputCat" class="form-control" name="catselec">
          <option selected value="0">TODAS</option>
          <option value="1">CAFÉ</option>
          <option value="2">TÉ</option>
          <option value="3">MATCHA</option>
          <option value="4">CAFÉ HELADO</option>
          <option value="5">LATTE</option>
          <option value="6">DESAYUNO</option>
          <option value="7">CITA</option>
          <option value="8">AESTHETIC</option>
      </select>
    </div>
           <div class="form-group" style="text-align: center; margin-bottom: 1rem;">
                <input id="fechainicial" name="fechainicialname" onkeydown="filtrarInput(event)" style="width: 200px;display:inline;" type="text" value="2023-03-02" class="form-control">
        <h5 class="pt-2" style="display:inline;"> hasta </h5>
        <input id="fechafinal" name="fechafinalname" onkeydown="filtrarInput(event)" style="width: 200px;display:inline;" type="text" value="2023-03-02" class="form-control">
        <span>Escribe la fecha en formato: yyyy-mm-dd</span>
           </div>
  <button class="btn btn-outline-success" id="botonSearch" type="submit" style="width: 200px;"> <i class="fa-solid fa-magnifying-glass"></i> Filtrar</button>
</form>
   <table id="tablapublicaciones">
            <thead>
                <tr>
                    <th style="border:none;"></th>
                </tr>
            </thead>
            <tbody>
                <%
                    for(PostDAO elemento:publicaciones.GetPostsASearch((String)request.getSession(false).getAttribute("keyword_search"), (String)request.getSession(false).getAttribute("categoriaid"), (String) request.getSession(false).getAttribute("search_idate"), (String)request.getSession(false).getAttribute("search_fdate"))){
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
    <script src="DataTables/datatables.min.js"></script>
    <script>

            
        var botonFiltrar=document.getElementById("botonSearch");
        console.log(botonFiltrar);
        botonFiltrar.addEventListener('click', function() {
            var formatoFecha = /^(\d{4}-\d{2}-\d{2})?$/;
                        var fechaini= document.getElementById("fechainicial").value;
                        var fechafina= document.getElementById("fechafinal").value;
                        var keyword=document.getElementById("inputKeyword");
                        var cat=document.getElementById("inputCat");
                        if(!formatoFecha.test(fechaini)|| !formatoFecha.test(fechafina)){
                            window.alert("Ingresa una fecha válida (Formato yyyy-mm-dd o vacío)"); 
                            event.preventDefault();
                        }
                        if(fechaini!==""){
                            var date= Date.parse(fechaini);
                            if(isNaN(date)){
                                window.alert("Fecha inicial no es una fecha valida"); 
                                event.preventDefault();
                            }
                        }
                        if(fechafina!==""){
                            var date= Date.parse(fechafina);
                            if(isNaN(date)){
                                window.alert("Fecha final no es una fecha valida"); 
                                event.preventDefault();
                            }
                        }
                        });
        function filtrarInput(event) {
  
            var keyCode = event.keyCode || event.which;

            if (
                (keyCode >= 48 && keyCode <= 57) || 
                (keyCode >= 96 && keyCode <= 105) ||
                keyCode === 189 || 
                keyCode === 109 || keyCode === 8 || event.shiftKey || keyCode === 37 || keyCode === 39
            ) {
    
                return true;
            }
            else {
                 event.preventDefault();
                return false;
            }
        }
      $('#tablapublicaciones').DataTable({
                "paging":true,
                "pagingType":"full_numbers",
                "dom": '<"top"lp>rt<"bottom"lp><"clear">',
                "language": {
                    "emptyTable":"¡Publica tu primer post para verlos aquí!",
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
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
</body>
<footer class="fixed-bottom">
  <div class="text-center p-1 " style="background-color: #d5d5b9;">
    <iframe class="ifFooter" src="footer.html" frameborder="0"></iframe>
  </div>
</footer>
</html>