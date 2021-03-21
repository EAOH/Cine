<%-- 
    Document   : Comprar
    Created on : 12-08-2020, 12:25:40 PM
    Author     : Elio Hernandez
--%>

<%@page import="java.io.StringReader"%>
<%@page import="com.lowagie.text.html.simpleparser.HTMLWorker"%>
<%@page import="java.util.Date"%>
<%@page import="com.lowagie.text.pdf.PdfWriter"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="com.lowagie.text.Document"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.internet.MimeMultipart"%>
<%@page import="javax.activation.FileDataSource"%>
<%@page import="javax.activation.DataHandler"%>
<%@page import="javax.mail.internet.MimeBodyPart"%>
<%@page import="javax.mail.BodyPart"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="java.util.Properties"%>
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
        <link href="css/Pestañas.css" rel="stylesheet" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Comprar Ticket</title>
    </head>
    <script>
        var Nombres = new String(""), Nombres2 = new String(""), Limite = 0, Nombres3 = new String("");
        function SubTotal(Cantidad, Precio, Subtotal, Codigos) {
            document.getElementById(Subtotal).value = document.getElementById(Cantidad).value * Precio;
            if (Nombres.split(Subtotal).length == 1) {
                Nombres += Subtotal + ",";
                document.getElementById("Txt_Subtotales").value += document.getElementById(Subtotal).name + ",";
                document.getElementById("Txt_Codigos").value += Codigos + ",";
            }
            if (Nombres2.split(Cantidad).length == 1) {
                Nombres2 += Cantidad + ",";
                document.getElementById("Txt_Cantidades").value += document.getElementById(Cantidad).name + ",";
            }
            document.getElementById("Txt_Total").value = "0.00";
            document.getElementById("Txt_Cantidad").value = "0";
            for (var i = 0; i <= Nombres.split("|").length; i++) {
                document.getElementById("Txt_Total").value = parseFloat(document.getElementById("Txt_Total").value) + parseFloat(document.getElementById(Nombres.split(",")[i]).value);
                document.getElementById("Txt_Cantidad").value = parseFloat(document.getElementById("Txt_Cantidad").value) + parseFloat(document.getElementById(Nombres2.split(",")[i]).value);
                Limite = parseFloat(document.getElementById("Txt_Cantidad").value);
            }
        }
    </script>

    <script>
        function Cambio(Check, Img) {
            var C = document.getElementById(Check);
            if (C.checked == true) {
                if (Limite > 0) {
                    document.getElementById(Img).src = "Recursos Imagenes/Propias.png";
                    Limite = Limite - 1;
                    if (Nombres3.split(document.getElementById(Check).name).length == 1) {
                        Nombres3 += document.getElementById(Check).name + ",";
                        document.getElementById("Txt_Butacas").value = Nombres3;
                    }
                } else {
                    alert("No es posible seleccionar mas asientos debido a que ya uso todos sus ticket");
                }
            } else {
                Limite = Limite + 1;
                document.getElementById(Img).src = "Recursos Imagenes/Disponibles.png";
            }
        }
    </script>

    <% String Iniciar = "Btn_Comprar";
        if (request.getParameter("Btn_Comprar") != null) {
            Iniciar = "Btn_Resumen";

        }
    %>

    <body onload="document.getElementById('<%=Iniciar%>').click();">
        <div class="tab" hidden="hidden" >
            <button id="Btn_Comprar" class="tablinks" onclick="openPaso(event, 'Tap_Comprar')">Comprar</button>
            <button id="Btn_Asientos" class="tablinks" onclick="openPaso(event, 'Tap_Asientos')">Asientos</button>
            <button id="Btn_Targeta" class="tablinks" onclick="openPaso(event, 'Tap_Targeta')">Targeta</button>
            <button id="Btn_Resumen" class="tablinks" onclick="openPaso(event, 'Tap_Resumen')">Resumen</button>
        </div>

        <form action="Comprar.jsp?Pelicula=<%= request.getParameter("Pelicula")%>&Cine=<%=request.getParameter("Cine")%>&Ubicacion=<%= request.getParameter("Ubicacion")%>&Sala=<%=request.getParameter("Sala")%>&Exhibir=<%=request.getParameter("Exhibir")%>" method="POST">

            <div id="Tap_Comprar" class="tabcontent">
                <h5 style="color:rgba(153,0,0,255); background-color: rgba(255,202,44,255)">Usted Ha seleccionado</h5>
                <table border="1">
                    <thead>
                        <tr>
                            <th><b>Pelicula</b></th>
                            <th><b>Fecha</b></th>
                            <th><b>Hora</b></th>
                            <th><b>Cine</b></th>
                            <th><b>Sucursal</b></th>
                            <th><b>Sala</b></th>
                        </tr>
                    </thead>
                    <tbody>
                        <% String Formato = "";
                            Dba db = new Dba();
                            db.Conectar();
                            try {
                                db.query.execute("select * from ver_Presentaciones where EXH_CODIGO='" + request.getParameter("Exhibir") + "'");
                                ResultSet rs = db.query.getResultSet();
                                while (rs.next()) {
                                    Formato = rs.getString(11);
                        %>
                        <tr>
                            <td><input type="hidden" name="Text_Pelicula" value="<%= rs.getInt(8)%>" /> <%= rs.getString(9)%> </td>
                            <td><input type="hidden" name="Text_Exhibir" value="<%= rs.getInt(1)%>" /> <%= rs.getDate(12)%> </td>
                            <td><input type="hidden" name="Text_Formato" value="<%= Formato%>" /><%= rs.getTime(12)%> </td>
                            <td><input type="hidden" name="Text_Cine" value="<%= rs.getInt(2)%>" /> <%= rs.getString(3)%> </td>
                            <td><input type="hidden" name="Text_Ubicacion" value="<%= rs.getInt(4)%>" /> <%= rs.getString(5)%> </td>
                            <td><input type="hidden" name="Text_Sala" value="<%= rs.getInt(6)%>" /> <%= rs.getString(7)%></td>
                        </tr>
                        <%
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            db.desconectar();
                        %>
                    </tbody>
                </table>
                <p>Por favor, verifique que la informacion de la sala, pelicula, fecha, hora, cantidad y tipo de entrada seleccionadas sean las correctas</p>
                <hr style="border-color: rgba(105,82,162,255);">
                <h5 style="color:rgba(153,0,0,255);">Comprar Boletos</h5>
                <br>
                <p>Seleccione la cantidad y tipo de entradas que desea comprar. Al terminar presione el boton "Seleccionar Buracas" para continuar.</p>
                <br>
                <table border="0">
                    <thead>
                        <tr>
                            <th style=" text-align: center; ">Tipo de entrada</th>
                            <th style=" text-align: center; ">Rango de Edad</th>
                            <th style=" text-align: center; ">Cantidad</th>
                            <th style=" text-align: center; ">Precio</th>
                            <th style=" text-align: center; ">Subtotal</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            db.Conectar();
                            try {
                                db.query.execute("select * from ver_Precios where CIN_CODIGO='" + request.getParameter("Cine") + "' and Pre_Formato='" + Formato + "'");
                                ResultSet rs = db.query.getResultSet();
                                while (rs.next()) {
                        %>
                        <tr>
                            <td><%= rs.getString(4)%> </td>
                            <td><%= rs.getInt(5)%> -  <%= rs.getInt(6)%> Años</td>
                            <td><input id="Nud_Cantidad<%=rs.getInt(1)%>" type="number" name="Number_Cantidad<%=rs.getInt(1)%>" value="0" min="0" step="1" required="required" onchange="SubTotal('Nud_Cantidad<%=rs.getInt(1)%>',<%=rs.getFloat(7)%>, 'Txt_Sub<%=rs.getInt(1)%>', '<%= rs.getInt(1)%>')" /></td>
                            <td style="color:red"><%=String.format("%.2f", rs.getFloat(7))%> L</td>
                            <td style="color:red;"><input style="color:red; border: 0; text-align: right;" id="Txt_Sub<%=rs.getInt(1)%>" type="Text" name="Text_Sub<%=rs.getInt(1)%>" value="0.00" readonly="readonly" />L</td>
                        </tr>
                        <%
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            db.desconectar();

                        %>
                        <tr>
                    <input id="Txt_Cantidades" type="hidden" name="Text_Cantidades" value="" />
                    <input id="Txt_Subtotales" type="hidden" name="Text_SubTotales" value="" />
                    <input id="Txt_Codigos" type="hidden" name="Text_Codigos" value="" />
                    <td style=" text-align: right;"><b>Cantidad de Boletos: </b></td>
                    <td><input style="border: 0; text-align: right;"  id="Txt_Cantidad" type="Text" name="Text_Cantidad" value="0" readonly="readonly" /></td>
                    <td></td>
                    <td style=" text-align: right;"><b>Total: </b></td>
                    <td><input style="border: 0; text-align: right;"  id="Txt_Total" type="Text" name="Text_Total" value="0.00" readonly="readonly" /> L</td>
                    </tr>
                    </tbody>
                </table>
                <br>
                <input style=" border-radius: 10px; background-color: rgba(255,205,51,255); border-color: rgba(206,139,33,255);" type="button" value="Seleccionar Butacas" onclick="document.getElementById('Btn_Asientos').click();" />
            </div>



            <div id="Tap_Asientos" class="tabcontent">
                <input style=" border-radius: 10px; background-color: rgba(255,205,51,255); border-color: rgba(206,139,33,255)" type="button" value="Cambiar mis Ticket" onclick="window.location = 'Comprar.jsp?Pelicula=<%= request.getParameter("Pelicula")%>&Cine=<%=request.getParameter("Cine")%>&Ubicacion=<%= request.getParameter("Ubicacion")%>&Sala=<%=request.getParameter("Sala")%>&Exhibir=<%=request.getParameter("Exhibir")%>';" />
                <br>
                <br>
                <h5 style="color:rgba(153,0,0,255);">Seleccionar Butacas</h5>
                <p>Si quiere cambiar la ubicacion de sus butacas haga clic en cada butaca seleccionada para liberarla. A continuacion, haga clic en la butaca vacia que desea reservar.<br><br> 

                    <b>Tenga en cuenta que al momento de seleccionar sus butacas a continuacion de las que ya estan reservadas o si desea dejar espacios libres debera dejar al menos 2 butacas vacias</b>
                <center><img src="Recursos Imagenes/Propias.png" width="30" height="30" alt="Propias"/>Su butaca  <img src="Recursos Imagenes/Disponibles.png" width="30" height="30" alt="Disponibles"/> Disponible  <img src="Recursos Imagenes/Ocupada.png" width="30" height="30" alt="Ocupada"/> Reservada </center>

                </p>
                <center><img src="Recursos Imagenes/Pantallas.png" width="1100" height="150" alt="Pantalla"/></center>
                <br>
                <br>
                <br>
                <div class=" container ">
                    <%   db.Conectar();
                        try {
                            db.query.execute("select distinct VER_SILLA.SAL_CODIGO,VER_SILLA.SIL_FILA, VER_SILLA.SIL_CANTIDAD, "
                                    + "(select distinct listagg(VER_OCUPADAS.ENUS_COLUMNA,',') within group(order by VER_OCUPADAS.ENUS_COLUMNA) "
                                    + "over (partition by VER_OCUPADAS.EXH_CODIGO ) "
                                    + "from VER_OCUPADAS where VER_SILLA.SIL_FILA= VER_OCUPADAS.ENUS_FILA and VER_PRESENTACIONES.EXH_CODIGO=VER_OCUPADAS.EXH_CODIGO) "
                                    + "from ver_Silla inner join ver_Presentaciones on VER_SILLA.SAL_CODIGO=VER_PRESENTACIONES.SAL_CODIGO "
                                    + "left join ver_Ocupadas on VER_PRESENTACIONES.EXH_CODIGO=VER_OCUPADAS.EXH_CODIGO "
                                    + "where VER_SILLA.SAL_CODIGO='" + request.getParameter("Sala") + "' and VER_PRESENTACIONES.EXH_CODIGO='"+request.getParameter("Exhibir")+ 
                                    "' order by VER_SILLA.SAL_CODIGO,VER_SILLA.SIL_FILA asc");
                            ResultSet rs = db.query.getResultSet();
                            while (rs.next()) {
                                int Indice = 0;
                    %>
                    <center>
                        <% for (int i = 0; i < rs.getInt(3); i++) {
                                if (!String.format("%s", rs.getString(4)).equals("null")) {
                                    if (Indice == rs.getString(4).split(",").length) {
                                        Indice = 0;
                                    }
                                }
                                if (!String.format("%s", rs.getString(4)).equals("null") && Integer.parseInt(rs.getString(4).split(",")[Indice]) == i) {
                                    out.print("<img src='Recursos Imagenes/Ocupada.png' width='30' height='30'/>");
                                    Indice++;
                                } else {
                        %>
                        <label class="checkeable">
                            <input value="<%= rs.getInt(2) + "," + i%>" id="Ck_Butaca<%= rs.getInt(2) + "" + i%>" style=" display: none;" type="checkbox" name="Check_Butaca<%= rs.getInt(2) + "" + i%>" onclick="Cambio('Ck_Butaca<%= rs.getInt(2) + "" + i%>', 'img_Butaca<%= rs.getInt(2) + "" + i%>')" />
                            <img id="img_Butaca<%= rs.getInt(2) + "" + i%>" src="Recursos Imagenes/Disponibles.png" width="30" height="30" alt="Disponibles"/>
                        </label>  
                        <%}
                            }
                        %>
                        <br></center> 
                        <%
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            db.desconectar();

                        %>
                </div>
                <input id="Txt_Butacas" type="hidden" name="Text_Butacas" value="" />
                <input style=" border-radius: 10px; background-color: rgba(255,205,51,255); border-color: rgba(206,139,33,255);" type="button" value="Pagar" onclick="document.getElementById('Btn_Targeta').click();" />
                <p>Nota: La pantalla es un indicador de la direccion solamente y no representa las distancias reales de los asientos a la pantalla</p>
            </div>



            <div id="Tap_Targeta" class="tabcontent">
                <p>¿Desea cambiar las butacas seleccionadas? <input style=" border-radius: 10px; background-color: rgba(255,205,51,255); border-color: rgba(206,139,33,255);" type="button" value="Cambiar Butacas" onclick="document.getElementById('Btn_Asientos').click();" /></p>
                <hr style="border-color: rgba(105,82,162,255);">
                <h5 style="color:rgba(153,0,0,255); background-color: rgba(255,202,44,255)">Informacion de Pago</h5>
                <p>Introduzca sus datos de pago, revise que la informacion de su tarjeta de credito sean Correcta, Al dar clic en el boton comprar usted acepta los terminos y condiciones para procesar su orden</p>
                <br>
                <table border="0" style="color: blue ">
                    <tbody>
                        <tr>
                            <td>Correo:</td>
                            <td><input type="text" name="Text_Correo" value="" required="required" /></td>
                        </tr>
                        <tr>
                            <td>Celular:</td>
                            <td><input type="text" name="Text_Cel" value="" required="required" /></td>
                        </tr>
                        <tr>
                            <td>Nombre:</td>
                            <td><input type="text" name="Text_Nombre" value="" required="required" /></td>
                        </tr>

                        <tr>
                            <td>Identidad:</td>
                            <td><input type="text" name="Text_Identidad" value="" required="required" /></td>
                        </tr>
                        <tr>
                            <td>Numero de tarjeta:</td>
                            <td><input type="text" name="Text_Tarjeta" value="" required="required" /></td>
                        </tr>
                        <tr>
                            <td>Fecha de vencimiento: </td>
                            <td><input type="date" name="Date_Vence" value="" required="required" /></td>
                        </tr>
                        <tr>
                            <td>Codigo de seguridad</td>
                            <td><input type="password" name="Text_Seguro" value="" required="required" /></td>
                        </tr>
                        <tr>
                            <td>Tipo de tarjeta:</td>
                            <td><select name="Cobo_Targeta" required="required">
                                    <option></option>
                                    <option>Credito</option>
                                    <option>Debito</option>
                                </select></td>
                        </tr>
                        <tr>
                            <td style=" text-align: center; " colspan="2"><input style=" border-radius: 10px; background-color: rgba(255,205,51,255); border-color: rgba(206,139,33,255);" type="submit" value="Comprar Ahora" name="Btn_Comprar" /></td>
                        </tr>
                        <tr>
                            <td style=" text-align: center; " colspan="2"><p style=" width: 500px;"><b>Al hacer clic en "Comprar ahora" su tarjeta sera cargada con el monto indicado en esta orden</b></p></td>
                        </tr>
                    </tbody>
                </table>
                <center> 
                    <p>Aceptamos las siguientes tarjetas</p>
                    <img src="Recursos Imagenes/Tarjetas.png" width="200" height="200" alt="Tarjetas"/></center>

            </div>
        </form>



        <div id="Tap_Resumen" class="tabcontent">
            <h1>Resumen de la compra</h1>
            <%-- start web service invocation --%><hr/>
            <%        if (request.getParameter("Btn_Comprar") != null) {
                    try {
                        service.ServiceBank_Service service = new service.ServiceBank_Service();
                        service.ServiceBank port = service.getServiceBankPort();
                        if (port.retirar(request.getParameter("Text_Tarjeta"), request.getParameter("Text_Seguro"), request.getParameter("Text_Nombre"), request.getParameter("Text_Identidad"), request.getParameter("Date_Vence"), request.getParameter("Text_Total")).equals("Transaccion denegada")) {
                            out.print("<p> No Hemos podido realizar la compra debido a que el banco nego la transaccion</p>");
                        } else {
                            int Factura = 0;
                            String HTML = "<html><head></head><body>";
                            out.print("<p>Transaccion bancaria exitosa</p>");
                            db.Conectar();
                            db.query.execute("select Max(Fac_Codigo)+1 from ver_Factura");
                            ResultSet rs = db.query.getResultSet();
                            while (rs.next()) {
                                Factura = rs.getInt(1);
                            }

                            int Contador = db.query.executeUpdate("insert into T_Factura values('" + request.getParameter("Text_Sala") + "','" + Factura + "','"
                                    + request.getParameter("Text_Pelicula") + "',sysdate,'" + request.getParameter("Text_Total") + "','" + request.getParameter("Text_Correo") + "','"
                                    + request.getParameter("Text_Cel") + "','" + request.getParameter("Text_Identidad") + "','" + request.getParameter("Text_Nombre") + "')");
                            db.commit();
                            if (Contador >= 1) {
                                Document documentoPDF = new Document();
                                FileOutputStream Archivo = new FileOutputStream(application.getRealPath("Facturas/" + Factura + ".pdf"));
                                PdfWriter.getInstance(documentoPDF, Archivo);
                                documentoPDF.open();
                                documentoPDF.addAuthor("Cine");
                                documentoPDF.addCreator("Cine");
                                documentoPDF.addSubject("Factura");
                                documentoPDF.addCreationDate();
                                documentoPDF.addTitle("Factura: " + Factura);
                                db.query.execute("select VER_CINE.CIN_NOMBRE, VER_UBICACION.CIN_CODIGO, VER_UBICACION.UBI_NOMBRE,VER_UBICACION.UBI_UBICACION,"
                                        + " VER_SALA.UBI_CODIGO, VER_SALA.SAL_NOMBRE, VER_FACTURA.SAL_CODIGO,VER_FACTURA.FAC_CODIGO, VER_PELICULA.PEL_TITULO,"
                                        + " VER_PELICULA.PEL_FORMATO,VER_FACTURA.PEL_CODIGO,VER_FACTURA.FAC_FECHA,VER_FACTURA.FAC_TOTAL,VER_FACTURA.FAC_ID,"
                                        + " VER_FACTURA.FAC_NOMBRE from Ver_Factura inner join Ver_Sala on VER_FACTURA.SAL_CODIGO=VER_SALA.SAL_CODIGO "
                                        + "inner join VER_UBICACION on VER_SALA.UBI_CODIGO= VER_UBICACION.UBI_CODIGO "
                                        + "inner join Ver_Cine on VER_UBICACION.CIN_CODIGO=VER_CINE.CIN_CODIGO "
                                        + "inner join Ver_Pelicula on VER_FACTURA.PEL_CODIGO= VER_PELICULA.PEL_CODIGO "
                                        + " where VER_FACTURA.FAC_CODIGO='" + Factura + "'");
                                ResultSet rs2 = db.query.getResultSet();
                                while (rs2.next()) {
                                    HTML += "<h2>Informacion general</h2><h4>Lugar de exhibiccion</h4> <br>"
                                            + "<table border='1'> <thead> <tr> <th>Cine</th> <th>Ubicacion</th> <th>Sala</th> "
                                            + "<th>Enlace Google Maps</th> </tr> </thead> <tbody> <tr>"
                                            + "<td>" + rs2.getString(1) + " </td> <td>" + rs2.getString(3) + "</td> <td>" + rs2.getString(6) + "</td>"
                                            + "<td><a href='https://www.google.com/maps/@" + rs2.getString(4).substring(1, rs2.getString(4).length() - 1) + ",190m/data=!3m1!1e3' target='_blank'>" + rs2.getString(4) + "</a></td>"
                                            + "</tr> </tbody> </table><br> <h4>Factura</h4> <br>"
                                            + "<table border='1'> <thead> <tr> <th>Identificador de Factura</th> <th>Pelicula a exhibir</th>"
                                            + "<th>Formato de pelicula</th> <th>Fecha y Hora de creacion</th> <th>Total Retirado</th>"
                                            + "<th>Identidad de tarjeta Habiente</th> <th>Nombre de tarjeta habiente</th> </tr> </thead> <tbody> <tr>"
                                            + "<td>" + rs2.getInt(8) + " </td> <td>" + rs2.getString(9) + "</td> <td>" + rs2.getString(10) + "</td>"
                                            + "<td>" + rs2.getDate(12) + " | " + rs2.getTime(12) + " </td> "
                                            + "<td>" + String.format("%.2f", rs2.getFloat(13)) + "</td> <td>" + rs2.getString(14) + "</td> "
                                            + "<td>" + rs2.getString(15) + "</td> </tr> </tbody> </table><br>";
            %>
            <h2>Informacion general</h2>
            <h4>Lugar de exhibiccion</h4>
            <table border="1">
                <thead>
                    <tr>
                        <th>Cine</th>
                        <th>Ubicacion</th>
                        <th>Sala</th>
                        <th>Enlace Google Maps</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><%= rs2.getString(1)%> </td>
                        <td><%= rs2.getString(3)%></td>
                        <td><%= rs2.getString(6)%></td>
                        <td><a href="https://www.google.com/maps/@<%= rs2.getString(4).substring(1, rs2.getString(4).length() - 1)%>,190m/data=!3m1!1e3" target="_blank"><%= rs2.getString(4)%></a></td>
                    </tr>
                </tbody>
            </table><br>
            <h4>Factura</h4>
            <table border="1">
                <thead>
                    <tr>
                        <th>Identificador de Factura</th>
                        <th>Pelicula a exhibir</th>
                        <th>Formato de pelicula</th>
                        <th>Fecha y Hora de creacion</th>
                        <th>Total Retirado</th>
                        <th>Identidad de tarjeta Habiente</th>
                        <th>Nombre de tarjeta habiente</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><%= rs2.getInt(8)%> </td>
                        <td><%= rs2.getString(9)%></td>
                        <td><%= rs2.getString(10)%></td>
                        <td><%= rs2.getDate(12)%> | <%= rs2.getTime(12)%> </td>
                        <td><%= String.format("%.2f", rs2.getFloat(13))%></td>
                        <td><%= rs2.getString(14)%></td>
                        <td><%= rs2.getString(15)%></td>
                    </tr>
                </tbody>
            </table><br>
            <%}
                Contador = 0;
                String Cantidades = request.getParameter("Text_Cantidades").substring(0, request.getParameter("Text_Cantidades").length() - 1);
                for (int i = 0; i < Cantidades.split(",").length; i++) {
                    String Codigo = request.getParameter("Text_Codigos").split(",")[i];
                    String Cantidad = request.getParameter(request.getParameter("Text_Cantidades").split(",")[i]);
                    String Subtotal = request.getParameter(request.getParameter("Text_SubTotales").split(",")[i]);
                    if (!Cantidad.equals("0")) {
                        Contador += db.query.executeUpdate("insert into T_Detalle values('" + Factura + "','" + Codigo + "','" + Cantidad + "','"
                                + Subtotal + "')");
                    }
                }
                db.commit();
                if (Contador >= 1) {
                    HTML += "<h4>Detalles</h4> <table border='1'> <thead> <tr> <th>Ticket de:</th> <th>Edades entre</th> <th>Precio unitario</th> <th>Cantidad</th>"
                            + "<th>Subtotal</th> </tr> </thead> <tbody>";
            %>
            <h4>Detalles</h4>
            <table border="1">
                <thead>
                    <tr>
                        <th>Ticket de:</th>
                        <th>Edades entre</th>
                        <th>Precio unitario</th>
                        <th>Cantidad</th>
                        <th>Subtotal</th>
                    </tr>
                </thead>
                <tbody><%
                    db.query.execute("select VER_DETALLE.PRE_CODIGO, VER_PRECIOS.PRE_DESCRIPCION, VER_PRECIOS.PRE_EDAD_MIN, "
                            + "VER_PRECIOS.PRE_EDAD_MAX, VER_PRECIOS.PRE_PRECIO,VER_DETALLE.DEFA_CANTIDAD, VER_DETALLE.DEFA_SUBTOTAL "
                            + "from Ver_Detalle inner join Ver_Precios on VER_DETALLE.PRE_CODIGO=VER_PRECIOS.PRE_CODIGO "
                            + "where VER_DETALLE.FAC_CODIGO='" + Factura + "'");
                    ResultSet rs3 = db.query.getResultSet();
                    while (rs3.next()) {
                        HTML += "<tr> <td>" + rs3.getString(2) + " </td> <td>" + rs3.getInt(3) + " - " + rs3.getInt(4) + "</td> "
                                + "<td>" + String.format("%.2f", rs3.getFloat(5)) + "</td> <td>" + rs3.getInt(6) + "</td> "
                                + "<td>" + String.format("%.2f", rs3.getFloat(7)) + "</td> </tr> ";
                    %>                       
                    <tr>
                        <td><%= rs3.getString(2)%> </td>
                        <td><%= rs3.getInt(3)%> - <%= rs3.getInt(4)%></td>
                        <td><%= String.format("%.2f", rs3.getFloat(5))%></td>
                        <td><%= rs3.getInt(6)%></td>
                        <td><%= String.format("%.2f", rs3.getFloat(7))%></td>
                    </tr> 
                    <%}
                        HTML += "</tbody> </table>";
                    %>
                </tbody>
            </table>
            <%}

                Contador = 0;
                String Butacas = request.getParameter("Text_Butacas").substring(0, request.getParameter("Text_Butacas").length() - 1);
                for (int i = 0; i < Butacas.split(",").length; i++) {
                    if (request.getParameter(request.getParameter("Text_Butacas").split(",")[i]) != null) {
                        String Butaca = request.getParameter(request.getParameter("Text_Butacas").split(",")[i]);
                        String Fila = Butaca.split(",")[0];
                        String Col = Butaca.split(",")[1];
                        Contador += db.query.executeUpdate("insert into T_Ocupadas values('" + request.getParameter("Exhibir") + "','" + Factura + "','"
                                + Fila + "','" + Col + "')");
                    }
                }
                db.commit();
                if (Contador >= 1) {
                    HTML += "<h4>Sus Asientos</h4> <table border='1'> <thead> <tr> <th>Fecha y Hora de la exhibiccion</th> <th>Fila del asiento</th>"
                            + "<th>Columna del asiento</th> </tr> </thead> <tbody>";
            %>
            <h4>Sus Asientos</h4>
            <table border="1">
                <thead>
                    <tr>
                        <th>Fecha y Hora de la exhibiccion</th>
                        <th>Fila del asiento</th>
                        <th>Columna del asiento</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        db.query.execute("select VER_OCUPADAS.EXH_CODIGO, VER_PRESENTACIONES.EXH_FECHA,VER_OCUPADAS.ENUS_FILA, "
                                + "VER_OCUPADAS.ENUS_COLUMNA "
                                + "from Ver_Ocupadas inner join Ver_Presentaciones on VER_OCUPADAS.EXH_CODIGO=VER_PRESENTACIONES.EXH_CODIGO "
                                + "where VER_OCUPADAS.FAC_CODIGO='" + Factura + "'");
                        ResultSet rs3 = db.query.getResultSet();
                        while (rs3.next()) {
                            HTML += "<tr> <td>" + rs3.getDate(2) + " | " + rs3.getTime(2) + "</td> <td>" + rs3.getInt(3) + "</td> <td>" + rs3.getInt(4) + "</td> </tr>";
                    %>
                    <tr>
                        <td><%= rs3.getDate(2)%> | <%= rs3.getTime(2)%></td>
                        <td><%= rs3.getInt(3)%></td>
                        <td><%= rs3.getInt(4)%></td>
                    </tr>
                    <%}
                        HTML += "</tbody> </table>";
                    %>
                </tbody>
            </table>

            <%
                                }
                                HTMLWorker htmlWorker = new HTMLWorker(documentoPDF);
                                htmlWorker.parse(new StringReader(HTML));
                                documentoPDF.close();
                                
                                
                            Properties props = new Properties();
                            props.put("mail.smtp.host", "smtp.gmail.com");
                            props.put("mail.smtp.port", "587");
                            props.put("mail.smtp.auth", "true");
                            props.put("mail.smtp.starttls.enable", "true");
                            props.put("mail.smtp.user", "eliohernandez9217@gmail.com");
                            props.put("mail.smtp.clave", "Histeria");

                            javax.mail.Session s = javax.mail.Session.getDefaultInstance(props);
                            MimeMessage mensaje = new MimeMessage(s);

                            mensaje.addRecipient(Message.RecipientType.TO, new InternetAddress(request.getParameter("Text_Correo")));
                            mensaje.setSubject("Verificacion de Compra");

                            mensaje.setText("Resumen de su compra");
                            /*Envio Mensaje de texto*/
                            BodyPart parteTexto = new MimeBodyPart();
                            parteTexto.setContent("<b>" + "Resumen de su compra" + "</b>", "text/html");

                            BodyPart parteArchivo = new MimeBodyPart();
                            parteArchivo.setDataHandler(new DataHandler(new FileDataSource(application.getRealPath("Facturas/" + Factura + ".pdf"))));
                            parteArchivo.setFileName(Factura + ".pdf");

                            MimeMultipart todaslasPartes = new MimeMultipart();
                            todaslasPartes.addBodyPart(parteTexto);
                            todaslasPartes.addBodyPart(parteArchivo);

                            mensaje.setContent(todaslasPartes);
                            
                            Transport transport = s.getTransport("smtp");
                            transport.connect("smtp.gmail.com", "eliohernandez9217@gmail.com", "Histeria");
                            transport.sendMessage(mensaje, mensaje.getAllRecipients());
                            transport.close();
                            out.print("<br> Se ha enviado el correo de verificacion a su bandeja de entrada de no encontrarlo revise su bandeja de Spam <br><br> ");
                            out.print("<p style=' text-align: justify'><b>Pasos para recoger sus entradas:</b> <br>  "
                                    + "Le informamos que las entradas solo seran entregadas al tarjeta habiente <br> "
                                    + " Presente en la taquilla ubicada en el lobby del cine que corresponde con las entradas compradas <br> "
                                    + "<b>Sera indispensable presentar: </b> <br>"
                                    + " El codigo de factura de forma impresa, escrita o en su telefono movil <br>"
                                    + " Documento de indentificacion personal y tarjeta de credito o debito con la que re realizo la compra <br> "
                                    + "Carnet de estudiante por cada entrada de estudiante comprada <br> "
                                    + "Adicionalmente debera firmar la hoja de control de recoleccion de entradas, por medio de la cual aseguramos la entrega de las entradas <br> "
                                    + "Posterirmente el cine debera entregarle sus ticket correspondientes a las entradas compradas <br> "
                                    + "Si tuvo algun inconveniente con el proceso de compra en linea puede reportarlo por medio del libro de quejas o correo de cualquiera de los cines afiliados <br>"
                                    + " <b>Informacion adicional: </b> <br> "
                                    + " Recomendamos que se presente al teatro a recoger sus entradas por lo menos 30 minutos antes del inicio de la funcion para que para que tenga tiempo de ubicarse en la sala con comodidad <br> </p>");
                            }
                            
                        }

                    } catch (Exception ex) {
                        ex.printStackTrace();
                        out.print("<p> Hubo problemas de coneccion no pudimos crear su reservacion verifique su internet</p>");
                    }
                    db.desconectar();
                }
            %>
            <%-- end web service invocation --%><hr/>
            <p style=" text-align: justify">
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
        <script src="js/Pestañas.js" type="text/javascript"></script>
        <script src="js/tab.js"></script>
    </body>
</html>
