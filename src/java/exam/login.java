/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package exam;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author suvo
 */
public class login extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.lang.ClassNotFoundException
     * @throws java.sql.SQLException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String id= request.getParameter("id");
            String pass=request.getParameter("passwd");
            String msg;
            //MySQL connectivity
            Class.forName("com.mysql.jdbc.Driver");
            Connection con=DriverManager.getConnection("jdbc:mysql://localhost/onlineexam","root","suvodip");
            //database=onlineexam, user=root, password=suvodip
            
            //Oracle driver connectivity
            /*Class.forName("oracle.jdbc.driver.OracleDriver");   
            Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","user","password");*/
            
            Statement stmt=con.createStatement();
            ResultSet rs=stmt.executeQuery("select * from user");
            int flag=0;
            
            HttpSession session= request.getSession();
            
            if(id.equals("admin") && pass.equals("admin"))
            {
                flag=2;
            }
            
            while(rs.next()){
                out.println(rs);
                if(rs.getString(2).equals(id) && rs.getString(3).equals(pass))
                    flag=1;
            }
            
            if(flag==0)
            {
                msg="Roll number or Password is not matching";
                session.setAttribute("msglog",msg);
                response.sendRedirect("welcome.jsp");
            }
            else if(flag==1)
            {
                session.setAttribute("sid",id);
                msg="Login successful";
                session.setAttribute("msglog",msg);
                Cookie roll=new Cookie("roll",id);
                Cookie password=new Cookie("password",pass);
                roll.setMaxAge(3600);
                password.setMaxAge(3600);
                response.addCookie(roll);
                response.addCookie(password);
                response.sendRedirect("studentlogin.jsp");
            }
            else if(flag==2)
            {
                session.setAttribute("sid",id);
                Cookie roll=new Cookie("roll",id);
                Cookie password=new Cookie("password",pass);
                roll.setMaxAge(3600);
                password.setMaxAge(3600);
                response.addCookie(roll);
                response.addCookie(password);
                session.removeAttribute("msg");
                response.sendRedirect("adminlogin.jsp");
            }
            out.println(flag);
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
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(login.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(login.class.getName()).log(Level.SEVERE, null, ex);
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
