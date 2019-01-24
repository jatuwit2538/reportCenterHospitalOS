/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.sql.Connection;
import java.sql.DriverManager;
import java.io.IOException;
import java.io.PrintWriter;
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
public class updateData extends HttpServlet {
    String name, description,query,idFil,id;
    String sql;
    
  
    ResultSet res;
    
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
        managePath path = new managePath(getServletContext().getRealPath("/")+"setting/setting.txt");
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        //response.setCharacterEncoding("UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
                
                    Class.forName("org.postgresql.Driver");
                
               
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(insertData.class.getName()).log(Level.SEVERE, null, ex);
            }
            Connection conn = (Connection)DriverManager.getConnection(path.getPathDB(), path.getUserDB(), path.getPassDB());

//Af_Scheme_Number=request.getParameter("Af_Scheme_Number"); 
            Integer id = Integer.parseInt(request.getParameter("id"));
            name = request.getParameter("name");
            idFil = request.getParameter("idfil");
            description = request.getParameter("description");
            query = request.getParameter("query");
            
            System.out.println("Name : "+name);
            System.out.println("IdFil : "+idFil);
            System.out.println("Description : "+description);
            System.out.println("Query : "+query);

            
            
            
            Statement stmt = (Statement) conn.createStatement();
           //select id,name,description,query,filtertype.nameFil
            sql = "update a_add_param set name='"+name+"',description='"+description+"',query='"+query+"',idfil='"+idFil+"' where id='"+id+"'";
             //update addparam set name='test',description='test_1_2'idFil=2 where id=53       
            //stmt.executeUpdate("SET NAMES UTF8");
            //stmt.executeUpdate("SET character_set_results=utf8");
            //stmt.executeUpdate("SET character_set_client=utf8");
            //stmt.executeUpdate("SET character_set_connection=utf8");
            System.out.println(sql);
            
            HttpSession session=request.getSession();
            if(session.getAttribute("userid")!=null){  
                        stmt.executeUpdate(sql);  
             }   
            
            
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
        
         RequestDispatcher rq = request.getRequestDispatcher("manageParams.jsp");
            rq.forward(request, response);
        
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
