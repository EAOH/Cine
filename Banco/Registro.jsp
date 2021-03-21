<%-- 
    Document   : Registro
    Created on : 12-10-2020, 10:33:09 AM
    Author     : Elio Hernandez
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="database.Dba"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%    if(session.getAttribute("Tarjeta")==null){
            request.getRequestDispatcher("index.jsp").forward(request,response);}

%>
<html>
    <head>
        <link rel="shortcut icon" type="image/x-icon" href="Imagenes/Icono.ico">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/data-table/bootstrap-table.css">
        <link rel="stylesheet" href="css/data-table/bootstrap-editable.css">
        <link rel="stylesheet" href="css/modal.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registro de tarjetas</title>
    </head>
    <%
        if(request.getParameter("Btn_Depositar")!=null){
        Dba db =new Dba(); 
      db.Conectar();     
      try{    int Contador=db.query.executeUpdate("Update T_Tarjeta set Tar_Saldo= (Tar_Saldo + '"+request.getParameter("Text_Monto")+ "') "
              + "where Tar_Codigo='" +request.getParameter("Text_Numero") + "'");
          db.commit();
          db.desconectar();
          if(Contador>=1){
                        out.print("<script>alert('Transaccion exitosa');</script>");}
                    
                } catch (Exception e) {
                    e.printStackTrace();
                    db.desconectar();
                }
         
    }
        if(request.getParameter("Btn_Retirar")!=null){
        Dba db =new Dba(); 
      db.Conectar();     
      try{    int Contador=db.query.executeUpdate("Update T_Tarjeta set Tar_Saldo= (Tar_Saldo - '"+request.getParameter("Text_Monto")+ "') "
              + "where Tar_Codigo='" +request.getParameter("Text_Numero") + "' and Tar_Saldo>='" + request.getParameter("Text_Monto") + "'");
          db.commit();
          db.desconectar();
          if(Contador>=1){
                        out.print("<script>alert('Transaccion exitosa');</script>");}
                    
                } catch (Exception e) {
                    e.printStackTrace();
                    db.desconectar();
                }
         
    }
    %>
    <body>
        <input style=" color:white; background-color: rgba(0,113,188,255); border-color: rgba(0,113,188,255)"  type="button" value="Salir" name="Btn_Salir" onclick="window.location='index.jsp'" />
        <br>
        <div class="data-table-area mg-tb-15">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        <div class="sparkline13-list">
                            <div class="sparkline13-hd">
                                <div class="main-sparkline13-hd">
                                </div>
                            </div>

                            <form name="Frm_Nuevo" action="Registro.jsp" method="POST">
                                <table border="1" style="border-color: rgba(105,82,162,255)">
                                    <tr>
                                        <td><center><h4>Transacciones</h4></center></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table border="0">
                                                <tbody>
                                                    <tr>
                                                        <td>Numero de tarjeta:</td>
                                                        <td> <input type="text" name="Text_Numero" value="<%=session.getAttribute("Clave")%>" required="required" readonly="readonly" /> </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Monto:</td>
                                                        <td><input  type="Text" name="Text_Monto" value="" required="required" /></td>
                                                    </tr>
                                                </tbody>
                                            </table>      <br>           
                                            <input style=" color:white; background-color: rgba(0,113,188,255); border-color: rgba(0,113,188,255)"  type="submit" value="Depositar" name="Btn_Depositar" />
                                            <input style=" color:white; background-color: rgba(0,113,188,255); border-color: rgba(0,113,188,255)"  type="submit" value="Retirar" name="Btn_Retirar" /><br>                      
                                        </td>
                                    </tr>
                                </table>
                            </form> <br> <br> 
                            <Center><h1>Historial de transacciones</h1></center>

                            <table id="table" data-toggle="table" data-search="true"   data-click-to-select="true">
                                <thead>
                                    <tr>

                                        <th data-field="Numero">Numero de Tarjeta</th>
                                        <th data-field="Id" data-editable="false">Identidad</th>
                                        <th data-field="Nombre" data-editable="false">Nombre</th>
                                        <th data-field="Vence" data-editable="false">Fecha de vencimiento</th>
                                        <th data-field="Tipo de tarjeta" data-editable="false">Tipo de tarjeta</th>
                                        <th data-field="Transaccion#" data-editable="false">Numero de transaccion</th>
                                        <th data-field="Descripcion" data-editable="false">Descripcion</th>
                                        <th data-field="Monto" data-editable="false">Monto de la transacion</th>
                                        <th data-field="Saldo Anterior" data-editable="false">Saldo anterior</th>
                                        <th data-field="Saldo nuevo" data-editable="false">Saldo actualizado</th>
                                        <th data-field="Fecha" data-editable="false">Fecha de la transaccion</th>
                                    </tr>
                                </thead>
                                <tbody>

                                    <% Dba db =new Dba();
                                       db.Conectar();
                                       try{
                                           db.query.execute("select * from ver_Solicitudes where TAR_ID='" + session.getAttribute("Tarjeta") + "' and Tar_Codigo='" +session.getAttribute("Clave")+"' order by Sol_Fecha desc");
                                           ResultSet rs=db.query.getResultSet();
                                           while (rs.next()) {
                                               %>
                                               <tr>
                                                   <td><%= rs.getInt(1) %></td>
                                                   <td><%= rs.getString(2) %></td>
                                                   <td><%= rs.getString(3)%></td>
                                                   <td><%= rs.getDate(4) %></td>
                                                   <td><%= rs.getString(5) %></td>
                                                   <td><%= rs.getInt(6) %></td>
                                                   <td><%= rs.getString(7) %></td>
                                                   <td><%= rs.getFloat(8) %></td>
                                                   <td><%= rs.getFloat(9) %></td>
                                                   <td><%= rs.getFloat(10) %></td>
                                                   <td><%= rs.getDate(11) %> | <%= rs.getTime(11) %></td>
                                               </tr> <% 
                                       }}catch(Exception e)
                                            { e.printStackTrace();      }
                                        db.desconectar();

                                     %>
                                </tbody>
                            </table>
                        </div>
                    </div>
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
