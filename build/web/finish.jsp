<%-- 
    Document   : finish.jsp
    Created on : 17 Mar, 2019, 11:20:07 AM
    Author     : suvo
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Finish this test</title>
        <link rel="stylesheet" href="css/finish.css">
        <script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
        <script type="text/javascript" src="js/finish.js"></script>
    </head>
    <body>
        <%
            String qtable=session.getAttribute("qtable").toString();
            String time=session.getAttribute("time").toString();
            
            //MySQL connectivity
            Class.forName("com.mysql.jdbc.Driver");
            Connection con=DriverManager.getConnection("jdbc:mysql://localhost/onlineexam","root","suvodip");
            //database=onlineexam, user=root, password=suvodip
                        
            //Oracle driver connectivity
            /*Class.forName("oracle.jdbc.driver.OracleDriver");   
            Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","user","password");*/
            
            Statement stmt=con.createStatement();
            ResultSet rs=stmt.executeQuery("select choice from "+qtable);
            String sub=session.getAttribute("sub").toString();
            int i=1;
            String ans=null;
        %>
        <header>
            <h2>Finish <%=sub%> Test</h2>
        </header>
        <div class="container">
            <table>
                <tr>
                    <th>ID</th>
                    <th>Answer status</th>
                </tr>
                <%
                    while(rs.next()){
                %>
                <tr>
                    <td>
                        <% out.println("Question "+i); %>
                    </td>
                    <td>
                        <%  ans=rs.getString(1);
                            if(ans.equals("NA"))
                                out.println("Not Answered Yet");
                            else
                                out.println("Answered");
                        %>
                    </td>
                </tr>
                <% i++;
                    } %>
            </table>
        
            <div class="timer">
                <div class="time"></div>
            </div>
            <input type="hidden" name="time" id="examtime" value="<%=time%>">
            <div class="buttons"> 
                <button id="back" class="btn" value="Back to Attempt">Back to Attempt</button>
                <button id="finish" class="btn" value="Finish">Finish</button>
                <dialog id="confirm-finish">
                    <p>Confirm to end test</p>
                    <div>
                        <button id="yes" class="btn" value="y">Yes</button>
                        <button id="no" class="btn" value="n">No</button>
                    </div>
                </dialog>
            </div>
         </div>
    </body>
</html>
