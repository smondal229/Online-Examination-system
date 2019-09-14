/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
window.addEventListener("load",function(event){
    y=document.querySelector('.time');
    total=document.querySelector("#examtime").value;
    //console.log(document.getElementById("back"));
    t=total;
    s=setInterval(timer,1000);
    
    document.getElementById("back").addEventListener("click",function(){
        time=document.querySelector("#examtime").value;
        window.location.href="finish?back=1&time="+time;
    });
    
    $("#finish").click(function(){
        $("#confirm-finish").attr('open','');
    });
    
    $("#no").on("click",function(){
        $("#confirm-finish").removeAttr('open');
    });
    $("#yes").on("click",function(){
        time=document.querySelector("#examtime").value;
        window.location.href="review?time="+time;
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
  hr=(hr.length===1)?hr+"0":hr;
  if(min.length===1)
    min='0'+min;
  if(sec.length===1)
    sec='0'+sec;
  y.innerHTML=hr+":"+min+":"+sec;
  document.querySelector("#examtime").value=t;
  t-=1;
}
