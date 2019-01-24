<%-- 
    Document   : addParams
    Created on : Sep 11, 2017, 4:33:35 PM
    Author     : NUT
--%>

<%@page import="path.managePath"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
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
        <link rel="stylesheet" href="style/default.css">
        <link rel="stylesheet" href="style/w3.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" href="images/Logo.png">
        <title>Add Parameters</title>
        <style>
html{
          background-color: #A9D0F5;      
            }
button {
    width: 50%;
    background-color: #0040FF;
    color: white;
    padding: 14px 20px;
    margin: 8px 0;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    
}



div {
    border-radius: 5px;
    background-color: #ffffff;
    padding: 0px 150px;
    
   
}
.buttonBack {
    background-color: #ffffff;
    
}
.buttonAccept {
    background-color: #ffffff;
    font-size: 20px;
}

#textArea {
    height: 150px;
    border-radius: 6px;
    background-color: transparent;
    resize: none;
  
    
}
#addButton {
   background-color: #ffffff; 
   border-radius:6px;
   font-weight: bold;
   font-family: TH SarabunPSK;
   font-size: 24px;
   padding: 0px 11px;
   color: black;
   height: 40px;
   
   border:2px solid #74B3DF;
   cursor: pointer;
}
#addButton:hover{
    color: white;
    background-color: #005ce6;
    transition-duration: 0.3s;
     
}
#pagewrap{
    background: rgba(256,256,256, 0.6);
    border-radius: 6px; 
    padding: 0px 0px;
    margin: 0px 200px;
    align-content: center;
    
}
#groupDetail{
    background: transparent;
    align-content: center;
    margin-left: 148px;
}
</style>
    </head>
    <body>
<div id='pagewrap' >
        <h1 align="center" style="font-family: TH SarabunPSK;font-size:45px;margin-left: 33px;font-weight: bold;">เพิ่มตัวแปร</h1>
       
        <form name="insertData" action="insertData" align="left">
           <div id="groupDetail">     
           ชื่อตัวแปร :  <input type="text" id="textInput" name="name" placeholder='ทดสอบ1(คำอธิบายตัวแปร)' style='margin-left: 15px;'><br><br>
           ตัวแปร :  <input type="text" id="textInput" name="description" placeholder='test_1(ชื่อตัวแปรใช้ส่งไปยังreport)' style='margin-left: 33px;'><br><br>
           <%
               try{
                   managePath path = new managePath(getServletContext().getRealPath("/")+"setting/setting.txt");
               String sql = "SELECT * FROM a_filter_type order by namefil";
            
             Class.forName("org.postgresql.Driver").newInstance();
               Connection conn = (Connection)DriverManager.getConnection(path.getPathDB(), path.getUserDB(), path.getPassDB()); 
               Statement statement = conn.createStatement(); 
               ResultSet rs = statement.executeQuery(sql);
               
              
               out.println("การรับข้อมูล : <select name='idfil' onchange='showData()' style='height: 40px;border:2px solid #74B3DF;'>");
               
               while(rs.next()){  
                   out.print(rs.getString(2));
                out.print("<option value="+rs.getString(1)+">");
                   out.print(rs.getString(2));
                out.print("</option>"); 
               }
               out.println("</select><br><br>");
 
               }catch(Exception ex){
                  ex.printStackTrace();
               }
               
           %>
           
           <div id="textArea" style='padding: 0px 0px;margin-right: 35px;'>
           คำสั่งSQL :  <textarea row="60" cols="80" name="query" placeholder='select id,name from membertest //ใช้2คอลัมน์ คือid(ส่งไปยัง report) ,name(แสดงในlist) ใช้ "" ในการระบุString เช่น where b_service_point_id = "1"' style='width: 400px;'></textarea><br>
           </div>
           <script>document.getElementById('textArea').style.display = 'none';</script>
           
           <button type="submit" id="addButton" align="right" action="" style='padding: 0px 0px;margin-left: 45px;margin-top: 0px;'>ยืนยัน</button>
        </form>  
            
            </div>
            <div id="groupDetail">
           <button id="addButton" onclick="goBack()" style='padding: 0px 0px;margin-left: 45px;margin-top: 2px;'>กลับ</button>
           </div>
         </div>  

        
           
           <script>
    
    function goBack() {
    //window.history.back();
    window.location.replace("manageParams.jsp");
    }
    function showData() {
        var theSelect = insertData.idfil;
        //alert(theSelect[theSelect.selectedIndex].text);
        if(theSelect[theSelect.selectedIndex].text==='list'){
            document.getElementById('textArea').style.display = 'block';  
        }else{
            document.getElementById('textArea').style.display = 'none';     
        }
        //hideElement(theSelect[theSelect.selectedIndex].text);
       }
    
       
     </script>
    </body>
</html>
