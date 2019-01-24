<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <link rel="stylesheet" href="style/default.css">
        <link rel="stylesheet" href="style/w3.css">
        
        <%@page contentType="text/html" pageEncoding="UTF-8"%>
        <link rel="shortcut icon" href="images/Logo.png">
        <title>Report Center</title>
        
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>

#mainmenu{
    width: 49%;
    background-color: #0040FF;
    color: white;
    padding: 14px 20px;
    margin: 8px 0;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}


#mainmenu:hover {
    background-color: #45a049;
}





body {
    margin: 0;
    padding: 0;
}
.banner {
    width: 35%;
    height: 150px;
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
                        }else{  
                            RequestDispatcher rq = request.getRequestDispatcher("index.jsp");
                            rq.forward(request, response);
                            
                        }  

    %>
    </head>
   
     <div class="tab">
            <form>
                <button type="submit" class="tablinks" name="backButton" style="float: left; font-size: 20px;font-family: TH SarabunPSK;font-weight: bold;" onclick="backtomenu()">
                    <img src='images/Logo Open.jpg' id='img' height='48' width='159'>
                </button>
             </form>
           
            
            <form action="authenLogout"> 
            <button type="submit" class="tablinks" name="backButton"><img src='images/logout.png' id='img' height='32' width='32'> Logout</button>
            </form>
            
            <form> 
            <button style="font-size: 16px;font-size: 20px;font-family: TH SarabunPSK;font-weight: bold;"><%=textUser%></button>
            </form>
        </div>
    
    
    
    <body align='center'>
        
        <form action = "reportForm.jsp">
            <button id="mainmenu" type='submit'  action="" ><img src="images/manageReport.png" style=" padding: 0 ; margin-left: 1px; margin-bottom: -11px;" id="img" height='32' width='32'>Manage Report Form</button><br><br>
        </form>
        
        <form action = "manageParams.jsp">
            <button id="mainmenu" type='submit'  action="" ><img src="images/manageParam.png" style=" padding: 0 ; margin-left: 1px; margin-bottom: -11px;" id="img" height='32' width='32'>Manage Parameters</button><br><br>
        </form>
        
        <script>
     function goBack() {
    //window.history.back();
    window.history.back();
    }
    </script>
    </div>
    </body>
</html>
