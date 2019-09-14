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
import java.sql.PreparedStatement;
import java.sql.SQLException;
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
public class QuestionOperations extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.sql.SQLException
     * @throws java.lang.ClassNotFoundException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ClassNotFoundException,NullPointerException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            HttpSession session=request.getSession();
            String op=request.getParameter("op");
            String qdb=session.getAttribute("qdb").toString();
            //MySQL connectivity
            Class.forName("com.mysql.jdbc.Driver");
            Connection con=DriverManager.getConnection("jdbc:mysql://localhost/onlineexam","root","suvodip");
            //Oracle driver connectivity
            /*Class.forName("oracle.jdbc.driver.OracleDriver");   
            Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","user","password");*/
            out.println(op);
            switch (op) {
            //to insert new question
                case "insert":
                    String qstn=request.getParameter("qstn");
                    String opta=request.getParameter("opta");
                    String optb=request.getParameter("optb");
                    String optc=request.getParameter("optc");
                    String optd=request.getParameter("optd");
                    String correct=request.getParameter("correct");
                    int marks=Integer.parseInt(request.getParameter("marks"));
                    out.println("here1");
                    PreparedStatement ps=con.prepareStatement("insert into "+qdb+"(question,opta,optb,optc,optd,correct,marks) values(?,?,?,?,?,?,?)");
                    //ps.setString(1,qdb);
                    ps.setString(1,qstn);
                    ps.setString(2,opta);
                    ps.setString(3,optb);
                    ps.setString(4,optc);
                    ps.setString(5,optd);
                    ps.setString(6,correct);
                    ps.setInt(7,marks);
                    int i=ps.executeUpdate();
                    out.println("here2");
                    out.println(i);
                    session.setAttribute("msg","Inserted successfully");
                    response.sendRedirect("questions.jsp");
                    break;
                case "update"://update question
                    qstn=request.getParameter("qstn");
                    opta=request.getParameter("opta");
                    optb=request.getParameter("optb");
                    optc=request.getParameter("optc");
                    optd=request.getParameter("optd");
                    correct=request.getParameter("correct");
                    marks=Integer.parseInt(request.getParameter("marks"));
                    String qid=request.getParameter("qid");
                    int id=Integer.parseInt(qid);
                    out.println(id);
                    ps=con.prepareStatement("delete from "+ qdb+" where id=?");
                    ps.setInt(1,id);
                    i=ps.executeUpdate();
                    out.println(i+" deleted ");
                    ps=con.prepareStatement("insert into "+qdb+" values(?,?,?,?,?,?,?,?)");
                    ps.setInt(1,id);
                    ps.setString(2,qstn);
                    ps.setString(3,opta);
                    ps.setString(4,optb);
                    ps.setString(5,optc);
                    ps.setString(6,optd);
                    ps.setString(7,correct);
                    ps.setInt(8,marks);
                    i=ps.executeUpdate();
                    out.println(i+" updated");
                    session.setAttribute("msg","1 question updated successfully");
                    response.sendRedirect("questions.jsp");
                    break;
                case "delete":
                    qid=request.getParameter("qid");
                    ps=con.prepareStatement("delete from "+ qdb+" where id=?");
                    ps.setInt(1,Integer.parseInt(qid));
                    out.println(ps);
                    i=ps.executeUpdate();
                    out.println(i+" deleted");
                    session.setAttribute("msg","1 question deleted successfully");
                    response.sendRedirect("questions.jsp");
                    break;
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
        try {
            processRequest(request, response);
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(QuestionOperations.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(QuestionOperations.class.getName()).log(Level.SEVERE, null, ex);
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
