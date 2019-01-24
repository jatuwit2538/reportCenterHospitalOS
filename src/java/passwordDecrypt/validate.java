/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package passwordDecrypt;

import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletContext;
import org.apache.commons.codec.binary.Hex;
import path.managePath;

/**
 *
 * @author NUT
 */
public class validate {
    String pathFile;
    public validate(String pathFile){
        this.pathFile = pathFile;
    }

   
    public  boolean checkUser(String emp_login,String emp_pass) 
     {
      boolean st =false;
      try{ // MD5 decoder
        final MessageDigest messageDigest = MessageDigest.getInstance("MD5");
            messageDigest.reset();
            messageDigest.update(emp_pass.getBytes());
            final byte[] resultByte = messageDigest.digest();
            final String resultPsw = new String(Hex.encodeHex(resultByte));
         managePath path = new managePath(pathFile);
	 //loading drivers for mysql
         Class.forName("org.postgresql.Driver");

 	 //creating connection with the database 
         Connection con = DriverManager.getConnection(path.getPathDB(), path.getUserDB(), path.getPassDB());
         //ดูว่ามีในฐานข้อมูลหรือเปล่า
         PreparedStatement ps =con.prepareStatement("select * from public.b_employee where b_employee.employee_login=? and b_employee.employee_password=?");
         ps.setString(1, emp_login);
         ps.setString(2, resultPsw);
         ResultSet rs =ps.executeQuery();
         st = rs.next();
          
         
         
      }catch(Exception e)
      {
          e.printStackTrace();
      }
         return st;                 
  }   
}
