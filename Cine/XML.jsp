<%-- 
    Document   : XML
    Created on : 12-16-2020, 09:39:18 AM
    Author     : Elio Hernandez
--%>
<%@page import="org.jdom.Document"%>
<%@page import="org.jdom.input.SAXBuilder"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.File"%>
<%@page import="org.jdom.output.XMLOutputter"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="database.Dba"%>
<%@page import="org.jdom.Element"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>XML</title>
    </head>

    <%
        if (request.getParameter("Accion") != null) {
            if (request.getParameter("Accion").equals("Exportar")) {
                Element BD = new Element("BD");
                Element Cine = new Element("Cine");
                BD.addContent(Cine);
                Dba db = new Dba();
                db.Conectar();
                try {
                    db.query.execute("select * from Ver_Cine");
                    ResultSet rs = db.query.getResultSet();
                    while (rs.next()) {
                        Element Registro = new Element("T_Cine");
                        Registro.setAttribute("Cin_Codigo", "" + rs.getInt(1));
                        Registro.setAttribute("Cin_Nombre", rs.getString(2));
                        Registro.setAttribute("Cin_Logo", rs.getString(3));
                        Registro.setAttribute("Cin_Mision", rs.getString(4));
                        Registro.setAttribute("Cin_Vision", rs.getString(5));
                        Registro.setAttribute("Cin_Fundacion", rs.getString(6));
                        Cine.addContent(Registro);
                    }

                    Element Ubicacion = new Element("Ubicacion");
                    BD.addContent(Ubicacion);
                    db.query.execute("select * from Ver_Ubicacion");
                    rs = db.query.getResultSet();
                    while (rs.next()) {
                        Element Registro = new Element("T_Ubicacion");
                        Registro.setAttribute("Ubi_Codigo", "" + rs.getInt(1));
                        Registro.setAttribute("Cin_Codigo", "" + rs.getInt(2));
                        Registro.setAttribute("Ubi_Ubicacion", rs.getString(4));
                        Registro.setAttribute("Ubi_Nombre", rs.getString(5));
                        Registro.setAttribute("Ubi_Fundado", rs.getString(6));
                        Ubicacion.addContent(Registro);
                    }

                    Element Sala = new Element("Sala");
                    BD.addContent(Sala);
                    db.query.execute("select * from ver_Sala");
                    rs = db.query.getResultSet();
                    while (rs.next()) {
                        Element Registro = new Element("T_Sala");
                        Registro.setAttribute("Sal_Codigo", "" + rs.getInt(3));
                        Registro.setAttribute("Ubi_Codigo", "" + rs.getInt(1));
                        Registro.setAttribute("Sal_Nombre", rs.getString(4));
                        Registro.setAttribute("Sal_Descripcion", rs.getString(5));
                        Registro.setAttribute("Sal_Formato", rs.getString(6));
                        Sala.addContent(Registro);
                    }

                    Element Silla = new Element("Silla");
                    BD.addContent(Silla);
                    db.query.execute("select * from ver_Silla");
                    rs = db.query.getResultSet();
                    while (rs.next()) {
                        Element Registro = new Element("T_Silla");
                        Registro.setAttribute("Sal_Codigo", "" + rs.getInt(1));
                        Registro.setAttribute("Sil_Fila", "" + rs.getInt(2));
                        Registro.setAttribute("Sil_Cantidad", "" + rs.getInt(3));
                        Silla.addContent(Registro);
                    }

                    Element Empleado = new Element("Empleado");
                    BD.addContent(Empleado);
                    db.query.execute("select * from ver_Empleado");
                    rs = db.query.getResultSet();
                    while (rs.next()) {
                        Element Registro = new Element("T_Empleado");
                        Registro.setAttribute("Emp_Codigo", "" + rs.getInt(1));
                        Registro.setAttribute("Emp_Id", rs.getString(2));
                        Registro.setAttribute("Emp_Nombre1", rs.getString(3));
                        Registro.setAttribute("Emp_Nombre2", String.format("%s", rs.getString(4)));
                        Registro.setAttribute("Emp_Apellido1", rs.getString(5));
                        Registro.setAttribute("Emp_Apellido2", String.format("%s", rs.getString(6)));
                        Registro.setAttribute("Emp_Direccion", rs.getString(7));
                        Registro.setAttribute("Emp_Nacido", rs.getString(8));
                        Registro.setAttribute("Emp_Sexo", rs.getString(9));
                        Registro.setAttribute("Emp_Contrato", rs.getString(10));
                        Registro.setAttribute("Emp_Puesto", rs.getString(11));
                        Registro.setAttribute("Emp_Sueldo", "" + rs.getFloat(12));
                        Registro.setAttribute("Emp_Correo", String.format("%s", rs.getString(13)));
                        Registro.setAttribute("Emp_Tel", String.format("%s", rs.getString(14)));
                        Registro.setAttribute("Emp_Cel", String.format("%s", rs.getString(15)));
                        Registro.setAttribute("Emp_Usuario", rs.getString(16));
                        Registro.setAttribute("Emp_Password", rs.getString(17));
                        Empleado.addContent(Registro);
                    }

                    Element Pelicula = new Element("Pelicula");
                    BD.addContent(Pelicula);
                    db.query.execute("select * from ver_Pelicula");
                    rs = db.query.getResultSet();
                    while (rs.next()) {
                        Element Registro = new Element("T_Pelicula");
                        Registro.setAttribute("Pel_Codigo", "" + rs.getInt(1));
                        Registro.setAttribute("Pel_Cartelera", rs.getString(2));
                        Registro.setAttribute("Pel_Titulo", rs.getString(3));
                        Registro.setAttribute("Pel_Sinopsis", rs.getString(4));
                        Registro.setAttribute("Pel_Generos", rs.getString(5));
                        Registro.setAttribute("Pel_Audio", rs.getString(6));
                        Registro.setAttribute("Pel_Director", rs.getString(7));
                        Registro.setAttribute("Pel_Subtitulos", rs.getString(8));
                        Registro.setAttribute("Pel_Estreno", rs.getString(9));
                        Registro.setAttribute("Pel_Duracion", rs.getString(10));
                        Registro.setAttribute("Pel_Trailer", rs.getString(11));
                        Registro.setAttribute("Pel_Formato", rs.getString(12));
                        Registro.setAttribute("Pel_EdadMin", "" + rs.getInt(13));
                        Registro.setAttribute("Pel_Calificacion", "" + rs.getInt(14));
                        Pelicula.addContent(Registro);
                    }

                    Element Precios = new Element("Precios");
                    BD.addContent(Precios);
                    db.query.execute("select * from ver_Precios");
                    rs = db.query.getResultSet();
                    while (rs.next()) {
                        Element Registro = new Element("T_Precio");
                        Registro.setAttribute("Pre_Codigo", "" + rs.getInt(1));
                        Registro.setAttribute("Cin_Codigo", "" + rs.getInt(2));
                        Registro.setAttribute("Pre_Descripcion", rs.getString(4));
                        Registro.setAttribute("Pre_Edad_Min", "" + rs.getInt(5));
                        Registro.setAttribute("Pre_Edad_Max", "" + rs.getInt(6));
                        Registro.setAttribute("Pre_Precio", "" + rs.getFloat(7));
                        Registro.setAttribute("Pre_Formato", rs.getString(8));
                        Precios.addContent(Registro);
                    }

                    Element Exhibiccion = new Element("Exhibiccion");
                    BD.addContent(Exhibiccion);
                    db.query.execute("select * from ver_Presentaciones");
                    rs = db.query.getResultSet();
                    while (rs.next()) {
                        Element Registro = new Element("T_Exhibicion");
                        Registro.setAttribute("Exh_Codigo", "" + rs.getInt(1));
                        Registro.setAttribute("Sal_Codigo", "" + rs.getInt(6));
                        Registro.setAttribute("Pel_Codigo", "" + rs.getInt(8));
                        Registro.setAttribute("Exh_Fecha",rs.getDate(12) +" " +rs.getTime(12));
                        Exhibiccion.addContent(Registro);
                    }

                    Element Factura = new Element("Factura");
                    BD.addContent(Factura);
                    db.query.execute("select * from ver_Factura");
                    rs = db.query.getResultSet();
                    while (rs.next()) {
                        Element Registro = new Element("T_Factura");
                        Registro.setAttribute("Sal_Codigo", "" + rs.getInt(1));
                        Registro.setAttribute("Fac_Codigo", "" + rs.getInt(2));
                        Registro.setAttribute("Pel_Codigo", "" + rs.getInt(3));
                        Registro.setAttribute("Fac_Fecha", rs.getDate(4) + " " + rs.getTime(4));
                        Registro.setAttribute("Fac_Total", "" + rs.getFloat(5));
                        Registro.setAttribute("Fac_Correo", rs.getString(6));
                        Registro.setAttribute("Fac_Cel", String.format("%s", rs.getString(7)));
                        Registro.setAttribute("Fac_Id", rs.getString(8));
                        Registro.setAttribute("Fac_Nombre", rs.getString(9));
                        Factura.addContent(Registro);
                    }

                    Element Ocupadas = new Element("Ocupadas");
                    BD.addContent(Ocupadas);
                    db.query.execute("select * from ver_Ocupadas");
                    rs = db.query.getResultSet();
                    while (rs.next()) {
                        Element Registro = new Element("T_Ocupadas");
                        Registro.setAttribute("Exh_Codigo", "" + rs.getInt(1));
                        Registro.setAttribute("Fac_Codigo", "" + rs.getInt(2));
                        Registro.setAttribute("EnUs_Fila", "" + rs.getInt(3));
                        Registro.setAttribute("EnUs_Columna", "" + rs.getInt(4));
                        Ocupadas.addContent(Registro);
                    }

                    Element Detalle = new Element("Detalle");
                    BD.addContent(Detalle);
                    db.query.execute("select * from ver_Detalle");
                    rs = db.query.getResultSet();
                    while (rs.next()) {
                        Element Registro = new Element("T_Detalle");
                        Registro.setAttribute("Fac_Codigo", "" + rs.getInt(1));
                        Registro.setAttribute("Pre_Codigo", "" + rs.getInt(4));
                        Registro.setAttribute("DeFa_Cantidad", "" + rs.getInt(12));
                        Registro.setAttribute("DeFa_Subtotal", "" + rs.getFloat(13));
                        Detalle.addContent(Registro);
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                }
                db.desconectar();

                try {
                    XMLOutputter salida = new XMLOutputter();
                    FileOutputStream FOS = new FileOutputStream(application.getRealPath("XML/Backup.xml"));
                    salida.output(BD, FOS);
                    FOS.close();

                } catch (Exception e) {
                    e.printStackTrace();
                }
                out.print("<a href='XML/Backup.xml' target='_blank'>Ver XML</a>");
            }

            if (request.getParameter("Accion").equals("Importar")) {
                 File fichero = new File(application.getRealPath("XML/Backup.xml"));
                 if(fichero.exists()){
                SAXBuilder builder = new SAXBuilder();
                String xml_path = application.getRealPath("XML/Backup.xml");
                Document bd_xml = builder.build(xml_path);
                Element raiz = bd_xml.getRootElement();
                Dba db = new Dba();
                db.Conectar();
                for (int i = 0; i < raiz.getChildren().size(); i++) {
                    Element Tablas = (Element) raiz.getChildren().get(i);
                    for (int j = 0; j < Tablas.getChildren().size(); j++) {
                        Element Registros = (Element) Tablas.getChildren().get(j);
                        String SQL = "";
                        try {
                            if (Registros.getName().equals("T_Cine")) {
                                SQL = "Insert into T_Cine values ('" + Registros.getAttributeValue("Cin_Codigo") + "','" + Registros.getAttributeValue("Cin_Nombre") + "','"
                                        + Registros.getAttributeValue("Cin_Logo") + "','" + Registros.getAttributeValue("Cin_Mision") + "','" + Registros.getAttributeValue("Cin_Vision") + "','"
                                        + Registros.getAttributeValue("Cin_Fundacion") + "')";
                            }

                            if (Registros.getName().equals("T_Ubicacion")) {
                                SQL = "Insert into T_Ubicacion values ('" + Registros.getAttributeValue("Ubi_Codigo") + "','" + Registros.getAttributeValue("Cin_Codigo") + "','"
                                        + Registros.getAttributeValue("Ubi_Ubicacion") + "','" + Registros.getAttributeValue("Ubi_Nombre") + "','"
                                        + Registros.getAttributeValue("Ubi_Fundado") + "')";
                            }

                            if (Registros.getName().equals("T_Sala")) {
                                SQL = "Insert into T_Sala values ('" + Registros.getAttributeValue("Sal_Codigo") + "','" + Registros.getAttributeValue("Ubi_Codigo") + "','"
                                        + Registros.getAttributeValue("Sal_Nombre") + "','" + Registros.getAttributeValue("Sal_Descripcion") + "','" + Registros.getAttributeValue("Sal_Formato") + "')";
                            }

                            if (Registros.getName().equals("T_Silla")) {
                                SQL = "Insert into T_Silla values ('" + Registros.getAttributeValue("Sal_Codigo") + "','"
                                        + Registros.getAttributeValue("Sil_Fila") + "','" + Registros.getAttributeValue("Sil_Cantidad") + "')";
                            }

                            if (Registros.getName().equals("T_Empleado")) {
                                SQL = "Insert into T_Empleado values ('" + Registros.getAttributeValue("Emp_Codigo") + "','" + Registros.getAttributeValue("Emp_Id") + "','"
                                        + Registros.getAttributeValue("Emp_Nombre1") + "','" + Registros.getAttributeValue("Emp_Nombre2") + "','" + Registros.getAttributeValue("Emp_Apellido1") + "','"
                                        + Registros.getAttributeValue("Emp_Apellido2") + "','" + Registros.getAttributeValue("Emp_Direccion") + "','" + Registros.getAttributeValue("Emp_Nacido") + "','"
                                        + Registros.getAttributeValue("Emp_Sexo") + "','" + Registros.getAttributeValue("Emp_Contrato") + "','" + Registros.getAttributeValue("Emp_Puesto") + "','"
                                        + Registros.getAttributeValue("Emp_Sueldo") + "','" + Registros.getAttributeValue("Emp_Correo") + "','" + Registros.getAttributeValue("Emp_Tel") + "','"
                                        + Registros.getAttributeValue("Emp_Cel") + "','" + Registros.getAttributeValue("Emp_Usuario") + "','" + Registros.getAttributeValue("Emp_Password") + "')";
                            }

                            if (Registros.getName().equals("T_Pelicula")) {
                                SQL = "Insert into T_Pelicula values ('" + Registros.getAttributeValue("Pel_Codigo") + "','" + Registros.getAttributeValue("Pel_Cartelera") + "','" + Registros.getAttributeValue("Pel_Titulo") + "','"
                                        + Registros.getAttributeValue("Pel_Sinopsis") + "','" + Registros.getAttributeValue("Pel_Generos") + "','" + Registros.getAttributeValue("Pel_Audio") + "','"
                                        + Registros.getAttributeValue("Pel_Director") + "','" + Registros.getAttributeValue("Pel_Subtitulos") + "','" + Registros.getAttributeValue("Pel_Estreno") + "','"
                                        + Registros.getAttributeValue("Pel_Duracion") + "','" + Registros.getAttributeValue("Pel_Trailer") + "','" + Registros.getAttributeValue("Pel_Formato") + "','"
                                        + Registros.getAttributeValue("Pel_EdadMin") + "','" + Registros.getAttributeValue("Pel_Calificacion") + "')";
                            }

                            if (Registros.getName().equals("T_Precio")) {
                                SQL = "Insert into T_Precio values ('" + Registros.getAttributeValue("Pre_Codigo") + "','" + Registros.getAttributeValue("Cin_Codigo") + "','"
                                        + Registros.getAttributeValue("Pre_Descripcion") + "','" + Registros.getAttributeValue("Pre_Edad_Min") + "','"
                                        + Registros.getAttributeValue("Pre_Edad_Max") + "','" + Registros.getAttributeValue("Pre_Precio") + "','" + Registros.getAttributeValue("Pre_Formato") + "')";
                            }

                            if (Registros.getName().equals("T_Exhibicion")) {
                                SQL = "Insert into T_Exhibicion values ('"+ Registros.getAttributeValue("Exh_Codigo") +"','" + Registros.getAttributeValue("Sal_Codigo") + "','" + Registros.getAttributeValue("Pel_Codigo")
                                        + "',TO_DATE('" + Registros.getAttributeValue("Exh_Fecha") +"','yyyy-mm-dd hh24:mi:ss'))";
                            }

                            if (Registros.getName().equals("T_Factura")) {
                                SQL = "insert into T_Factura values('" + Registros.getAttributeValue("Sal_Codigo") + "','" + Registros.getAttributeValue("Fac_Codigo") + "','"
                                        + Registros.getAttributeValue("Pel_Codigo") + "',TO_DATE('" + Registros.getAttributeValue("Fac_Fecha") + "','yyyy-mm-dd hh24:mi:ss'),'" + Registros.getAttributeValue("Fac_Total") + "','" + Registros.getAttributeValue("Fac_Correo") + "','"
                                        + Registros.getAttributeValue("Fac_Cel") + "','" + Registros.getAttributeValue("Fac_Id") + "','" + Registros.getAttributeValue("Fac_Nombre") + "')";
                            }

                            if (Registros.getName().equals("T_Ocupadas")) {
                                SQL = "insert into T_Ocupadas values('" + Registros.getAttributeValue("Exh_Codigo") + "','" + Registros.getAttributeValue("Fac_Codigo") + "','"
                                        + Registros.getAttributeValue("EnUs_Fila") + "','" + Registros.getAttributeValue("EnUs_Columna") + "')";
                            }

                            if (Registros.getName().equals("T_Detalle")) {
                                SQL = "insert into T_Detalle values('" + Registros.getAttributeValue("Fac_Codigo") + "','" + Registros.getAttributeValue("Pre_Codigo") + "','" + Registros.getAttributeValue("DeFa_Cantidad") + "','"
                                        + Registros.getAttributeValue("DeFa_Subtotal") + "')";
                            }

                            int Contador = db.query.executeUpdate(SQL);
                            db.commit();
                            if (Contador == 1) {
                                out.print("Dato ingresado corectamente en: " + Tablas.getName() + "<br>");
                            }

                        } catch (Exception e) {
                            e.printStackTrace();
                        }

                    }
                }
                db.desconectar();
                out.print("Se han restaurado los elementos");
            } else{
                     out.print("No existe ningun archivo de restauracion porfavor pegue una copia del archivo de restauracion en esta direccion: "+ application.getRealPath("XML"));
                 }

        }}
    %>

    <body >

    </body>
</html>
