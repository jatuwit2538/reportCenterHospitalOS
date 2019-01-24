<%-- 
    Document   : index
    Created on : Aug 24, 2017, 1:36:45 PM
    Author     : NUT
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.List"%>
<%@page import="org.w3c.dom.traversal.NodeIterator"%>
<%@page import="javax.swing.tree.DefaultMutableTreeNode"%>
<%@page import="java.io.File"%>
<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="java.util.ArrayList"%>
<%@page import="org.w3c.dom.Node, org.w3c.dom.Element, org.w3c.dom.Document, org.w3c.dom.NodeList, javax.xml.parsers.DocumentBuilder, javax.xml.parsers.DocumentBuilderFactory" %>
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
        <title>Parsing using the DOM</title>
        <style>
	html { margin:0; padding:0; font-size:62.5%; }
	body { max-width:800px; min-width:300px; margin:0 auto; padding:20px 10px; font-size:14px; font-size:1.4em; }
	h1 { font-size:1.8em; }
	.demo { overflow:auto; border:1px solid silver; min-height:100px; }
        
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

	</style>
	<link rel="stylesheet" href="dist/themes/default/style.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
        
         <div class="tab">
      <button class="tablinks" onclick="goBack();">กลับ</button>
      
    </div>   
    </head>
    <body>
       
       <%
          
         request.setCharacterEncoding("UTF-8");
            Class.forName("org.postgresql.Driver").newInstance();
               Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5433/dbHos", "postgres", "postgres"); //database connection
               Statement statement = conn.createStatement();
               Statement statement1 = conn.createStatement();
            
              
              String sqlCateCount = "select id_cate,name_cate from a_report_category order by id_cate ASC";
              ResultSet rsCateCount = statement.executeQuery(sqlCateCount);
              

         
         
         %>
       <div id="jstree"> 
           <!-- in this example the tree is populated from inline HTML -->
           <%
             try{ 
            
        out.print("<ul>"); 
         while(rsCateCount.next()){
            out.print("<li>"); 
            out.print(rsCateCount.getString(2)); 
                   out.print("<ul>");
                        String sqlDetailCount = "select id_report,name_report from a_report_detail where id_cate = '"+rsCateCount.getString(1)+"' order by id_report ASC";
                         ResultSet rsDetailCount = statement1.executeQuery(sqlDetailCount);
                              while(rsDetailCount.next()){
                             out.print("<li>");
                             out.print(rsDetailCount.getString(2));
                             out.print("</li>");//staff
                            }
                   out.print("</ul>");//staff
           out.print("</li>");//company
            }
        
        out.print("</ul>");//company
          
             }catch(Exception ex){
                ex.printStackTrace();
             } 
                    %>
               
       </div>
        

      
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
        <script> //var img = "JonSnow.jpg"; 
       
    	$(function () {
    // 6 create an instance when the DOM is ready
    $('#jstree').jstree();
    // 7 bind to events triggered on the tree
    
    $('#jstree').on("changed.jstree", function (e, data) {
            //view image by path split
           
           
           var text = (data.instance.get_node(data.selected[0]).text);
           //var atSplit = img[1].toString()+".jpg";
           //alert(data.instance.get_node(data.selected[0]).text); //alert(myVar);use java parameter in javascript
           
           var linkHref = "filterReport.jsp?text="+text;
           window.open(linkHref,'filty');
 
    });
   
  });
  
  function goBack() {
    //window.history.back();
    window.open("manageReport.html");
    }
	</script>
        
    </body>
</html>
