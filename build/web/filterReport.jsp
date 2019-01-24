<%-- 
    Document   : viewImage
    Created on : Aug 25, 2017, 11:22:59 AM
    Author     : NUT
--%>



<%@page import="path.managePath"%>
<%@page import="java.util.LinkedHashSet"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="net.sf.jasperreports.engine.xml.JRXmlLoader"%>
<%@page import="net.sf.jasperreports.engine.design.JasperDesign"%>
<%@page import="java.util.List"%>
<%@page import="org.w3c.dom.traversal.NodeIterator"%>
<%@page import="javax.swing.tree.DefaultMutableTreeNode"%>
<%@page import="java.io.File"%>
<%@page contentType="text/html; charset=UTF-8" %>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.w3c.dom.Node, org.w3c.dom.Element, org.w3c.dom.Document, org.w3c.dom.NodeList, javax.xml.parsers.DocumentBuilder, javax.xml.parsers.DocumentBuilderFactory" %>
<!DOCTYPE html>
<html>
    <head>
  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="style/default.css">
        <link rel="stylesheet" href="style/w3.css">
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        
        <style>
#pagewrap, header{
                border: solid 0px #ccc;
                font-family: TH SarabunPSK;
                font-size: 23px;
                font-weight: bold;
                padding: 0;
            } 
            
 body{
       margin-left: 20px;         
       font-family: TH SarabunPSK;         
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
    width: 180px;
    top: -95px;
    left: 155%; 
    margin-left: -60px;
    /* Position the tooltip */
    position: absolute;
    z-index: 1;
}
.tooltip:hover .tooltiptext {
    visibility: visible;
}



</style>
       <script>
  $( function() {  //ไม่ได้ใช้
    $( "#datepicker" ).datepicker();
  } );
  </script> 
      
    </head>
    <body>
        
        
            
        <%  
              request.setCharacterEncoding("UTF-8");  
                       String textUser = null;
                        if(session.getAttribute("userid")!=null){  
                        String userID=(String)session.getAttribute("userid");  
                        String nameUser=(String)session.getAttribute("username");
                        String userType=(String)session.getAttribute("usertype");
                        //out.print("Hello, "+userID+" Welcome to Profile");  
                            try{
              managePath path = new managePath(getServletContext().getRealPath("/")+"setting/setting.txt");
            int cRow = 0;
            int cRowOther = 0;
              StringBuilder sb = new StringBuilder();

          //รับข้อความจากtext ของ readXML.jsp ใช้เป็นหัวข้อ
           String text="";
           text = request.getParameter("text");
           if(text.equals("")){
              text = " ";
           }
           out.println("<h4 style='font-size: 26px;font-family: TH SarabunPSK;font-weight: bold;text-decoration: underline;'>"+text+"</h4>");
           out.println("<div id='pagewrap'>");
              //database filter type
              
              //filter type
              String sql = "select a_add_param.id,a_filter_type.namefil,a_add_param.name,a_add_param.description,a_add_param.query from a_add_param inner join a_filter_type on a_add_param.idfil = a_filter_type.idfil order by a_add_param.id ASC";
              Class.forName("org.postgresql.Driver").newInstance();
              Connection conn = DriverManager.getConnection(path.getPathDB(), path.getUserDB(), path.getPassDB());
              Statement statement = conn.createStatement();
              ResultSet rs = statement.executeQuery(sql);
              
    
              Connection con = (Connection) DriverManager.getConnection(path.getPathDB(), path.getUserDB(), path.getPassDB());
              Statement statement1 = con.createStatement();
             
              //for compile
              String sqlCompile = "";
              ResultSet rsCompile = null;
                
           
           JasperDesign jasperDesign; //find filter
           
           String textPath=""; //getString(4);
           String textReport=""; //getString(5);
           String textReportJasper=""; //getString(5);
           
           String paramJas="";
           String paramDbDes="";
           String paramDbType="";
           String paramDbName="";
           

                        String sqlDetailCount = "select id_cate,id_report,name_report,path_report,jrxml_report,jasper_report from a_report_detail order by id_report ASC";
                         ResultSet rsDetailCount = statement1.executeQuery(sqlDetailCount);
                              while(rsDetailCount.next()){
                             if(text.equals(rsDetailCount.getString(3))){
                                  textPath = rsDetailCount.getString(4); //folder ที่เก็บข้อมูล
                                  textReport = rsDetailCount.getString(5); //jrxml
                                  textReportJasper = rsDetailCount.getString(6); //jasper
                                  //out.println(">>>>>"+text+"<br>");
                                  //out.println(">>>>>"+textPath+"<br>");
                                  //out.println(">>>>>"+textReport+"<br><br>");
            }
                            }
                  
          ArrayList reportParams = new ArrayList();
          jasperDesign = JRXmlLoader.load(application.getRealPath(textPath+"/"+textReport));
          out.print("<form action='Show.jsp' target='righty'>");
          while(rs.next()){
          for(int i =20;i<jasperDesign.getParametersList().size();i++){
               paramJas =jasperDesign.getParametersList().get(i).getName();
              //out.println(paramJas+"from report   <br>");
                 paramDbDes = rs.getString(4).toString(); //ชื่อparmaters ของตัวแปร
                 paramDbType = rs.getString(2).toString(); //filter type 
                 paramDbName = rs.getString(3).toString(); //คำอธิบายของตัวแปร
                 reportParams.add(paramJas);
                
                  if(paramJas.equals(paramDbDes)){
                    //out.println(paramJas+"from report   <br>"); //test paramter list
                     if(paramDbType.equals("date")){
                     out.print(paramDbName+": <input class='date' type='date' name="+paramJas+" value='2555-01-02' style='font-size: 22px;'> ");
                     //out.print(paramDbName+": <input type='text' id='datepicker' name="+paramJas+" style='font-size: 22px;'>");
                      cRow++;
                     }
                     if(paramDbType.equals("textfield")){
                     out.print(paramDbName+": <input type='text' name="+paramJas+" value=' ' style='font-size: 22px;margin-top:10px;'>"); 
                     cRowOther++;
                     }
                    
                     if(paramDbType.equals("list")){ //want database for test
                         //out.print(rsCompile);
                         sqlCompile=rs.getString(5);
                         String newSql = sqlCompile.replace("\"","\'");
                         rsCompile = statement1.executeQuery(newSql);
                         
                        out.print(paramDbName+": ");
                             out.println("<select name="+paramJas+" style='font-size: 22px;margin-top:10px;'>");
                             while (rsCompile.next()) {
                                 out.print("<option value=" + rsCompile.getString(1) + ">");
                                 out.print(rsCompile.getString(2));
                                 out.print("</option>");
                             }
                             out.println("</select>");
                             
                      cRowOther++;       
                     }
                     
                    if(cRow>1){
                        cRow = 0;
                       out.print("<br>");
                    }
                    if(cRowOther>2){
                        cRowOther = 0;
                       out.print("<br>");
                    }
                    // break;
                  } 
                  //out.print(paramJas+"<br>");
                  }
                    
            } 
          //Set<String> set=new HashSet<>(reportParams);
          List li2 = new ArrayList(new LinkedHashSet(reportParams)); //หาตัวแปรที่ใช้ จาก jrxml
             for(int i=0;i<li2.size();i++){
               //out.print(li2.get(i)+"<br>");
               sb.append(li2.get(i)+"<br>");
            }
            out.print("<input type='hidden' name='textPath' value="+textPath+">");
            out.print("<input type='hidden' name='textReportJasper' value="+textReportJasper+">");
            out.print("<input type='hidden' name='textReport' value="+textReport+">");
            //out.print("<br><input type='submit' class='button button2' value='แสดงรายงาน'>");
            if(userType == "manager"){ //ต้องเป็น user ประเภท manager  ถึงจะเห็นตัวแปรที่ใช้
            out.print("<div class='tooltip'><input type='submit' class='button button2' value='แสดงรายงาน' style='margin-top:10px;'><span class='tooltiptext' style='font-size: 18px;'>ตัวแปรที่จำเป็น: <br>"+sb+"</span></div>");
            }else{
            out.print("<input type='submit' class='button button2' value='แสดงรายงาน' style='margin-top:10px;'>");
            }
           out.print("</form>");
          
           out.print("</div>"); 
          
          
          
         }catch(Exception ex){
           ex.printStackTrace();
            }
                        }else{  
                            
                          out.print("ต้องทำการเข้าสู่ระบบก่อนเข้าใช้งาน");  
                        }  
            
        
         %>
           
    </body>
  

</html>
