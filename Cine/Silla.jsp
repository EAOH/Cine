<%-- 
    Document   : Silla
    Created on : 12-01-2020, 11:23:02 AM
    Author     : Elio Hernandez
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="database.Dba"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%    if (session.getAttribute("Puesto") != null) {
        if (!session.getAttribute("Puesto").equals("Empleado")) {
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    } else {
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }%>
<html>
    <head>
        <link rel="shortcut icon" type="image/x-icon" href="Recursos Imagenes/Icono.ico">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/data-table/bootstrap-table.css">
        <link rel="stylesheet" href="css/data-table/bootstrap-editable.css">
        <link rel="stylesheet" href="css/modal.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Silla</title>
    </head>
    <%
        if (request.getParameter("Btn_Agregar") != null) {
            Dba db = new Dba();
            db.Conectar();
            try {
                int Contador = db.query.executeUpdate("Insert into T_Silla values ('" + request.getParameter("Txt_Codigo") + "','"
                        + request.getParameter("Number_Fila") + "','" + request.getParameter("Number_Columna") + "')");
                if (Contador >= 1) {
                    out.print("<script>alert('Transaccion exitosa');</script>");
                }
                db.commit();
            } catch (Exception e) {
                e.printStackTrace();
            }
            db.desconectar();
        }
        if (request.getParameter("Btn_Modificar") != null) {
            Dba db = new Dba();
            db.Conectar();
            try {
                int Contador = db.query.executeUpdate("Update T_Silla set Sil_Cantidad='" + request.getParameter("Number_Columna") + "' "
                                + "where Sal_Codigo='" + request.getParameter("Txt_Codigo") + "' and Sil_Fila='" + request.getParameter("Number_Fila") +"'");
                if (Contador >= 1) {
                    out.print("<script>alert('Transaccion exitosa');</script>");
                }
                db.commit();
            } catch (Exception e) {
                e.printStackTrace();
            }
            db.desconectar();
        }%>
    <body>
        <%if (request.getParameter("Accion") != null) {
                if (request.getParameter("Accion").equals("Agregar")) {%>
        <form  name = "Frm_Agregar" action = "Silla.jsp?Accion=<%=request.getParameter("Accion")%>&Codigo=<%=request.getParameter("Codigo")%>" method = "POST">
            <table border="0">
                <tbody>
                    <tr>
                        <td>Codigo:</td>
                        <td><input border="0" type="Text" name="Txt_Codigo" value="<%= request.getParameter("Codigo")%>" readonly="readonly"/></td>
                    </tr>
                    <tr>
                        <td>Fila:</td>
                        <td><input type="number" id="NUD_Fila" name="Number_Fila" min="1" max="26" step="1"></td>
                    </tr>
                    <tr>
                        <td>Columna:</td>
                        <% Dba db = new Dba();
                            db.Conectar();
                            try {
                                db.query.execute("select Sum(Sil_Cantidad) from ver_Silla where Sal_Codigo='" + request.getParameter("Codigo") + "'");
                                ResultSet rs = db.query.getResultSet();
                                while (rs.next()) {
                        %>

                        <td><input type="number" id="NUD_Columna" name="Number_Columna" min="0" max="<%= 200 - rs.getInt(1)%>" step="1"></td>
                            <%
                                    }
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                                db.desconectar();

                            %>
                    </tr>
                </tbody>
            </table>
            <input type="submit" value="Agregar fila de sillas" name="Btn_Agregar" />

        </form>


        <%} else if (request.getParameter("Accion").equals("Modificar")) {
            Dba db = new Dba();
            db.Conectar();
            try {
                db.query.execute("select Sal_Codigo,Sil_Fila,Sil_Cantidad , (select sum(Sil_Cantidad) from ver_Silla where Sal_Codigo='" + request.getParameter("Codigo") +"')"
                               + " from ver_Silla where Sal_Codigo='" + request.getParameter("Codigo") + "' order by Sil_Fila asc");
                ResultSet rs = db.query.getResultSet();
                while (rs.next()) {
        %>
        <form  name = "Frm_Agregar" action = "Silla.jsp?Accion=<%=request.getParameter("Accion")%>&Codigo=<%=request.getParameter("Codigo")%>" method = "POST">
            <input border="0" type="hidden" name="Txt_Codigo" value="<%= rs.getInt(1) %>" readonly="readonly"/>
            <table border="0">
                <tbody>
                    <tr>
                        <td>Fila:</td>
                        <td><input type="number" id="NUD_Fila" name="Number_Fila" min="1" max="26" step="1" value="<%= rs.getInt(2) %>" readonly="readonly"></td>
                    </tr>
                    <tr>
                        <td>Columna:</td>
                        <td><input type="number" id="NUD_Columna" name="Number_Columna" min="0" max="<%= 200 - rs.getInt(4) + rs.getInt(3) %>" value="<%= rs.getInt(3) %>" step="1"></td>
                        </tr>
                </tbody>
            </table>
            <input type="submit" value="Modificar fila de sillas" name="Btn_Modificar" />

        </form><hr style="border-color: rgba(105,82,162,255);">
                        <%
                                    }
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                                db.desconectar();
                                }}

                            %>
        


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
