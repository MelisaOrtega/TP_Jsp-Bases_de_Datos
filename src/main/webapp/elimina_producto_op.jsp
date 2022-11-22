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
        <title>ELIMINA</title>
    </head>
      
    <body>   <h1>EMPRESA DE CAFE</h1>
             <%
                Class.forName("com.mysql.jdbc.Driver");
                Connection conexion = null;            
                String qProd ="DELETE FROM tb_prod_sucur WHERE id_tbprod=? AND id_tbsucur=?";
                PreparedStatement eliminaProd = null;
               
                try {
                    conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/empresadecafe", "root", "");
                    /*prepara curso*/
                    eliminaProd = conexion.prepareStatement(qProd);
                    eliminaProd.setString(1, request.getParameter("id_tbprod"));
                    eliminaProd.setString(2, request.getParameter("sucursal"));
                    eliminaProd.execute();       
                    /*String vProd = request.getParameter("id_tbprod");
                    if(vProd ){*/
                    out.print("ELIMINADO");
               
                    
                   
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println(eliminaProd + "</br>");
                    //out.println(consultaRel + "</br>");
                  
                } finally {
                    try {

                        //consultaRel.close();
                        eliminaProd.close();
                        conexion.close();
                    } catch (Exception e) {
                    }
                }
            %>
    </body>
</html>