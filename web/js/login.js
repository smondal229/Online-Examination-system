$(document).ready(function(){
  x=document.querySelector("#flip-register");
  y=document.querySelector(".card");
  z=document.querySelector("#flip-login");
  x.addEventListener("click",function(){
    if($("input").val()!==""){
        $(this).css({"height":"100%"});
        $(this).siblings("label").css({"font-size":"0.8em","opacity":"1","color":"#0f87aa"});
    }
    y.style.transform="rotateY(180deg)";
  });
  z.addEventListener("click",function(){
    if($("input").val()!==""){
        $(this).css({"height":"100%"});
        $(this).siblings("label").css({"font-size":"0.8em","opacity":"1","color":"#0f87aa"});
    }
    y.style.transform="rotateY(0deg)";
  });
  $("input").focus(function(){
      $(this).css({"height":"100%","color":"black"});
      $(this).siblings("label").css({"font-size":"0.8em","opacity":"1","color":"#0f87aa"});
  });
  $("input").blur(function(){
    if($(this).val()===""){
      $(this).css("height","0px");
      $(this).siblings("label").css({"font-size":"1.2em","opacity":"0.5","color":"black"});
    }
  });
  $("#passwd2").change(function(){
     if($(this).val()===$("#passwd1").val())
     {
         console.log("correct");
     }
  });
});