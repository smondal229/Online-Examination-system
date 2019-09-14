<%-- 
    Document   : viewstudentinfo
    Created on : 1 Mar, 2019, 12:13:39 AM
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
        <link rel="stylesheet" href="css/table.css">
        <title>View Student information</title>
    </head>
    <body>
        <%
            //MySQL connectivity
            Class.forName("com.mysql.jdbc.Driver");
            Connection con=DriverManager.getConnection("jdbc:mysql://localhost/onlineexam","root","suvodip");
            //database=onlineexam, user=root, password=suvodip
                        
            //Oracle driver connectivity
            /*Class.forName("oracle.jdbc.driver.OracleDriver");   
            Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","user","password");*/
            
            Statement stmt=con.createStatement();
            ResultSet rs=stmt.executeQuery("select * from user");
        %>
        <jsp:include page="header.jsp"/>
        <table class="table-container">
            <caption>Student information</caption>
            <tr>
                <th>Name</th>
                <th>Roll number</th>
                <th>Email-id</th>
                <th>Contact number</th>
                <th>Results</th>
            </tr>
            <% 
                while(rs.next())
                {
            %>
            <tr>
                <td><%=rs.getString(1)%></td>
                <td><%=rs.getString(2)%></td>
                <td><%=rs.getString(4)%></td>
                <td><%=rs.getString(5)%></td>
                <td><a href="results.jsp?id=<%=rs.getString(2)%>&chart=aptitude">Click to view</a></td>
            </tr>
            <%
                }
            %>
            
        </table>
        
    </body>
</html>
