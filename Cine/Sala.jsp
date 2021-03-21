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
        <title>Sala</title>
    </head>
    <script> 
           function mod(Codigo,Ubicacion,Nombre,Descripcion,Formato){
                var modal2 = document.getElementById("myModal");
                modal.style.display = "block"; 
                document.getElementById("Txt_Codigo").value=Codigo;
                document.getElementById("Txt_Ubicacion").value=Ubicacion;
                document.getElementById("Txt_Nombre").value=Nombre;
                document.getElementById("Txt_Descripcion").value=Descripcion;
                document.getElementById("Cb_Formato").value=Formato;
                Pagina("IF_Modificar","Modificar",Codigo);
                
            }
            
            function Pagina(Caja,Accion,Codigo){
        document.getElementById(Caja).src="Silla.jsp?Accion=" + Accion + "&Codigo=" + Codigo;}
        </script>
<%
    if(request.getParameter("Btn_modificar")!=null){
        Dba db =new Dba(); 
      db.Conectar();     
      try{    int Contador=db.query.executeUpdate("Update T_SALA set Sal_Nombre='" + request.getParameter("Text_Nombre")+
                  "',Sal_Descripcion='" + request.getParameter("Text_Descripcion") + "',Sal_Formato='" + request.getParameter("Combo_Formato") + 
                  "' where Sal_Codigo='" + request.getParameter("Text_Codigo") + "'");
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
          int Contador=db.query.executeUpdate("Insert into T_Sala values (Codigos.nextval,'" + request.getParameter("Combo_Ubicacion") + "','" +
                  request.getParameter("Text_Nombre") + "','" + request.getParameter("Text_Descripcion") + "','" + request.getParameter("Combo_Formato") +"')");
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
          int Contador=db.query.executeUpdate("delete from T_Sala where Sal_Codigo='" + request.getParameter("Codigo") + "'");
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
                            <td><center><h4>Modificar Sala</h4></center></td>
                            <td><center><h4>Modificar FIla</h4></center></td>
                        </tr>
                        <tr>
                            <td>
                                <form name="Frm_Modificar" action="Sala.jsp" method="POST">
                                <input type="hidden" id="Txt_Codigo" name="Text_Codigo" value="" />
                                <table border="0">
                                    <tbody>
                                        <tr>
                                            <td>Ubicacion:</td>
                                            <td> <input border="0" id="Txt_Ubicacion" type="text" name="Text_Ubicacion" value="" readonly="readonly" /> </td>
                                            <td>Nombre:</td>
                                            <td> <input id="Txt_Nombre" type="text" name="Text_Nombre" value="" required="required" /> </td>
                                        </tr>
                                        <tr>
                                        <td>Descripcion:</td>
                                        <td><textarea id="Txt_Descripcion" name="Text_Descripcion" rows="4" cols="20" required="required"> </textarea></td>
                                        </tr>
                                        <tr>
                                            <td>Formato:</td>
                                            <td><select id="Cb_Formato" name="Combo_Formato" required="required">
                                                    <option></option>
                                                    <option>2D</option>
                                                    <option>3D</option>
                                                    <option>4D</option>
                                                    <option>Estreno</option>
                                                    <option>Privada</option>
                                                </select></td>
                                        </tr>
                                    </tbody>
                                </table>       <br>             
                                <input type="submit" value="Modificar Compañia" name="Btn_modificar" /><br>
                                </form>
                            </td>
                            <td colspan="3" ><iframe id="IF_Modificar" src="" style="width: 100%; height: 100%" frameborder="0" ></iframe></td>
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
                                    <Center><h1>Sala</h1></center>
                                </div>
                            </div>
                                
                                <table border="1" style="border-color: rgba(105,82,162,255)">
                                    
                                    <tr>
                                        <td><center><h4>Nueva Sala</h4></center></td>
                                        <td><center><h4>Nueva Fila</h4></center></td>
                                    </tr>
                                    <tr>
                                        <td><form name="Frm_Nuevo" action="Sala.jsp" method="POST">
                                             <table border="0">
                                    <tbody>
                                        <tr>
                                            <td>Ubicacion:</td>
                                            <td> <select id="Cb_Cine" name="Combo_Ubicacion" required="required">
                                                    <option></option>
                                                
                                        <% Dba db =new Dba();
                                       db.Conectar();
                                       try{
                                           db.query.execute("SELECT Ubi_Codigo,UBI_NOMBRE from Ver_Ubicacion");
                                           ResultSet rs=db.query.getResultSet();
                                           while (rs.next()) {
                                               %>
                                               <option value='<%= rs.getInt(1) %>'><%= rs.getString(2) %></option>
                                               <% 
                                       }}catch(Exception e)
                                            { e.printStackTrace();      }
                                        db.desconectar();

                                     %>
                                            </select></td>
                                            <td>Nombre:</td>
                                            <td> <input id="Txt_Nombre" type="text" name="Text_Nombre" value="" required="required" /> </td>
                                        </tr>
                                        <tr>
                                        <td>Descripcion:</td>
                                        <td><textarea id="Txt_Descripcion" name="Text_Descripcion" rows="4" cols="20" required="required"> </textarea></td>
                                        </tr>
                                        <tr>
                                            <td>Formato:</td>
                                            <td><select id="Cb_Formato" name="Combo_Formato" required="required">
                                                    <option></option>
                                                    <option>2D</option>
                                                    <option>3D</option>
                                                    <option>4D</option>
                                                    <option>Estreno</option>
                                                    <option>Privada</option>
                                                </select></td>
                                        </tr>
                                    </tbody>
                                </table>       <br>           
                                            <input type="submit" value="Crear Compañia" name="Btn_crear" /><br>
                                            </form>
                                        </td>
                                        <td>
                                                <table border="0">
                                                    <tbody>
                                                        <tr>
                                                            <td></td>
                                                        </tr>
                                                        <tr>
                                                            <td><iframe frameborder="0"  id="IF_Agregar" src="" style="width: 100%; height: 100%" ></iframe></td></tr>
                                                    </tbody>
                                                </table>
                                             </td>          </tr>
                                </table>
                             <br> <br> 

                            <table id="table" data-toggle="table" data-search="true"   data-click-to-select="true">
                                <thead>
                                    <tr>
                                        <th data-field="Seleccionar">Silla</th>
                                        <th data-field="Codigo">Codigo</th>
                                        <th data-field="Sala" data-editable="false">Sala</th>
                                        <th data-field="Nombre" data-editable="false">Nombre</th>
                                        <th data-field="Descripcion" data-editable="false">Descripcion</th>
                                        <th data-field="Formato" data-editable="false">Formato</th>
                                        <th data-field="Operacion" data-editable="false">Operaciones</th>
                                    </tr>
                                </thead>
                                <tbody>

                                    <%
                                       db.Conectar();
                                       try{
                                           db.query.execute("SELECT * from ver_Sala");
                                           ResultSet rs=db.query.getResultSet();
                                           while (rs.next()) {
                                               %>
                                               <tr>
                                                   <td><input type="button" value="Generar" name="Text_Generar" onclick="Pagina('IF_Agregar','Agregar','<%=rs.getInt(3)%>')" /></td>
                                                   <td><%= rs.getInt(3) %></td>
                                                   <td><%= rs.getString(2) %></td>
                                                   <td><%= rs.getString(4) %></td>
                                                   <td><%= rs.getString(5) %></td>
                                                   <td><%= rs.getString(6) %></td>
                                                   <td><input type="button" value="Eliminar" 
                                                    onclick="window.location='Sala.jsp?Codigo=<%=rs.getInt(3)%>&Btn_Eliminar=1'"/>
                                             <input type="button" value="Modificar" 
                                                    onclick="mod('<%= rs.getInt(3) %>','<%= rs.getString(2) %>','<%= rs.getString(4) %>','<%= rs.getString(5) %>','<%= rs.getString(6) %>')"/></td>
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