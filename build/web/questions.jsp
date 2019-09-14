<%-- 
    Document   : questions
    Created on : 27 Feb, 2019, 1:11:28 PM
    Author     : suvo
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/table.css">
        <link rel="stylesheet" href="css/questions.css">
        <%
            String qdb=request.getParameter("qdb");
            if(qdb==null)
                qdb=session.getAttribute("qdb").toString();
            else
                session.setAttribute("qdb",qdb);
        %>
        <title><%=qdb.substring(0,1).toUpperCase()+qdb.substring(1)%> Question Page</title>
    </head>
    <body>
        <jsp:include page="header.jsp"/><%--navbar--%>
        <%
            //MySQL connectivity
            Class.forName("com.mysql.jdbc.Driver");
            Connection con=DriverManager.getConnection("jdbc:mysql://localhost/onlineexam","root","suvodip");
                        
            //Oracle driver connectivity
            /*Class.forName("oracle.jdbc.driver.OracleDriver");   
            Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","user","password");*/
            
            Statement stmt = con.createStatement();
            ResultSet rs2=stmt.executeQuery("select * from examinfo");
            int t=0;
            int no_of_que=0;
            while(rs2.next())
            {
                if(rs2.getString(1).equalsIgnoreCase("qdb"))
                no_of_que=rs2.getInt(3);
                t=rs2.getInt(2);
            }
            int hr=t/3600;
            int min=0;
            if(hr!=0)
                min=t%(hr*60);
            else
                min=t/60;
        %>
        
        <div class="info-container">
            <form class="form-group" action="timeset">
                <div>
                    <label for="noq">No of questions : </label>
                    <input type="number" name="noq" id="noq" min ="5" max="100" value="<%=no_of_que%>"></input>
                </div>
                <div>
                    <label for="hr">Time :  </label>
                    <input type="number" name="hour" id="hr" min=0 max=3 value="<%=hr%>" >
                    <label for="hr">hours </label>
                    <input type="number" name="min" id="min" min=0 max=59 value="<%=min%>">
                    <label for="min">minutes </label>
                </div>
                <div class="btn">
                    <input type="submit" value="Add / Update Time">
                </div>
            </form>
            <p>
                <%
                try{
                    String msgtop=session.getAttribute("updateinfo").toString();
                    out.println(msgtop);
                    session.removeAttribute("updateinfo");
                }catch(Exception e){}
                %>
            </p>
        </div>
        <table class="table-container">
            <caption><%=qdb%> question table</caption>
            <tr>
                <th>Questions</th>
                <th>Option a</th>
                <th>Option b</th>
                <th>Option c</th>
                <th>Option d</th>
                <th>Correct answer</th>
                <th>Marks</th>
                <th>Update Question</th>
                <th>Delete Question</th>
            </tr>
        <%//fetch questions
            
            ResultSet rs = stmt.executeQuery("select * from "+qdb);
            while(rs.next())
            {
        %>
            <tr>
                <td><%=rs.getString(2)%></td>
                <td><%=rs.getString(3)%></td>
                <td><%=rs.getString(4)%></td>
                <td><%=rs.getString(5)%></td>
                <td><%=rs.getString(6)%></td>
                <td><%=rs.getString(7)%></td>
                <td><%=rs.getString(8)%></td>
                <td><a href="qupdate.jsp?qid=<%=rs.getString(1)%>">Update</a></td>
                <td><a href="QuestionOperations?qid=<%=rs.getString(1)%>&op=delete">Delete</a></td>
            <% } %>
            </tr>
        </table>
        <div class="btn">
            <a href="qinsert.jsp" class="button-link">Insert question to this subject</a>
        </div>
        <%
            try{
                String msg=session.getAttribute("msg").toString();
        %>
        <div class="msginfo">
            <p><% 
            out.println(msg);
            session.removeAttribute("msg");
            }catch(Exception e){}%>
            </p>
        </div>
    </body>
</html>
