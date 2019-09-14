<%-- 
    Document   : review
    Created on : 23 Mar, 2019, 11:33:17 AM
    Author     : suvo
--%>

<%@page import="java.util.Enumeration"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@page errorPage="errorpage.jsp"%>
        <link rel="stylesheet" href="css/review.css">
        <title>Answer Review</title>
    </head>
    <body>
        <%
            String qtable = session.getAttribute("qtable").toString();
            //MySQL connectivity
            Class.forName("com.mysql.jdbc.Driver");
            Connection con=DriverManager.getConnection("jdbc:mysql://localhost/onlineexam","root","suvodip");
            //database=onlineexam, user=root, password=suvodip
                        
            //Oracle driver connectivity
            /*Class.forName("oracle.jdbc.driver.OracleDriver");   
            Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","user","password");*/
            
            Statement stmt=con.createStatement();
            String sub=session.getAttribute("sub").toString();
            ResultSet totalmarks=stmt.executeQuery("select obtained,total_marks from examsession where tname='"+qtable+"'");
            int total=0,obtained=0;
            while(totalmarks.next())
            {
                obtained=totalmarks.getInt(1);
                total=totalmarks.getInt(2);
            }
            ResultSet name=stmt.executeQuery("select name from user inner join examsession on id=sid where tname='"+qtable+"'");
        %>
        <div class="info">
            <div>
            <% while(name.next())
            { %>
                <div><b>Name : </b></div>
                <span><% out.println(name.getString(1).toUpperCase()); %></span>
            <% } %>
            </div>
            <% ResultSet info=stmt.executeQuery("select start,end from examsession where tname='"+qtable+"'"); %>
            <div>
                <div><b>Subject/Test : </b></div>
                <span><%= sub.toUpperCase() %></span>
            </div>
            <% while(info.next()){ %>
            <div>
                <div><b>Exam started at : </b></div>
                <span><%=info.getString(1)%></span>
            </div>
            <div>
                <div><b>Exam ended at : </b></div>
                <span><%=info.getString(2)%></span>
            </div>
            <% } %>
            <div>
                <div><b>Marks : </b></div>
                <span><%=obtained %> out of <%= total %></span>
            </div>
            
        </div>
        <div class="ans-field">
            <%
                ResultSet rs= stmt.executeQuery("select * from "+qtable);
                while(rs.next())
                {
                    String correct=rs.getString(7);
                    String choice=rs.getString(10);
            %>
            <div class="section">
                <h4><%out.println(rs.getString(2));%></h4>
                <div class="options">
                    <% for(int i=3;i<=6;i++){
                        if(rs.getString(i).equals(correct)&&rs.getString(i).equals(choice))
                            out.println("<div class=\"correct choice\">"+rs.getString(i)+"</div>");
                        else if(rs.getString(i).equals(choice)&&!rs.getString(i).equals(correct))
                            out.println("<div class=\"wrong choice\">"+rs.getString(i)+"</div>");
                        else
                            out.println("<div class=\"optn\">"+rs.getString(i)+"</div>");
                    } %>
                </div>
                <h4>Correct answer : <%=correct%></h4>
            </div>
            <% } %>
        </div>
        <div class="buttons">
            <a href="welcome.jsp" class="btn">Finish Review</a>
        </div>
        <% 
            session.invalidate();
        %>
    </body>
</html>
