 <%-- 
    Document   : reportForm
    Created on : Sep 25, 2017, 1:34:49 PM
    Author     : NUT
--%>

<%@page import="path.managePath"%>
<%@page import="java.awt.Desktop"%>
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
        <link rel="stylesheet" href="style/default.css"> 
        <link rel="stylesheet" href="style/w3.css">
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
            header, #content, #middle, #sidebar {
                margin-bottom: 5px;
            }

            #pagewrap,  #content, #middle, #sidebar, footer {
                border: solid 1px #ccc;
                font-family: TH SarabunPSK;
                font-size: 23px;
                font-weight: bold;
                
            }  
            #pagewrap{
                padding-right: 25px;   
            }
            
           
             div.tab {
    overflow: hidden;
    border: 1px solid #ccc;
    background-color: #f1f1f1;
}

/* Style the buttons inside the tab */
div.tab button {
    background-color: inherit;
    float: left;
    border: none;
    outline: none;
    cursor: pointer;
    padding: 12px 20px;
    transition: 0.6s;
    font-size: 22px;
}

/* Change background color of buttons on hover */
div.tab button:hover {
    background-color: #cceeff;
}

/* Create an active/current tablink class */
div.tab button.active {
    background-color: #ccc;
}

/* Style the tab content */
.tabcontent {
    display: none;
    padding: 6px 10px;
    border: 1px solid #ccc;
    border-top: none;
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
            if(request.getParameterMap().containsKey("messages")){
                
                 String messages = request.getParameter("messages");
                        if(messages.equals("")){
                        }else{
                         //out.print("<script>alert('"+messages+"');</script>");
                         out.print("<div class='warning'>"+messages+"</div>");
                        }     
                }
             if(session.getAttribute("userid")!=null){  
                        String userID=(String)session.getAttribute("userid");  
                        String nameUser=(String)session.getAttribute("username");
                        //out.print("Hello, "+userID+" Welcome to Profile");  
                          
             }else{
                        out.print(" "); 
             }             
                           
           
           
            managePath path = new managePath(getServletContext().getRealPath("/")+"setting/setting.txt");
            request.setCharacterEncoding("UTF-8");
            Class.forName("org.postgresql.Driver").newInstance();
               Connection conn = DriverManager.getConnection(path.getPathDB(), path.getUserDB(), path.getPassDB()); //database connection
               Statement statement = conn.createStatement();
               Statement stmt = conn.createStatement();
              //String sqlCompile = "select * from member";
              //ResultSet rsCompile = statement1.executeQuery(sqlCompile);
              
              String sql = "select id_cate,name_cate,name_folder,b_service_point_id from a_report_category order by id_cate DESC";
              String sqlServicePoint = "select b_service_point.b_service_point_id,b_service_point.service_point_description from b_service_point where service_point_active = '1' order by b_service_point.service_point_description ASC";
              
              ResultSet rs = null;
              ResultSet rsServicePoint = null;
              
              if(session.getAttribute("userid")!=null){  
                        String userID=(String)session.getAttribute("userid");  

                        //out.print("Hello, "+userID+" Welcome to Profile");  
                         
             
        %>    
       

        <div id="pagewrap">

	<header id="header" align='center' style="font-family: TH SarabunPSK;">
		<% out.print("<h2>ประเภทรายงาน</h2>"); %>
	</header>
	
        
		<%
                    rs = statement.executeQuery(sql);
                    rsServicePoint = stmt.executeQuery(sqlServicePoint);
                            
                    out.print("<div class='w3-container'>");
                    out.print("<table class='w3-table-all w3-hoverable'>");
                    
                    while(rs.next()){
                      out.print("<tr class='w3-hover-light-blue'>");
                          out.print("<td style='cursor: pointer;' onclick='goLink(this)'>");
                             out.print(rs.getString(2)); 
                          out.print("</td>");
                          
                          out.print("<form action='reportEditForm.jsp'>");
                           out.print("<td style='text-align: right; width: 8%;'>");
                             out.print("<input type='hidden' name='id_cate' value='"+rs.getString(1)+"'>");
                             out.print("<input type='hidden' name='category' value='"+rs.getString(2)+"'>");
                             out.print("<input type='hidden' name='name_folder' value='"+rs.getString(3)+"'>");
                             out.print("<input type='hidden' name='service_point' value='"+rs.getString(4)+"'>");
                             out.print("<input type='hidden' name='reportType' value='category'>");
                             out.print("<div class='tooltip'><button name='editButton' type='submit' class='button button2' style='background-color:transparent; border-color:transparent; padding: 0 ; margin-left: 1px; margin-bottom: 2px; cursor: pointer; src=''><img src='images/edit.png' id='img' height='40' width='40'></button><span class='tooltiptext'>แก้ไข</span></div>");
                          out.print("</td>");
                          out.print("</form>");
                          
                          out.print("<form>");
                           out.print("<td style='text-align: right; width: 6%;'>");
                             //out.print("<input type='hidden' name='id_cate' value='"+rs.getString(1)+"'>");
                             out.print("<div class='tooltip'><button name='deleteButton'type='submit'  class='button button2' style='background-color:transparent; border-color:transparent; padding: 0 ; margin-left: 1px; margin-bottom: 2px; cursor: pointer;  src=''  onClick='onDelete("+rs.getString(1)+")'><img src='images/remove.png' id='img' height='40' width='40'></button><span class='tooltiptext'>ลบ</span></div>"); 
                          out.print("</td>");
                          out.print("</form>");
                          
                          String isFolder = getServletContext().getRealPath("\\")+path.getPathReport()+"\\"+rs.getString(3);
                          //out.print(getServletContext().getRealPath("/")+path.getPathReport()+"/"+rs.getString(3));
                          File fileList = new File(isFolder);
                          if(fileList.isDirectory()){
                              out.print("<form action='openFolder'>");
                           out.print("<td style='text-align: right; width: 6%;'>");
                             out.print("<input type='hidden' name='name_folder' value='"+rs.getString(3)+"'>");
                             out.print("<div class='tooltip'><button name='folderButton' type='submit' class='button button2' style='background-color:transparent; border-color:transparent; padding: 0 ; margin-left: 1px; margin-bottom: 2px; cursor: pointer; src=''><img src='images/openfolder.png' id='img' height='40' width='40'></button><span class='tooltiptext'>เปิดโฟลเดอร์: "+rs.getString(3)+"</span></div>");  
                          out.print("</td>");
                          out.print("</form>");
                          }else{
                          out.print("<form action='openFolder'>");
                           out.print("<td style='text-align: right; width: 6%;'>");
                             out.print("<input type='hidden' name='name_folder' value='"+rs.getString(3)+"'>");
                             out.print("<button type='submit' name='folderButton' class='button button2' style='background-color:transparent; border-color:transparent; padding: 0 ; margin-left: 1px; margin-bottom: 2px; cursor: pointer;' disabled><img src='images/openfolder.png' id='img' height='40' width='40'></button>"); 
                             
                          out.print("</td>");
                          out.print("</form>");
                          }
                          
                          
                          
                      out.print("</tr>");
                       
                    }
                    out.print("</table>");
                    out.print("</div>");
                
                 out.print("<form action='insertCate'>");
                 out.print("<input type='text' placeholder='เพิ่มประเภทรายงาน...' id='inputForm' name='nameCate' style='width: 72%;height: 35px;font-size: 22px;font-family: TH SarabunPSK;margin-left:25px;'>");
                   out.print("<input type='submit' class='addButton'  style='width:20%;height: 35px; margin-left: 1px;padding: 0px 0px;margin-top: 10px;font-size: 22px;margin-bottom: 0px;' value='เพิ่ม'><br>");
                  
                             out.println("<select name='service_point' style='width: 72%;padding: 0px 0px;margin-left:25px;margin-top: 0px;margin-bottom: 8px;'>");
                             while(rsServicePoint.next()) {
                                 out.print("<option value=" + rsServicePoint.getString(1) + ">");
                                 out.print(rsServicePoint.getString(2));
                                 out.print("</option>");
                             }
                             out.println("</select> ");
                
                 out.print("</form>");
                 
                  }  
                        else{ 
                           
                           out.print("<h3>ต้องทำการเข้าสู่ระบบก่อนเข้าใช้งาน</h3>");
                           out.print("<script>window.open('blankPage.jsp','mid')</script>");
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

    var cate = element.innerHTML;
     //alert(y);
    //var x = document.getElementsByTagName("td")[0].innerText;
    //alert(x);
    var linkHref = "reportDetailForm.jsp?category="+cate;
    //alert(linkHref);
     window.open(linkHref,'mid');
    }

 function onDelete(id_cate) {
    //window.history.back();
    //var y = element.innerHTML;
    var confirmDel = confirm('รายงานในหมวดหมู่นี้จะถูกลบทั้งหมด!!!');
    
   
    if(confirmDel){
    var linkHref = "deleteCate?id_cate="+id_cate;  
    window.open(linkHref,'mid');

    }else{
   
    }
     //alert(pkCate);
    //var x = document.getElementsByTagName("td")[0].innerText;
    //alert(x);
    //var linkHref = "deleteCate?id_cate="+id_cate;
    //window.open(linkHref);
   
    }
   function errorShow(mes) {
    //window.history.back();
    alert(mes);
    } 
  
  function goBack() {
    //window.history.back();
    window.open("manageReport.html");
    }
	</script>
    </body>
</html>
