<%-- 
    Document   : reportEditForm
    Created on : Oct 2, 2017, 2:52:07 PM
    Author     : NUT
--%>

<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="path.managePath"%>
<!DOCTYPE html>
<%@page contentType="text/html; charset=UTF-8" %>

<html>
<title>EDIT</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="style/w3.css">
<link rel="stylesheet" href="style/default.css">
<style>
    body{
    font-family: TH SarabunPSK;
    font-size: 24px;
    font-weight: bold;
      }
    
</style>
<body>

<div class="w3-card-4">
  <div class="w3-container w3-blue">
    <h2>แก้ไขข้อมูล</h2>
  </div>
    <%
        Class.forName("org.postgresql.Driver");
        
        managePath path = new managePath(getServletContext().getRealPath("/")+"setting/setting.txt");
        Connection conn = (Connection) DriverManager.getConnection(path.getPathDB(), path.getUserDB(), path.getPassDB());
        Statement stmt = (Statement) conn.createStatement();
        String sqlServicePoint = "select b_service_point.b_service_point_id,b_service_point.service_point_description from b_service_point where service_point_active='1' order by b_service_point.service_point_description ASC";
       
        request.setCharacterEncoding("UTF-8");
       String reportType = request.getParameter("reportType");
       String text = "";
       String id_cate = ""; //id_cate=1&category=1.รายงานการเงิน&reportType=category
       String category = "";
       String service_point = "";
       String name_folder="";
       String id_report = "";
       String detail = "";  //category=4.รายงานการนัดหมาย&reportType=detail&pkCate=4&id_report=18&detail=1.รายการนัดหมายแยกตามวัน+เวลา+คลินิก+และแพทย์      
       String sql,sqlCate;
       ResultSet rsServicePoint = null;
       
       rsServicePoint = stmt.executeQuery(sqlServicePoint);
             if(reportType.equals("category")){
                 category = request.getParameter("category");
                 name_folder = request.getParameter("name_folder");
                 text = category;
                 service_point = request.getParameter("service_point");
                 
                 id_cate = request.getParameter("id_cate");
                 
                 out.print("<form class='w3-container' action='updateReport'>");
                 out.print("<p><label class='w3-text-blue'><b></b></label>");
                 out.print("ชื่อ<br><input class='w3-input w3-sand' name='edited' type='text' value='"+text+"' style='height: 30px;width: 250px;font-size:22px;margin-bottom: 0px'>");
                 out.print("โฟลเดอร์<br><input class='w3-input w3-sand' name='folder' type='text' value='"+name_folder+"' style='height: 30px;width: 250px;font-size:22px;margin-bottom: 0px'>");
                 
                 out.println("แผนก<br><select name='service_point' style='height: 30px;width: 250px;font-size:22px;margin-bottom: 0px'>");
                            
                 while(rsServicePoint.next()) {
                                  if(rsServicePoint.getString(1).equals(service_point)){
                   out.print("<option value="+rsServicePoint.getString(1)+" selected>");
                   out.print(rsServicePoint.getString(2));
                   out.print("</option>");
                   
                   }else{
                out.print("<option value="+rsServicePoint.getString(1)+">");
                   out.print(rsServicePoint.getString(2));
                out.print("</option>");
                   }
                             }
                             out.println("</select> ");
                 
                 out.print("<p><button class='w3-btn w3-green' style='height: 45px;width: 180px;font-size:22px;margin-bottom: 10px;border-radius: 6px;margin-left: 26%;'>ยืนยัน</button></p>");
                 out.print("<input type='hidden' name='reportType' value='"+reportType+"'>");
                 out.print("<input type='hidden' name='id_cate' value='"+id_cate+"'>");
                 out.print("<input type='hidden' name='category' value='"+category+"'>");
                 out.print("<input type='hidden' name='id_report' value='"+id_report+"'>");
                
                 out.print("<form>");
             }else{
                 detail = request.getParameter("detail");
                 text = detail;
                 
                 category = request.getParameter("category");
                 id_cate = request.getParameter("id_cate");
                 id_report = request.getParameter("id_report"); 
                 
                 out.print("<form class='w3-container' action='updateReport'>");
                 out.print("<p><label class='w3-text-blue'><b></b></label>");
                 out.print("<input class='w3-input w3-sand' name='edited' type='text' value='"+text+"' style='height: 30px;width: 280px;font-size:22px;margin-bottom: 0px'>");
                 out.print("<p><button class='w3-btn w3-green' style='height: 45px;width: 180px;font-size:22px;margin-bottom: 10px;border-radius: 6px;margin-left: 26%;'>ยืนยัน</button></p>");
                 out.print("<input type='hidden' name='reportType' value='"+reportType+"'>");
                 out.print("<input type='hidden' name='id_cate' value='"+id_cate+"'>");
                 out.print("<input type='hidden' name='category' value='"+category+"'>");
                 out.print("<input type='hidden' name='id_report' value='"+id_report+"'>");
                 out.print("<form>");
             }
        
    %>
  
 
</div>
  <script>
    function goBack(){
       window.history.back();  
        
    }
    
  </script>
</body>
</html> 