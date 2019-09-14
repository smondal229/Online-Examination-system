/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package exam;

import java.io.IOException;
import java.io.PrintWriter;
//import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
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

/**
 *
 * @author suvo
 */
public class register extends HttpServlet {

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
        PrintWriter out=response.getWriter();
        HttpSession session =request.getSession();
        String msg="";
        String name=request.getParameter("name");
        String id=request.getParameter("roll");
        String pass=request.getParameter("password");
        String email=request.getParameter("email");
        String phone=request.getParameter("phone");
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
        String query="Insert into user values('"+name+"','"+id+"','"+pass+"','"+email+"','"+phone+"')";
        if(rs.next())
        {       
                out.println("1");
                if(rs.getString(2).equals(id)){
                    out.println("2");
                    msg="Roll or id already exists";
                    out.println(msg);
                    flag=1;
                }
                else if(rs.getString(4).equals(email)){
                    msg="Email id already exists";
                    out.println(msg);
                    flag=1;
                }
                else if(rs.getString(5).equals(phone)){
                    msg="Contact number already exists";
                    out.println(msg);
                    flag=1;
                }
            while(rs.next())
            {
                if(rs.getString(2).equals(id)){
                    msg="Roll or id already exists";
                    out.println(msg);
                    flag=1;
                    break;
                }
                else if(rs.getString(4).equals(email)){
                    msg="Email id already exists";
                    out.println(msg);
                    flag=1;
                    break;
                }
                else if(rs.getString(5).equals(phone)){
                    msg="Contact number already exists";
                    out.println(msg);
                    flag=1;
                }
            }
            if(flag==1){
                session.setAttribute("msg", msg);
                response.sendRedirect("welcome.jsp");
            }
            else{ 
                //out.println(query);
                msg="Successfully Registered! Login now!";
                session.setAttribute("msg", msg);
                stmt.executeUpdate(query);
                response.sendRedirect("welcome.jsp");
            }
        }
        else{
            out.println(query);
            session.removeAttribute("msg");
            stmt.executeUpdate(query);
        }
        out.println(flag);
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
            Logger.getLogger(register.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(register.class.getName()).log(Level.SEVERE, null, ex);
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
