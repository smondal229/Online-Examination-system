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
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author suvo
 */
public class saveans extends HttpServlet {
    
    @Override
    public void init(){
        
    }
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
            HttpSession session = request.getSession();
            String time=request.getParameter("time");
            String qnav=request.getParameter("qnav");
            String end=request.getParameter("end");
            int qno = Integer.parseInt(request.getParameter("qno"));
            int id=Integer.parseInt(request.getParameter("qid"));
            String ans=request.getParameter("ans");
            String correct=request.getParameter("correct");
            String qtable=session.getAttribute("qtable").toString();
            
            //MySQL connectivity
            Class.forName("com.mysql.jdbc.Driver");
            Connection con=DriverManager.getConnection("jdbc:mysql://localhost/onlineexam","root","suvodip");
            //database=onlineexam, user=root, password=suvodip
            
            //Oracle driver connectivity
            /*Class.forName("oracle.jdbc.driver.OracleDriver");   
            Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","user","password");*/
            
            Statement stmt=con.createStatement();
            ResultSet rs=stmt.executeQuery("select marks from "+qtable+" where id="+id);
            int marks=0;
            while(rs.next())
            {
                marks=rs.getInt(1);
            }
            int marks_obt;
            if(ans==null)
            {
                ans="NA";
                marks_obt=0;
            }
            else if(ans.equals(correct))
                marks_obt=marks;
            else
                marks_obt=0;
            out.println("update "+qtable+" set marks_obt = "+marks_obt+" where id="+id);
            int i=stmt.executeUpdate("update "+qtable+" set marks_obt = "+marks_obt+" where id="+id);   //got something wrong in space seperated answers
            int j=stmt.executeUpdate("update "+qtable+" set choice ='"+ans+"' where id="+id);
            out.println(i+" "+j);
            if(end.equals(""))
            {
                if(qnav.equals(""))    
                {
                    out.println(qno);
                    qno+=1;//next question no
                }
                else
                    qno=Integer.parseInt(qnav)-1;
            }
            stmt.executeUpdate("update examsession set remaining="+time+" where tname='"+qtable+"'");
            session.setAttribute("qno",qno);
            session.setAttribute("time",time);
            if(end.equals(""))
            {
                if(qno<=4)
                    response.sendRedirect("test.jsp");
                else if(qno>4)
                {
                    qno=4;//last question
                    session.setAttribute("qno",qno);
                    response.sendRedirect("finish.jsp");
                }
            }
            else
            {
                response.sendRedirect("finish.jsp");
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
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(saveans.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(saveans.class.getName()).log(Level.SEVERE, null, ex);
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
