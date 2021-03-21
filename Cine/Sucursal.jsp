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
        <script type="text/javascript" src="https://maps.google.com/maps/api/js?sensor=true"></script>
        <script type="text/javascript">      
    
    function mostrar_mapa(centinela,Ubi){
            var ubicacion = new google.maps.LatLng(14.6203, -87.644); //Latitud y Longitud
                //ParÃ¡metros Iniciales
                var opciones={zoom:7, //acercamiento
                    center: ubicacion,
                    mapTypeId: google.maps.MapTypeId.ROADMAP //Las posibles opciones son ROADMAP/SATELLITE/HYBRID/TERRA                    
                };
                var map = new google.maps.Map(document.getElementById("mapa"),opciones);
                
              //recuperar ubicacion donde hago click
                var iw = new google.maps.InfoWindow(
                            {content: 'Haga click sobre el mapa <br> para ver Latitud y Longitud!', 
                             position: ubicacion});
                iw.open(map);
                // configurar evento click sobre el mapa
                map.addListener('click', function(mapsMouseEvent) {                 
                  iw.close();
                  iw = new google.maps.InfoWindow({position: mapsMouseEvent.latLng});
                  iw.setContent(mapsMouseEvent.latLng.toString());
                  document.getElementById("Txt_Ubicacion2").value=mapsMouseEvent.latLng.toString();
                  
                  iw.open(map);
                });
                                }
            function mostrar_mapa2(Ubi,Nombre,Fecha){
            var ubicacion = new google.maps.LatLng(14.6203, -87.644); //Latitud y Longitud
                //ParÃ¡metros Iniciales
                var opciones={zoom:7, //acercamiento
                    center: ubicacion,
                    mapTypeId: google.maps.MapTypeId.ROADMAP //Las posibles opciones son ROADMAP/SATELLITE/HYBRID/TERRA                    
                };
                var map2 = new google.maps.Map(document.getElementById("mapa2"),opciones);
                
              //recuperar ubicacion donde hago click
                         var iw2 = new google.maps.InfoWindow(
                            {content: 'Haga click sobre el mapa <br> para ver Latitud y Longitud!', 
                             position: ubicacion});
                iw2.open(map2);
                // configurar evento click sobre el mapa                
                map2.addListener('click', function(mapsMouseEvent) {                 
                  iw2.close();
                  iw2 = new google.maps.InfoWindow({position: mapsMouseEvent.latLng});
                  iw2.setContent(mapsMouseEvent.latLng.toString());
                  document.getElementById("Txt_Ubicacion").value=mapsMouseEvent.latLng.toString();
                  
                  iw2.open(map2);
                });
                
                    var Coordenadas=new String(Ubi);
                    var x=parseFloat(Coordenadas.substring(1,Coordenadas.length-1).split(",")[0]);
                    var y=parseFloat(Coordenadas.substring(1,Coordenadas.length-1).split(",")[1]);
                    //Colocar una marca sobre el Mapa
                    mi_ubicacion = new google.maps.Marker({
                       position: new google.maps.LatLng(x, y),//PosiciÃ³n de la marca
                       map: map2, //Mapa donde estarÃ¡ la marca
                       title: Nombre //TÃ­tulo all hacer un mouseover
                    });

                    //Mostrar InformaciÃ³n al hacer click en la marca
                    var infowindow = new google.maps.InfoWindow({
                        content: 'Fundado en:' + Fecha
                    });

                    google.maps.event.addListener(mi_ubicacion, 'click',function(){
                        //Calling the open method of the InfoWindow
                       infowindow.open(map2, mi_ubicacion);
                    });
                
                
                
            }
            </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sucursal</title>
    </head>
    
        <script> 
           function mod(Codigo,Cine,Ubicacion,Nombre,Fundacion){
                var modal2 = document.getElementById("myModal");
                modal.style.display = "block"; 
                document.getElementById("Txt_Codigo").value=Codigo;
                document.getElementById("Cb_Cine").value=Cine;
                document.getElementById("Txt_Ubicacion").value=Ubicacion;
                document.getElementById("Txt_Nombre").value=Nombre;                
                document.getElementById("Dp_Fundacion").value=Fundacion;
                var Coordenadas =new String(Ubicacion);
                
                mostrar_mapa2(Ubicacion,Nombre,Fundacion);
                
                
    }
    </script>
<%
    if(request.getParameter("Btn_modificar")!=null){
        Dba db =new Dba(); 
      db.Conectar();     
      try{    int Contador=db.query.executeUpdate("Update T_Ubicacion set Cin_Codigo='" + request.getParameter("Combo_Cine") +
              "', Ubi_Ubicacion='" + request.getParameter("Text_Ubicacion") + "', Ubi_Nombre='" + request.getParameter("Text_Nombre")+
                  "',Ubi_Fundado='" + request.getParameter("Date_Fundacion") + 
                  "' where Ubi_Codigo='" + request.getParameter("Text_Codigo") + "'");
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
          int Contador=db.query.executeUpdate("Insert into T_Ubicacion values (Codigos.nextval,'" + request.getParameter("Combo_Cine") + "','" +
                  request.getParameter("Text_Ubicacion") + "','"+ request.getParameter("Text_Nombre") + "','" + request.getParameter("Date_Fundacion") + "')");
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
          int Contador=db.query.executeUpdate("delete from T_Ubicacion where Ubi_Codigo='" + request.getParameter("Codigo") + "'");
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
    <body onload="mostrar_mapa(0,0)">
        <div id="myModal" class="modal">  
            <div class="modal-content"">
                <span class="close" onclick="modal.style.display = 'none';" >&times;</span>
                <form name="Frm_Modificar" action="Sucursal.jsp" method="POST">
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
                                            <td>Cine:</td>
                                            <td> <select id="Cb_Cine" name="Combo_Cine" required="required">
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
                                            </select></td>
                                        </tr>
                                        <tr>
                                            <td>Ubicacion:</td>
                                            <td> <input id="Txt_Ubicacion" type="text" name="Text_Ubicacion" value="" required="required"/> </td>
                                        </tr>
                                        <tr>
                                            <td>Nombre:</td>
                                            <td> <input id="Txt_Nombre" type="text" name="Text_Nombre" value="" required="required" /> </td>
                                            <td>Fundado:</td>
                                            <td><input id="Dp_Fundacion" type="date" name="Date_Fundacion" value="" required="required" /></td>
                                        </tr>
                                        <tr>
                                            <td  COLSPAN="4" ><div id="mapa2" style="width: 450px; height: 250px; border: 5px groove #006600;"></div></td>
                                        </tr>
                                    </tbody>
                                </table>       <br>             
                                <input type="submit" value="Modificar Sucursal" name="Btn_modificar" /><br>                      
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
                                    <Center><h1>Sucursal</h1></center>
                                </div>
                            </div>
                            <form name="Frm_Nuevo" action="Sucursal.jsp" method="POST">
                                <table border="1" style="border-color: rgba(105,82,162,255)">
                                    <tr>
                                        <td><center><h4>Nuevo</h4></center></td>
                                    </tr>
                                    <tr>
                                        <td>
                                    <table border="0">
                                    <tbody>
                                        <tr>
                                            <td>Cine:</td>
                                            <td> <select id="Cb_Cine" name="Combo_Cine" required="required">
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
                                        db.desconectar();  %>
                                            </select></td>
                                        </tr>
                                        <tr>
                                            <td>Ubicacion:</td>
                                            <td> <input id="Txt_Ubicacion2" type="text" name="Text_Ubicacion" value="" required="required" /> </td>
                                        </tr>
                                        <tr>
                                            <td>Nombre:</td>
                                            <td> <input id="Txt_Nombre" type="text" name="Text_Nombre" value="" required="required" /> </td>
                                            <td>Fundado:</td>
                                            <td><input id="Dp_Fundacion" type="date" name="Date_Fundacion" value="" required="required" /></td>
                                        </tr>
                                        <tr>
                                            <td  COLSPAN="4" ><div id="mapa" style="width: 450px; height: 250px; border: 5px groove #006600;"></div></td>
                                        </tr>
                                    </tbody>
                                </table>       <br>           
                                            <input type="submit" value="Crear Sucursal" name="Btn_crear" /><br></td>
                                    </tr>
                                </table>
                            </form> <br> <br>
                                                
                            </div>

                            <table id="table" data-toggle="table" data-search="true"   data-click-to-select="true">
                                <thead>
                                    <tr>

                                        <th data-field="Codigo">Codigo</th>
                                        <th data-field="Cine" data-editable="false">Cine</th>
                                        <th data-field="Ubicacion" data-editable="false">Ubicacion</th>
                                        <th data-field="Nombre" data-editable="false">Nombre</th>
                                        <th data-field="Fundacion" data-editable="false">Fundacion</th>
                                        <th data-field="operaciones" data-editable="false">Operaciones</th>
                                    </tr>
                                </thead>
                                <tbody>

                                    <%
                                       db.Conectar();
                                       try{
                                           db.query.execute("select *  from Ver_Ubicacion");
                                          ResultSet  rs=db.query.getResultSet();
                                           while (rs.next()) {
                                               %>
                                               <tr>
                                                   <td><%= rs.getInt(1) %></td>
                                                   <td><%= rs.getString(3) %></td>
                                                   <td><%= rs.getString(4) %></td>
                                                   <td><%= rs.getString(5) %></td>
                                                   <td><%= rs.getString(6) %></td>
                                                   <td><input type="button" value="Eliminar" 
                                                    onclick="window.location='Sucursal.jsp?Codigo=<%=rs.getInt(1)%>&Btn_Eliminar=1'"/>
                                             <input type="button" value="Modificar" 
                                                    onclick="mod('<%=rs.getInt(1)%>','<%=rs.getInt(2)%>','<%=rs.getString(4)%>',
                                                                '<%=rs.getString(5)%>','<%=rs.getString(6)%>')"/></td>
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