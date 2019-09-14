/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function(){
    console.log("hi");
    $("#writecode").click(function(){
        x = $("#question").val();
        $("#question").val(x+" <pre><code>Enter Code Snippet Here</code></pre>");
    });
    $("#preserved").click(function(){
        x = $("#question").val();
        $("#question").val(x+" <pre>Enter expressions or specially formatted texts</pre>");
    });
    $(".radio-btn").each(function(){
        $(this).click(function(){
            optn=$(this).val();
            if($("#"+optn).val()==="")
            {
                alert("No value is set in this option! Please enter all data then click here");
                return false;
            }
            $("#correct").val($("#"+optn).val());
        });
    });
    $(".optn-area").each(function(){
        correct=$("#correct").val();
        if($(this).val()===correct)
        {
            optn_id=$(this).attr("id");
            $("#radio_"+optn_id).attr("checked","true");
        }   
    });
});
