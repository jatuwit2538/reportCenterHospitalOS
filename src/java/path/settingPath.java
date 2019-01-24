/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package path;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;

/**
 *
 * @author NUT
 */
public class settingPath {
    
     public String path;
        public settingPath(String path){
              this.path = path;
        } 
        
      //ใช้เขียนไฟล์textในการsetting ค่าระบบ ตำแหน่ง textfile คือ 
       public void writeFile(String pathDB,String userDB,String passDB,String folderReport) throws IOException{
           String verify;
        File file = new File(path);
        file.createNewFile();
        FileWriter fw = new FileWriter(file);
        BufferedWriter bw = new BufferedWriter(fw);//pathDB==jdbc:postgresql://localhost:5433/dbHos  userDB==postgres  passDB==postgres
        bw.write(pathDB+","+userDB+","+passDB);
        bw.newLine();
        bw.write(folderReport);
        bw.flush();

        FileReader fr = new FileReader(file);
        BufferedReader br = new BufferedReader(fr);

        while( (verify=br.readLine()) != null )
        { 
            if(verify != null)
            {
                System.out.println(verify);
            }
        }
        br.close();
        bw.close();
       }
           }
         