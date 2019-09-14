/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package exam;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author suvo
 */
@WebServlet(name = "createTest", urlPatterns = {"/createTest"})
public class createTest extends HttpServlet {

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
            String table=request.getParameter("new");
            
            //MySQL connectivity
            Class.forName("com.mysql.jdbc.Driver");
            Connection con=DriverManager.getConnection("jdbc:mysql://localhost/onlineexam","root","suvodip");
            
            //Oracle driver connectivity
            /*Class.forName("oracle.jdbc.driver.OracleDriver");   
            Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","user","password");*/
            String query="create table "+table+"(id int primary key,question varchar(4000),opta varchar(1000),optb varchar(1000),optc varchar(1000),optd varchar(1000),correct varchar(1000),marks int(5))";
            String sequence="create sequence "+table+"_seq";
            String trigger="create trigger trg_"+table+"_id\n" +
            "    before insert on "+table+"\n" +
            "    for each row\n" +
            "  begin\n" +
            "      select "+table+"_seq.nextval\n" +
            "      into :new.id\n" +
            "      from dual;\n" +
            "  end;\n" +
            "  /";
            Statement stmt = con.createStatement();
            out.println("create table "+table+"(id int(10) auto_increment,question varchar(4000),opta varchar(1000),optb varchar(1000),optc varchar(1000),optd varchar(1000),correct varchar(1000),marks int(5),primary key(id))");
            stmt.executeUpdate("create table "+table+"(id int(10) auto_increment,question varchar(4000),opta varchar(1000),optb varchar(1000),optc varchar(1000),optd varchar(1000),correct varchar(1000),marks int(5),primary key(id))");
            stmt.executeUpdate("insert into examinfo values('"+table+"',300,5)");
            out.println("Added");
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
            throws ServletException, IOException  {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(createTest.class.getName()).log(Level.SEVERE, null, ex);
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
        }catch(ClassNotFoundException | SQLException ex) {
            Logger.getLogger(createTest.class.getName()).log(Level.SEVERE, null, ex);
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
