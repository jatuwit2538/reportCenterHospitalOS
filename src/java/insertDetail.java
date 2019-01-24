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
public class insertDetail extends HttpServlet {
  String nameDetail,category,nameCate;
  String pkCate;        
  String sql,sqlCate;
    
  
    ResultSet res,resCate,rs;
    
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
         String messages = "";
        //response.setCharacterEncoding("UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
                Class.forName("org.postgresql.Driver");
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(insertData.class.getName()).log(Level.SEVERE, null, ex);
            }
            Connection conn = (Connection) DriverManager.getConnection(path.getPathDB(), path.getUserDB(), path.getPassDB());

//Af_Scheme_Number=request.getParameter("Af_Scheme_Number");  
            nameDetail = request.getParameter("nameDetail");
            category = request.getParameter("category");
            //pkDetail = request.getParameter("pkDetail");
            pkCate = request.getParameter("pkCate");
           
            //System.out.println("pkDetail : "+pkDetail);
            System.out.println("pkCate : "+pkCate);
            System.out.println("nameDetail : "+nameDetail);
            System.out.println("category : "+category);
            
            

            
            Statement stmt = (Statement) conn.createStatement();
            Statement stmtCate = (Statement) conn.createStatement();
            boolean checked = true;
            boolean sessionChecked = true;
            if(nameDetail.equals("")){      
               messages = "กรุณาใส่ข้อมูล";
           }else{

            
            sqlCate = "select name_cate from a_report_category where id_cate = '"+pkCate+"'";
            resCate = stmtCate.executeQuery(sqlCate);
            
            
            Statement stmtCompare = (Statement) conn.createStatement(); //ถ้าเหมือนไม่เพิ่ม
            String sqlCompare = "select name_report from a_report_detail";
            rs = stmtCompare.executeQuery(sqlCompare);
            
            while(resCate.next()){
                nameCate = resCate.getString(1);
            }
            
            while(rs.next()){
                if(rs.getString(1).equals(nameDetail)){
                         checked = false;
                         messages = "ข้อมูลนี้มีอยู่แล้ว"; 
                }
            }
             HttpSession session=request.getSession();
            if(session.getAttribute("userid")!=null){  
                        String userID=(String)session.getAttribute("userid");  
                        String nameUser=(String)session.getAttribute("username");
                        //out.print("Hello, "+userID+" Welcome to Profile");  
                        sessionChecked = true;  
             }else{
                        sessionChecked = false;
                        messages = "ต้องทำการเข้าสู่ระบบก่อนการใช้งาน";
             }           
            if(checked&&sessionChecked){
            sql = "insert into a_report_detail(id_cate,name_report)"
                    + " values('" + pkCate + "','" + nameDetail + "')";
            System.out.println(sql);
            //stmtCate.executeQuery(sqlCate);
            stmt.execute(sql);
            }
            }
            
            
            //pass parameter error
            
            response.sendRedirect("/reportCenterHosOS/reportDetailForm.jsp?category="+ URLEncoder.encode(category, "UTF-8")+"&messages="+ URLEncoder.encode(messages, "UTF-8"));
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
