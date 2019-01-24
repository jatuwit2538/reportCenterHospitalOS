<%-- 
    Document   : menuAdmin
    Created on : Nov 17, 2017, 4:37:27 PM
    Author     : NUT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="style/default.css">
  <link rel="stylesheet" href="style/w3.css">
  <style>
      
  </style>  
</head>
<body>


  <div class="btn-group-vertical" style="width: 100%;">
    <button type="button" id="menuButton"  class="btn btn-primary" onclick="manageReport();">จัดการรายงาน</button>
    <button type="button" id="menuButton" class="btn btn-primary" onclick="manageParams();">จัดการตัวแปร</button>
    <button type="button" id="menuButton" class="btn btn-primary" onclick="manageSetting();">ตั้งค่าระบบ</button>
  </div>


</body>
</html>
<script>
       function manageReport(){
           window.open('reportForm.jsp','righter');
       }
       function manageParams(){
           window.open('manageParams.jsp','righter');
       }
       function manageSetting(){
           window.open('manageSetting.jsp','righter');
       }
       
       $(document).ready(function() { 
    
  $(document).delegate("button","click",function(e){
  $("button").css('background-color', '#3385ff');
  $(this).css('background-color', 'blue');
});
});
    
</script>
