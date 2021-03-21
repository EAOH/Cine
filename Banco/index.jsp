<%-- 
    Document   : index
    Created on : 12-10-2020, 10:34:00 AM
    Author     : Elio Hernandez
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="database.Dba"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="shortcut icon" type="image/x-icon" href="Imagenes/Icono.ico">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/data-table/bootstrap-table.css">
        <link rel="stylesheet" href="css/data-table/bootstrap-editable.css">
        <link rel="stylesheet" href="css/modal.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registrarse</title>
    </head>
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
                db.query.execute("SELECT * FROM Ver_Tarjetas WHERE Tar_Id='"
                        + request.getParameter("Txt_Usuario") + "' and Tar_Codigo='" + request.getParameter("Txt_pass") + "'");
                ResultSet rs = db.query.getResultSet();
                while (rs.next()) {
                    session.setAttribute("Tarjeta", request.getParameter("Txt_Usuario"));
                    session.setAttribute("Clave", request.getParameter("Txt_pass"));
                    request.getRequestDispatcher("Registro.jsp").forward(request, response);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            db.desconectar();
        }
        if (request.getParameter("Btn_crear") != null) {
            Dba db = new Dba();
            db.Conectar();

            try {
                int Contador = db.query.executeUpdate("Insert into T_Tarjeta values ('" + request.getParameter("Text_Numero") + "','" + request.getParameter("Text_Id") + "','"
                        + request.getParameter("Text_Nombre") + "','" + request.getParameter("Text_direccion") + "',To_Date('" + request.getParameter("Date_Nacido") + "','yyyy-mm-dd'),'"
                        + request.getParameter("Combo_Sexo") + "','" + request.getParameter("Text_Saldo") + "','" + request.getParameter("Text_Correo") + "','" + request.getParameter("Text_Tel") + "','"
                        + request.getParameter("Text_Cel") + "',To_Date('" + request.getParameter("Date_Vence") + "','yyyy-mm-dd'),'" + request.getParameter("Text_Pass") + "','"
                        + request.getParameter("Combo_Tipo") + "')");
                if (Contador >= 1) {
                    out.print("<script>alert('Transaccion exitosa');</script>");
                }
                db.commit();
            } catch (Exception e) {
                e.printStackTrace();
            }
            db.desconectar();
        }
    %>
    <body>
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
                            <td><img class="img-fluid" src="Imagenes/Icono.png" alt="Login"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="w-25"><b>Identidad:</b></td>
                        </tr>
                        <tr>
                            <td><input id="Id_Uss" type="text" name="Txt_Usuario" value="" placeholder="Usuario" required="required" /></td>
                        </tr>
                        <tr>
                            <td><b>Codigo de tarjeta:</b></td>
                        </tr>
                        <tr>
                            <td><input id="Id_Pass" type="password" name="Txt_pass" value="" placeholder="Contraseña" required="required" /></td>
                        </tr>
                        <tr>
                            <td><br><input style=" color:white; background-color: rgba(0,113,188,255); border-color: rgba(0,113,188,255)" type="submit" value="Ingresar" name="Btn_Ingresar"/></td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>

        <div class="row">
            <div class="col-12 text-right">
                <input style=" color:white; background-color: rgba(0,113,188,255); border-color: rgba(0,113,188,255)" 
                       type="button" value="Iniciar Sesion" name="Btn_Sesion" onclick="modal.style.display = 'block';" />
            </div>
        </div>
        <br>
        <div class="container">
            <div class="row">
                <div class="col-12 text-center justify-content-center">

                    <form name="Frm_Nuevo" action="index.jsp" method="POST">
                        <table border="1" style="border-color: rgba(0,113,188,255)">
                            <tr>
                                <td><center><h4>Registrarse</h4></center></td>
                            </tr>
                            <tr>
                                <td>
                                    <table border="0" style=" color: white; background-color: rgba(0,159,218,255);">
                                        <tbody>
                                            <tr>
                                                <%
                                                    Dba db = new Dba();
                                                    db.Conectar();
                                                    try {
                                                        db.query.execute("SELECT count(Tar_Codigo)+1 FROM Ver_Tarjetas");
                                                        ResultSet rs = db.query.getResultSet();
                                                        while (rs.next()) {%>
                                                <td>Numero de tarjeta:</td>
                                                <td> <input type="text" name="Text_Numero" value="<%= rs.getInt(1)%>" required="required" readonly="readonly" /> </td>
                                                    <% }
                                                        } catch (Exception e) {
                                                            e.printStackTrace();
                                                        }
                                                        db.desconectar();
                                                    %>
                                            </tr>
                                            <tr>
                                                <td>Identidad:</td>
                                                <td> <input type="text" name="Text_Id" value="" required="required" /> </td>
                                            </tr>
                                            <tr>
                                                <td>Nombre completo:</td>
                                                <td><input  type="text" name="Text_Nombre" value="" required="required" /></td>
                                            <tr>
                                                <td>Direccion:</td>
                                                <td><textarea  name="Text_direccion" rows="4" cols="20" required="required"></textarea></td>
                                                <td>Fecha de nacimiento:</td>
                                                <td><input type="date" name="Date_Nacido" value="" required="required"/></td>
                                            </tr>
                                            <tr>
                                                <td>Sexo:</td>
                                                <td><select name="Combo_Sexo" required="required">
                                                        <option></option>
                                                        <option>Masculino</option>
                                                        <option>Femenino</option>
                                                    </select></td>
                                            </tr>
                                            <tr>
                                                <td>Saldo:</td>
                                                <td><input  type="Text" name="Text_Saldo" value="" required="required" /></td>
                                            </tr>
                                            <tr>
                                                <td>Correo:</td>
                                                <td><input type="text" name="Text_Correo" value="" /></td>
                                                <td>Telefono:</td>
                                                <td><input type="Text" name="Text_Tel" value="" /></td>
                                                <td>Celular:</td>
                                                <td><input type="Text" name="Text_Cel" value="" /></td>
                                            </tr>
                                            <tr>
                                                <td>Fecha de vencimiento:</td>
                                                <td><input type="date" name="Date_Vence" value="" required="required" /></td>
                                            </tr>
                                            <tr>
                                                <td>Codigo de seguridad:</td>
                                                <td><input type="password" name="Text_Pass" value="" required="required" /></td></tr>
                                            <tr>
                                                <td>Tipo:</td>
                                                <td><select name="Combo_Tipo" required="required">
                                                        <option></option>
                                                        <option>Credito</option>
                                                        <option>Debito</option>
                                                    </select></td>
                                            </tr>

                                        </tbody>
                                    </table>      <br>           
                                    <input style=" color:white; background-color: rgba(0,113,188,255); border-color: rgba(0,113,188,255)"  type="submit" value="Crear Empleado" name="Btn_crear" /><br>                      
                                </td>
                            </tr>
                        </table>
                    </form> <br> <br>
                </div>
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
