$(document).ready(function(){
  $("td.book-title").click(function(){
    $("div[id=" + $(this)[0].id + "]").slideToggle("slow");
    console.log($(this)[0].id)
  }); 

});

