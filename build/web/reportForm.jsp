 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
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
                            RequestDispatcher rq = request.getRequestDispatcher("blankPage.jsp");
                            rq.forward(request, response);
                            
                            
                        }  

    %>
 

    
        <frameset cols="33%,33%,33%" border="1" BORDERCOLOR="#ffffff">
                     <frame name="left" src="reportCateForm.jsp" >
                     <frame name="mid" src="blankPage.jsp" >
                     <frame name="right" src="blankPage.jsp" >
        </frameset>


</html>
