<%-- 
    Document   : viewImage
    Created on : Aug 25, 2017, 11:22:59 AM
    Author     : NUT
--%>



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
        
        
        <style>
.button {
    background-color: #4CAF50; /* Green */
    border: none;
    color: white;
    padding: 8px 16px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 12px;
    margin: 4px 2px;
    -webkit-transition-duration: 0.4s; /* Safari */
    transition-duration: 0.4s;
    cursor: pointer;
}

.button2 {
    background-color: white; 
    color: black; 
    border: 2px solid #008CBA;
}

.button2:hover {
    background-color: #008CBA;
    color: white;
    border-radius: 12px;
}

div {
    font-size: 12pt;
    font-family: times new roman;
    color: #23238e;
}

select {
        border:2px solid lightblue;
	border-radius:8px;
	height: 22px;
	width: 120px;
}

input[type=date] {
        border:2px solid lightblue;
	border-radius:8px;
	height: 22px;
	width: 130px;
}

input[type=text] {
        border:2px solid lightblue;
	border-radius:8px;
	height: 22px;
	width: 130px;
}

</style>
        
      
    </head>
    <body>
        
        
        <%  
            
          try{
            int cRow = 0;  
              
           //encode from getparameter
           request.setCharacterEncoding("UTF-8");
           String text = "1.รายงานผู้ป่วยที่ค้างชำระเงิน";
           
              //database filter type
              
              String sql = "select a_add_param.id,a_filter_type.namefil,a_add_param.name,a_add_param.description,a_add_param.query from a_add_param inner join a_filter_type on a_add_param.idfil = a_filter_type.idfil order by a_add_param.id ASC";
              Class.forName("org.postgresql.Driver").newInstance();
              Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5433/dbHos", "postgres", "postgres");
              Statement statement = conn.createStatement();
              ResultSet rs = statement.executeQuery(sql);
              
    
              Connection con = (Connection) DriverManager.getConnection("jdbc:postgresql://localhost:5433/dbHos", "postgres", "postgres");
              Statement statement1 = con.createStatement();
             
              //for list category
               //String sqlCateCount = "select id_cate,id_report,name_report,path_report,jrxml_report from a_report_detail order by id_report ASC";
              //ResultSet rsCateCount = statement.executeQuery(sqlCateCount);
   
              //for compile
              String sqlCompile = "";
              ResultSet rsCompile = null;
                
              //ResultSet rsCompile = null;
              
             
               
           
           //out.println(">>>>>>"+text);
           //out.println(text+"<<<<<<");
           //Read XML 
           JasperDesign jasperDesign; //find filter
           
           String textPath=""; //getString(4);
           String textReport=""; //getString(5);
           
           String paramJas="";
           String paramDbDes="";
           String paramDbType="";
           String paramDbName="";
           
           String textGroupFilter="";
           
           
          // while(rsCateCount.next()){
            
           // out.print(rsCateCount.getString(2)); 
                   
                        //String sqlDetailCount = "select id_report,name_report from a_report_detail where id_cate = '"+rsCateCount.getString(1)+"' order by id_report ASC";
                        String sqlDetailCount = "select id_cate,id_report,name_report,path_report,jrxml_report from a_report_detail order by id_report ASC";
                         ResultSet rsDetailCount = statement1.executeQuery(sqlDetailCount);
                              while(rsDetailCount.next()){
                             if(text.equals(rsDetailCount.getString(3))){
                                  textPath = rsDetailCount.getString(4);
                                  textReport = rsDetailCount.getString(5);
                                  
                                  //out.println(">>>>>"+text+"<br>");
                                  //out.println(">>>>>"+textPath+"<br>");
                                  //out.println(">>>>>"+textReport+"<br><br>");
            }
                            }
                  
            //}
         
          
          jasperDesign = JRXmlLoader.load(application.getRealPath(textPath+"/"+textReport));
          out.print("<form action='Show.jsp' target='righty'>");
          while(rs.next()){
          for(int i =20;i<jasperDesign.getParametersList().size();i++){
               paramJas =jasperDesign.getParametersList().get(i).getName();
              //out.println(paramJas+"from report   <br>");
                 paramDbDes = rs.getString(4).toString();
                 paramDbType = rs.getString(2).toString();
                 paramDbName = rs.getString(3).toString();
                 
                 //String sqlCompile = rs.getString(5).toString();
                 
                  
                 //Connection con = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/dbHosDemo?useUnicode=yes&characterEncoding=UTF-8", "root", "");
                 //Statement statement1 = con.createStatement();
                 //ResultSet rsCompile = statement1.executeQuery(sqlCompile);
                 
                 //rsCompile = statement1.executeQuery(sqlCompile);
                  //out.println("ParamJas : "+paramJas+"    ParamDB : "+paramDbDes+"<br>");
                  if(paramJas.equals(paramDbDes)){
                     //out.println("ParamDb : "+paramDbDes+"  ParamJas  : "+paramJas+"<br>");
                      
                     //out.print(paramJas+"<br>");
                     //out.print(paramDbType+"<br>");
                     
                     
                     if(paramDbType.equals("date")){
                     out.print(paramDbName+": <input class='date' type='date' name="+paramJas+" value='2555-01-02'>");
                     cRow++;
                     }
                     if(paramDbType.equals("textfield")){
                     out.print(paramDbName+": <input type='text' name="+paramJas+" value=''>"); 
                     cRow++;
                     }
                     if(paramDbType.equals("textarea")){
                         out.print(paramDbName+":  <textarea name="+paramJas+" value='' rows='10' cols='50'>Write something here</textarea>");
                         cRow++;
                     }
                     if(paramDbType.equals("list")){ //want database for test
                         //out.print(rsCompile);
                         sqlCompile=rs.getString(5);
                         rsCompile = statement1.executeQuery(sqlCompile);
                         //
                         //for(int a=0;a>5;a++){
                             //out.println("Row : "+rsCompile.getString(2));
                         //}
                         //out.print(rsCompile.getCursorName());
                        out.print(paramDbName+": ");
                             out.println("<select name="+paramJas+">");
                             while (rsCompile.next()) {
                                 out.print("<option value=" + rsCompile.getString(1) + ">");
                                 out.print(rsCompile.getString(2));
                                 out.print("</option>");
                             }
                             out.println("</select>");
                             cRow++;
                             
                     }
                     
                    if(cRow>2){
                        cRow = 0;
                       out.print("<br><br>");
                    }
                    // break;
                  } 
                  //out.print(paramJas+"<br>");
                  }
                    
            } 
            out.print("<input type='hidden' name='textPath' value="+textPath+">");
            out.print("<input type='hidden' name='textReport' value="+textReport+">");
            out.print("<br><input type='submit' class='button button2' value='แสดงรายการ'>");
           out.print("</form>");
          
          
         
         }catch(Exception ex){
           ex.printStackTrace();
            }
         %>
         
        
    </body>
     

</html>
