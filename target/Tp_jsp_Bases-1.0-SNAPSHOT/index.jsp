<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Consulta Productos</title>
    </head>
    <body>
          <h1>EMPRESA DE CAFE</h1>
         <%
                Class.forName("com.mysql.jdbc.Driver");
                Connection conexion = null;
                String qSucur= "SELECT * FROM tb_sucur";
                PreparedStatement consultaSucur = null;
                ResultSet listaSucur= null;
                try {
                    conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/empresadecafe", "root", "");
                    consultaSucur = conexion.prepareStatement(qSucur);
                    listaSucur= consultaSucur.executeQuery();
                     
                   while(listaSucur.next()){
                   %>
                   <h1><%out.print(listaSucur.getString("nom_sucur"));%></h1>
                    <p><%out.print(listaSucur.getString("direc"));%></p>
                   
                   <ul>
                       
                       <li><a href= "carga_productos.jsp?id=<%out.print(listaSucur.getString("id_sucur"));%>">carga</a></li>
                        <li><a href= "muestra_productos.jsp?id=<%out.print(listaSucur.getString("id_sucur"));%>&sucur=<%out.print(listaSucur.getString("nom_sucur"));%></br>&direc=<%out.print(listaSucur.getString("direc"));%>">muestra</a></li>
                         <li><a href= "elimina_producto.jsp?id=<%out.print(listaSucur.getString("id_sucur"));%>">elimina</a></li> 
                   </ul>
                 
                   <%
                    }    
                    
                } catch (Exception e) {
                    e.printStackTrace();
                    /*out.println("exepcion </br>");
                    out.println("detalle de la consulta: </br>");
                 */
                } finally {
                    try {
                        listaSucur.close();
                        consultaSucur.close();
                    } catch (Exception e) {
                    }
                }
            %>
    </body>
</html>

