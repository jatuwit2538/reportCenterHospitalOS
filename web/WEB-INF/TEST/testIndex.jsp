<%-- 
    Document   : testIndex
    Created on : Oct 4, 2017, 10:24:46 AM
    Author     : NUT
--%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 <head><title>Upload page</title></head></p> <p><body>
 <form action="UploadServlet" method="post" enctype="multipart/form-data" name="form1" id="form1">
   <center>
   <table border="2">
       <tr>
	       <td align="center"><b>Multipale file Uploade</td>
	   </tr>
       <tr>
	       <td>
		       Specify file: <input name="file" type="file" id="file">
		   <td>
	   </tr>
	   <tr>
	     
            <tr>
		   <td>
		      Specify file:<input name="file" type="file" id="file">
		   </td>
		 </tr>
		 <tr>
		    <td align="center">
               <input type="submit" name="Submit" value="Submit files"/>
			</td>
		 </tr>
    </table>
	<center>
 </form>
 </body>
 </html>