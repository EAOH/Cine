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
<html class="no-js" lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <link rel="shortcut icon" type="image/x-icon" href="Recursos Imagenes/Icono.ico">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/data-table/bootstrap-table.css">
        <link rel="stylesheet" href="css/data-table/bootstrap-editable.css">
        <link rel="stylesheet" href="css/modal.css">
        <title>Compañia</title>
    </head>
    
        <script> 
           function mod(Codigo,Nombre,Logo,Mision,Vision,Fundacion){
                var modal2 = document.getElementById("myModal");
                modal.style.display = "block"; 
                document.getElementById("Txt_Codigo").value=Codigo;
                document.getElementById("Txt_Nombre").value=Nombre;
                document.getElementById("Txt_Logo").value=Logo;
                document.getElementById("Txt_Mision").value=Mision;
                document.getElementById("Txt_Vision").value=Vision;
                document.getElementById("Dp_Fundacion").value=Fundacion;
                FotoA('Pb_Previa','Txt_Logo');
    }
    function FotoA(Caja,Texto){
        document.getElementById(Caja).srcset=document.getElementById(Texto).value;}
    </script>
<%
    if(request.getParameter("Btn_modificar")!=null){
        Dba db =new Dba(); 
      db.Conectar();     
      try{    int Contador=db.query.executeUpdate("Update T_Cine set Cin_Nombre='" + request.getParameter("Text_Nombre")+
                  "',Cin_Logo='" + request.getParameter("Text_Logo") + "',Cin_Mision='" + request.getParameter("Text_Mision") + 
                  "',Cin_Vision='" + request.getParameter("Text_Vision") + "',Cin_Fundacion='" + request.getParameter("Date_Fundacion") + 
                  "' where Cin_Codigo='" + request.getParameter("Text_Codigo") + "'");
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
          int Contador=db.query.executeUpdate("Insert into T_Cine values (Codigos.nextval,'" + request.getParameter("Text_Nombre") + "','" +
                  request.getParameter("Text_Logo") + "','" + request.getParameter("Text_Mision") + "','" + request.getParameter("Text_Vision") + "','"
                  + request.getParameter("Date_Fundacion") + "')");
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
          int Contador=db.query.executeUpdate("delete from T_Cine where Cin_Codigo='" + request.getParameter("Codigo") + "'");
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
                <form name="Frm_Modificar" action="Compañia.jsp" method="POST">
                    <input type="hidden" id="Txt_Codigo" name="Text_Codigo" value="" />
                    <table border="1" style="border-color: rgba(105,82,162,255)" >
                        <tr>
                            <td><center><h4>Modificar</h4></center></td>
                        </tr>
                        <tr>
                            <td>
                                <table border="0">
                                    <tbody>
                                        <tr>
                                            <td>Nombre:</td>
                                            <td> <input id="Txt_Nombre" type="text" name="Text_Nombre" value="" required="required" /> </td>
                                        </tr>
                                        <tr>                                            
                                            <td><img id="Pb_Previa" src="" width="80" height="60"/></td>
                                        </tr>
                                        <tr>
                                            <td>Logo:</td>
                                            <td><input id="Txt_Logo" type="text" name="Text_Logo" value="" required="required" onblur="FotoA('Pb_Previa','Txt_Logo')" /></td>
                                        </tr>
                                        <tr>
                                            <td>Mision:</td>
                                            <td><input id="Txt_Mision" type="text" name="Text_Mision" value="" required="required" /></td>
                                            <td>Vision:</td>
                                            <td><input id="Txt_Vision" type="text" name="Text_Vision" value="" required="required" /></td>
                                        </tr>
                                        <tr>
                                            <td>Fundado:</td>
                                            <td><input id="Dp_Fundacion" type="date" name="Date_Fundacion" value="" required="required" /></td>
                                        </tr>
                                    </tbody>
                                </table>       <br>             
                                <input type="submit" value="Modificar Compañia" name="Btn_modificar" /><br>                      
                            </td>
                        </tr>
                    </table>
                </form>
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
                                    <Center><h1>Compañia</h1></center>
                                </div>
                            </div>
                            <form name="Frm_Nuevo" action="Compañia.jsp" method="POST">
                                <table border="1" style="border-color: rgba(105,82,162,255)">
                                    <tr>
                                        <td><center><h4>Nuevo</h4></center></td>
                                    </tr>
                                    <tr>
                                        <td>
                                             <table border="0">
                                    <tbody>
                                        <tr>
                                            <td>Nombre:</td>
                                            <td> <input id="Txt_Nombre" type="text" name="Text_Nombre" value="" required="required" /> </td>
                                        </tr>
                                        <tr>
                                        <td>Vista previa:</td>
                                        </tr>
                                        <tr>                                            
                                            <td><img id="Pb_Previa2" src="" width="80" height="60"/></td>
                                        </tr>
                                        <tr>
                                            <td><input id="Txt_Logo2" type="text" name="Text_Logo" value="" required="required" onblur="FotoA('Pb_Previa2','Txt_Logo2')" /> </td>
                                        </tr>
                                        <tr>
                                            <td>Mision:</td>
                                            <td><input id="Txt_Mision" type="text" name="Text_Mision" value="" required="required" /></td>
                                            <td>Vision:</td>
                                            <td><input id="Txt_Vision" type="text" name="Text_Vision" value="" required="required" /></td>
                                        </tr>
                                        <tr>
                                            <td>Fundado:</td>
                                            <td><input id="Dp_Fundacion" type="date" name="Date_Fundacion" value="" required="required" /></td>
                                        </tr>
                                    </tbody>
                                </table>       <br>           
                                            <input type="submit" value="Crear Compañia" name="Btn_crear" /><br>                      
                                        </td>
                                    </tr>
                                </table>
                            </form> <br> <br> 

                            <table id="table" data-toggle="table" data-search="true"   data-click-to-select="true">
                                <thead>
                                    <tr>

                                        <th data-field="Codigo">Codigo</th>
                                        <th data-field="Nombre" data-editable="false">Nombre</th>
                                        <th data-field="Logo" data-editable="false">Logo</th>
                                        <th data-field="Mision" data-editable="false">Mision</th>
                                        <th data-field="Vision" data-editable="false">Vision</th>
                                        <th data-field="Fundacion" data-editable="false">Fundacion</th>
                                        <th data-field="operaciones" data-editable="false">Operaciones</th>
                                    </tr>
                                </thead>
                                <tbody>

                                    <% Dba db =new Dba();
                                       db.Conectar();
                                       try{
                                           db.query.execute("SELECT * from ver_Cine");
                                           ResultSet rs=db.query.getResultSet();
                                           while (rs.next()) {
                                               %>
                                               <tr>
                                                   <td><%= rs.getInt(1) %></td>
                                                   <td><%= rs.getString(2) %></td>
                                                   <td><img srcset="<%= rs.getString(3)%>" style="height: 60px; width: 80px"></td>
                                                   <td><%= rs.getString(4) %></td>
                                                   <td><%= rs.getString(5) %></td>
                                                   <td><%= rs.getString(6) %></td>
                                                   <td><input type="button" value="Eliminar" 
                                                    onclick="window.location='Compañia.jsp?Codigo=<%=rs.getInt(1)%>&Btn_Eliminar=1'"/>
                                             <input type="button" value="Modificar" 
                                                    onclick="mod('<%=rs.getInt(1)%>','<%=rs.getString(2)%>','<%=rs.getString(3)%>',
                                                                '<%=rs.getString(4)%>','<%=rs.getString(5)%>','<%=rs.getString(6)%>')"/></td>
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
        <script src="js/JQuery/jquery-1.11.3.min.js" type="text/javascript"></script>
        <!-- bootstrap JS
                    ============================================ -->
        <script src="js/bootstrap.min.js"></script>

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