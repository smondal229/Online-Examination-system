<%-- 
    Document   : test
    Created on : 10 Mar, 2019, 10:13:44 AM
    Author     : suvo
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/test.css">
        <script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
        <script type="text/javascript" src="js/test.js"></script>
        <title>Test Page</title>
    </head>
    <body>
        <%
            String qtable=session.getAttribute("qtable").toString();
            String time=session.getAttribute("time").toString();
            int qno=Integer.parseInt(session.getAttribute("qno").toString());
            //MySQL driver connectivity
            Class.forName("com.mysql.jdbc.Driver");
            Connection con=DriverManager.getConnection("jdbc:mysql://localhost/onlineexam","root","suvodip");
            //Oracle driver connectivity
            /*Class.forName("oracle.jdbc.driver.OracleDriver");   
            Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","user","password");*/
            Statement stmt=con.createStatement();
        %>
        
        <div class="container">
            <div class="header">
                <h2>Question <%=(qno+1)%></h2>
            </div>
            <%
            ResultSet rs2=stmt.executeQuery("select choice from "+qtable);
            int i=0;
            %>
            <div class="nav-menu">
                <div class="title"><div class="heading">QUESTION NAVIGATOR</div></div>
                <div class="navigator">
                <%
                    while(rs2.next()){
                        if(qno==i)
                            out.println("<a href=\"javascript:void(0)\" id=q"+i+" value="+i+" class=\"navbutton active\" onclick=\"getNav(this)\">"+(i+1)+"</a>");
                        else if(rs2.getString(1).equals("NA"))
                            out.println("<a href=\"javascript:void(0)\" id=q"+i+" value="+i+" class=\"navbutton\" onclick=\"getNav(this)\">"+(i+1)+"</a>");
                        else
                            out.println("<a href=\"javascript:void(0)\" id=q"+i+" value="+i+" class=\"navbutton answered\" onclick=\"getNav(this)\">"+(i+1)+"</a>");
                        i++;
                    } 
                %>
                </div>
            </div>
            <div class="questionarea">
                <form action="saveans" method="post" id="QuestionForm">
                    <input type="hidden" name="qnav" id="qnav">
                    <input type="hidden" name="time" id="examtime" value=<%=time%> >
                    <input type="hidden" name="qno" value=<%=qno%> >
                <%  
                    //Query only for MySQL below
                    ResultSet rs=stmt.executeQuery("select * from "+qtable+" limit 1 offset "+qno);
                    //Query for oracle below
                    //ResultSet rs=stmt.executeQuery("select * from "+qtable+" where rownum ="+qno);
                    while(rs.next()){ 
                %>
                    <input type="hidden" name="qid" value=<%=rs.getString(1)%> >
                    <div class="question">
                        <h4><%=rs.getString(2)%></h4>
                    </div>
                    <input type="hidden" name="choice" id="mychoice" value="<%=rs.getString(10)%>" >
                    <div><input type="radio" id="op1"name="ans" value="<%=rs.getString(3)%>" ><label for="op1"><%=rs.getString(3)%></label></div>
                    <div><input type="radio" id="op2" name="ans" value="<%=rs.getString(4)%>" ><label for="op2"><%=rs.getString(4)%></div>
                    <div><input type="radio" id="op3" name="ans" value="<%=rs.getString(5)%>" ><label for="op3"><%=rs.getString(5)%></div>
                    <div><input type="radio" id="op4" name="ans" value="<%=rs.getString(6)%>" ><label for="op4"><%=rs.getString(6)%></div>
                    <input type="hidden" name="correct" value="<%=rs.getString(7)%>" >
                    <% } %>
                    <input type="hidden" name="end" id="endtest" value="">
                    <div class="buttons">
                        <input type="submit" class="btn" value="Next">
                        <button id="finishexam" type="button" class="btn" name="finish" value="finish">Finish</button>
                    </div>
                </form>
            </div>  
            <div class="timer">
                <div class="time"></div>
            </div>
        </div>
    </body>
</html>
