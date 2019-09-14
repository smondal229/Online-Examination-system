/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function(){
    $("#add").on("click",function(){
        x=$(this).parent("div");
        if($(this).attr("class")==="remove-new"){
            $(this).removeClass("remove-new");
            $(this).text("Add a new test");
            $(this).addClass("add-new");
            x.children("br").remove();
            $("#new-table").remove();
            $("#add-test").remove();
            $("#errormsg").remove();
        }
        else{
            $(this).removeClass("add-new");
            $(this).text("Write the test name here");
            $(this).addClass("remove-new");
            x.append("<br/><input type=text id='new-table'>");
            x.append("<span id='errormsg'></span>");
            x.append("<br/><button id='add-test'>Add Test</button>");
            
        }
        $("#new-table").keyup(function(){
            a = $(this).val().toLowerCase();
            $(".subject-link").each(function(){
                str=$(this).find("a").html().split(" ")[0];
                if(a===str){
                    console.log("if");
                    $("#new-table").after("<span id='errormsg'>Test name already exists!</span>");
                    return false;
                }
                else if(a.length == 0)
                {
                    $("#new-table").after("<span id='errormsg'>Test name can't be blank!</span>");
                    return false;
                }
                
                $("#errormsg").remove();
            });
        });
        $("#add-test").click(function(){
            y=$("#new-table").val();

            $.get("createTest",{"new":y},function(){
                $(".subject-link:last-child").before("<div class='subject-link'>\n\
                <a href='questions.jsp?qdb="+y+"'>"+y+" Questions</a></div>");
                $("#add").removeClass("remove-new");
                $("#add").text("Add a new test");
                $("#add").addClass("add-new");
                x.children("br").remove();
                $("#new-table").remove();
                $("#add-test").remove();
                $(".subject-link:nth-last-child(2)").css({
                    'animation':'animate 3s linear normal'
                });
            });
        });
    });
    
});

