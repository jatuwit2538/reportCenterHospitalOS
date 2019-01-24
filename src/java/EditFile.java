
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
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
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
 
public class EditFile {

public static void main(String[] args) {

    try{
        String verify, putData;
        File file = new File("C:\\Users\\NUT\\Documents\\NetBeansProjects\\reportCenterHosOS\\build\\web\\setting\\file.txt");
        file.createNewFile();
        FileWriter fw = new FileWriter(file);
        BufferedWriter bw = new BufferedWriter(fw);
        bw.write("Some text here for a reason,test,test2");
        bw.newLine();
        bw.write("Some text here for a reason2");
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

    }catch(IOException e){
    e.printStackTrace();
    }
}
}