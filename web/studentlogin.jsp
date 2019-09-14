<%-- 
    Document   : studentlogin
    Created on : 22 Feb, 2019, 11:45:39 PM
    Author     : suvo
--%>

<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/table.css">
        <link rel="stylesheet" href="css/studentlogin.css">
        <script src="js/jquery-3.3.1.min.js"></script>
        <script>
            $(document).ready(function(){
                $(".examinfo").hide();
                $(".examlink").hover(function(){
                    $(this).children(".examinfo").slideToggle(300); 
                });
            });
        </script>
        <title>Student Dashboard</title>
    </head>
    <body>
        <jsp:include page= "header.jsp"/>
        <% 
            try{
            String msg = session.getAttribute("msg").toString();
            session.removeAttribute("msg");
            }catch(Exception e){}
            
            String id=session.getAttribute("sid").toString();
            //MySQL connectivity
            Class.forName("com.mysql.jdbc.Driver");
            Connection con=DriverManager.getConnection("jdbc:mysql://localhost/onlineexam","root","suvodip");
            //database=onlineexam, user=root, password=suvodip
                        
            //Oracle driver connectivity
            /*Class.forName("oracle.jdbc.driver.OracleDriver");   
            Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","user","password");*/
            
            Statement stmt=con.createStatement();
            Statement stmt2=con.createStatement();
            ResultSet rs=stmt.executeQuery("select name from user where id='"+id+"'");
            String name=null;
            while(rs.next())
            {
                name=rs.getString(1);
            }
        %>
        
        <div class="studentinfo">
            <h3>Profile Information</h3>
            <p><b>Name : </b> <%=name%></p>
            <%
                ResultSet r=stmt.executeQuery("select start,subject from examsession where start=(select max(start) from examsession where sid='"+id+"')");
                while(r.next()){
            %>
            <p><b>Last attempted test : </b><%=r.getString(1)%> <%=r.getString(2).substring(0,1).toUpperCase()+r.getString(2).substring(1)%></p>
            <% } %>
            <jsp:include page= "chart.jsp" />
        </div>
        <%
                ResultSet expire=stmt.executeQuery("select * from examsession where sid='"+id+"' and end='NA'");
                while(expire.next()){
                    DateFormat sdf=new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
                    DateFormat df=new SimpleDateFormat("yyyy-MM-dd");
                    Date d=sdf.parse(expire.getString(3).toString());
                    Date d2=Calendar.getInstance().getTime();
                    String now=df.format(d2);
                    String start=df.format(d);
                    LocalDate ld_start=LocalDate.parse(start);
                    LocalDate ld_now=LocalDate.parse(now);
                    long noOfDays= ChronoUnit.DAYS.between(ld_start, ld_now);
                    if(noOfDays>1)
                    {
                        out.println("delete from examsession where tname='"+expire.getString(2)+"'");
                        stmt2.executeUpdate("delete from examsession where tname='"+expire.getString(2)+"'");
                    }
                }
        %>
        <div class="incomplete-test">
            <%
                ResultSet rs2=stmt.executeQuery("select * from examsession where sid='"+id+"' and end='NA'");
            %>
            
            <% if(rs2.next()){ %>
            <p><em>Reminder : You left some tests incomplete</em></p>
            <span class="incomlete-links"><%=rs2.getString(6)%> exam started at <%=rs2.getString(3)%> <a href="starttest?tname=<%=rs2.getString(2).toString()%>">Continue test</a></span><!--existed test to be added-->
            <%
                
                }
            while(rs2.next()){

            %>
                <span class="incomlete-links"><%=rs2.getString(6)%> exam started at <%=rs2.getString(3)%> <a href="starttest?tname=<%=rs2.getString(2).toString()%>">Continue test</a></span><!--existed test to be added-->
            <% } %>
        </div>
        <%
            ResultSet subs=stmt.executeQuery("select sub,no_of_que,time from examinfo");
        %>
        <div class="link-container">
            <%  while(subs.next()){ 
                    ResultSet count_que=stmt2.executeQuery("select count(question) from "+subs.getString(1));
                    count_que.next();
                    if(count_que.getInt(1)>=Integer.parseInt(subs.getString(2)))
                    {
            %>
            <div class="examlink">
                    <a href= "starttest?sub=<%=subs.getString(1)%>"><%=subs.getString(1)%></a>
                <div class="examinfo">
                    <%
                        int time=Integer.parseInt(subs.getString(3));
                        int hr=0,min=0;
                        String t="";
                        if(time>3600)
                        {
                           hr=time/3600;
                           min=time%3600;
                           min/=60;
                           t=hr+" hours "+min +" minutes "; 
                        }
                        else{
                            min=time/60;
                            t=min +" minutes ";
                        }
        
                    %>
                    <span>Time : <%=t%></span>
                    <span>Questions : <%=subs.getString(2)%></span>
                </div>
            </div>
            <% } %>
            <%  }   %>
        </div>
    </body>
</html>
