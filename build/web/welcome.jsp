<%-- 
    Document   : welcome.jsp
    Created on : 15 Feb, 2019, 5:32:55 PM
    Author     : suvo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/login.css">
        <script src="js/jquery-3.3.1.min.js"></script>
        <script src="js/login.js"></script>
        <title>Welcome to online exam portal</title>
    </head>
    <body>
        <header>
            <h1>Welcome to online exam portal</h1>
        </header>
        <%
            Cookie cookie = null;
            Cookie[] cookies=null;
            cookies=request.getCookies();
            if(cookies!=null)
            {
                for(Cookie c : cookies)
                {
                    if(c.getName().equals("roll"))
                    { 
                        String id=c.getValue();
                        if(id.equals("admin")){
                            session.setAttribute("sid",id);
                            response.sendRedirect("adminlogin.jsp");
                        }
                        else{
                            session.setAttribute("sid",id);
                            response.sendRedirect("studentlogin.jsp");
                        }
                    }
                }
            }
        %>
        <%  
            String msglog="";
            try{
                msglog=session.getAttribute("msglog").toString();
                session.removeAttribute("msglog");
            }catch(Exception e){}
        %>
        <div class="container">
            <div class="card">
                <div class="login">
                    <form action ="login" method="post" id="log">
                        <div>
                            <label for="login">Roll Number</label><br/>
                            <input type="text" id="login" name="id" autocomplete="off"/>
                        </div>
                        <span class="errorid"></span>
                        <div>
                            <label for="pass">Password</label><br/>
                            <input type="password" id="pass" name="passwd" autocomplete="off"/>
                        </div>
                        
                        <div class="buttons">
                            <button type="submit" form="log">Login</button>
                            <span>--OR--</span>
                            <button id="flip-register" type="button">Register now</button>
                        </div>
                        <span class="errorlog"><%=msglog%></span>   
                    </form>
                </div>
                <%  
                    String msg="";
                    try{
                        msg=session.getAttribute("msg").toString();
                        session.removeAttribute("msg");
                    }catch(Exception e){}
                %>
                <div class="register">
                    <form action="register" method="post" id="reg">
                        <div>
                            <label for="name">Full Name</label><br/>
                            <input type="text" id="name" name="name" pattern="^([a-zA-Z'-]+\s){1,4}[a-zA-z]+$"/>
                        </div>
                        <div>
                            <label for="roll">University Roll Number</label><br/>
                            <input type="text" id="roll" name="roll" pattern="^([1-2]{1})([5-9]{2})([0-9]{8})$"/>
                        </div>
                        <div>
                            <label for="phone">Contact No</label><br/>
                            <input type="text" id="phone" name="phone" pattern="^([6-9]{1})([2-9]{1})([0-9]{8})$"/>
                        </div>
                        <div>
                            <label for="email">Email</label><br/>
                            <input type="email" id="email" name="email" required/>
                        </div>
                        <div>
                            <label for="passwd1">Choose password</label><br/>
                            <input type="password" id="passwd1" name="password"/>
                        </div>
                        <div>
                            <label for="passwd2">Confirm Password</label><br/>
                            <input type="password" id="passwd2" required/>
                        </div>
                        <div class="buttons">
                            <button type="submit" form="reg">Register</button>
                            <span>--OR--</span>
                            <button id="flip-login" type="button">Go back to Login</button>
                        </div>
                        <span class="error"><%=msg%></span>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
