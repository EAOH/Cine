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
        <title>Precios</title>
    </head>
    <script> 
           function mod(Codigo,Cine,Descripcion,EdadMin,EdadMax,Precio,Formato){
                var modal2 = document.getElementById("myModal");
                modal.style.display = "block"; 
                document.getElementById("Txt_Codigo").value=Codigo;
                document.getElementById("Cb_Cine").value=Cine;
                document.getElementById("Txt_Descripcion").value=Descripcion;
                document.getElementById("Nud_EdadMin").value=EdadMin;
                document.getElementById("Nud_EdadMax").value=EdadMax;
                document.getElementById("Txt_Precio").value=Precio;
                document.getElementById("Cb_Formato").value=Formato;
                Edad('Nud_EdadMax','Nud_EdadMin');
            }
            function Edad(Caja,Text){
                document.getElementById(Caja).min= parseInt(document.getElementById(Text).value)+1;
            }
            
        </script>
<%
    if(request.getParameter("Btn_modificar")!=null){
        Dba db =new Dba(); 
      db.Conectar();     
      try{    int Contador=db.query.executeUpdate("Update T_Precio set Cin_Codigo='" + request.getParameter("Combo_Cine")+
                  "',Pre_Descripcion='" + request.getParameter("Text_Descripcion") + "',Pre_Edad_Min='" + request.getParameter("Number_EdadMin") + 
              "', Pre_Edad_Max='" + request.getParameter("Number_EdadMax") + "', Pre_Precio='" + request.getParameter("Text_Precio") + 
              "', Pre_Formato='" + request.getParameter("Combo_Formato") + "'" +
                  " where Pre_Codigo='" + request.getParameter("Text_Codigo") + "'");
          db.commit();
          db.desconectar();
          if(Contador>=1){
                        out.print("<script>alert('Transaccion exitosa');</script>");}
                    
                } catch (Exception e) {
                    e.printStackTrace();
                    db.desconectar();
                }
         
    }
    if(request.getParameter("Btn_crear")!=null){
        Dba db =new Dba(); 
      db.Conectar();
        
      try{           
          int Contador=db.query.executeUpdate("Insert into T_Precio values (Codigos.nextval,'" + request.getParameter("Combo_Cine") + "','" +
                   request.getParameter("Text_Descripcion") +  "','" + request.getParameter("Number_EdadMin") + "','" +
                  request.getParameter("Number_EdadMax") +"','" + request.getParameter("Text_Precio") + "','" + request.getParameter("Combo_Formato") + "')");
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
          int Contador=db.query.executeUpdate("delete from T_Precio where Pre_Codigo='" + request.getParameter("Codigo") + "'");
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
        <div id="myModal" class="modal">  
            <div class="modal-content">
                <span class="close" onclick="modal.style.display = 'none';" >&times;</span>
                    <table border="1" style="border-color: rgba(105,82,162,255)" >
                        <tr>
                            <td><center><h4>Modificar</h4></center></td>
                        </tr>
                        <tr>
                            <td>
                                <form name="Frm_Modificar" action="Precios.jsp" method="POST">
                                <input type="hidden" id="Txt_Codigo" name="Text_Codigo" value="" />
                                <table border="0">
                                    <tbody>
                                        <tr>
                                            <td>Cine:</td>
                                            <td> <select id="Cb_Cine" name="Combo_Cine">
                                                    <option></option>
                                                    <% Dba db =new Dba();
                                       db.Conectar();
                                       try{
                                           db.query.execute("SELECT CIN_CODIGO,CIN_NOMBRE from Ver_Cine");
                                           ResultSet rs=db.query.getResultSet();
                                           while (rs.next()) {
                                               %>
                                               <option value='<%= rs.getInt(1) %>'><%= rs.getString(2) %></option>
                                               <% 
                                       }}catch(Exception e)
                                            { e.printStackTrace();      }
                                        db.desconectar();

                                     %>
                                                </select> </td>
                                         <td>Descripcion:</td>
                                        <td><textarea id="Txt_Descripcion" name="Text_Descripcion" rows="4" cols="20" required="required"> </textarea></td>
                                        </tr>
                                        <tr>
                                            <td>Edad minima:</td>
                                            <td> <input id="Nud_EdadMin" type="number" name="Number_EdadMin" value="0" min="0" max="200" step="1" required="required" onblur="Edad('Nud_EdadMax','Nud_EdadMin')" /> </td>
                                            <td>Edad maxima:</td>
                                            <td> <input id="Nud_EdadMax" type="number" name="Number_EdadMax" value="1" min="1" max="200" step="1" required="required" /> </td>
                                        </tr>
                                        <tr>
                                        <td>Precio:</td>
                                        <td><input id="Txt_Precio" type="text" name="Text_Precio" value="" required="required"  /></td>
                                        <td>Formato:</td>
                                            <td><select id="Cb_Formato" name="Combo_Formato" required="required">
                                                    <option></option>
                                                    <option>2D</option>
                                                    <option>3D</option>
                                                    <option>4D</option>
                                                </select></td>
                                        </tr>
                                    </tbody>
                                </table>       <br>             
                                <input type="submit" value="Modificar Precios" name="Btn_modificar" /><br>
                                </form>
                            </td>
                        </tr>
                    </table>
            </div>
        </div>
        <!-- Static Table Start -->
        <div class="data-table-area mg-tb-15">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        <div class="sparkline13-list">
                            <div class="sparkline13-hd">
                                <div class="main-sparkline13-hd">
                                    <Center><h1>Precios</h1></center>
                                </div>
                            </div>
                                
                                <table border="1" style="border-color: rgba(105,82,162,255)">
                                    
                                    <tr>
                                        <td><center><h4>Nueva Sala</h4></center></td>
                                    </tr>
                                    <tr>
                                        <td><form name="Frm_Nuevo" action="Precios.jsp" method="POST">
                                             <table border="0">
                                    <tbody>
                                        <tr>
                                            <td>Cine:</td>
                                            <td> <select id="Cb_Cine" name="Combo_Cine">
                                                    <option></option>
                                                    <% 
                                       db.Conectar();
                                       try{
                                           db.query.execute("SELECT CIN_CODIGO,CIN_NOMBRE from Ver_Cine");
                                           ResultSet rs=db.query.getResultSet();
                                           while (rs.next()) {
                                               %>
                                               <option value='<%= rs.getInt(1) %>'><%= rs.getString(2) %></option>
                                               <% 
                                       }}catch(Exception e)
                                            { e.printStackTrace();      }
                                        db.desconectar();

                                     %>
                                                </select> </td>
                                         <td>Descripcion:</td>
                                        <td><textarea id="Txt_Descripcion" name="Text_Descripcion" rows="4" cols="20" required="required"> </textarea></td>
                                        </tr>
                                        <tr>
                                            <td>Edad minima:</td>
                                            <td> <input id="Nud_EdadMin2" type="number" name="Number_EdadMin" value="0" min="0" max="200" step="1" required="required" onblur="Edad('Nud_EdadMax2','Nud_EdadMin2')" /> </td>
                                            <td>Edad maxima:</td>
                                            <td> <input id="Nud_EdadMax2" type="number" name="Number_EdadMax" value="1" min="1" max="200" step="1" required="required" /> </td>
                                        </tr>
                                        <tr>
                                        <td>Precio:</td>
                                        <td><input id="Txt_Precio" type="text" name="Text_Precio" value="" required="required"  /></td>
                                        <td>Formato:</td>
                                            <td><select id="Cb_Formato" name="Combo_Formato" required="required">
                                                    <option></option>
                                                    <option>2D</option>
                                                    <option>3D</option>
                                                    <option>4D</option>
                                                </select></td>
                                        </tr>
                                    </tbody>
                                </table>       <br>           
                                            <input type="submit" value="Crear Precios" name="Btn_crear" /><br>
                                            </form>
                                        </td>
                                                  </tr>
                                </table>
                             <br> <br> 

                            <table id="table" data-toggle="table" data-search="true"   data-click-to-select="true">
                                <thead>
                                    <tr>
                                        <th data-field="Codigo">Codigo</th>
                                        <th data-field="Cine" data-editable="false">Cine</th>
                                        <th data-field="Descripcion" data-editable="false">Descripcion</th>
                                        <th data-field="Edad minima" data-editable="false">Edad minima</th>
                                        <th data-field="Edad Maxima" data-editable="false">Edad Maxima</th>
                                        <th data-field="Precio" data-editable="false">Precio</th>
                                        <th data-field="Precio" data-editable="false">Formato</th>
                                        <th data-field="Operacion" data-editable="false">Operaciones</th>
                                    </tr>
                                </thead>
                                <tbody>

                                    <%
                                       db.Conectar();
                                       try{
                                           db.query.execute("SELECT * from ver_Precios");
                                           ResultSet rs=db.query.getResultSet();
                                           while (rs.next()) {
                                               %>
                                               <tr>
                                                   <td><%= rs.getInt(1) %></td>
                                                   <td><%= rs.getString(3) %></td>
                                                   <td><%= rs.getString(4) %></td>
                                                   <td><%= rs.getInt(5) %></td>
                                                   <td><%= rs.getInt(6) %></td>
                                                   <td><%= rs.getFloat(7) %></td>
                                                   <td><%= rs.getString(8) %></td>
                                                   <td><input type="button" value="Eliminar" 
                                                    onclick="window.location='Precios.jsp?Codigo=<%=rs.getInt(1)%>&Btn_Eliminar=1'"/>
                                             <input type="button" value="Modificar" 
                                                    onclick="mod('<%= rs.getInt(1) %>','<%= rs.getInt(2) %>','<%= rs.getString(4) %>','<%= rs.getInt(5) %>','<%= rs.getInt(6) %>','<%= rs.getFloat(7) %>','<%= rs.getString(8) %>')"/></td>
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