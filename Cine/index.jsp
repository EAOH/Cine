<%-- 
    Document   : index
    Created on : 11-16-2020, 11:27:06 AM
    Author     : Elio Hernandez
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="database.Dba"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% 
    if (session.getAttribute("Puesto") != null) {
        if (session.getAttribute("Puesto").equals("Empleado")) {
            request.getRequestDispatcher("PrincipalE.jsp").forward(request, response);
        } else if (session.getAttribute("Puesto").equals("Gerente")) {
            request.getRequestDispatcher("PrincipalG.jsp").forward(request, response);
        }
    }
%>
<html>
    <head>
        <link rel="shortcut icon" type="image/x-icon" href="Recursos Imagenes/Icono.ico">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/data-table/bootstrap-table.css">
        <link rel="stylesheet" href="css/data-table/bootstrap-editable.css">
        <link rel="stylesheet" href="css/modal.css">
        <script src="js/md5.js" type="text/javascript"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cine online</title>
    </head>
    
    <script>
        function modificarPASS(Nombre){
                var sinCifrar =document.getElementById(Nombre).value;           
            document.getElementById(Nombre).value=hex_md5(sinCifrar);     
        }
    </script>
    
    <script>
        function Cerrar() {
            var modal2 = document.getElementById("myModal");
            modal.style.display = "none";
            document.getElementById("Id_Uss").value = null;
            document.getElementById("Id_Pass").value = null;
        }
    </script>

    <%
        if (request.getParameter("Btn_Ingresar") != null) {
            Dba db = new Dba();
            db.Conectar();
            try {
                db.query.execute("SELECT Puesto FROM Login WHERE Usuario='"
                        + request.getParameter("Txt_Usuario") + "' and Clave='" + request.getParameter("Txt_pass") + "'");
                ResultSet rs = db.query.getResultSet();
                while (rs.next()) {
                    session.setAttribute("Usuario", request.getParameter("Txt_Usuario"));
                    session.setAttribute("Puesto", rs.getString(1));
                    if (rs.getString(1).equals("Empleado")) {
                        request.getRequestDispatcher("PrincipalE.jsp").forward(request, response);
                    } else {
                        request.getRequestDispatcher("PrincipalG.jsp").forward(request, response);
                    }

                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            db.desconectar();
        }
    %>

    <body style="background-color: rgba(153,0,0,255);">
        <div id="myModal" class="modal">  
            <div class="modal-content w-50">
                <div class="row justify-content-end">
                    <div class="col-12">
                        <span class="close" onclick="Cerrar()">&times;</span>
                    </div>
                </div>
                <form name="Frm_Login" action="index.jsp" method="POST">
                    <table border="0" style="text-align: center" class="w-auto">
                        <tr>
                            <td><img class="img-fluid" src="Recursos Imagenes/Login.png" alt="Login"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="w-25"><b>Usuario:</b></td>
                        </tr>
                        <tr>
                            <td><input id="Id_Uss" type="text" name="Txt_Usuario" value="" placeholder="Usuario" required="required" /></td>
                        </tr>
                        <tr>
                            <td><b>Contraseña:</b></td>
                        </tr>
                        <tr>
                            <td><input id="Id_Pass" type="password" name="Txt_pass" value="" placeholder="Contraseña" required="required" onchange="modificarPASS('Id_Pass')" /></td>
                        </tr>
                        <tr>
                            <td><br><input type="submit" value="Ingresar" name="Btn_Ingresar"/></td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
        <div class="container pt-5">
            <div class="row">
                <div class="col-12 text-right">
                    <input style=" border-radius: 10px; background-color: rgba(255,205,51,255); border-color: rgba(206,139,33,255)" 
                           type="button" value="Iniciar Sesion" name="Btn_Sesion" onclick="modal.style.display = 'block';" />
                </div>
            </div>
            <h1 class="text-uppercase" style="color: rgba(255,158,0,255)">Cartelera</h1>
            <div class="row justify-content-center">
                <% Dba db = new Dba();
                    db.Conectar();
                    try {
                        db.query.execute("select Distinct(PEL_CODIGO),Pel_Titulo,PEL_CARTELERA,Pel_Formato from ver_Presentaciones where EXH_FECHA>=sysdate");
                        ResultSet rs = db.query.getResultSet();
                        while (rs.next()) {
                %>
                <div class="col-2 text-center m-3">
                    <a href="Ticket.jsp?Codigo=<%=rs.getInt(1) %>" style="color: white">
                    <table border="0" style="background-color: rgba(88,0,0,255)">
                        <tbody>
                            <tr>
                                <td><h5><span style="background-color: black"><%=rs.getString(4) %></span></h5></td>
                            </tr>
                            <tr>
                                <td><img src="<%=rs.getString(3) %>" width="200px" height="250px"></td>
                            </tr>
                            <tr>
                                <td><h4><%=rs.getString(2) %></h4></td>
                            </tr>
                        </tbody>
                    </table></a>
                </div>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    db.desconectar();

                %>
            </div>
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


    </body>
</html>
