<%-- 
    Document   : results
    Created on : 1 Mar, 2019, 11:12:32 AM
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
        <script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
        <script type="text/javascript" src="js/Chart.bundle.js"></script>
        <title>Student's result</title>
    </head>
    <style>
        body{
            font-family: sans-serif;
        }
        .header{
            color: #666;
            text-align: center;
        }
        .select-box{
            margin:3em;
            position:relative;
        }
        .select-box select{
            min-width:200px;
            background:#d8f4ff;
            border:1px solid #005d82;
            border-radius:5px;
            padding:.3em 0.8em;
            color:#005d82;
            text-align: center;
            font-weight:bold;
        }
        #chartsub:selected::after{
            position: absolute;
            content: "suv";
            top: 14px;
            left: 10px;
            width:2em;
            height:2em;
            border: 6px solid transparent;
            border-color: #fff transparent transparent transparent;
            z-index:100;
        }
        .chart-container{
            display:block;
            margin:0 auto;
        max-width:800px;
        }     
    </style>
    <body>
        <%
            String id = request.getParameter("id");
            if(id==null)
            {
                id=session.getAttribute("sid").toString();
            }
            //MySQL connectivity
            Class.forName("com.mysql.jdbc.Driver");
            Connection con=DriverManager.getConnection("jdbc:mysql://localhost/onlineexam","root","suvodip");
            //database=onlineexam, user=root, password=suvodip
                        
            //Oracle driver connectivity
            /*Class.forName("oracle.jdbc.driver.OracleDriver");   
            Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","user","password");*/
            
            Statement st=con.createStatement();
            ResultSet rs=st.executeQuery("select name from user where id='"+id+"'");
            String name=null;
            while(rs.next())
                name=rs.getString(1);
        %>
        <jsp:include page="header.jsp"/>
        <input type="hidden" id="sid" value="<%=id%>">
        <h2 class="header">Student (Roll number: <%=id%>) Result</h2>
        <%
            String chart=request.getParameter("chart");
            if(chart==null)
                chart="aptitude";
            //database=onlineexam, user=root, password=suvodip
            ResultSet sub=st.executeQuery("select distinct(subject) from examsession where sid='"+id+"'");
        %>
        <input type="hidden" id="chart" value="<%=chart%>">
        <div class="select-box">
        <label for="chartsub">Select a Subject here: </label>
        <select id="chartsub">
            <%
            while(sub.next())
                {
            %>
                <option value="<%=sub.getString(1)%>"><%=sub.getString(1).toUpperCase()%></option>
            <%  } %>
            </select>
        </div>
        <!--code for chart ends here-->
        <table class="table-container">
            <tr>
                <td colspan="3">Name : <%=name%></td>
                <td colspan="2">Roll : <%=id%></td>
            </tr>
            <tr class="table-heading">
                <th>Subject</th>
                <th>Start time</th>
                <th>End time</th>
                <th>Obtained Marks</th>
                <th>Total Marks</th>
            </tr>
        <%
            rs = st.executeQuery("select * from examsession where end<>'NA' and sid='"+id+"' and subject='"+chart+"'");
            while(rs.next())
            {
        %>
        <tr>
            <td><%=rs.getString(6).toUpperCase()%></td>
            <td><%=rs.getString(3)%></td>
            <td><%=rs.getString(4)%></td>
            <td><%=rs.getString(7)%></td>
            <td><%=rs.getString(8)%></td>
        </tr>
        <%
            }
        %>
        </table>
            <%
            ResultSet m_percent=st.executeQuery("select subject,end, total_marks,obtained from examsession where sid='"+id+"' and subject='"+chart+"'and not end='NA' order by end");
            
            while(m_percent.next()){
                float m=0;
                String d=m_percent.getString(2);
                String s=m_percent.getString(1);
                try{
                    m=m_percent.getInt(4)/(float)(m_percent.getInt(3))*100;
                }catch(Exception e){};
            %>
            <input type="hidden" name="marks" value="<%=m %>">
            <input type="hidden" name="dates" value="<%=d %>">
            <input type="hidden" name="subject" value="<%=s %>">
            <%
                }
            %>
            <div class="chart-container">
                <canvas id="myChart" ></canvas>
            </div>
        <script>
            $(document).ready(function(){
                $("#chartsub option").each(function(i,e){
                    if($(e).val()===$("#chart").val())
                    {
                        //console.log($(e).val());
                        $("#chartsub").prop('selectedIndex',i);;
                    }
                });
            });
            $("#chartsub").change(function(){
                let id=$("#sid").val();
                let chartsub=$("#chartsub option:selected").val();
                location.href='results.jsp?id='+id+'&chart='+chartsub;
            });
            
            var chartsub=$("#chart").val();
            var x = document.getElementsByName("marks");
            var d= document.getElementsByName("dates");
            var s= document.getElementsByName("subject");
            marks=new Array();
            for(let i of x)
            {
                marks.push(i.value);
            }
            dates=new Array();
            for(let i of d)
            {
                if(!Date.parse(i.value).isNaN)
                    dates.push(Date.parse(i.value));
            }
            subjects=new Array();
            for(let i of s)
            {
                subjects.push(i.value);
            }
            var ctx = document.getElementById('myChart').getContext('2d');
            var chart = new Chart(ctx, {
            // The type of chart we want to create
                type: 'bar',
                
                // The data for our dataset
                data: {
                    labels: dates,
                    datasets: [{
                        label : 'Marks Percentage',
                        backgroundColor:
                            '#87d9ff',
                        borderColor: '#87d9ff',
                        data: marks
                    }]
                },
                
                // Configuration options go here
                options: {
                    title : {
                        display:true,
                        text : 'Performance at '+chartsub.charAt(0).toUpperCase()+chartsub.slice(1)+' Test',
                        fontSize :20
                    },
                    legend : 
                        {
                            display:false
                        },
                    scales: {
                        xAxes: [{
                            type: 'time',
                            distribution: 'Series',
                            time: {
                                unit : 'day'
                            },
                            ticks: {
                                source : 'labels'
                            },
                            scaleLabel: {
                                display: true,
                                labelString: 'Date of Attempt'
                            }
                        }],
                        yAxes: [{
                            ticks: {
                                beginAtZero: true
                                },
                            scaleLabel: {
                                    display: true,
                                    labelString: 'Marks in percentage(%)'
                                }
                            }]
                        }
                    }
            });
        </script>
    </body>
</html>
