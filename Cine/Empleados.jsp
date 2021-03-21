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
        <script src="js/md5.js" type="text/javascript"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Empleados</title>
    </head>
    
    <script>
        var Accion=0;
        var Cambio="";
        function Cambios(Nombre){
            var Actual=document.getElementById(Nombre).value;
            if (Cambio!==Actual){
                Accion=1;
            }else{
                Accion=0;
            }
        }
        
        function modificarPASS(Nombre){
            if(Accion==1){
                var sinCifrar =document.getElementById(Nombre).value;           
            document.getElementById(Nombre).value=hex_md5(sinCifrar);
            }           
        }
    </script>
    
    <script>
        
    </script>
    
        <script> 
           function mod(Codigo,Id,Nombre1,Nombre2,Apellido1,Apellido2,Direccion,Nacido,Sexo,Contrato,Puesto,Sueldo,Correo,Tel,Cel,Usuario,Pass){
                var modal2 = document.getElementById("myModal");
                modal.style.display = "block"; 
                document.getElementById("Txt_Codigo").value=Codigo;
                document.getElementById("Txt_Id").value=Id;
                document.getElementById("Txt_Nombre1").value=Nombre1;
                document.getElementById("Txt_Nombre2").value=Nombre2;
                document.getElementById("Txt_Apellido1").value=Apellido1;
                document.getElementById("Txt_Apellido2").value=Apellido2;
                document.getElementById("Txt_Direccion").value=Direccion;
                document.getElementById("Dp_Nacido").value=Nacido;
                document.getElementById("Dp_Contrato").value=Contrato;
                document.getElementById("Cb_Sexo").value=Sexo;
                document.getElementById("Cb_Puesto").value=Puesto;
                document.getElementById("Txt_Sueldo").value=Sueldo;
                document.getElementById("Txt_Correo").value=Correo;
                document.getElementById("Txt_Tel").value=Tel;
                document.getElementById("Txt_Cel").value=Cel;
                document.getElementById("Txt_Usuario").value=Usuario;
                document.getElementById("Txt_Pass").value=Pass;
                Cambio=Pass;
           }
    
    </script>
<%
    if(request.getParameter("Btn_modificar")!=null){
        Dba db =new Dba(); 
      db.Conectar();     
      try{    int Contador=db.query.executeUpdate("Update T_Empleado set Emp_Id='" + request.getParameter("Text_Id") + "',Emp_Nombre1='" + request.getParameter("Text_Nombre1")+
                  "',Emp_Nombre2='" + request.getParameter("Text_Nombre2") + "',Emp_Apellido1='" + request.getParameter("Text_Apellido1") + 
                  "',Emp_Apellido2='" + request.getParameter("Text_Apellido2") + "',Emp_Direccion='" + request.getParameter("Text_direccion") +
                  "',Emp_Nacido='" + request.getParameter("Date_Nacido") + "',Emp_Sexo='" + request.getParameter("Combo_Sexo") +
                  "',Emp_Contrato='" + request.getParameter("Date_Contrato") + "',Emp_Puesto='" + request.getParameter("Combo_Puesto") +
                  "',Emp_Sueldo='" + request.getParameter("Text_Sueldo") + "',Emp_Correo='" + request.getParameter("Text_Correo") + 
                  "',Emp_Tel='" + request.getParameter("Text_Tel") + "',Emp_Cel='" + request.getParameter("Text_Cel") + 
                  "',Emp_Usuario='" + request.getParameter("Text_Usuario") + "',Emp_Password='" + request.getParameter("Text_Pass") +
                  "' where Emp_Codigo='" + request.getParameter("Text_Codigo") + "'");
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
          int Contador=db.query.executeUpdate("Insert into T_Empleado values (Codigos.nextval,'" + request.getParameter("Text_Id") + "','" +
                  request.getParameter("Text_Nombre1") + "','" + request.getParameter("Text_Nombre2") + "','" + request.getParameter("Text_Apellido1") + "','"
                  + request.getParameter("Text_Apellido2") + "','" + request.getParameter("Text_direccion") + "','" + request.getParameter("Date_Nacido") + "','" 
                  + request.getParameter("Combo_Sexo") + "','" + request.getParameter("Date_Contrato") + "','" + request.getParameter("Combo_Puesto") + "','" + 
                   request.getParameter("Text_Sueldo") + "','" + request.getParameter("Text_Correo") + "','" + request.getParameter("Text_Tel") + "','" 
                  + request.getParameter("Text_Cel") + "','" + request.getParameter("Text_Usuario") + "','" + request.getParameter("Text_Pass") + "')");
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
          int Contador=db.query.executeUpdate("delete from T_Empleado where Emp_Codigo='" + request.getParameter("Codigo") + "'");
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
                <form name="Frm_Modificar" action="Empleados.jsp" method="POST">
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
                                            <td>Identidad:</td>
                                            <td> <input id="Txt_Id" type="text" name="Text_Id" value="" required="required" /> </td>
                                        </tr>
                                        <tr>
                                            <td>Primer nombre:</td>
                                            <td><input id="Txt_Nombre1" type="text" name="Text_Nombre1" value="" required="required" /></td>
                                            <td>Segundo nombre:</td>
                                            <td><input id="Txt_Nombre2" type="text" name="Text_Nombre2" value="" /></td>
                                        </tr>
                                        <tr>
                                            <td>Primer apellido:</td>
                                            <td><input id="Txt_Apellido1" type="text" name="Text_Apellido1" value="" required="required" /></td>
                                            <td>Segundo apellido:</td>
                                            <td><input id="Txt_Apellido2" type="text" name="Text_Apellido2" value=""  /></td>
                                        </tr>
                                        <tr>
                                            <td>Direccion:</td>
                                            <td><textarea id="Txt_Direccion" name="Text_direccion" rows="4" cols="20" required="required"></textarea></td>
                                            <td>Fecha de nacimiento:</td>
                                            <td><input id="Dp_Nacido" type="date" name="Date_Nacido" value="" required="required" /></td>
                                        </tr>
                                        <tr>
                                            <td>Sexo:</td>
                                            <td><select id="Cb_Sexo" name="Combo_Sexo" required="required" >
                                                    <option></option>
                                                    <option>Masculino</option>
                                                    <option>Femenino</option>
                                                </select></td>
                                        </tr>
                                        <tr>
                                            <td>Fecha de contratacion:</td>
                                            <td><input id="Dp_Contrato" type="date" name="Date_Contrato" value="" required="required" /></td>
                                            <td>Puesto:</td>
                                            <td><select id="Cb_Puesto" name="Combo_Puesto" required="required">
                                                    <option></option>
                                                    <option>Empleado</option>
                                                    <option>Gerente</option>
                                                </select></td>
                                            <td>Sueldo:</td>
                                            <td><input id="Txt_Sueldo" type="Text" name="Text_Sueldo" value="" required="required"  /></td>
                                        </tr>
                                        <tr>
                                            <td>Correo:</td>
                                            <td><input id="Txt_Correo" type="text" name="Text_Correo" value="" /></td>
                                            <td>Telefono:</td>
                                            <td><input id="Txt_Tel" type="Text" name="Text_Tel" value="" /></td>
                                            <td>Celular:</td>
                                            <td><input id="Txt_Cel" type="Text" name="Text_Cel" value="" /></td>
                                        </tr>
                                        <tr>
                                            <td>Usuario:</td>
                                            <td><input id="Txt_Usuario" type="text" name="Text_Usuario" value="" required="required" /></td>
                                            <td>Contraseña:</td>
                                            <td><input id="Txt_Pass" type="password" name="Text_Pass" value="" required="required" onchange="Cambios('Txt_Pass'); modificarPASS('Txt_Pass')" /></td>
                                        </tr>
                                    </tbody>
                                </table>       <br>             
                                <input type="submit" value="Modificar Empleado" name="Btn_modificar" /><br>                      
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
                                    <Center><h1>Empleados</h1></center>
                                </div>
                            </div>

                            <form name="Frm_Nuevo" action="Empleados.jsp" method="POST">
                                <table border="1" style="border-color: rgba(105,82,162,255)">
                                    <tr>
                                        <td><center><h4>Nuevo</h4></center></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table border="0">
                                                <tbody>
                                                    <tr>
                                                        <td>Identidad:</td>
                                                        <td> <input type="text" name="Text_Id" value="" /> </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Primer nombre:</td>
                                                        <td><input  type="text" name="Text_Nombre1" value="" /></td>
                                                        <td>Segundo nombre:</td>
                                                        <td><input type="text" name="Text_Nombre2" value="" /></td>
                                                    </tr>
                                                    <tr>
                                                        <td>Primer apellido:</td>
                                                        <td><input type="text" name="Text_Apellido1" value="" /></td>
                                                        <td>Segundo apellido:</td>
                                                        <td><input type="text" name="Text_Apellido2" value="" /></td>
                                                    </tr>
                                                    <tr>
                                                        <td>Direccion:</td>
                                                        <td><textarea  name="Text_direccion" rows="4" cols="20"></textarea></td>
                                                        <td>Fecha de nacimiento:</td>
                                                        <td><input type="date" name="Date_Nacido" value="" /></td>
                                                    </tr>
                                                    <tr>
                                                        <td>Sexo:</td>
                                                        <td><select name="Combo_Sexo">
                                                                <option></option>
                                                                <option>Masculino</option>
                                                                <option>Femenino</option>
                                                            </select></td>
                                                    </tr>
                                                    <tr>
                                                        <td>Fecha de contratacion:</td>
                                                        <td><input type="date" name="Date_Contrato" value="" /></td>
                                                        <td>Puesto:</td>
                                                        <td><select name="Combo_Puesto">
                                                                <option></option>
                                                                <option>Empleado</option>
                                                                <option>Gerente</option>
                                                            </select></td>
                                                        <td>Sueldo:</td>
                                                        <td><input  type="Text" name="Text_Sueldo" value="" /></td>
                                                    </tr>
                                                    <tr>
                                                        <td>Correo:</td>
                                                        <td><input type="text" name="Text_Correo" value="" /></td>
                                                        <td>Telefono:</td>
                                                        <td><input type="Text" name="Text_Tel" value="" /></td>
                                                        <td>Celular:</td>
                                                        <td><input type="Text" name="Text_Cel" value="" /></td>
                                                    </tr>
                                                    <tr>
                                                        <td>Usuario:</td>
                                                        <td><input type="text" name="Text_Usuario" value="" /></td>
                                                        <td>Contraseña:</td>
                                                        <td><input id="Text_Password" type="password" name="Text_Pass" value="" onchange="Accion=1; modificarPASS('Text_Password')" /></td>
                                                    </tr>
                                                </tbody>
                                            </table>      <br>           
                                            <input type="submit" value="Crear Empleado" name="Btn_crear" /><br>                      
                                        </td>
                                    </tr>
                                </table>
                            </form> <br> <br> 

                            <table id="table" data-toggle="table" data-search="true"   data-click-to-select="true">
                                <thead>
                                    <tr>

                                        <th data-field="Codigo">Codigo</th>
                                        <th data-field="Id" data-editable="false">Identidad</th>
                                        <th data-field="Nombre" data-editable="false">Nombre</th>
                                        <th data-field="Direccion" data-editable="false">Direccion</th>
                                        <th data-field="Nacido" data-editable="false">Fecha de nacimiento</th>
                                        <th data-field="Sexo" data-editable="false">Sexo</th>
                                        <th data-field="Contratado" data-editable="false">Fecha de contratacion</th>
                                        <th data-field="Puesto" data-editable="false">Cargo</th>
                                        <th data-field="Sueldo" data-editable="false">Sueldo</th>
                                        <th data-field="Correo" data-editable="false">Correo</th>
                                        <th data-field="Tel" data-editable="false">Telefono</th>
                                        <th data-field="Cel" data-editable="false">Celular</th>
                                        <th data-field="Usuario" data-editable="false">Usuario</th>
                                        <th data-field="Contraseña" data-editable="false">Contraseña</th>
                                        <th data-field="operaciones" data-editable="false">Operaciones</th>
                                    </tr>
                                </thead>
                                <tbody>

                                    <% Dba db =new Dba();
                                       db.Conectar();
                                       try{
                                           db.query.execute("SELECT * from ver_Empleado");
                                           ResultSet rs=db.query.getResultSet();
                                           while (rs.next()) {
                                               %>
                                               <tr>
                                                   <td><%= rs.getInt(1) %></td>
                                                   <td><%= rs.getString(2) %></td>
                                                   <td><%= rs.getString(3) + " " + rs.getString(4) + " " + rs.getString(5) + " " + rs.getString(6)%></td>
                                                   <td><%= rs.getString(7) %></td>
                                                   <td><%= rs.getDate(8) %></td>
                                                   <td><%= rs.getString(9) %></td>
                                                   <td><%= rs.getDate(10) %></td>
                                                   <td><%= rs.getString(11) %></td>
                                                   <td><%= rs.getFloat(12) %></td>
                                                   <td><%= rs.getString(13) %></td>
                                                   <td><%= rs.getString(14) %></td>
                                                   <td><%= rs.getString(15) %></td>
                                                   <td><%= rs.getString(16) %></td>
                                                   <td><%= rs.getString(17) %></td>
                                                   <td><input type="button" value="Eliminar" 
                                                    onclick="window.location='Empleados.jsp?Codigo=<%=rs.getInt(1)%>&Btn_Eliminar=1'"/>
                                             <input type="button" value="Modificar" 
                                                    onclick="mod('<%=rs.getInt(1)%>','<%=rs.getString(2)%>','<%=rs.getString(3)%>',
                                                                '<%=rs.getString(4)%>','<%=rs.getString(5)%>','<%=rs.getString(6)%>',
                                                                '<%=rs.getString(7)%>','<%=rs.getDate(8)%>','<%=rs.getString(9)%>','<%=rs.getDate(10)%>'
                                                                ,'<%=rs.getString(11)%>','<%=rs.getFloat(12)%>','<%=rs.getString(13)%>','<%=rs.getString(14)%>'
                                                                ,'<%=rs.getString(15)%>','<%=rs.getString(16)%>','<%=rs.getString(17)%>')"/></td>
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
