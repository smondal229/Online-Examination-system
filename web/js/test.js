/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function(){
    //openFullScreen();
    //select existing choice
    var cheat=0;
    
    selectOption();
    y=document.querySelector('.time');
    total=document.querySelector("#examtime").value;
    t=total;
    s=setInterval(timer,1000);
    $("#finishexam").click(function(){
        $("#endtest").val("end");
        console.log($("#endtest").val());
        f=document.getElementById("QuestionForm");
        f.submit();
    });
    $(window).on("blur",function(){
        cheat+=1;
        alert("Your exam may get cancelled if you move from this page!");
        if(cheat===3){
            /*$("#endtest").val("end");
            console.log($("#endtest").val());
            f=document.getElementById("QuestionForm");
            f.submit();*/
            window.location.href="review?time="+t;
        }
    });
});

function timer(){
  if(t===10)
  {
      $(".timer").css({
          "background-color":"#ffffff",
          "color":"#ff530f",
          "animation": "animate2 1s linear infinite"
      });
  }
  if(t===0)
    clearInterval(s);
  hr=Math.floor(t/3600).toString();
  min=Math.floor((t%3600)/60).toString();
  sec=Math.round(t%60).toString();
  console.log(min);
  hr=(hr.length===1)?hr+"0":hr;
  if(min.length===1)
    min='0'+min;
  if(sec.length===1)
    sec='0'+sec;
  y.innerHTML=hr+":"+min+":"+sec;
  document.querySelector("#examtime").value=t;
  t-=1;

}
function openFullScreen() {
    // Supports most browsers and their versions.
    var docElm = document.documentElement;
    if (docElm.requestFullscreen) {
        docElm.requestFullscreen();
    }
    else if (docElm.mozRequestFullScreen) {
        docElm.mozRequestFullScreen();
    }
    else if (docElm.webkitRequestFullScreen) {
        docElm.webkitRequestFullScreen();
    }
    else if (docElm.msRequestFullscreen) {
        docElm.msRequestFullscreen();
    }
}
function selectOption()
{
    console.log("hi");
    var ch=document.getElementById("mychoice");
    x=ch.value;
    y=document.getElementsByName("ans");
    for(let i of y)
    {
        //console.log(x+" "+i.value);
        //console.log(i.checked);
        if(x===i.value)
            i.checked="True";
    }
}
function getNav(x){
    qnav=x.innerHTML.trim();
    nav=document.getElementById("qnav");
    nav.value=qnav;
    console.log(nav.value);
    f=document.getElementById("QuestionForm");
    f.submit();
}
