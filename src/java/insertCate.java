/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.sql.Connection;
import java.sql.DriverManager;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import path.managePath;

/**
 *
 * @author NUT
 */
public class insertCate extends HttpServlet {
  String nameCate,service_point;
        
  String sql;
    
  
    ResultSet res,rs;
    
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        //response.setContentType("text/html;charset=UTF-8");
        managePath path = new managePath(getServletContext().getRealPath("/")+"setting/setting.txt");
        request.setCharacterEncoding("UTF-8");
        String messages = ""; //ใช้ส่งกลับไปยังหน้า reportCateForm.jsp หากมีerror
        //response.setCharacterEncoding("UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
                Class.forName("org.postgresql.Driver");
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(insertData.class.getName()).log(Level.SEVERE, null, ex);
            }
            Connection conn = (Connection) DriverManager.getConnection(path.getPathDB(), path.getUserDB(), path.getPassDB());

//Af_Scheme_Number=request.getParameter("Af_Scheme_Number");  
            
           nameCate = request.getParameter("nameCate");
           service_point = request.getParameter("service_point");
           if(nameCate.equals("")){      
              messages = "กรุณาใส่ข้อมูล";
           }else{
               
             System.out.println("nameCate : "+nameCate);
            Statement stmt = (Statement) conn.createStatement();
            Statement stmtCompare = (Statement) conn.createStatement();
            String sqlCompare = "select name_cate from a_report_category";
            
            rs = stmtCompare.executeQuery(sqlCompare);
            boolean checked = true;
            boolean sessionChecked = true;
            while(rs.next()){
                if(rs.getString(1).equals(nameCate)){
                         checked = false;
                         messages = "ข้อมูลนี้มีอยู่แล้ว"; 
                }
            }
            HttpSession session=request.getSession();
            if(session.getAttribute("userid")!=null){  //ตรวจดูการเข้าสู่ระบบ
                        String userID=(String)session.getAttribute("userid");  
                        String nameUser=(String)session.getAttribute("username");
                        //out.print("Hello, "+userID+" Welcome to Profile");  
                        sessionChecked = true;  
             }else{
                        sessionChecked = false;
                        messages = "ต้องทำการเข้าสู่ระบบก่อนการใช้งาน";
             }           
            
            if(checked&&sessionChecked){
            sql = "insert into a_report_category(name_cate,name_folder,b_service_point_id)"
                    + " values('" + nameCate + "','" + nameCate + "','"+service_point+"')";
            System.out.println(sql);
            stmt.executeUpdate(sql);
            
            }
           }
           response.sendRedirect("/reportCenterHosOS/reportCateForm.jsp?messages="+ URLEncoder.encode(messages, "UTF-8"));
        }
         
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        //request.setAttribute("todo", "10");
       
        
        //request.getRequestDispatcher("/addParams.jsp").forward(request, response);
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(insertData.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
            
        } catch (SQLException ex) {
            Logger.getLogger(insertData.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
