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
        <title>Pelicula</title>
    </head>
    
        <script> 
           function mod(Codigo,Cartelera,Titulo,Sinopsis,Generos,Audio,Director,Subtitulos,Estreno,Duracion,Trailer,Formato,Edad){
                var modal2 = document.getElementById("myModal");
                modal.style.display = "block"; 
                document.getElementById("Txt_Codigo").value=Codigo;
                document.getElementById("Txt_Cartelera").value=Cartelera;
                document.getElementById("Txt_Titulo").value=Titulo;
                document.getElementById("Txt_Sinopsis").value=Sinopsis;
                document.getElementById("Txt_Generos").value=Generos;
                document.getElementById("Txt_Audio").value=Audio;
                document.getElementById("Txt_Director").value=Director;
                document.getElementById("Txt_Subtitulos").value=Subtitulos;
                document.getElementById("Dp_Estreno").value=Estreno;
                document.getElementById("Txt_Duracion").value=Duracion;
                document.getElementById("Txt_Trailer").value=Trailer;
                document.getElementById("Cb_Formato").value=Formato;
                document.getElementById("NUD_Edad").value=Edad;
                
                FotoA('Pb_Cartelera','Txt_Cartelera');
                Video('Vd_Trailer','Txt_Trailer');
    }
    function FotoA(Caja,Texto){
        document.getElementById(Caja).srcset=document.getElementById(Texto).value;}
    function Video(Caja,Texto){
        var Embebido= new String(document.getElementById(Texto).value);
        document.getElementById(Caja).src="https://www.youtube.com/embed/" + Embebido.split("=")[1].split("&")[0];}
    </script>
<%
    if(request.getParameter("Btn_modificar")!=null){
        Dba db =new Dba(); 
      db.Conectar();     
      try{    int Contador=db.query.executeUpdate("Update T_Pelicula set Pel_Cartelera='" + request.getParameter("Text_Cartelera") + "',Pel_Titulo='" + request.getParameter("Text_Titulo")+
                  "',Pel_Sinopsis='" + request.getParameter("Text_Sinopsis") + "',Pel_Generos='" + request.getParameter("Text_Generos") + 
                  "',Pel_Audio='" + request.getParameter("Text_Audio") + "',Pel_Director='" + request.getParameter("Text_Director") +
                  "',Pel_Subtitulos='" + request.getParameter("Text_Subtitulos") + "',Pel_Estreno='" + request.getParameter("Date_Estreno") +
                  "',Pel_Duracion='" + request.getParameter("Text_Duracion") + "',Pel_Trailer='" + request.getParameter("Text_Trailer") +
                  "',Pel_Formato='" + request.getParameter("Combo_Formato") + "',Pel_EdadMin='" + request.getParameter("Number_Edad") + 
                  "' where Pel_Codigo='" + request.getParameter("Text_Codigo") + "'");
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
          int Contador=db.query.executeUpdate("Insert into T_Pelicula(Pel_Codigo,Pel_Cartelera,Pel_Titulo,Pel_Sinopsis,Pel_Generos,Pel_Audio,"
                  + "Pel_Director,Pel_Subtitulos,Pel_Estreno,Pel_Duracion,Pel_Trailer,Pel_Formato,Pel_EdadMin) "
                  + "values (Codigos.nextval,'" + request.getParameter("Text_Cartelera") + "','" + request.getParameter("Text_Titulo") + "','" 
                  + request.getParameter("Text_Sinopsis") + "','" + request.getParameter("Text_Generos") + "','" + request.getParameter("Text_Audio") + "','"
                  + request.getParameter("Text_Director") + "','" + request.getParameter("Text_Subtitulos") + "','" + request.getParameter("Date_Estreno") + "','"
                  + request.getParameter("Text_Duracion") + "','" + request.getParameter("Text_Trailer") + "','" + request.getParameter("Combo_Formato") + "','"
                  + request.getParameter("Number_Edad") + "')");
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
          int Contador=db.query.executeUpdate("delete from T_Pelicula where Pel_Codigo='" + request.getParameter("Codigo") + "'");
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
                <form name="Frm_Modificar" action="Pelicula.jsp" method="POST">
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
                                            <td>Cartelera:</td>
                                            <td><input id="Txt_Cartelera" type="text" name="Text_Cartelera" value="" required="required" onblur="FotoA('Pb_Cartelera','Txt_Cartelera')" /></td>
                                        </tr>
                                        <tr>                                            
                                            <td>Titulo:</td>
                                            <td><input id="Txt_Titulo" type="text" name="Text_Titulo" value="" required="required" /></td>
                                            <td>Director:</td>
                                            <td><input id="Txt_Director" type="text" name="Text_Director" value="" required="required" /></td>
                                        </tr>
                                        <tr>                                            
                                            <td>Sinopsis:</td>
                                            <td><textarea id="Txt_Sinopsis" name="Text_Sinopsis" rows="4" cols="20" required="required">
                                                </textarea></td>
                                            <td>Generos:</td>
                                            <td><input id="Txt_Generos" type="text" name="Text_Generos" value="" required="required" /></td>
                                        </tr>
                                        <tr>
                                            <td>Audio:</td>
                                            <td><input id="Txt_Audio" type="text" name="Text_Audio" value="" required="required" /></td>
                                            <td>Subtitulos:</td>
                                            <td><input id="Txt_Subtitulos" type="text" name="Text_Subtitulos" value="" required="required" /></td>
                                        </tr>
                                        <tr>
                                            <td>Estreno:</td>
                                            <td><input id="Dp_Estreno" type="date" name="Date_Estreno" value="" required="required" /></td>
                                            <td>Duracion:</td>
                                            <td><input id="Txt_Duracion" type="text" name="Text_Duracion" value="" required="required" /></td>
                                        </tr>
                                        <tr>
                                            <td>Trailer:</td>
                                            <td><input id="Txt_Trailer" type="text" name="Text_Trailer" value="" required="required" onblur="Video('Vd_Trailer','Txt_Trailer')" /></td>
                                        </tr>
                                        <tr>
                                            <td>Formato:</td>
                                            <td><select id="Cb_Formato" name="Combo_Formato" required="required">
                                                    <option></option>
                                                    <option>2D</option>
                                                    <option>3D</option>
                                                    <option>4D</option>
                                                </select></td>
                                            <td>Edad minima:</td>
                                            <td><input type="number" id="NUD_Edad" name="Number_Edad" min="0" max="200" step="1"> Años</td>
                                        </tr>
                                    </tbody>
                                </table>       <br>             
                                <input type="submit" value="Modificar Compañia" name="Btn_modificar" /><br>                      
                            </td>
                            <td>
                                <table border="0">
                                    <tr>
                            <td><h2>Cartelera:</h2></td>
                        </tr>
                        <tr>
                            <td><img id="Pb_Cartelera" src="" width="100px" height="150px"></td>
                        </tr>
                        <tr>
                            <td><h2>Trailer:</h2></td>
                        </tr>
                        <tr>
                            <td><iframe frameborder="0" id="Vd_Trailer" src="" width="426px" height="240px" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe></td>
                        </tr></table>
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
                                    <Center><h1>Pelicula</h1></center>
                                </div>
                            </div>
                            <form name="Frm_Nuevo" action="Pelicula.jsp" method="POST">
                                <table border="1" style="border-color: rgba(105,82,162,255)">
                                    <tr>
                                        <td><center><h4>Nuevo</h4></center></td>
                                    </tr>
                                    <tr>
                                        <td>
                                             <table border="0">
                                    <tbody>
                                        <tr>
                                            <td>Cartelera:</td>
                                            <td><input id="Txt_Cartelera2" type="text" name="Text_Cartelera" value="" required="required" onblur="FotoA('Pb_Cartelera2','Txt_Cartelera2')" /></td>
                                        </tr>
                                        <tr>                                            
                                            <td>Titulo:</td>
                                            <td><input id="Txt_Titulo" type="text" name="Text_Titulo" value="" required="required" /></td>
                                            <td>Director:</td>
                                            <td><input id="Txt_Director" type="text" name="Text_Director" value="" required="required" /></td>
                                        </tr>
                                        <tr>                                            
                                            <td>Sinopsis:</td>
                                            <td><textarea id="Txt_Sinopsis" name="Text_Sinopsis" rows="4" cols="20" required="required">
                                                </textarea></td>
                                            <td>Generos:</td>
                                            <td><input id="Txt_Generos" type="text" name="Text_Generos" value="" required="required" /></td>
                                        </tr>
                                        <tr>
                                            <td>Audio:</td>
                                            <td><input id="Txt_Audio" type="text" name="Text_Audio" value="" required="required" /></td>
                                            <td>Subtitulos:</td>
                                            <td><input id="Txt_Subtitulos" type="text" name="Text_Subtitulos" value="" required="required" /></td>
                                        </tr>
                                        <tr>
                                            <td>Estreno:</td>
                                            <td><input id="Dp_Estreno" type="date" name="Date_Estreno" value="" required="required" /></td>
                                            <td>Duracion:</td>
                                            <td><input id="Txt_Duracion" type="text" name="Text_Duracion" value="" required="required" /></td>
                                        </tr>
                                        <tr>
                                            <td>Trailer:</td>
                                            <td><input id="Txt_Trailer2" type="text" name="Text_Trailer" value="" required="required" onblur="Video('Vd_Trailer2','Txt_Trailer2')" /></td>
                                        </tr>
                                        <tr>
                                            <td>Formato:</td>
                                            <td><select id="Cb_Formato" name="Combo_Formato" required="required">
                                                    <option></option>
                                                    <option>2D</option>
                                                    <option>3D</option>
                                                    <option>4D</option>
                                                </select></td>
                                            <td>Edad minima:</td>
                                            <td><input type="number" id="NUD_Edad" name="Number_Edad" min="0" max="200" step="1"> Años</td>
                                        </tr>
                                    </tbody>
                                </table>       <br>           
                                            <input type="submit" value="Crear Compañia" name="Btn_crear" /><br>                      
                                        </td>
                                        <td>
                                <table border="0">
                                    <tr>
                            <td><h2>Cartelera:</h2></td>
                        </tr>
                        <tr>
                            <td><img id="Pb_Cartelera2" src="" width="100px" height="150px"></td>
                        </tr>
                        <tr>
                            <td><h2>Trailer:</h2></td>
                        </tr>
                        <tr>
                            <td><iframe frameborder="0" id="Vd_Trailer2" src="" width="426px" height="240px" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe></td>
                        </tr></table>
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
                                        <th data-field="Director" data-editable="false">Director</th>
                                        <th data-field="Subtitulos" data-editable="false">Subtitulos</th>
                                        <th data-field="Estreno" data-editable="false">Estreno</th>
                                        <th data-field="Duracion" data-editable="false">Duracion</th>
                                        <th data-field="Trailer" data-editable="false">Trailer</th>
                                        <th data-field="FOrmato" data-editable="false">Formato</th>
                                        <th data-field="Edad minima" data-editable="false">Edad minima</th>
                                        <th data-field="Calificacion" data-editable="false">Calificacion</th>
                                        <th data-field="operaciones" data-editable="false">Operaciones</th>
                                    </tr>
                                </thead>
                                <tbody>

                                    <% Dba db =new Dba();
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
                                                   <td><%= rs.getString(7) %></td>
                                                   <td><%= rs.getString(8) %></td>
                                                   <td><%= rs.getString(9) %></td>
                                                   <td><%= rs.getString(10) %></td>
                                                   <td><a href="<%= rs.getString(11) %>" target="_blank"><%= rs.getString(11) %></a></td>
                                                   <td><%= rs.getString(12) %></td>
                                                   <td><%= rs.getInt(13) %></td>
                                                   <td><%= rs.getInt(14) %></td>
                                                   <td><input type="button" value="Eliminar" 
                                                    onclick="window.location='Pelicula.jsp?Codigo=<%=rs.getInt(1)%>&Btn_Eliminar=1'"/>
                                             <input type="button" value="Modificar" 
                                                    onclick="mod('<%= rs.getInt(1) %>','<%= rs.getString(2)%>','<%= rs.getString(3) %>','<%= rs.getString(4) %>',
                                                                '<%= rs.getString(5) %>','<%= rs.getString(6) %>','<%= rs.getString(7) %>','<%= rs.getString(8) %>',
                                                                '<%= rs.getString(9) %>','<%= rs.getString(10) %>','<%= rs.getString(11) %>','<%= rs.getString(12) %>',
                                                                '<%= rs.getInt(13) %>')"/></td>
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
