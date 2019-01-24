<%-- 
    Document   : Show
    Created on : Mar 12, 2017, 4:41:03 PM
    Author     : Admin
--%>




<%@page import="path.managePath"%>
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
<html>
    <head>
  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="http://code.jquery.com/jquery-1.6.3.min.js"></script>
        <script type="text/javascript" src="scripts/jquery.cycle.all.js"></script>

       <style>
           .content{
               display:none;
           } 
           
           .preload{
               margin:0;
               position:absolute;
               top:50%;
               left:50%;
               margin-right: -50%;
               transform: translate(-50%, -50%)
           }
       </style>
    
       
      
    </head>
    <body>
        <% //เมื่อไฟล์รายงานไม่สามารถใช้งานได้ %>
        <div class="preload">  
              <h1>ไฟล์รายงานมีปัญหา</h1>
        </div>    
        <div class="content">
 <%  
                
            try {
               request.setCharacterEncoding("UTF-8"); 
               managePath pathDB = new managePath(getServletContext().getRealPath("/")+"setting/setting.txt"); //เรียกใช้งานคลาส mangePathDB
                //out.print(getServletContext().getRealPath("/")+"setting/setting.txt");
  
               //for connect HosOS
               Class.forName("org.postgresql.Driver").newInstance();
               Connection conn = DriverManager.getConnection(pathDB.getPathDB(), pathDB.getUserDB(), pathDB.getPassDB()); //database connection

               //arraylist ใช้เก็บค่าparamteter และvalue ที่ส่งมายังหน้านี้ เพื่อใช้ในการquery  
               ArrayList<String> allParams = new ArrayList<String>();
               ArrayList<String> allValues = new ArrayList<String>();
              
              
               String path = request.getParameter("textPath"); //ชื่อfolder ที่ใช้เก็บไฟล์jasper และ jrxml
               String textReportJasper = request.getParameter("textReportJasper"); //jasper
               String textReport = request.getParameter("textReport");  //jrxml
               //String textReportSplit = textReport.split("\\.")[0].toString();
               
               
               //code for compile .jrxml file to .jasper file
               /* 
               JasperCompileManager.compileReportToFile(
                application.getRealPath(path+"/"+textReport),//the path to the jrxml file to compile
                application.getRealPath(path+"/"+textReportSplit+".jasper"));//the path and name we want to save the compiled file to
               */
             
            File reportFile = new File(application.getRealPath(path+"/"+textReportJasper));//your report_name.jasper file
             //out.print(reportFile.getPath());
            //Split parameters and values
            
            //แยกparameter และ value ที่ได้รับมา
            String[] splits = request.getQueryString().toString().split("&");
            for(int i =0;i<splits.length;i++){
               String[] paramSplit  = splits[i].split("=");
               for(int j=0;j<paramSplit.length;j+=2){
                  //out.print(paramSplit[j]+"<br>");
                   allParams.add(paramSplit[j]); // parameters
               }
    
               for(int k=1;k<paramSplit.length;k+=2){
                  //out.print(paramSplit[k]+"<br>");
                    allValues.add(paramSplit[k]); // values
               }
            }
            
            for(int i = 0;i<allParams.size();i++){
                //out.print("Parameters : "+allParams.get(i)+"Values : "+allValues.get(i)+"<>");
            }
            
            Map parameters = new HashMap();
            for(int i = 0;i<allParams.size();i++){
            parameters.put(allParams.get(i), allValues.get(i));  //นำ parameter และ value เก็บไว้ใน HashMap()  
            }
            
            
            
            byte[] bytes = JasperRunManager.runReportToPdf(reportFile.getPath(), parameters, conn); //นำตัวแปร parameters ไปใช้ในการ query
             
            
            //display pdf form 
            response.setContentType("application/pdf");
            response.setContentLength(bytes.length);
            ServletOutputStream outStream = response.getOutputStream();
            outStream.write(bytes, 0, bytes.length);
            
            outStream.flush();
            outStream.close();
            
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        %>
        </div> 
        
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
     <script>
          $(function(){
              $(".preload").fadeOut(2000, function(){
                     $(".content").fadeIn(3000); 
              });
          });
          
     </script>
     </body>
     

</html>   
    
    
    
        
         

     