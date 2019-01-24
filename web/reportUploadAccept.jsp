    <%@page import="path.managePath"%>
<%@page import="java.awt.Desktop"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
<%@page pageEncoding="utf8" %>
   <%@page import="java.util.Enumeration"%>
   <%@ page import="java.util.List" %>
   <%@ page import="java.util.Iterator" %>
   <%@ page import="java.io.File" %>
   <%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
   <%@ page import="java.io.*,java.util.*, javax.servlet.*"%>
   <%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
   <%@ page import="org.apache.commons.fileupload.*"%>
   <%@ page language="java" contentType="text/html;charset=UTF-8" %>
   
     <meta contentType="text/html; charset=UTF-8"/>
      <link rel="stylesheet" href="style/default.css"> 
      <link rel="stylesheet" href="style/w3.css">
      <style>
            @import url(https://fonts.googleapis.com/css?family=Open+Sans);

            body { 
                font-family: 'Open Sans', sans-serif;
                color: #666;
                
            }

            /* STRUCTURE */

            #pagewrap {
                padding: 5px;
                width: 1300px;
                margin: 20px auto;
            }
            header {
                height: 100px;
                padding: 0 15px;
            }
            #content {
                width: 380px;
                float: left;
                padding: 5px 15px;
                
            }

            #middle {
                width: 520px; /* Account for margins + border values */
                float: left;
                padding: 5px 15px;
                
            }

            #sidebar {
                width: 290px;
                padding: 5px 15px;
                float: left;
            }
            footer {
                clear: both;
                padding: 0 15px;
            }

            /************************************************************************************
            MEDIA QUERIES
            *************************************************************************************/
            /* for 980px or less */
            @media screen and (max-width: 980px) {

                #pagewrap {
                    width: 94%;
                }
                #content {
                    width: 41%;
                    padding: 1% 4%;
                }
                #middle {
                    width: 41%;
                    padding: 1% 4%;
                    margin: 0px 0px 5px 5px;
                    float: right;
                }

                #sidebar {
                    clear: both;
                    padding: 1% 4%;
                    width: auto;
                    float: none;
                }

                header, footer {
                    padding: 1% 4%;
                }
            }

            /* for 700px or less */
            @media screen and (max-width: 600px) {

                #content {
                    width: auto;
                    float: none;
                }

                #middle {
                    width: auto;
                    float: none;
                    margin-left: 0px;
                }

                #sidebar {
                    width: auto;
                    float: none;
                }

            }

            /* for 480px or less */
            @media screen and (max-width: 480px) {

                header {
                    height: auto;
                }
                h1 {
                    font-size: 2em;
                }
                #sidebar {
                    display: none;
                }

            }


            #content {
                background: #f8f8f8;
            }
            #sidebar {
                background: #f0efef;
            }
            header, #content, #middle, #sidebar {
                margin-bottom: 5px;
            }

            #pagewrap, header, #content, #middle, #sidebar, footer {
                border: solid 1px #ccc;
                
            }  
            
             div.tab {
    overflow: hidden;
    border: 1px solid #ccc;
    background-color: #f1f1f1;
}

/* Style the buttons inside the tab */
div.tab button {
    background-color: inherit;
    float: left;
    border: none;
    outline: none;
    cursor: pointer;
    padding: 12px 20px;
    transition: 0.6s;
}

/* Change background color of buttons on hover */
div.tab button:hover {
    background-color: #cceeff;
}

/* Create an active/current tablink class */
div.tab button.active {
    background-color: #ccc;
}

/* Style the tab content */
.tabcontent {
    display: none;
    padding: 6px 10px;
    border: 1px solid #ccc;
    border-top: none;
}

 input[type=submit]{
                    width: 60%;
                    background-color: #088A08;
                    color: white;
                    margin: 8px 0;
                    border: none;
                    border-radius: 6px;
                    cursor: pointer;
                    align-content: center;
                    font-size: 24px;
}

            input[type=text]{
                    width: 100%;
                    padding: 12px 20px;
                    margin: 8px 0;
                    display: inline-block;
                    border: 1px solid #ccc;
                    border-radius: 4px;
                    box-sizing: border-box;
                    font-size: 16px;
}
body{
   background-color: #A9D0F5;
   color: black;
            }
#pagewrap{
    background: rgba(256,256,256, 0.6);
    border-radius: 6px; 
}     
        </style>
   
   <%
       
       request.setCharacterEncoding("UTF-8");
       
       ArrayList reportList = new ArrayList();
       ArrayList detailList = new ArrayList();
       
       managePath path = new managePath(getServletContext().getRealPath("/")+"setting/setting.txt");
       
       //out.println("TEST PATH : "+path.getPathReport());
  
       out.print("<div id='pagewrap'>");
 boolean isMultipart = ServletFileUpload.isMultipartContent(request);
 if (!isMultipart) {
 } else {
           
	   FileItemFactory factory = new DiskFileItemFactory();
	   ServletFileUpload upload = new ServletFileUpload(factory);
           
	   List items = null;
	   try {
                  
		   items = upload.parseRequest(request);
                   
	   } catch (FileUploadException e) {
		   e.printStackTrace();
	   }
           
           //set parameter to folder
           Iterator itrFolder = items.iterator();
           String name_folder = "";
           int i =1;
	   while (itrFolder.hasNext()) {
	   FileItem itemFolder = (FileItem) itrFolder.next();
           
	   if (itemFolder.isFormField()) {
               String name = itemFolder.getFieldName();
               String value = itemFolder.getString();
               //value = URLDecoder.decode( value, "UTF-8" );
               String valueDecoded = new String (value.getBytes ("iso-8859-1"), "UTF-8");
              
               if(i==3){ 
                   name_folder = valueDecoded;
                   //out.print("isFormField : "+name_folder+""+i+"<br>");
                     }
                i=i+1;
               //out.print("isFormField : "+valueDecoded+"<br>");
	   } 
           }
           
           
           
           
	   Iterator itr = items.iterator();
           
	   while (itr.hasNext()) {
	   FileItem item = (FileItem) itr.next();
           
	   if (item.isFormField()) {
               String name = item.getFieldName();
               String value = item.getString();
               //value = URLDecoder.decode( value, "UTF-8" );
               String valueDecoded = new String (value.getBytes ("iso-8859-1"), "UTF-8"); //decode 
               detailList.add(valueDecoded);
               //out.print("isFormField : "+valueDecoded+"<br>");
	   } else {
		   try {
                        String name = items.get(2).toString();
                        String value = item.getName();
                        
                        reportList.add(value);
                        //out.print("!isFormField : "+value+"<br>");
                        //out.print(item.getOutputStream());
                        //out.print("isFormField : "+name_folder+"<br>");
                        
                        
                        String strProjectDir = ""; 
                        strProjectDir = getServletContext().getRealPath("/")+path.getPathReport()+"/"+name_folder; //create directory if exist
                       
                        //out.print("testDir"+strProjectDir);
                        File ProjectDir = new File(strProjectDir);
                        //out.print(getServletContext().getRealPath("/")+"upload"+"\\"+name_folder+"\\<br>");
                        if(! ProjectDir.exists())
                        {
                            ProjectDir.mkdir(); //สร้างfolder หากfolderชื่อนั้นยังไม่มีการสร้าง
                            //out.print("make dir<br>");
                        }
			    String itemName = item.getName();
			    File savedFile = new File(getServletContext().getRealPath("/")+path.getPathReport()+"/"+name_folder+"\\"+itemName); //set follow category folder
                            //out.println("testItemName : "+getServletContext().getRealPath("/")+path.getPathReport()+"\\"+name_folder+"\\"+itemName+"<br>");
                            item.write(savedFile); //อัพโหลดไฟล์ลงในfolder ที่สร้าง
                            
                            
                            
                            // String pathFolder = getServletContext().getRealPath("/")+"upload/"+name_folder; 
                            // File fileDir = new File (pathFolder);
                            // Desktop desktop = Desktop.getDesktop();
                             //desktop.open(fileDir);
                            
		           //out.println("ตำแหน่งไฟล์ที่ได้บันทึก: "+getServletContext().getRealPath("/")+path.getPathReport()+"\\"+name_folder+"\\"+itemName+"<br><br>");
                           //out.println(itemName+" "+request.getParameter("category"));
		   } catch (Exception e) {
			   e.printStackTrace();
		   }
	   }
	   }
   }
             

         for(int i=0;i<reportList.size();i++){
              //out.print(reportList.get(i)+"<br>");
         }
         for(int i=0;i<detailList.size();i++){
              //out.print(detailList.get(i)+"<br>");
         }
        out.print("<div align='center' id='upload'>");
        out.print("<img src='images/success.gif' id='img' height='80' width='89'>");
        out.print("<h4>อัพโหลดเสร็จสมบูรณ์</h4>");
        out.print("</div>");
        
        out.print("<form action='UploadServlet'>");
        out.print("<input type='hidden' name='category' value='"+detailList.get(0).toString()+"'>");
        out.print("<input type='hidden' name='detail' value='"+detailList.get(1).toString()+"'>");
        out.print("<input type='hidden' name='name_folder' value='"+detailList.get(2).toString()+"'>");
        out.print("<input type='hidden' name='jrxml' value='"+reportList.get(0).toString()+"'>");
        out.print("<input type='hidden' name='jasper' value='"+reportList.get(1).toString()+"'>");
        
        out.print("<input type='submit' value='ตกลง' style='margin-left: 75px;'>");
        out.print("<form>");
       
       
      
        out.print("</div>");
   %>
  
   <script>
      function openFolder(){
       
      }
    
    
   </script>