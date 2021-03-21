<%-- 
    Document   : PrincipalE
    Created on : 11-26-2020, 07:56:22 AM
    Author     : Elio Hernandez
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%    if(session.getAttribute("Puesto")!=null){
        if(!session.getAttribute("Puesto").equals("Empleado") ){
            request.getRequestDispatcher("index.jsp").forward(request,response);
        }} else{ request.getRequestDispatcher("index.jsp").forward(request,response);}
         
        String Direccion="";
        if(request.getParameter("Destino")!=null){
            Direccion=request.getParameter("Destino") + ".jsp";
        }
        %>
<html>
    <head>
        <link rel="shortcut icon" type="image/x-icon" href="Recursos Imagenes/Icono.ico">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/data-table/bootstrap-table.css">
        <link rel="stylesheet" href="css/data-table/bootstrap-editable.css">
        <link rel="stylesheet" href="css/modal.css">
        <link href="css/Side-Navigation.css" rel="stylesheet" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menu principal</title>
    </head>
    
    <% if (request.getParameter("Btn_Cerrar")!=null){
        session.invalidate();
        request.getRequestDispatcher("index.jsp").forward(request,response);
    }
    %>
    
    <body>
        
        <div id="mySidenav" class="sidenav">
            <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
            <a href="PrincipalE.jsp?Destino=Compañia">Compañias</a>
            <a href="PrincipalE.jsp?Destino=Sucursal">Sucursal</a>
            <a href="PrincipalE.jsp?Destino=Sala">Sala</a>
            <a href="PrincipalE.jsp?Destino=Pelicula">Pelicula</a>
            <a href="PrincipalE.jsp?Destino=Precios">Precios</a>
            <a href="PrincipalE.jsp?Destino=Cartelera">Cartelera</a>
            <a href="PrincipalE.jsp?Destino=Empleados">Empleados</a>
            <a href="index.jsp?Btn_Cerrar=Cerrar">Salir</a>
        </div>
        <div class="container-fluid" style="width: 100%; height: 100%;">
        <span style="font-size:30px;cursor:pointer" onclick="openNav()">&#9776; Navegar</span>
        <iframe  src="<%=Direccion%>" style="width: 100%; height: 600px; border-color: rgba(105,82,162,255);" ></iframe>
        
        </div>        
        
        <!-- jquery
                    ============================================ -->
        <script src="js/JQuery/jquery-1.11.3.min.js"></script>
        <!-- bootstrap JS
                    ============================================ -->
        <script src="js/bootstrap.min.js"></script>

        <!-- data table JS
                    ============================================ -->
        <script src="js/data-table/bootstrap-table.js"></script>
        <script src="js/modal.js"></script>
        <script src="js/data-table/tableExport.js"></script>
        <script src="js/data-table/data-table-active.js"></script>
        <script src="js/data-table/bootstrap-table-editable.js"></script>
        <script src="js/data-table/bootstrap-editable.js"></script>
        <script src="js/data-table/bootstrap-table-resizable.js"></script>
        <script src="js/data-table/colResizable-1.5.source.js"></script>
        <script src="js/data-table/bootstrap-table-export.js"></script>

        <!-- tab JS
                    ============================================ -->
        <script src="js/tab.js"></script>
        
        <script src="js/Side-Navigator.js" type="text/javascript"></script>
        
        
    </body>
</html>
 