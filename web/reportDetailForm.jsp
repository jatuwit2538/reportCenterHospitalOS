<%-- 
    Document   : reportDetailForm
    Created on : Sep 27, 2017, 3:51:13 PM
    Author     : NUT
--%>

<%@page import="path.managePath"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.List"%>
<%@page import="org.w3c.dom.traversal.NodeIterator"%>
<%@page import="javax.swing.tree.DefaultMutableTreeNode"%>
<%@page import="java.io.File"%>
<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="java.util.ArrayList"%>
<%@page import="org.w3c.dom.Node, org.w3c.dom.Element, org.w3c.dom.Document, org.w3c.dom.NodeList, javax.xml.parsers.DocumentBuilder, javax.xml.parsers.DocumentBuilderFactory" %>
<%@page import="java.util.List"%>
<%@page import="org.w3c.dom.traversal.NodeIterator"%>
<%@page import="javax.swing.tree.DefaultMutableTreeNode"%>
<%@page import="java.io.File"%>
<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<%!
  public boolean isTextNode(Node n)
  {
    return n.getNodeName().equals("#text");
  }
%>



<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
         
        <link rel="stylesheet" href="style/w3.css">
        <link rel="stylesheet" href="style/default.css">
        <style>
            @import url(https://fonts.googleapis.com/css?family=Open+Sans);

            body { 
                font-family: 'Open Sans', sans-serif;
                color: #666;
            }

            /* STRUCTURE */

            #pagewrap {
                padding: 5px;
                width: 1300px;
                margin: 20px auto;
            }
            header {
                height: 100px;
                padding: 0 15px;
            }
            #content {
                width: 380px;
                float: left;
                padding: 5px 15px;
            }

            #middle {
                width: 520px; /* Account for margins + border values */
                float: left;
                padding: 5px 15px;
                
            }

            #sidebar {
                width: 290px;
                padding: 5px 15px;
                float: left;
            }
            footer {
                clear: both;
                padding: 0 15px;
            }

            /************************************************************************************
            MEDIA QUERIES
            *************************************************************************************/
            /* for 980px or less */
            @media screen and (max-width: 980px) {

                #pagewrap {
                    width: 94%;
                }
                #content {
                    width: 41%;
                    padding: 1% 4%;
                }
                #middle {
                    width: 41%;
                    padding: 1% 4%;
                    margin: 0px 0px 5px 5px;
                    float: right;
                }

                #sidebar {
                    clear: both;
                    padding: 1% 4%;
                    width: auto;
                    float: none;
                }

                header, footer {
                    padding: 1% 4%;
                }
            }

            /* for 700px or less */
            @media screen and (max-width: 600px) {

                #content {
                    width: auto;
                    float: none;
                }

                #middle {
                    width: auto;
                    float: none;
                    margin-left: 0px;
                }

                #sidebar {
                    width: auto;
                    float: none;
                }

            }

            /* for 480px or less */
            @media screen and (max-width: 480px) {

                header {
                    height: auto;
                }
                h1 {
                    font-size: 2em;
                }
                #sidebar {
                    display: none;
                }

            }


            #content {
                background: #f8f8f8;
            }
            #sidebar {
                background: #f0efef;
            }
             #content, #middle, #sidebar {
                margin-bottom: 5px;
            }

              #content, #middle, #sidebar, footer {
                border: solid 1px #ccc;
                font-family: TH SarabunPSK;
                font-size: 21px;
                font-weight: bold;
                
            }  
            #pagewrap{
                padding-right: 25px;   
            }
            
            input[type=text] {
    width: 80%;
    padding: 6.25px 16px;
    margin: 20px 0;
    display: inline-block;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
    font-size: 16px;
}

.tooltip {
    position: relative;
    display: inline-block;
   
}

.tooltip .tooltiptext {
    visibility: hidden;
    
    background-color: black;
    color: #fff;
    text-align: center;
    border-radius: 6px;
    padding: 5px 0;
    width: 120px;
    bottom: 100%;
    left: 50%; 
    margin-left: -60px;
    /* Position the tooltip */
    position: absolute;
    z-index: 1;
}

.tooltip:hover .tooltiptext {
    visibility: visible;
}
.warning {
color: #9F6000;
background-color: #FEEFB3;

}

body{
   background-color: #A9D0F5;
   color: black;
            }
#pagewrap{
    background: rgba(256,256,256, 0.6);
    border-radius: 6px; 
}     
        </style>
        <link rel="stylesheet" href="dist/themes/default/style.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
       
    </head>
    <body>
       <%
           
                            
  
                       
                          
            request.setCharacterEncoding("UTF-8");
           managePath path = new managePath(getServletContext().getRealPath("/")+"setting/setting.txt");
           
           //ถ้ามี parameter messasge เข้ามาให้ทำการแสดง จะเป็นการดักerror 
           if(request.getParameterMap().containsKey("messages")){
                
                 String messages = request.getParameter("messages");
                        if(messages.equals("")){
                        }else{
                         //out.print("<script>alert('"+messages+"');</script>");
                         out.print("<div class='warning'>"+messages+"</div>");
                        }     
                }
           
           //response.setCharacterEncoding("UTF-8");
           String category=request.getParameter("category");
           String name_folder="";
          
           //String cateNum=request.getParameter("pkCate");
           //int count=0;
           String pkCate="";
           
           Class.forName("org.postgresql.Driver").newInstance();
               Connection conn = DriverManager.getConnection(path.getPathDB(), path.getUserDB(), path.getPassDB()); //database connection
               Statement statement = conn.createStatement();
               Statement statement1 = conn.createStatement();
              //String sqlCompile = "select * from member";
              //ResultSet rsCompile = statement1.executeQuery(sqlCompile);
              
              String sql = "select id_report,name_report,path_report,jrxml_report,jasper_report from a_report_category inner join a_report_detail on (a_report_category.id_cate = a_report_detail.id_cate) where name_cate = '"+category+"' order by id_report ASC";
              String sqlCate = "select id_cate,name_folder from a_report_category where name_cate = '"+category+"' limit 1";
              ResultSet rs = null;
              ResultSet rsCate = null;
             
            if(session.getAttribute("userid")!=null){  
                        String userID=(String)session.getAttribute("userid");  

                        //out.print("Hello, "+userID+" Welcome to Profile");  
                         
        %>
        <div id="pagewrap">

	<header align='center' id="header" style="font-family: TH SarabunPSK;">
		<% out.print("<h2>"+category+"</h2>"); %>
	</header>
	
        
		<%
                    rsCate = statement1.executeQuery(sqlCate);
                    rs = statement.executeQuery(sql);
                      while(rsCate.next()){
                        pkCate=rsCate.getString(1);
                        name_folder=rsCate.getString(2);
                    }
                    out.print("<div class='w3-container'>");
                    out.print("<table class='w3-table-all w3-hoverable'>");
                    
                  
                    while(rs.next()){
                      out.print("<tr class='w3-hover-light-blue'>");
                          out.print("<td style='cursor: pointer;' onclick='goLink(this)'>");
                             out.print(rs.getString(2)); 
                          out.print("</td>");
                          
                          out.print("<form action='reportEditForm.jsp'>");
                           out.print("<td style='text-align: right; width: 10%;'>");
                             out.print("<input type='hidden' name='category' value='"+category+"'>");
                             out.print("<input type='hidden' name='jasper_report' value='"+rs.getString(5)+"'>");
                             out.print("<input type='hidden' name='reportType' value='detail'>");
                             out.print("<input type='hidden' name='id_cate' value='"+pkCate+"'>");
                             out.print("<input type='hidden' name='id_report' value='"+rs.getString(1)+"'>");
                             out.print("<input type='hidden' name='detail' value='"+rs.getString(2)+"'>");
                             out.print("<div class='tooltip'><button name='editorButton' type='submit' class='button button2' style='background-color:transparent; border-color:transparent; padding: 0 ; margin-left: 1px; margin-bottom: 2px; cursor: pointer;' src=''><img src='images/edit.png' id='img' height='40' width='40'></button><span class='tooltiptext'>แก้ไข</span></div>");
                          out.print("</td>");
                          out.print("</form>");
                          
                          out.print("<form action='deleteDetail'>");
                           out.print("<td style='text-align: right; width: 10%;'>");
                             out.print("<input type='hidden' name='category' value='"+category+"'>");
                             out.print("<input type='hidden' name='pkCate' value='"+pkCate+"'>");
                             out.print("<input type='hidden' name='id_report' value='"+rs.getString(1)+"'>");
                             out.print("<div class='tooltip'><button name='deleterButton' type='submit' class='button button2' style='background-color:transparent; border-color:transparent; padding: 0 ; margin-left: 1px; margin-bottom: 2px; cursor: pointer;' src=''><img src='images/remove.png' id='img' height='40' width='40'></button><span class='tooltiptext'>ลบ</span></div>");
                          out.print("</td>");
                          out.print("</form>");
                          
                      out.print("</tr>");
                    //count = count+1;
                    }
                    out.print("</table>");
                    out.print("</div>");
                 out.print("<form action='insertDetail'>");
                 out.print("<input type='text' placeholder='เพิ่มรายงาน...' id='inputForm' name='nameDetail' style='width: 72%;height: 35px;;font-size: 22px;font-family: TH SarabunPSK;margin-left:25px;'>");
                 out.print("<input type='hidden' name='category' value='"+category+"'>");
                 out.print("<input type='hidden' name='pkCate' value='"+pkCate+"'>");
                 //out.print("<input type='hidden' name='pkDetail' value='"+(count+1)+"'>");
                 
                 out.print("<input type='submit' class='addButton' style='width:20%;height: 35px;padding: 0 ; margin-left: 1px;font-size: 22px; margin-bottom: 4px;' value='เพิ่ม'>");
                 out.print("</form>");
                  }  
                        else{ 
                           
                           out.print("<h3>ต้องทำการเข้าสู่ระบบก่อนเข้าใช้งาน</h3>");
                           out.print("<script>window.open('blankPage.jsp','left')</script>");
                           out.print("<script>window.open('blankPage.jsp','top')</script>");
                           out.print("<script>window.open('blankPage.jsp','right')</script>"); 
                           } 
                %>
	</div>
        
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
         <script>
$(document).ready(function() { 
    
  $(document).delegate("tr","click",function(e){
  $("tr").css('background-color', 'white');
  $("tr:nth-child(even)").css('background-color', '#f2f2f2');
  $(this).css('background-color', '#74B3DF');
});
});
 function goLink(element) {
    //window.history.back();
    var cate = '<%=category%>';
    var folder = '<%=name_folder%>';
    
    var y = element.innerHTML;
     //alert(y);
    //var x = document.getElementsByTagName("td")[0].innerText;
    //alert(x);
    var linkHref = "reportPathForm.jsp?detail="+y+"&category="+cate+"&name_folder="+folder;
    //alert(linkHref);
     window.open(linkHref,'right');
    }
  
    

  function goBack() {
    //window.history.back();
    window.open("manageReport.html");
    }
    
    function goLogin() {
    //window.history.back();
   
    var linkHref = "blankPage.jsp";
    //alert(linkHref);
     window.open(linkHref,'left');
    }
	</script>
    </body>
</html>
