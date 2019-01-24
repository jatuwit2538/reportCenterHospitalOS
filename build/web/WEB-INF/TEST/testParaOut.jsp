<%-- 
    Document   : testParaOut
    Created on : Sep 11, 2017, 10:17:00 AM
    Author     : NUT
--%>

<%@page import="net.sf.jasperreports.engine.design.JasperDesign" %>
<%@page import="net.sf.jasperreports.engine.xml.JRXmlLoader"%>
<%@page import="net.sf.jasperreports.engine.util.JRLoader"%>
<%@page import="net.sf.jasperreports.engine.design.JRDesignStyle"%>
<%@ page import="net.sf.jasperreports.engine.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.HashMap" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
            
            JasperDesign jasperDesign;
            
          
            jasperDesign = JRXmlLoader.load(application.getRealPath("//Report/statistics/rp_statistics_fiscal_year_sum.jrxml"));
                        // คอมไพล์ report จะได้ไฟล์ report3.jasper
            //jasperReport = JasperCompileManager.compileReport(jasperDesign);
            for(int i =20;i<jasperDesign.getParametersList().size();i++){
            out.println(jasperDesign.getParametersList().get(i).getName()+"  Type : "+jasperDesign.getParametersList().get(i).getValueClassName()+"<br>");
            } 
           

           
            
        %>
    </body>
</html>
