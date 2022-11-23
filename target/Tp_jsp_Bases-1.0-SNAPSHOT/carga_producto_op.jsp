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
        <title>Carga Productos</title>
    </head>
     
    <body> 
                    <%
                Class.forName("com.mysql.jdbc.Driver");
                Connection conexion = null;            
                String qProd = "INSERT INTO tb_prod(nom_prod, desc_prod, costo) VALUES (?,?,?)";
                String qSet = "SET @id_prod = LAST_INSERT_ID()";
                String qRel = "INSERT INTO tb_prod_sucur(id_tbprod, id_tbsucur, stock) VALUES (@id_prod,?,?)";
           
                PreparedStatement consultaProd = null;
                PreparedStatement consultaRel = null;
                PreparedStatement consultaSet = null;
                String vId = request.getParameter("id");
                String vDesc = request.getParameter("desc");
                String vProd = request.getParameter("prod");
                String vCosto = request.getParameter("costo");
                String vStock = request.getParameter("stock");
               
                try {
                    conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/empresadecafe", "root", "");
                    /*prepara curso*/
                    consultaProd = conexion.prepareStatement(qProd);
                    consultaProd.setString(1, request.getParameter("prod"));
                    consultaProd.setString(2, request.getParameter("desc"));
                    consultaProd.setString(3, request.getParameter("costo"));
                    /*preparar consulta set*/
                    consultaSet = conexion.prepareStatement(qSet);
                    /*prepara relacion*/
                    consultaRel = conexion.prepareStatement(qRel);
                    consultaRel.setString(1, request.getParameter("id"));
                    consultaRel.setInt(2,Integer.parseInt(request.getParameter("stock")));

                    consultaProd.execute();
                    consultaSet.execute();
                    consultaRel.execute();
                    
                    out.print("Producto cargado correctamente");
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println(consultaProd + "</br>");
                    out.println(consultaRel + "</br>");
                  
                } finally {
                    try {
                        consultaRel.close();
                        consultaProd.close();
                        conexion.close();
                    } catch (Exception e) {
                    }
                }
            %>
    </body>
</html>