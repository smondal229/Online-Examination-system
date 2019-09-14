<%-- 
    Document   : qupdate
    Created on : 10 Mar, 2019, 9:53:24 PM
    Author     : suvo
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/qstnOperation.css">
        <script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
        <script type="text/javascript" src="js/questionOperation.js"></script>
        <title>Update Question</title>
        
    </head>
    <body>
        <%
            String qdb=session.getAttribute("qdb").toString();
            String qid=request.getParameter("qid");
            //MySQL connectivity
            Class.forName("com.mysql.jdbc.Driver");
            Connection con=DriverManager.getConnection("jdbc:mysql://localhost/onlineexam","root","suvodip");
            Statement stmt = con.createStatement();
                        
            //Oracle driver connectivity
            /*Class.forName("oracle.jdbc.driver.OracleDriver");   
            Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","user","password");*/
            
            ResultSet rs =stmt.executeQuery("select * from "+qdb+" where id="+qid);
            while(rs.next())
            {
        %>
        <h2 class="header">Update Question</h2>
        <form action="QuestionOperations" class="form-group">
            <div>
                <input type="hidden" name="op" value="update">
                <input type="hidden" name="qid" value="<%=rs.getString(1)%>">
                
            </div>
            <div>
                <label for="question">Question name</label>
                <textarea id="question" name="qstn" required><%=rs.getString(2)%></textarea>
                <div class="buttons">
                    <button type="button" id="writecode">&#10094<strong> code <storng>&#10095</button>
                    <button type="button" id="preserved"><strong><i>{ expression }</i></strong></button>
                </div>
            </div>
            <div>    
            </div>
            <div>
                <label for="opta">Option A</label>
                <textarea id="opta" class="optn-area" name="opta" required><%=rs.getString(3)%></textarea>
            </div>
            <div>
                <label for="optb">Option B</label>
                <textarea id="optb" class="optn-area" name="optb" required><%=rs.getString(4)%></textarea>
            </div>
            <div>
                <label for="optc">Option C</label>
                <textarea id="optc" class="optn-area" name="optc" required><%=rs.getString(5)%></textarea>
            </div>
            <div>
                <label for="optd">Option D</label>
                <textarea id="optd" class="optn-area" name="optd"required><%=rs.getString(6)%></textarea>
            </div>
            <div>
                <label for="radio_opt">Correct Option</label>
                <br/>
                <br/>
                <input type="radio" id="radio_opta" class="radio-btn" name="options" value="opta" required>
                <label for="radio_opta">Option a</label>
                <input type="radio" id="radio_optb" class="radio-btn" name="options" value="optb">
                <label for="radio_optb">Option b</label>
                <input type="radio" id="radio_optc" class="radio-btn" name="options" value="optc">
                <label for="radio_optc">Option c</label>
                <input type="radio" id="radio_optd" class="radio-btn" name="options" value="optd">
                <label for="radio_optd">Option d</label>
                <input type="hidden" id="correct" name="correct" value="<%=rs.getString(7)%>">
            </div>
            <div>
                <label for="marks" >Marks</label>
                <input type="number" name="marks" min="1" max="10" value="5">
            </div>
            <div class="btn-div">
                <button type="submit" class="btn-lg">Update Question</button>
            </div>
        </form>
        <%}%>
    </body>
</html>
