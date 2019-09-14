/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package exam;

import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.Math.random;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.Calendar;
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
public class starttest extends HttpServlet {

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
            throws ServletException, IOException, ClassNotFoundException, SQLException{
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            int time=0,no_of_que=0;
            
            //MySQL connectivity
            Class.forName("com.mysql.jdbc.Driver");
            Connection con=DriverManager.getConnection("jdbc:mysql://localhost/onlineexam","root","suvodip");
            //database=onlineexam, user=root, password=suvodip
            
            //Oracle driver connectivity
            /*Class.forName("oracle.jdbc.driver.OracleDriver");   
            Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","user","password");*/
            
            Statement stmt=con.createStatement();
            HttpSession session=request.getSession();
            String sub=request.getParameter("sub");
            String existing_table=request.getParameter("tname");
            session.setAttribute("sub",sub);
            String sid=session.getAttribute("sid").toString();
            if(existing_table!=null)
            {
                ResultSet t=stmt.executeQuery("select remaining,subject from examsession where tname='"+existing_table+"'");
                int time2=0;
                String subject=null;
                while(t.next())
                {
                    out.println(t.getInt(1));
                    time2 = t.getInt(1);
                    subject=t.getString(2);
                }
                ResultSet noq=stmt.executeQuery("select no_of_que from examinfo where sub='"+subject+"'");
                int n=0;
                while(noq.next())
                {
                    n=noq.getInt(1);
                }
                session.setAttribute("noq",n);
                session.setAttribute("time",time2);
                session.setAttribute("sub",subject);
                redirect(request,response,existing_table);
            }
            else{
            String questiondb=sub;
            ResultSet r=stmt.executeQuery("select time,no_of_que from examinfo where sub='"+questiondb+"'");
            while(r.next())
            {
                time=r.getInt(1);
                no_of_que=r.getInt(2); 
            }
            out.println(time+" "+no_of_que);
            int n =(int) ((random()*1000000)%1000000);
            session.setAttribute("time",time);
            session.setAttribute("noq",no_of_que);
            String tname="temp"+n;//if table exists try another
            //Starting datetime
            String datepattern="yyyy/MM/dd HH:mm:ss";
            DateFormat df= new SimpleDateFormat(datepattern);
            Date now= Calendar.getInstance().getTime();
            String timenow=df.format(now);
            out.println(timenow);
            //out.println("insert into examsession values('"+sid+"','"+tname+"','"+timenow+"','NA',"+time+",'"+sub+"',0,0)");
            //out.println(tname+" "+timenow);;
            stmt.executeUpdate("insert into examsession values('"+sid+"','"+tname+"','"+timenow+"','NA',"+time+",'"+sub+"',0,0)");
            //Query for MySQL below
            stmt.executeUpdate("create table "+tname+" as select * from "+questiondb+" order by rand() limit "+no_of_que);
            //Query for Oracle below
            //stmt.executeUpdate("create table "+tname+" as select * from (select * from "+questiondb+" order by dbms_random.value) where rownum<="+no_of_que);
            stmt.executeUpdate("alter table "+tname+" add column marks_obt int(5)");
            stmt.executeUpdate("update "+tname+" set marks_obt=0");
            stmt.executeUpdate("alter table "+tname+" add column choice varchar(200)");
            stmt.executeUpdate("update "+tname+" set choice='NA'");
            redirect(request,response,tname);
            }
        }
    }
    void redirect(HttpServletRequest request, HttpServletResponse response,String tname) throws ServletException, IOException {
            HttpSession session=request.getSession();
            session.setAttribute("qno",0);
            session.setAttribute("qtable", tname);
            response.sendRedirect("test.jsp");
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
            Logger.getLogger(starttest.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(starttest.class.getName()).log(Level.SEVERE, null, ex);
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
