<%-- 
    Document   : testTextRead
    Created on : Oct 10, 2017, 10:44:57 AM
    Author     : NUT
--%>

<%@page import="path.managePath"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
       <%
           /*String path = getServletContext().getRealPath("/")+"setting/setting.txt";
          BufferedReader br = new BufferedReader(new FileReader(path));
           StringBuilder sb = new StringBuilder();
            String line;
            ArrayList list = new ArrayList();
            
              while((line = br.readLine())!= null){
                sb.append(line+",");
                list.add(line);
            }
            for(int i = 0;i<list.size();i++){
               out.println(list.get(i)+"<br>");
            }*/
           
            //managePath test = new managePath(getServletContext().getRealPath("/")+"setting/setting.txt");
            //String path = test.path();
              //out.println(test.getPathDB());
              //out.println(test.getUserDB());
              //out.println(test.getPassDB()+"<br>");
              //out.println(test.getPathReport()+"<br>");
              String value = "&#8217;";
               String test = new String(value.getBytes ("iso-8859-1"), "UTF-8");            
               System.out.print(test);

       %>
    </body>
</html>
