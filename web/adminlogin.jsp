<%-- 
    Document   : adminlogin
    Created on : 27 Feb, 2019, 12:03:10 PM
    Author     : suvo
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
        <script type="text/javascript" src="js/adminpage.js"></script>
        <link rel="stylesheet" href="css/adminlogin.css">
        <title>Admin Page</title>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <header>
            <h2>Welcome Admin</h2>
        </header>
        <div class="student-link">
            <a href="viewstudentinfo.jsp">View Student Information</a>
        </div>
        <% 
            //MySQL connectivity
            Class.forName("com.mysql.jdbc.Driver");
            Connection con=DriverManager.getConnection("jdbc:mysql://localhost/onlineexam","root","suvodip");
                        
            //Oracle driver connectivity
            /*Class.forName("oracle.jdbc.driver.OracleDriver");   
            Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","user","password");*/
            
            Statement stmt = con.createStatement();
            ResultSet rs=stmt.executeQuery("select sub from examinfo");
        %>
        <div class="subjects">
            <%  while(rs.next()){ %>
            <div class="subject-link"><a href="questions.jsp?qdb=<%=rs.getString(1)%>"><%=rs.getString(1)+" Questions"%></a></div>
            <% } %>
            <div class="subject-link"><a href="javascript:void(0)" id="add" class="add-new"> Add a new test</a></div><!--create new tables-->
        </div>
    </body>
</html>
