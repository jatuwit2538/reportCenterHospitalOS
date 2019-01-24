<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        
        <link rel="stylesheet" href="style/default.css">
        <link rel="stylesheet" href="style/w3.css">
        
        <title>Report Center</title>
        
    
        <link rel="shortcut icon" href="images/Logo.png">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
h2{
    font-family: TH SarabunPSK;
    font-weight: bold;
    
    
      }
body {
    font-family: TH SarabunPSK;
    margin: 0;
    padding: 0;
    background-color: #A9D0F5;
}
.banner {
    width: 35%;
    height: 150px;
}


#mainmenu1{
    border-radius: 6px;
    margin: 3% 4%;
   margin-top: 5%;
   margin-left: 35%;
   float: left;
   align-items: center;
   height: 150px;
    width: 150px;
}
#mainmenu2{
    border-radius: 6px;
    margin: 3% 4%;
   margin-top: 5%;
   float: left;
   align-items: center;
   height: 150px;
    width: 150px;
}

.container{
    margin-left: 38%;
    margin-top: 11%;
    background: rgba(256,256,256, 0.6);
    
}
#img1{
    background-image: url('images/setting3.1.png');
    height: 150px;
    width: 150px; 
    padding: 0; 
    margin-left: 1px; 
    margin-bottom: -11px;
    border-radius: 6px;
}
#img1:hover {
    background-image: url('images/setting3.2.png');
    
}
#img2{
    background-image: url('images/Report1.1.png');
    height: 150px;
    width: 150px; 
    padding: 0; 
    margin-left: 1px; 
    margin-bottom: -11px;
    border-radius: 6px;
}
#img2:hover {
    background-image: url('images/Report1.2.png');
    
}

</style>
<%
                       request.setCharacterEncoding("UTF-8");  
                       String textUser = null;
                        if(session.getAttribute("userid")!=null){  
                        String userID=(String)session.getAttribute("userid");  
                        String nameUser=(String)session.getAttribute("username");
                        //out.print("Hello, "+userID+" Welcome to Profile");  
                           if(nameUser.equals("null")){
                              textUser = "กำลังเข้าใช้งานโดยไอดี : "+userID;
                           }else{
                              textUser = "กำลังเข้าใช้งานโดยชื่อผู้ใช้ : "+nameUser;
                           }
                        }  
                        else{  
                            RequestDispatcher rq = request.getRequestDispatcher("index.jsp");
                            rq.forward(request, response);
                            
                        }  
%>

        <div class="tab">
            
             <form>
                <button type="submit" class="tablinks" name="backButton" style="float: left; font-size: 20px;font-family: TH SarabunPSK;font-weight: bold;" onclick="backtomenu()">
                    <img src='images/Logo Open.jpg' id='img' height='48' width='159'>
                    
                </button>
             </form>
            
            <form action="authenLogout"> 
            <button type="submit" class="tablinks" name="lockoutButton"><img src='images/logout.png' id='img' height='48' width='48' style='margin-right: 10px; '></button>
            </form>
            
            <form> 
            <button style="font-size: 16px;font-size: 20px;font-family: TH SarabunPSK;font-weight: bold;margin-top: 10px;"><%=textUser%></button>
            </form>
        </div>


<div class="container">
      
    </head>
    <body align='center'>
        <form action = "manageForm.jsp" id="manageForm1">
            <button id="mainmenu1" type='submit' style='background-color:transparent; border-color:transparent; padding: 0 ; margin-left: 1px; margin-bottom: 2px; cursor: pointer;' ><img id="img1"><br><h2>การจัดการระบบ</h2></button>
        </form>
        
        <form action = "showPage.jsp" id="manageForm2">
            <button id="mainmenu2" type='submit' style='background-color:transparent; border-color:transparent; padding: 0 ; margin-left: 1px; margin-bottom: 2px; cursor: pointer;' ><img id="img2"><br><h2>ดูรายงาน</h2></button>
        </form>
        
    </body>
</div>    
</html>
