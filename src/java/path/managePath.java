package path;


import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author NUT
 */
public class managePath {
    //UploadServlet set path of report
    public String path;
        public managePath(String path){
              this.path = path;
        } 
        
        
        
       public String getPathDB() throws FileNotFoundException, IOException{ //database name
           
               //String path = application.getRealPath("/")+"setting/setting.txt";
          BufferedReader br = new BufferedReader(new FileReader(path));
           //StringBuilder sb = new StringBuilder();
            String line;
            ArrayList list = new ArrayList();
            
              while((line = br.readLine())!= null){
                //sb.append(line+",");
                list.add(line);
            }
              String sql = list.get(0).toString();
              
              
           return sql.split(",")[0];
       }
       public String getUserDB() throws FileNotFoundException, IOException{ //username database
           
               //String path = application.getRealPath("/")+"setting/setting.txt";
          BufferedReader br = new BufferedReader(new FileReader(path));
           //StringBuilder sb = new StringBuilder();
            String line;
            ArrayList list = new ArrayList();
            
              while((line = br.readLine())!= null){
                //sb.append(line+",");
                list.add(line);
            }
            String sql = list.get(0).toString();
              
              
           return sql.split(",")[1];
       }
       
       public String getPassDB() throws FileNotFoundException, IOException{ //password database
           
               //String path = application.getRealPath("/")+"setting/setting.txt";
          BufferedReader br = new BufferedReader(new FileReader(path));
           //StringBuilder sb = new StringBuilder();
            String line;
            ArrayList list = new ArrayList();
            
              while((line = br.readLine())!= null){
                //sb.append(line+",");
                list.add(line);
            }
             String sql = list.get(0).toString();
             String newSql = (sql.split(",")[2]);
              
           return newSql.trim();
       }
       
       public String getPathReport() throws FileNotFoundException, IOException{ // folder name
           
               //String path = application.getRealPath("/")+"setting/setting.txt";
          BufferedReader br = new BufferedReader(new FileReader(path));
           StringBuilder sb = new StringBuilder();
            String line;
            ArrayList list = new ArrayList();
            
              while((line = br.readLine())!= null){
                //sb.append(line+",");
                list.add(line);
            }
             String sql = list.get(1).toString();
             
              
           return sql.trim();
       }
}
