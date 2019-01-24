<%-- 
    Document   : testXML
    Created on : Sep 26, 2017, 10:40:28 AM
    Author     : NUT
--%>

<%@ page import="javax.xml.parsers.DocumentBuilderFactory" %>
<%@ page import="javax.xml.parsers.DocumentBuilder" %>
<%@ page import="org.w3c.dom.Document" %>
<%@ page import="org.w3c.dom.NodeList" %>
<%@ page import="org.w3c.dom.Node" %>
<%@ page import="org.w3c.dom.Element" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.io.File"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="java.io.FileNotFoundException"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.SQLException"%>
<html>
<head>
	
</head>
<body>

<%

	try {
	        response.setCharacterEncoding("UTF-8");
                
                
                Class.forName("org.postgresql.Driver").newInstance();
                //Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5433/dbHos", "postgres", "postgres"); //database connection
                Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5433/dbHos", "postgres", "postgres");
                 ArrayList<String> sql = new ArrayList<String>();
                // = statement.executeQuery(sql);
                 Statement statement = conn.createStatement();
                 int count=0;
                 
		String fileName = "C:/Users/NUT/Desktop/ex.xml";//application.getRealPath("/myData.xml");
		File strXML = new File(fileName);
		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		DocumentBuilder dBuilder = dbf.newDocumentBuilder();
		Document doc = dBuilder.parse(strXML);
		doc.getDocumentElement().normalize();
	
		NodeList nList = doc.getElementsByTagName("reportgroup");
	
                //arrayList identify multiple value 
		ArrayList<HashMap<String, String>> myArrList = new ArrayList<HashMap<String, String>>();
		HashMap<String, String> map;
	
		for (int temp = 0; temp < nList.getLength(); temp++) {
			Node nNode = nList.item(temp);
	
			if (nNode.getNodeType() == Node.ELEMENT_NODE) {
				Element ele = (Element) nNode;
				map = new HashMap<String, String>();
                               
                                //map.put("reportname", ele.getElementsByTagName("name").item(0).getTextContent());
                                //out.println("<br>REPORT NAME = " + ele.getElementsByTagName("name").item(0).getTextContent());
                                
                                for(int i=1;i<ele.getElementsByTagName("name").getLength();i++){
                                 //map.put("name", ele.getElementsByTagName("name").item(i).getTextContent());
				 //map.put("path", ele.getElementsByTagName("path").item(i-1).getTextContent());
				 //map.put("jrxml", ele.getElementsByTagName("jrxml").item(i-1).getTextContent());
                                  //out.println("<br>Primary key = " +i+"   Foreign key = "+(temp+1)+"<br>");
                                  //out.println("<br>NAME = " + ele.getElementsByTagName("name").item(i).getTextContent());
                                 //out.println("<br>NAME = " + ele.getElementsByTagName("name").item(i+1).getTextContent());
			          //out.println("<br>PATH = " + ele.getElementsByTagName("path").item(i-1).getTextContent());
			          //out.println("<br>JRXML = " + ele.getElementsByTagName("jrxml").item(i-1).getTextContent()+"<br>");
                                  String sql1 = "insert into a_report_detail(id_cate,name_report,path_report,jrxml_report,jasper_report)  values('"+(temp+1)+"','"+ele.getElementsByTagName("name").item(i).getTextContent()+"','"+ele.getElementsByTagName("path").item(i-1).getTextContent()+"','"+ele.getElementsByTagName("jrxml").item(i-1).getTextContent()+"','"+ele.getElementsByTagName("jrxml").item(i-1).getTextContent().split("\\.")[0]+".jasper"+"');";
                                  //String sql1 = "insert into a_report_category(id_cate,name_cate)  values('"+(temp+1)+"','"+ele.getElementsByTagName("name").item(0).getTextContent()+"')";
                                  sql.add(sql1);
                                  //Statement statement = conn.createStatement();
                                  //ResultSet rsCompile = statement.executeQuery(sql);
                                  
                                  //statement.executeQuery(sql);
                                   
                                   }
                                out.print("<br><br>");
				//out.print(ele.getElementsByTagName("name").item(0).getTextContent().length()+"  ");
				//map.put("Link", ele.getElementsByTagName("Link").item(0).getTextContent());
				//myArrList.add(map);
			}
		}
                
                
                
                for(int i =0;i<sql.size();i++){
                    out.print(sql.get(i)+"<br>");
                    
                    //statement.execute(sql.get(i));
                }
                
                                  //
	
		// *** Print Result ***//
		//for (int i = 0; i < myArrList.size(); i++) {
	             // String reportName = myArrList.get(i).get("reportname").toString();
                       //for(int j=0;j<myArrList.get(i).get("name").length();j++){
			//String name = myArrList.get(j).get("name").toString();
			//String path = myArrList.get(j).get("path").toString();
			//String jrxml = myArrList.get(j).get("jrxml").toString();
                       
                       //}
			//String sLink = myArrList.get(i).get("Link").toString();
	              //out.println("<br>REPORT NAME = " + reportName);
			//out.println("<br>NAME = " + name);
			//out.println("<br>PATH = " + path);
			//out.println("<br>JRXML = " + jrxml);
			
			//out.println("<br>=========================");
	
		//}
	         //out.print("<br>"+myArrList.size());
                   
	} catch (Exception e) {
		e.printStackTrace();
	}

%>
	
</body>
</html>