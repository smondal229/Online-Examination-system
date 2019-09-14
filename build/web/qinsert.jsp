<%-- 
    Document   : qinsert
    Created on : 10 Mar, 2019, 9:53:33 PM
    Author     : suvo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/qstnOperation.css">
        <script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
        <script type="text/javascript" src="js/questionOperation.js"></script>
        <title>Insert Question Here</title>	
    </head>
    <body>
        <h2 class="header">Insert Question here</h2>
        <form action="QuestionOperations" class="form-group">
            <input type="hidden" name="op" value="insert">
            <div>
                <label for="question">Question name</label>
                <textarea id="question" name="qstn" required></textarea>
                <div class="buttons">
                    <button type="button" id="writecode">&#10094<strong> code <storng>&#10095</button>
                    <button type="button" id="preserved"><strong><i>expression</i></strong></button>
                </div>
            </div>
            <div>
                <label for="opta">Option A</label>
                <textarea id="opta" name="opta" required></textarea>
            </div>
            <div>
                <label for="optb">Option B</label>
                <textarea id="optb" name="optb" required></textarea>
            </div>
            <div>
                <label for="optc">Option C</label>
                <textarea id="optc" name="optc" required></textarea>
            </div>
            <div>
                <label for="optd">Option D</label>
                <textarea id="optd" name="optd" required></textarea>
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
                <input type="hidden" id="correct" name="correct">
            </div>
            <div>
                <label for="marks" >Marks</label>
                <input type="number" name = "marks" min="1" max="10" value="5">
            </div>
            <div class="btn-div">
                <button type="submit" class="btn-lg">Add Question</button>
            </div>
        </form>
    </body>
</html>
