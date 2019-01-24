<%-- 
    Document   : reportUploadReportFile
    Created on : Oct 5, 2017, 2:36:54 PM
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
                
            }  
            
            

input[type=submit]{
                    width: 60%;
                    background-color: #088A08;
                    color: white;
                    margin: 8px 0;
                    border: none;
                    border-radius: 6px;
                    cursor: pointer;
                    align-content: center;
                    font-size: 24px;
}

            input[type=text]{
                    width: 100%;
                    padding: 12px 20px;
                    margin: 8px 0;
                    display: inline-block;
                    border: 1px solid #ccc;
                    border-radius: 4px;
                    box-sizing: border-box;
                    font-size: 16px;
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
            managePath pathDB = new managePath(getServletContext().getRealPath("/")+"setting/setting.txt");
            request.setCharacterEncoding("UTF-8");
            
            String path,jrxml,jasper,detail,category,name_folder;
            
            path = request.getParameter("path");
            jrxml = request.getParameter("jrxml");
            jasper = request.getParameter("jasper");
            name_folder = request.getParameter("name_folder");
            detail = request.getParameter("detail");
            category = request.getParameter("category");
            
            Class.forName("org.postgresql.Driver").newInstance();
               Connection conn = DriverManager.getConnection(pathDB.getPathDB(), pathDB.getUserDB(), pathDB.getPassDB()); //database connection
               Statement statement = conn.createStatement();
              //String sqlCompile = "select * from member";
              //ResultSet rsCompile = statement1.executeQuery(sqlCompile);
              
              String sql = "select id_report,name_report,path_report,jrxml_report,jasper_report from a_report_category inner join a_report_detail on (a_report_category.id_cate = a_report_detail.id_cate) where name_cate = '"+category+"' and name_report = '"+detail+"' ";
              
              ResultSet rs = null;
           //out.println(category);
           //out.println(detail);
        %>
       

        <div id="pagewrap">

        
		<%
                    rs = statement.executeQuery(sql);
                    while(rs.next()){
                    out.print("<div class='w3-container'>");
                    out.print("<form action='reportUploadAccept.jsp' method='post' enctype='multipart/form-data' name='form1' id='form1' accept-charset='UTF-8'>");
                    out.print("<div class='custom-file-upload'>");
                    out.print("jrxml file: <input name='file' type='file' id='file' accept='.jrxml' style='font-size: 20px;margin-bottom: 20px;margin-left: 6px;'><br>");
                    out.print("jasper file: <input name='file' type='file' id='file' accept='.jasper' style='font-size: 20px;'><br>");
                    out.print("</div>");
                    out.print("<input type='hidden' name='category' value='"+category+"'>");
                    out.print("<input type='hidden' name='detail' value='"+detail+"'>");
                    out.print("<input type='hidden' name='name_folder' value='"+name_folder+"'>");
                    out.print("<input type='submit' value='อัพโหลดไฟล์รายงาน' style='margin-left: 75px;'>");
                    out.print("</form>");
                    
                    out.print("<form action='reportPathForm.jsp'>");
                    out.print("<input type='hidden' name='category' value='"+category+"'>");
                    out.print("<input type='hidden' name='detail' value='"+detail+"'>");
                    out.print("<input type='hidden' name='name_folder' value='"+name_folder+"'>");
                    out.print("<input type='submit' style='background-color: #2A69E5;margin-left: 75px;' value='กลับ'>");
                    out.print("</form>");
                    out.print("</div>");
                    
                    // String category=request.getParameter("category");
           //String name_folder=request.getParameter("name_folder");
           //String detail=request.getParameter("detail");
                    }
                %>
	</div>
        
        
         <script>

 function goLink(element) {
    //window.history.back();
    var y = element.innerHTML;
     //alert(y);
    //var x = document.getElementsByTagName("td")[0].innerText;
    //alert(x);
    //var linkHref = "reportPathForm.jsp?category="+y;
     //window.open(linkHref);
    }
  
    

  function goBack() {
    //window.history.back();
    window.open("manageReport.html");
    }
	</script>
    </body>
</html>
