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
        <title>MUESTRA</title>
    </head>
    <body>
        <h1>PRODUCTOS</h1>
        
            <%
                Class.forName("com.mysql.jdbc.Driver");
                Connection conexion = null;
                String qProd = "SELECT tb_prod.nom_prod AS producto,"
                        + " tb_sucur.nom_sucur AS sucursal"
                        + " FROM tb_prod_sucur "
                        + "    JOIN tb_prod ON tb_prod_sucur.id_tbprod= tb_prod.id_prod"
                        + "   JOIN tb_sucur ON tb_prod_sucur.id_tbsucur= tb_sucur.id_sucur"
                        + "    AND tb_sucur.id_sucur=?";
                PreparedStatement consultaProd = null;
                try {
                    conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/empresadecafe", "root", "");
                    /*prepara producto*/
                    consultaProd = conexion.prepareStatement(qProd);
                    consultaProd.setString(1, request.getParameter("id"));
                    ResultSet listaProd = consultaProd.executeQuery();
                    
                    while (listaProd.next()) {
                         %>
                        <ul>
                            
                            <li><%out.print("PRODUCTO: " + listaProd.getString("producto") + "</br>");%></li>   
                         <li><%out.print("SUCURSAL: " + listaProd.getString("sucursal"));%></li>  
                      
                        </ul>
                        <%
                    }
                   
                    out.print("cargado");
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println(consultaProd + "</br>");
                } finally {
                    try {
                        consultaProd.close();
                        conexion.close();
                    } catch (Exception e) {
                    }
                }
            %>
    </body>
</html>