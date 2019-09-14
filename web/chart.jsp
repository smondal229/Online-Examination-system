<%-- 
    Document   : chart
    Created on : 31 Mar, 2019, 10:58:46 AM
    Author     : suvo
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
        <script type="text/javascript" src="js/Chart.bundle.js"></script>
        <title>JSP Page</title>
    </head>
    <body>
        <style>
            .container{
                display:flex;
            }
            #chartsub{
                margin:auto;
                border : 1px solid transparent;
                padding: 0.3em 0.8em;
                border-radius : 3px;
                color:#ffffff;
                background-color: rgba(0,0,0,0.8);
                box-shadow : 0 0 1em rgba(0,0,0,0.5);
            }
            .chart-container{
                margin:auto;
                
                max-width:800px;
                width:100%;
            }
            @media only screen and (max-width:1024px){
                .container{
                    display :grid;
                }
            }
        </style>
        <%
            String id=null;
            try{
                id=session.getAttribute("sid").toString();
            }catch(Exception e){
                id=request.getParameter("id");
                out.println(id);
            }
            String chart=request.getParameter("chart");
            if(chart==null)
                chart="aptitude";
            
            //MySQL connectivity
            Class.forName("com.mysql.jdbc.Driver");
            Connection con=DriverManager.getConnection("jdbc:mysql://localhost/onlineexam","root","suvodip");
            //database=onlineexam, user=root, password=suvodip
                        
            //Oracle driver connectivity
            /*Class.forName("oracle.jdbc.driver.OracleDriver");   
            Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","user","password");*/
            
            Statement stmt=con.createStatement();
            ResultSet sub=stmt.executeQuery("select distinct(subject) from examsession");
            %>
            <div class ="container">
                <input type="hidden" id="chart" value="<%=chart%>">
                <select id="chartsub">
                <%
                while(sub.next())
                {%>
                    <option value="<%=sub.getString(1)%>"><%=sub.getString(1).toUpperCase()%></option>
                <% }%>
                </select>
                <%
                ResultSet m_percent=stmt.executeQuery("select subject,end, total_marks,obtained from examsession where sid='"+id+"' and subject='"+chart+"'and not end='NA' order by end");
            
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
                let chartsub=$("#chartsub option:selected").val();
                location.href='studentlogin.jsp?chart='+chartsub;
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
                type: 'line',
                
                // The data for our dataset
                data: {
                    labels: dates,
                    datasets: [{
                        label : 'Marks Percentage',
                        backgroundColor:
                            'rgba(0, 93, 130,0.7)',
                        borderColor: 'rgb(0, 93, 130)',
                        data: marks
                    }]
                },
                
                // Configuration options go here
                options: {
                    title : {
                        display:true,
                        text : 'Performance at '+chartsub.charAt(0).toUpperCase()+chartsub.slice(1)+' Test',
                        fontSize :20,
                        fontColor:'#005d82'
                    },
                    legend : 
                        {
                            display:false
                        },
                    scales: {
                        xAxes: [{
                            type: 'time',
                            distribution: 'linear',
                            time: {
                                unit : 'day'
                            },
                            ticks: {
                                source : 'labels'
                            }
                        }],
                        yAxes: [{
                            ticks: {
                                beginAtZero: true
                                }
                            }]
                        }
                    }
            });
        </script>
    </body>
</html>
