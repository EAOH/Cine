<%-- 
    Document   : Empleados
    Created on : 11-26-2020, 10:13:00 AM
    Author     : Elio Hernandez
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="database.Dba"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%    if(session.getAttribute("Puesto")!=null){
        if(!session.getAttribute("Puesto").equals("Empleado") ){
            request.getRequestDispatcher("index.jsp").forward(request,response);
        }} else{ request.getRequestDispatcher("index.jsp").forward(request,response);}%>
<html>
    <head>
        <link rel="shortcut icon" type="image/x-icon" href="Recursos Imagenes/Icono.ico">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/data-table/bootstrap-table.css">
        <link rel="stylesheet" href="css/data-table/bootstrap-editable.css">
        <link rel="stylesheet" href="css/modal.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cartelera</title>
    </head>
    <script>
        function Validar(Codigo,Tabla){
            if(Tabla==="Sala"){
                    document.getElementById("Txt_Sala").value=Codigo;
            } else{
                document.getElementById("Txt_Pelicula").value=Codigo;
            }
        }
    </script>
<%
    if(request.getParameter("Btn_crear")!=null){
        Dba db =new Dba(); 
      db.Conectar();
        
      try{
          int Contador=db.query.executeUpdate("Insert into T_Exhibicion values (Codigos.nextval,'" + request.getParameter("Text_Sala") + "','" + request.getParameter("Text_Pelicula") + 
                  "',TO_DATE('" + request.getParameter("Date_Fecha") +" " +request.getParameter("Time_Hora")+"','yyyy-mm-dd hh24:mi'))");
          if(Contador>=1){
                        out.print("<script>alert('Transaccion exitosa');</script>");
                    }
                    db.commit();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            db.desconectar();
    }
    if(request.getParameter("Btn_Eliminar")!=null){
        Dba db =new Dba();
      db.Conectar();
        
      try{           
          int Contador=db.query.executeUpdate("delete from T_Exhibicion where Exh_Codigo='" + request.getParameter("Codigo") + "'");
          db.commit();
          db.desconectar();
          if(Contador>=1){
                        out.print("<script>alert('Transaccion exitosa');</script>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    db.desconectar();
                }
    }
%>
    <body>
        <!-- Static Table Start -->
        <div class="data-table-area mg-tb-15">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        <div class="sparkline13-list">
                            <div class="sparkline13-hd">
                                <div class="main-sparkline13-hd">
                                    <Center><h1>Pelicula</h1></center>
                                </div>
                            </div>
                            <form name="Frm_Nuevo" action="Cartelera.jsp" method="POST">
                                <table border="1" style="border-color: rgba(105,82,162,255)">
                                    <tr>
                                        <td><center><h4>Salas</h4></center></td>
                                        <td><center><h4>Nueva Exhibicion</h4></center></td>
                                        <td><center><h4>Exhibiciones</h4></center></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table id="table" data-toggle="table" data-search="true"   data-click-to-select="true">
                                <thead>
                                    <tr>

                                        <th data-field="Codigo">Codigo</th>
                                        <th data-field="Ubicacion" data-editable="false">Ubicacion</th>
                                        <th data-field="Nombre" data-editable="false">Nombre</th>
                                        <th data-field="Formato" data-editable="false">Formato</th>
                                        <th data-field="Generar" data-editable="false">Generar</th>
                                    </tr>
                                </thead>
                                <tbody>

                                    <% Dba db =new Dba();
                                       db.Conectar();
                                       try{
                                           db.query.execute("select SAL_CODIGO, UBI_NOMBRE, SAL_NOMBRE, SAL_FORMATO from ver_Sala");
                                           ResultSet rs=db.query.getResultSet();
                                           while (rs.next()) {
                                               %>
                                               <tr>
                                                   <td><%= rs.getInt(1) %></td>
                                                   <td><%= rs.getString(2)%></td>
                                                   <td><%= rs.getString(3) %></td>
                                                   <td><%= rs.getString(4) %></td>
                                                   <td><input type="button" value="Generar" 
                                                    onclick="Validar('<%= rs.getInt(1) %>','Sala')"/></td>
                                               </tr> <% 
                                       }}catch(Exception e)
                                            { e.printStackTrace();      }
                                        db.desconectar();

                                     %>
                                </tbody>
                            </table>
                                        </td>
                                        <td>
                                             <table border="0">
                                    <tbody>
                                        <tr>
                                            <td>Sala:</td>
                                            <td><input id="Txt_Sala" type="text" name="Text_Sala" value="" required="required" readonly="readonly" />
                                            <input id="Txt_FormatoS" type="hidden" name="Text_FormatoS" value="" required="required"/></td>
                                        </tr>
                                        <tr>                                            
                                            <td>Pelicula</td>
                                            <td><input id="Txt_Pelicula" type="text" name="Text_Pelicula" value="" required="required" readonly="readonly" />
                                            <input id="Txt_FormatoP" type="hidden" name="Text_FormatoP" value="" required="required" /></td>                                            
                                        </tr>
                                        <tr>                                            
                                            <td>Fecha:</td>
                                            <td><input id="Dp_Fecha" type="date" name="Date_Fecha" value="" required="required" /></td>
                                            <td>Hora:</td>
                                            <td><input id="Dp_Hora" type="time" name="Time_Hora" value="" required="required" /></td>
                                        </tr>
                                    </tbody>
                                </table>       <br>           
                                            <input type="submit" value="Crear Exhibicion" name="Btn_crear" /><br>                      
                                        </td>
                                        <td>
                                            <table id="table" data-toggle="table" data-search="true"   data-click-to-select="true">
                                <thead>
                                    <tr>

                                        <th data-field="Codigo">Codigo</th>
                                        <th data-field="Ubicacion" data-editable="false">Compañia</th>
                                        <th data-field="Ubicacion" data-editable="false">Ubicacion</th>
                                        <th data-field="Ubicacion" data-editable="false">Sala</th>
                                        <th data-field="Nombre" data-editable="false">Pelicula</th>
                                        <th data-field="Formato" data-editable="false">Fecha</th>
                                        <th data-field="Hora" data-editable="false">Hora</th>
                                        <th data-field="Generar" data-editable="false">Operacion</th></tr>
                                </thead>
                                <tbody>

                                    <%
                                       db.Conectar();
                                       try{
                                           db.query.execute("select EXH_CODIGO, CIN_NOMBRE, UBI_NOMBRE,SAL_NOMBRE, PEL_TITULO,EXH_FECHA from ver_Presentaciones");
                                           ResultSet rs=db.query.getResultSet();
                                           while (rs.next()) {
                                               %>
                                               <tr>
                                                   <td><%= rs.getInt(1) %></td>
                                                   <td><%= rs.getString(2)%></td>
                                                   <td><%= rs.getString(3) %></td>
                                                   <td><%= rs.getString(4) %></td>
                                                   <td><%= rs.getString(5) %></td>
                                                   <td><%= rs.getDate(6) %> </td>
                                                   <td><%= rs.getTime(6) %> </td>
                                                   <td><input type="button" value="Cancelar" 
                                                    onclick="window.location='Cartelera.jsp?Codigo=<%=rs.getInt(1)%>&Btn_Eliminar=1'"/></td>
                                               </tr> <% 
                                       }}catch(Exception e)
                                            { e.printStackTrace();      }
                                        db.desconectar();

                                     %>
                                </tbody>
                            </table>
                            </td>
                                    </tr>
                                </table>
                            </form> <br> <br> 

                            <table id="table" data-toggle="table" data-search="true"   data-click-to-select="true">
                                <thead>
                                    <tr>

                                        <th data-field="Codigo">Codigo</th>
                                        <th data-field="Cartelera" data-editable="false">Cartelera</th>
                                        <th data-field="Titulo" data-editable="false">Titulo</th>
                                        <th data-field="Sinopsis" data-editable="false">Sinopsis</th>
                                        <th data-field="Generos" data-editable="false">Generos</th>
                                        <th data-field="Audio" data-editable="false">Audio</th>
                                        <th data-field="Subtitulos" data-editable="false">Subtitulos</th>
                                        <th data-field="Duracion" data-editable="false">Duracion</th>
                                        <th data-field="FOrmato" data-editable="false">Formato</th>
                                        <th data-field="Edad minima" data-editable="false">Edad minima</th>
                                        <th data-field="operacion" data-editable="false">Operaciones</th>
                                    </tr>
                                </thead>
                                <tbody>

                                    <%
                                       db.Conectar();
                                       try{
                                           db.query.execute("select * from ver_Pelicula");
                                           ResultSet rs=db.query.getResultSet();
                                           while (rs.next()) {
                                               %>
                                               <tr>
                                                   <td><%= rs.getInt(1) %></td>
                                                   <td><img srcset="<%= rs.getString(2)%>" width="100px" height="150px"></td>
                                                   <td><%= rs.getString(3) %></td>
                                                   <td><label style="width: 200px; text-align: justify;"><%= rs.getString(4) %></label></td>
                                                   <td><%= rs.getString(5) %></td>
                                                   <td><%= rs.getString(6) %></td>
                                                   <td><%= rs.getString(8) %></td>
                                                   <td><%= rs.getString(10) %></td>
                                                   <td><%= rs.getString(12) %></td>
                                                   <td><%= rs.getString(13) %></td>
                                                   <td><input type="button" value="Generar" 
                                                    onclick="Validar('<%= rs.getInt(1) %>','Pelicula')"/></td>
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