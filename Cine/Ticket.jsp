<%-- 
    Document   : Ticket
    Created on : 12-06-2020, 02:05:15 PM
    Author     : Elio Hernandez
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="database.Dba"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="shortcut icon" type="image/x-icon" href="Recursos Imagenes/Icono.ico">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/data-table/bootstrap-table.css">
        <link rel="stylesheet" href="css/data-table/bootstrap-editable.css">
        <link rel="stylesheet" href="css/modal.css">
        <link href="css/dtree.css" rel="stylesheet" type="text/css"/>
        <script src="js/dtree.js" type="text/javascript"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Venta de Ticket</title>
    </head>   
    
        <% String Estado="none",Ir="";
            if(request.getParameter("Bandera")!=null){
                if(request.getParameter("Bandera").equals("1")){
                Estado="block";
                Ir="Comprar.jsp?Pelicula=" + request.getParameter("Codigo") + "&Cine=" + request.getParameter("Cine") + "&Ubicacion=" +
                request.getParameter("Ubicacion") + "&Sala=" + request.getParameter("Sala") + "&Exhibir=" + request.getParameter("Exhibir");
                }
            }
        %>
    
        <body onload=" modal.style.display = '<%=Estado%>'" style="background-color: rgba(153,0,0,255);">
        <div id="myModal" class="modal">  
            <div class="modal-content" style="width: 100%; height: 100%;">
                <span class="close" onclick="modal.style.display = 'none';" >&times;</span>
                <iframe src="<%=Ir%>" style="width: 100%; height: 100%; border-color: rgba(105,82,162,255);" ></iframe>
            </div>
        </div>
    <center><h1 style="color:white;">Horarios disponibles</h1></center>
    <div class="container-fluid" style=" background: linear-gradient(black,rgba(88,0,0,255));">
        <div class="row">
            <div class="col-9">
                <% String Nombre = "";
                    Dba db = new Dba();
                    db.Conectar();
                    try {
                        db.query.execute("select * from ver_Pelicula where Pel_Codigo='" + request.getParameter("Codigo") + "'");
                        ResultSet rs = db.query.getResultSet();
                        while (rs.next()) {
                            Nombre = rs.getString(3);
                %>
                <table border="0" style="color: white">
                    <tbody>
                        <tr>
                            <td><img src="<%=rs.getString(2)%>" width="300px" height="400px"></td>
                            <td><table border="0">
                                    <tbody>
                                        <tr>
                                            <td colspan="4"><h3 style="color: white"><%=rs.getString(3)%></h3> <br></td>
                                        </tr>
                                        <tr>
                                            <td><spa style="color: silver"><b>Sinopsis:</b> </spa></td>
                            <td colspan="3"><label style="width: 300px; text-align: justify;"><%=rs.getString(4)%></label></td>
                        </tr>
                        <tr>
                            <td><spa style="color: silver"><b>Generos:</b> </spa></td>
                    <td><%=rs.getString(5)%></td>
                    </tr>
                    <tr>
                        <td><spa style="color: silver"><b>Director:</b> </spa></td>
                    <td><%=rs.getString(7)%></td>
                    </tr>
                    <tr>
                        <td><spa style="color: silver"><b>Audio:</b> </spa></td>
                    <td> <%=rs.getString(6)%></td>
                    <td><spa style="color: silver"><b>Subtitulos:</b> </spa></td>
                    <td><%=rs.getString(8)%></td>
                    </tr>
                    <tr>
                        <td><spa style="color: silver"><b>Formato:</b> </spa></td>
                    <td><%=rs.getString(12)%></td>
                    <td><spa style="color: silver"><b>Duracion:</b> </spa></td>
                    <td><%=rs.getString(10)%></td>
                    </tr>
                    <tr>
                        <td><spa style="color: silver"><b>Clasificacion:</b> </spa></td>
                    <td>+<%=rs.getInt(13)%> Años</td>
                    </tr>
                    <tr>
                        <td><spa style="color: silver"><b> Calificacion:</b> </spa></td>
                    <td><%= rs.getInt(14)%>/10</td>
                    </tr>
                    </tbody>
                </table>
                </td>
                </tr>
                </tbody> 
                </table><br><center>
                    <iframe frameborder="0" id="Vd_Trailer" src="https://www.youtube.com/embed/<%= rs.getString(11).split("=")[1].split("&")[0]%>" width="854px" height="480px" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>            
                </center><%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    db.desconectar();

                %>

            </div>
            <div class="col-3" style="border-left: rgba(153,0,0,255) 1px dashed;  ">
                <div class="dtree">

	<p><a href="javascript: d.openAll();">open all</a> | <a href="javascript: d.closeAll();">close all</a></p>

	<script type="text/javascript">

		d = new dTree('d');

		d.add(<%= Integer.parseInt(request.getParameter("Codigo"))%>,-1,'<%=Nombre %>');
                <% String Cine="",Ubicacion="",Sala="";
                    db.Conectar();
                    try {
                        db.query.execute("select * from ver_Presentaciones where Pel_Codigo='"+ request.getParameter("Codigo")+"' and EXH_FECHA>=sysdate");
                        ResultSet rs = db.query.getResultSet();
                        while (rs.next()) {
                            if(!Cine.contains(rs.getString(2))){%>
                                d.add(<%= rs.getInt(2) %>,<%= rs.getInt(8)%>,'<%=rs.getString(3) %>');
                           <% }
                           if(!Ubicacion.contains(rs.getString(4))){%>
                               d.add(<%= rs.getInt(4) %>,<%= rs.getInt(2)%>,'<%=rs.getString(5) %>');

                            <%}
                            if(!Sala.contains(rs.getString(6))){%>
                                d.add(<%= rs.getInt(6) %>,<%= rs.getInt(4)%>,'<%=rs.getString(7) %>');
                        <%}%>
                            d.add(<%= rs.getInt(1) %>,<%= rs.getInt(6)%>,'<%=rs.getDate(12) + " | " + rs.getTime(12) %>','Ticket.jsp?Bandera=1&Codigo=<%= rs.getInt(8)%>&Cine=<%= rs.getInt(2) %>&Ubicacion=<%= rs.getInt(4) %>&Sala=<%= rs.getInt(6) %>&Exhibir=<%= rs.getInt(1) %>');
                            <%
                        Cine+=" | "+ rs.getInt(2);
                        Ubicacion+=" | "+ rs.getInt(4);
                        Sala+=" | "+ rs.getInt(6);
                        
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    db.desconectar();

                %>

		document.write(d);
	</script>

</div>
            </div>
        </div></div> 
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
