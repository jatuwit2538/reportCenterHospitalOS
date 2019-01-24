<%-- 
    Document   : manageParams
    Created on : Sep 18, 2017, 10:23:49 AM
    Author     : NUT
--%>

<%@page import="path.managePath"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="style/default.css">
        <link rel="stylesheet" href="style/w3.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
       
        <style>

#pagewrap{
    background: rgba(256,256,256, 0.5);
    border-radius: 6px; 
}            
#header{
    border: 1px solid #ccc;
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

#pageForm{
                border: solid 1px #ccc;
                font-family: TH SarabunPSK;
                font-size: 23px;
                font-weight: bold;
    
}
body{
    background-color: #A9D0F5;        
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
                            RequestDispatcher rq = request.getRequestDispatcher("blankPage.jsp");
                            rq.forward(request, response);
                            
                        }  
                           
    %>

<link rel="shortcut icon" href="images/Logo.png">
  <title>การจัดการตัวแปร</title>
  
    
    
            
   
    <body>
       
        
        <%
              
              out.print("<div id='pagewrap'>");
           try{
               String sql = null;
               managePath path = new managePath(getServletContext().getRealPath("/")+"setting/setting.txt");
               int i = 1;
               if(request.getParameterMap().containsKey("query")){ //ถ้ามีตัวแปร query ส่งมาจะทำการquery
                 
                 String query = request.getParameter("query");
                        if(query.equals("")){
                            sql = "select a_add_param.id,a_add_param.name,a_add_param.description,a_add_param.query,a_filter_type.namefil from a_add_param,a_filter_type where (a_add_param.idfil = a_filter_type.idfil) order by a_add_param.id DESC";
                        }else{
                             sql = "select a_add_param.id,a_add_param.name,a_add_param.description,a_add_param.query,a_filter_type.namefil from a_add_param,a_filter_type where (a_add_param.idfil = a_filter_type.idfil) "
                       + "and ((a_add_param.name LIKE '%"+query+"%') "
                       //+ "or (a_add_param.id = '"+query+"') "
                       + "or (a_add_param.description LIKE '%"+query+"%') "
                       + "or (a_add_param.query LIKE '%"+query+"%') "
                       + "or (a_filter_type.nameFil LIKE '%"+query+"%'))order by a_add_param.id DESC";
                        }     
                }else{
                    sql = "select a_add_param.id,a_add_param.name,a_add_param.description,a_add_param.query,a_filter_type.namefil from a_add_param inner join a_filter_type on a_add_param.idfil = a_filter_type.idfil order by a_add_param.id DESC";
               }
               
               
               //String sqlFilter = "select filtertype.nameFil from addparam ";
               Connection con =null; 
               
               Class.forName("org.postgresql.Driver").newInstance();
               con = DriverManager.getConnection(path.getPathDB(), path.getUserDB(), path.getPassDB());
               
               Statement statement = con.createStatement();
               
               ResultSet rs = statement.executeQuery(sql);
               
                  //out.println("<h1 align='center' style='font-family: TH SarabunPSK;font-weight: bold;font-size:56px;'>การจัดการตัวแปร</h1>");
               //ResultSet rsFilter = statement.executeQuery(sqlFilter);
 
                      
               out.print("<form action='addParams.jsp' align='left'>"); //add parameter
                   out.print("<input type='submit' class='addButton'  name=''  value='เพิ่มตัวแปร' style='margin-left:25px;margin-top:25px;'>");
               out.print("</form>");
                   
                     
                    
               out.print("<form action='manageParams.jsp' align='right' style='top: 150px;'>"); //filter parameter
                   out.print("<input type='text' id='search' name='query' value=''>");
                   out.print("<div class='tooltip'><button type='submit' style='background-color:transparent; border-color:transparent; padding: 0 ; margin-left: 1px; margin-bottom: 2px; cursor: pointer;'><img src='images/search.png' style=' padding: 0 ; margin-left: 1px; margin-bottom: -11px;'id='img' height='32' width='32'></button><span class='tooltiptext'>ค้นหา</span></div>");
               out.print("</form>");
                     
                   out.print("<div class='w3-container'>");
                   out.println("<table class='w3-table-all w3-hoverable'>");
                        out.print("<thead>");
                         out.println("<tr class='w3-hover-light-blue'>");
                          out.print("<th style='text-align: center; width: 3%;'>ลำดับ</th>");
                          out.print("<th style='text-align: center; width: 7%;'>รายละเอียด</th>");
                          out.print("<th style='text-align: center; width: 7%;'>ตัวแปร</th>");
                          out.print("<th style='text-align: center; width: 20%;'>คำสั่งSQL</th>");
                          out.print("<th style='text-align: center; width: 5%;'>การรับข้อมูล</th>");
                          out.print("<th style='text-align: center; width: 2%;'></th>");
                          out.print("<th style='text-align: center; width: 2%;'></th>");
                         out.println("</tr>");
                        out.print("</thead>"); 
                         
                     while(rs.next()){
                         out.println("<tr>");
                         out.println("<form action='editParams.jsp'>");
                         
                         out.print("<td style='text-align: center; width: 3%;'>"+(i++)+"</td>");
                          out.print("<td style='text-align: center; width: 7%;'>"+rs.getString(2)+"</td>");
                          out.print("<td style='text-align: center; width: 7%;'>"+rs.getString(3)+"</td>");
                          out.print("<td style='text-align: center; width: 20%;'>"+rs.getString(4)+"</td>");
                          out.print("<td style='text-align: center; width: 5%;'>"+rs.getString(5)+"</td>");
                          
                          
                          out.print("<input type='hidden' name='id' value="+rs.getString(1)+">");
                          out.print("<input type='hidden' name='name' value="+rs.getString(2)+">");
                          out.print("<input type='hidden' name='description' value="+rs.getString(3)+">");
                          out.print("<input type='hidden' name='query' value='"+rs.getString(4)+"'>");
                          out.print("<input type='hidden' name='filtertype' value="+rs.getString(5)+">");
                          out.print("<td style='text-align: center; width: 2%;'><div class='tooltip'><button type='submit'  style='background-color:transparent; border-color:transparent; padding: 0 ; margin-left: 1px; margin-bottom: 2px; cursor: pointer; src=''><img src='images/edit.png' id='img' height='40' width='40'></button><span class='tooltiptext'>แก้ไข</span></div></td>");
                         out.println("</form>"); 
                         
                         out.println("<form>");
                         out.print("<td style='text-align: center; width: 2%;'><div class='tooltip'><button type='submit' style='background-color:transparent; border-color:transparent; padding: 0 ; margin-left: 1px; margin-bottom: 2px; cursor: pointer;  src='' onClick='onDelete("+rs.getString(1)+")'><img src='images/remove.png' id='img' height='40' width=''></button><span class='tooltiptext'>ลบ</span></div></td>");
                         out.println("</form>"); 
                         out.println("</tr>");
                     }
                    
                     out.println("</table>");
           out.print("</div>");
           out.print("</div>");
              rs.close();
               //out.println("test");
                
               
               //to top
               //out.print("<button onclick='topFunction()' id='myBtn' title='Go to top'>ขึ้นบน</button>");
               
               
               //out.println(statement.executeQuery(sql));
           }catch(Exception ex){
               ex.printStackTrace();
           }
        
        %>
        
       
        
            <script>
     function goBack() {
    //window.history.back();
    window.location.replace("manageReport.html");
    }
    
    window.onscroll = function() {scrollFunction()};

function scrollFunction() {
    if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
        document.getElementById("myBtn").style.display = "block";
    } else {
        document.getElementById("myBtn").style.display = "none";
    }
}

function onDelete(id) {
    //window.history.back();
    //var y = element.innerHTML;
    var confirmDel = confirm('ยืนยันการลบตัวแปร');
    //alert(id);
   
    if(confirmDel){
    var linkHref = "deleteData?id="+id;  
    window.open(linkHref);
    window.close();

    }else{
   
    }
     //alert(pkCate);
    //var x = document.getElementsByTagName("td")[0].innerText;
    //alert(x);
    //var linkHref = "deleteCate?id_cate="+id_cate;
    //window.open(linkHref);
   
    }

// When the user clicks on the button, scroll to the top of the document
function topFunction() {
    document.body.scrollTop = 0;
    document.documentElement.scrollTop = 0;
}

 function backtomenu() {
    //window.history.back();
    //var y = element.innerHTML;
    var linkHref = "managePage.jsp";  
    window.open(linkHref);    
    }
  function openAdd(){
    var linkHref = "addParams.jsp";
    window.open(linkHref,'left=20,top=20,width=500,height=500,toolbar=1,resizable=0');
  }  
    </script>
    </body>
</html>
