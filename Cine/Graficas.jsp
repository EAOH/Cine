<%-- 
    Document   : Graficas
    Created on : 12-15-2020, 10:53:44 AM
    Author     : Elio Hernandez
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="database.Dba"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    if (session.getAttribute("Puesto") != null) {
        if (!session.getAttribute("Puesto").equals("Gerente")) {
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    } else {
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
    int Max = 0;
    if (request.getParameter("Grafico") != null) {
        Dba db = new Dba();
        db.Conectar();
        try {
            db.query.execute("select Sum(VER_FACTURA.FAC_TOTAL) from Ver_Factura");
            ResultSet rs = db.query.getResultSet();
            while (rs.next()) {
                Max = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        db.desconectar();
    }

%>
<html>
    <head>
        <link rel="shortcut icon" type="image/x-icon" href="Recursos Imagenes/Icono.ico">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/data-table/bootstrap-table.css">
        <link rel="stylesheet" href="css/data-table/bootstrap-editable.css">
        <link rel="stylesheet" href="css/modal.css">
        <script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
        <script type="text/javascript" src="js/highcharts.js"></script>
        <script type="text/javascript" src="js/exporting.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Graficos</title>

        <script type="text/javascript">

            var chart;
            $(document).ready(function () {
                chart = new Highcharts.Chart({
                    chart: {
                        renderTo: 'graficaCircular'
                    },
                    title: {
                        text: 'Grafico de ventas'
                    },
                    subtitle: {
                        text: 'Por: <%= request.getParameter("Grafico")%>'
                    },
                    plotArea: {
                        shadow: null,
                        borderWidth: null,
                        backgroundColor: null
                    },
                    tooltip: {
                        formatter: function () {
                            return '<b>' + this.point.name + '</b>: ' + this.y + ' Lps';
                        }
                    },
                    plotOptions: {
                        pie: {
                            allowPointSelect: true,
                            cursor: 'pointer',
                            dataLabels: {
                                enabled: true,
                                color: '#000000',
                                connectorColor: '#000000',
                                formatter: function () {
                                    return '<b>' + this.point.name + '</b>: ' + Number.parseFloat((this.y /<%=Max%>) * 100, 2).toFixed(2) + ' %';
                                }
                            }
                        }
                    },
                    series: [{
                            type: 'pie',
                            name: 'Browser share',
                            data: [
            <% String SQL = "", Grafico = "";
                if (request.getParameter("Grafico").equals("Sala")) {
                    SQL = "select distinct VER_FACTURA.SAL_CODIGO, VER_SALA.SAL_NOMBRE, VER_SALA.UBI_CODIGO, VER_UBICACION.UBI_NOMBRE, "
                            + "(select SUM(VER_FACTURA.FAC_TOTAL) from Ver_Factura where VER_FACTURA.SAL_CODIGO=VER_SALA.SAL_CODIGO ) "
                            + "from Ver_Factura inner join Ver_Sala on VER_FACTURA.SAL_CODIGO=VER_SALA.SAL_CODIGO "
                            + "inner join VER_UBICACION on VER_SALA.UBI_CODIGO= VER_UBICACION.UBI_CODIGO ";
                }

                if (request.getParameter("Grafico").equals("Pelicula")) {
                    SQL = "select distinct VER_FACTURA.PEL_CODIGO, VER_PELICULA.PEL_TITULO,"
                            + "(select SUM(VER_FACTURA.FAC_TOTAL) from Ver_Factura where VER_FACTURA.PEL_CODIGO =VER_PELICULA.PEL_CODIGO )"
                            + "from Ver_Factura inner join Ver_Pelicula on VER_FACTURA.PEL_CODIGO=Ver_Pelicula.PEL_CODIGO";
                }

                if (request.getParameter("Grafico").equals("Horario")) {
                    SQL = "select To_Date(VER_FACTURA.FAC_FECHA,'dd-mm-RR') , Sum(VER_FACTURA.FAC_TOTAL) from VER_FACTURA GROUP BY To_Date(VER_FACTURA.FAC_FECHA,'dd-mm-RR')";
                }

                if (request.getParameter("Grafico").equals("Sucursal")) {
                    SQL = "select distinct VER_FACTURA.SAL_CODIGO, VER_SALA.SAL_NOMBRE, VER_SALA.UBI_CODIGO, VER_UBICACION.UBI_NOMBRE, "
                            + "(select SUM(VER_FACTURA.FAC_TOTAL) from Ver_Factura where VER_FACTURA.SAL_CODIGO=VER_SALA.SAL_CODIGO and VER_SALA.UBI_CODIGO =VER_UBICACION.UBI_CODIGO ) "
                            + "from Ver_Factura inner join Ver_Sala on VER_FACTURA.SAL_CODIGO=VER_SALA.SAL_CODIGO "
                            + "inner join VER_UBICACION on VER_SALA.UBI_CODIGO= VER_UBICACION.UBI_CODIGO ";
                }

                if (request.getParameter("Grafico").equals("Compañia")) {
                    SQL = "select distinct VER_FACTURA.SAL_CODIGO, VER_SALA.SAL_NOMBRE, VER_SALA.UBI_CODIGO, VER_UBICACION.UBI_NOMBRE, VER_UBICACION.CIN_CODIGO, VER_CINE.CIN_NOMBRE, "
                            + "(select SUM(VER_FACTURA.FAC_TOTAL) from Ver_Factura where VER_FACTURA.SAL_CODIGO=VER_SALA.SAL_CODIGO and VER_SALA.UBI_CODIGO =VER_UBICACION.UBI_CODIGO "
                            + "and VER_UBICACION.CIN_CODIGO=VER_CINE.CIN_CODIGO ) from Ver_Factura inner join Ver_Sala on VER_FACTURA.SAL_CODIGO=VER_SALA.SAL_CODIGO "
                            + "inner join VER_UBICACION on VER_SALA.UBI_CODIGO= VER_UBICACION.UBI_CODIGO inner join Ver_Cine on VER_UBICACION.CIN_CODIGO= VER_CINE.CIN_CODIGO";
                }

                Dba db = new Dba();
                db.Conectar();
                try {
                    db.query.execute(SQL);
                    ResultSet rs = db.query.getResultSet();
                    while (rs.next()) {
                        if (request.getParameter("Grafico").equals("Sala")) {
                            Grafico += "['" + rs.getString(4) +":" +  rs.getString(2) +"'," + rs.getInt(5) + "],";
                        }

                        if (request.getParameter("Grafico").equals("Pelicula")) {
                            Grafico += "['" +rs.getString(2) +"'," + rs.getInt(3) + "],";
                        }

                        if (request.getParameter("Grafico").equals("Horario")) {
                            Grafico += "['" +rs.getDate(1) +"'," + rs.getInt(2) + "],";
                        }

                        if (request.getParameter("Grafico").equals("Sucursal")) {
                            Grafico += "['" + rs.getString(4)+"'," + rs.getInt(5) + "],";
                        }

                        if (request.getParameter("Grafico").equals("Compañia")) {
                            Grafico += "['"  +  rs.getString(6) +"'," + rs.getInt(7) + "],";
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
                db.desconectar();

            %>
            <%if(Grafico.length()>0){
                out.print(Grafico.substring(0, Grafico.length() - 1));
                }%>
                            ]
                        }]
                });
            });

        </script>

    </head>
    <body>
        <div id="graficaCircular" style="width: 100%; height: 500px; margin: 0 auto"></div>



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
