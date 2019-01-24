
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;  
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
import javax.servlet.http.HttpSession;  
import javax.websocket.Session;
import org.apache.commons.lang.Validate;
import passwordDecrypt.validate;
import path.managePath;

/**
 *
 * @author macky
 */
public class authenLogin extends HttpServlet {
         String userID = null;
         String authenType = null;
         String nameUser = null;
         String userType = null;
         String userPointID = null;
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
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet indexAuthen</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet indexAuthen at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        processRequest(request, response);
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
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {response.setContentType("text/html;charset=UTF-8");
            request.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
       
        String emp_login = request.getParameter("uname");
        String emp_pass = request.getParameter("psw");
        
        
        String pathFile = getServletContext().getRealPath("/")+"setting/setting.txt";
        validate v = new validate(pathFile); //อยู่ในpackage passwordDecrypt
        
        if(v.checkUser(emp_login, emp_pass)) //เช็คจากฐานข้อมูล
        {
                        
                try {
                     
                     managePath path = new managePath(pathFile);
                    Class.forName("org.postgresql.Driver");
                    Connection conn = (Connection) DriverManager.getConnection(path.getPathDB(), path.getUserDB(), path.getPassDB()); 
                   Statement stmt = (Statement) conn.createStatement();
                    String sql = "select * from public.b_employee where b_employee.employee_login = '"+emp_login+"'"; 
                           
                    ResultSet rs = stmt.executeQuery(sql);
                    
                    
                    while(rs.next()){
                       userID = rs.getString(1);
                       authenType = rs.getString(13);
                       nameUser = rs.getString(4)+" "+rs.getString(5);
                       userPointID = rs.getString(10);
                    }
                      HttpSession session=request.getSession();  //seesion create
                      session.setAttribute("userid",userID);
                      session.setAttribute("username",nameUser);
                      
                      session.setAttribute("userpointid",userPointID);
                      
                      
                       
                    //check authen 10 is ONE STOP SERVICE  
                    if(authenType.equals("10")){
                    userType = "manager";  
                    session.setAttribute("usertype",userType);
                    
                    response.sendRedirect("/reportCenterHosOS/managePage.jsp?userid="+userID);
                    }else{
                      userType = "viewer";
                      session.setAttribute("usertype",userType);
                      response.sendRedirect("/reportCenterHosOS/showPage.jsp?userid="+userID);
                    }
                    
                    
                } catch (ClassNotFoundException ex) {
                    Logger.getLogger(authenLogin.class.getName()).log(Level.SEVERE, null, ex);
                } catch (SQLException ex) {
                    Logger.getLogger(authenLogin.class.getName()).log(Level.SEVERE, null, ex);
                }
              
           
            
        }
        else
        {
           out.print("<div class='warning'>"+"username หรือ password ไม่ถูกต้อง "+"</div>");
           RequestDispatcher rq = request.getRequestDispatcher("index.jsp");
           rq.include(request, response);
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