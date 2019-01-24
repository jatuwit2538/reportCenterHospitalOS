<%-- 
    Document   : index
    Created on : Sep 1, 2017, 9:28:24 AM
    Author     : NUT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="style/default.css">
        <link rel="stylesheet" href="style/w3.css">
        <title>Login</title>
        
       
    </head>
    <style>

/* Change styles for span and cancel button on extra small screens */
@media screen and (max-width: 300px) {
    span.psw {
       display: block;
       float: none;
    }
    .cancelbtn {
       width: 100%;
    }
}


body{
    
    background-color: #e6ffff;
}
input[type=text], input[type=password] {
    width: 100%;
    padding: 6px 10px;
    margin: 4px 0;
    display: inline-block;
    border: 1px solid #ccc;
    box-sizing: border-box;
}



.imgcontainer {
    text-align: center;
    
    
}

img.avatar {
    width:90%;
    height: 180px;
    border-radius: 8px;
    margin: 0px 6px;
}



span.psw {
    float: right;
    padding-top: 16px;
}


.warning {
color: #9F6000;
background-color: #FEEFB3;

}

.container {
    
    padding: 8px;
    margin: 4px 0;
    font-weight: bold;
    font-family: TH SarabunPSK;
    font-size: 25px;
    display: table;
    
    float:left;
    width:20%;
    min-width:400px;
    margin-top:58px;
    margin-left:calc(50% - 200px);
    margin-left:-webkit-calc(50% - 200px);
    margin-left:-moz-calc(50% - 200px);
    background: rgba(256,256,256, 0.6);
    border-radius: 6px; 
  }
#fieldData{
   display: table-cell;
   text-align: center;
   vertical-align: middle;
    height: 500px;
}

body{
    background-color: #A9D0F5;
}

</style>
<link rel="shortcut icon" href="images/Logo.png">
    <body>
        
        
      
        <%  
                       request.setCharacterEncoding("UTF-8");  
                       String textUser = "";
                        if(session.getAttribute("userid")!=null){  
                        String userID=(String)session.getAttribute("userid");  
                        String nameUser=(String)session.getAttribute("username");
                        //out.print("Hello, "+userID+" Welcome to Profile");  
                           if(nameUser.equals("null")){
                              textUser = "กำลังเข้าใช้งานโดยไอดี : "+userID;
                           }else{
                              textUser = "กำลังเข้าใช้งานโดยชื่อผู้ใช้ : "+nameUser;
                           }
                           
                            
                        
                         
                        
                
                           out.print("<div class='tab'>");
                           out.print("<form>");
                           out.print("<button type='submit' class='tablinks' name='backButton' style='float: left; font-size: 20px;font-family: TH SarabunPSK;font-weight: bold;' onclick='backtomenu()'>");
                           out.print("<img src='images/Logo Open.jpg' id='img' height='48' width='159'>");
                           out.print("</button>");
                           out.print("</form>");
                           out.print("<form action='authenLogout'>");
                           out.print("<button type='submit' class='tablinks' name='backButton'><img src='images/logout.png' id='img' height='48' width='48' style='margin-right: 10px; '></button>");
                           out.print("</form>");
                           
                           out.print("<form>");
                           out.print("<button style='font-size: 16px;font-size: 20px;font-family: TH SarabunPSK;font-weight: bold;margin-top: 10px;'>"+textUser+"</button>");
                           out.print("</form>");
                           out.print("</div>");
                        }
        %>
       
       <div class="container" id="container">   
          <form id="fieldData" action="authenLogin" method="post" align="center" >
              <img src='images/Hospital-OS-LOGO1.png' id='img' width="300" height="140" ><br><br>
            <input type="text" id="textLogin" placeholder="ผู้ใช้" name="uname" required><br>
            <input type="password" id="textLogin" placeholder="รหัสผ่าน" name="psw"><br>   
            <button id="loginButton" type="submit" >เข้าสู่ระบบ</button>
          </form>

    </body>
</html>
