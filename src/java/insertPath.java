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
public class insertPath extends HttpServlet {
  String path,category,jrxml,detail;
  String pkCate;        
  String sql,sqlCate;
    
  
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
        managePath pathDB = new managePath(getServletContext().getRealPath("/")+"setting/setting.txt");
        request.setCharacterEncoding("UTF-8");
        //response.setCharacterEncoding("UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
                Class.forName("org.postgresql.Driver");
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(insertData.class.getName()).log(Level.SEVERE, null, ex);
            }
            Connection conn = (Connection) DriverManager.getConnection(pathDB.getPathDB(), pathDB.getUserDB(), pathDB.getPassDB());

//Af_Scheme_Number=request.getParameter("Af_Scheme_Number");  
            path = request.getParameter("path");
            jrxml = request.getParameter("jrxml");
            detail = request.getParameter("detail");
            category = request.getParameter("category");
            //pkDetail = request.getParameter("pkDetail");
            
           
            //System.out.println("pkDetail : "+pkDetail);
            System.out.println("path : "+path);
            System.out.println("jrxml : "+jrxml);
            System.out.println("detail : "+detail);
            System.out.println("category : "+category);
            
            

            
            
            
            Statement stmt = (Statement) conn.createStatement();
            Statement stmtCate = (Statement) conn.createStatement();
            
            sqlCate = "select id_cate from a_report_category where name_cate = '"+category+"' limit 1";
            resCate = stmtCate.executeQuery(sqlCate);
           
            
            
            
            
             while(resCate.next()){
                pkCate = resCate.getString(1);
            }
             //update a_report_detail set path_report='1',jrxml_report='1'
             //where id_cate='12' and name_report='2.รายงานอื่น'
             sql = "update a_report_detail set path_report='"+path+"',jrxml_report='"+jrxml+"' where id_cate='"+pkCate+"' and name_report='"+detail+"'";
                   
            System.out.println(sql);
            
            //stmtCate.executeQuery(sqlCate);
            HttpSession session=request.getSession();
            if(session.getAttribute("userid")!=null){  
                        stmt.execute(sql);  
             }   
            
            //pass parameter error
            //response.setCharacterEncoding("UTF-8");
            response.sendRedirect("/reportCenterHosOS/reportPathForm.jsp?detail="+URLEncoder.encode(detail, "UTF-8")+"&category="+ URLEncoder.encode(category, "UTF-8"));
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
