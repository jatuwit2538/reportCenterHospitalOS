<%-- 
    Document   : manageForm
    Created on : Nov 17, 2017, 4:25:48 PM
    Author     : NUT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-="content-type" content="text/html; charset=utf-8">


<link rel="shortcut icon" href="images/Logo.png">
<title>Report Management</title>
</head>
<% 
                        request.setCharacterEncoding("UTF-8");
  
                        if(session.getAttribute("userid")!=null){  
                        String userID=(String)session.getAttribute("userid");  

                        //out.print("Hello, "+userID+" Welcome to Profile");  
                        }  
                        else{  
                            RequestDispatcher rq = request.getRequestDispatcher("index.jsp");
                            rq.forward(request, response);
                            
                        }  

    %>
 
<frameset name="allSet" rows="8.7%,91.3%" border="1" BORDERCOLOR="#5858FA">  
    <frame name="topper" src="tabContent.jsp" noresize="noresize" scrolling="no">
        <frameset cols="8%,92%" border="1" BORDERCOLOR="#5858FA">
                     <frame name="lefter" src="menuAdmin.jsp">
                     <frame name="righter" src="reportForm.jsp">
        </frameset>
</frameset>

</html>
