 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-="content-type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="style/default.css">
<link rel="stylesheet" href="style/w3.css">
      
<style>
    frame[name=lefty]{
        background-color: #EFFBFB;
    }
    frame[name=filty]{
        background-color: #EFFBFB;
    }
   
</style>
<link rel="shortcut icon" href="images/Logo.png">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<title>Preview Report</title>



</head>


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
  
<frameset name="allSet" rows="8.7%,91.3%" border="1" BORDERCOLOR="#5858FA" >   
    <frame name="top" src="tabContent.jsp" noresize="noresize" scrolling="no">
        
        
    
    <frameset cols="25%,75%" border="1" BORDERCOLOR="#5858FA">

            <frame name="lefty" src="readXML.jsp">


            <frameset rows="38%,62%" >

                   <frame id="filty" name="filty" src="filterReport.jsp" style="height: auto;">
                   <frame name="righty" src="blankPage.jsp">

            </frameset>
    </frameset>
</frameset>        
       
    
</html>
 
<script>
   
       
    function resize( frame ) {
  var b = frame.contentWindow.document.body || frame.contentDocument.body,
      cHeight = $(b).height();

  if( frame.oHeight !== cHeight ) {
    $(frame).height( 0 );
    frame.style.height = 0;

    $(frame).height( cHeight );
    frame.style.height = cHeight + "px";

    frame.oHeight = cHeight;
  }

  // Call again to check whether the content height has changed.
  setTimeout( function() { resize( frame ); }, 250 );
}

/**
 * Resizes all the iframe objects on the current page. This is called when
 * the page is loaded. For some reason using jQuery to trigger on loading
 * the iframe does not work in Firefox 26.
 */
window.onload = function() {
  var frame,
      frames = document.getElementsByID( 'filty' ),
      i = frames.length - 1;

  while( i >= 0 ) {
    frame = frames[i];
    frame.onload = resize( frame );

    i -= 1;
  }
};

    
</script>