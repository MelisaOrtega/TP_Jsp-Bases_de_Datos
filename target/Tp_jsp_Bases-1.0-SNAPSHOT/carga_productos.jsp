<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>

<!DOCTYPE html>
<!--
Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Html.html to edit this template
-->
<html>
    <head>
        <title>CARGA</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
         
    <%
                Class.forName("com.mysql.jdbc.Driver");
                Connection conexion = null;            
                String qSucur ="SELECT direc from tb_sucur WHERE id_sucur=?";   
                PreparedStatement consultaDirec = null;
                ResultSet listaDirec = null;
                try {
                    conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/empresadecafe", "root", "");
                    consultaDirec = conexion.prepareStatement(qSucur);
                    consultaDirec.setString(1, request.getParameter("id"));
                    listaDirec = consultaDirec.executeQuery();
                    listaDirec.next();    
        %>
    <body>
        <h1><%out.print(listaDirec.getString("direc"));%><h1>
        <form method="post" action="carga_producto_op.jsp">
            NOMBRE PRODUCTO:<input type="text" name="prod"><br>
            DESCRIPCION: <input type="text" name="desc"><br>
            COSTO: <input type="text" name="costo"><br>
            <input type="hidden" name="id" value="<%out.print(request.getParameter("id"));%>">
            <input type="submit" value="CARGAR">
        </form>
    </body>
    <%
        } catch (Exception e) {
                    e.printStackTrace();
                    /*out.println("exepcion </br>");
                    out.println("detalle de la consulta: </br>");*/

                } finally {
                    try {                                     
                        consultaDirec.close();
                        conexion.close();
                    } catch (Exception e) {
                    }
                }
    %>
</html>
