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
import javax.servlet.RequestDispatcher;
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
public class updateReport extends HttpServlet {
  String reportType;

    ResultSet res,resCate;
    
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
        request.setCharacterEncoding("UTF-8");
        managePath path = new managePath(getServletContext().getRealPath("/")+"setting/setting.txt");
        //response.setCharacterEncoding("UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
                Class.forName("org.postgresql.Driver");
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(insertData.class.getName()).log(Level.SEVERE, null, ex);
            }
            Connection conn = (Connection) DriverManager.getConnection(path.getPathDB(), path.getUserDB(), path.getPassDB());
             HttpSession session=request.getSession();
            
            reportType = request.getParameter("reportType");
             if(reportType.equals("category")){ //id_cate=1&category=1.รายงานการเงิน&reportType=category
                 String category = request.getParameter("category");
                 String id_cate = request.getParameter("id_cate");
                 String edited = request.getParameter("edited");
                 String folder = request.getParameter("folder");
                 String service_point = request.getParameter("service_point");
                 
                 String sql="update a_report_category set name_cate='"+edited+"' ,name_folder='"+folder+"',b_service_point_id='"+service_point+"' where id_cate = '"+id_cate+"' ";
                  Statement stmt = (Statement) conn.createStatement();          
                  System.out.println(sql);
                   //stmtCate.executeQuery(sqlCate);
                   if(session.getAttribute("userid")!=null){ 
                   stmt.execute(sql);
                   }
                    RequestDispatcher rq = request.getRequestDispatcher("reportCateForm.jsp");
                    rq.forward(request, response);
                   
                   //out.print("category submit");
                
             }else{ //category=4.รายงานการนัดหมาย&reportType=detail&id_cate=4&id_report=18&detail=1.รายการนัดหมายแยกตามวัน+เวลา+คลินิก+และแพทย์
                 String category = request.getParameter("category");
                 
                 String id_cate = request.getParameter("id_cate");
                 String id_report = request.getParameter("id_report");
                 String edited = request.getParameter("edited");
                 String sql="update a_report_detail set name_report='"+edited+"' where id_cate = '"+id_cate+"' and id_report='"+id_report+"' ";
                 Statement stmt = (Statement) conn.createStatement();          
                 System.out.println(sql);
                 System.out.println(category);
                 //stmtCate.executeQuery(sqlCate);
                  if(session.getAttribute("userid")!=null){ 
                   stmt.execute(sql);
                   }
                 response.sendRedirect("/reportCenterHosOS/reportDetailForm.jsp?category="+ URLEncoder.encode(category, "UTF-8"));
                  //out.print("detail submit");  
             }

           
            //response.sendRedirect("/WebApplication3/reportPathForm.jsp?detail="+URLEncoder.encode(detail, "UTF-8")+"&category="+ URLEncoder.encode(category, "UTF-8"));
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
