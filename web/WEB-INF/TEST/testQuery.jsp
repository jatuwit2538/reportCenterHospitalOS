<%-- 
    Document   : testQuery
    Created on : Sep 11, 2017, 3:02:45 PM
    Author     : NUT
--%>



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="net.sf.jasperreports.engine.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.io.File"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="java.io.FileNotFoundException"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.SQLException"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            
           try{
               
               String sql = "select a_add_param.id,a_filter_type.namefil,a_add_param.name,a_add_param.description,a_add_param.query from a_add_param inner join a_filter_type on a_add_param.idfil = a_filter_type.idfil order by a_add_param.id ASC";
               //String sqlFilter = "select filtertype.nameFil from addparam ";
               Connection con =null; 
               
               Class.forName("org.postgresql.Driver").newInstance();
               con = DriverManager.getConnection("jdbc:postgresql://localhost:5433/dbHos", "postgres", "postgres");
               
               Statement statement = con.createStatement();
               
               ResultSet rs = statement.executeQuery(sql);
               
               //ResultSet rsFilter = statement.executeQuery(sqlFilter);
                   out.println("<table border='2'>");
                   out.println("<tr>");
                   for(int i =1;i<(rs.getMetaData().getColumnCount()+1);i++){
                          out.print("<td>"+rs.getMetaData().getColumnName(i).toUpperCase()+"</td>"); 
                   }
                   out.println("</tr>");
                     while(rs.next()){
                         out.println("<tr>");
                         for(int i =1;i<(rs.getMetaData().getColumnCount()+1);i++){
                          out.print("<td>"+rs.getString(i)+"</td>");
                         }
                         out.println("</tr>");
                     }
                     out.println("</table>");
           
           
              rs.close();
               //out.println("test");
               
               //out.println(statement.executeQuery(sql));
           }catch(Exception ex){
               ex.printStackTrace();
           }
        
        %>
        
        
        
    </body>
</html>
