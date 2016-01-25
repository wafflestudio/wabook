$(document).ready(function() {
  $("#book_isbn").focus().bind('blur', function() {
    $(this).focus();            

  }); 

  $("html").click(function() {
    $("#book_isbn").val($("#book_isbn").val()).focus();

  });  

  //disable the tab key
  $(document).keydown(function(objEvent) {
    if (objEvent.keyCode == 9) {  //tab pressed
      objEvent.preventDefault(); // stops its action
    }
  })      
});
