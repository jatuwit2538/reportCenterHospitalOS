<%-- 
    Document   : testDecrypt
    Created on : Nov 7, 2017, 1:40:37 PM
    Author     : NUT
--%>

<%@page import="org.apache.commons.codec.binary.Hex"%>

<%@page import="java.nio.charset.Charset"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="java.math.BigInteger"%>
<%@page import="java.security.NoSuchAlgorithmException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
        try{
            String testUname = "";
            String testPsw = "";
            
            request.setCharacterEncoding("UTF-8");
            testUname = request.getParameter("uname");
            testPsw = request.getParameter("psw");
            
            final MessageDigest messageDigest = MessageDigest.getInstance("MD5");
            messageDigest.reset();
            messageDigest.update(testPsw.getBytes());
            final byte[] resultByte = messageDigest.digest();
            final String resultPsw = new String(Hex.encodeHex(resultByte));
            out.println(testUname);
            out.println(resultPsw);
/*           
  MessageDigest messageDigest = MessageDigest.getInstance("MD5");
  messageDigest.update(digestInput.getBytes());

  BASE64Encoder base64Encoder = new BASE64Encoder();
  String digestString = base64Encoder.encode(messageDigest.digest());
*/
       
  // digestString now contains the md5 hashed password
}
catch (Exception e){
  // do some type of logging here
}
        %>
    </body>
</html>
