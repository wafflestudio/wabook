$(document).ready(function(){
  $("td.book-title").click(function(){
    var book_id = $(this).parent().data("book_id");
    $("#book_data_" + book_id).slideToggle("slow");
    console.log($(this).parent())
    console.log(book_id)
    //$(this).data("book_id").slideToggle("slow");
  }); 

  $("button.delete").click(function(){
    console.log(this)
    var book_id = $(this).parent().parent().data("book_id");
    $.get('/delete_book/' + book_id, function(data){
      if(data.status == "OK"){
        alert("삭제 되었습니다");
        location.reload();
      }
      else{
        alert("삭제 실패?????");
      }
    }) 
  })

  $("button.available").click(function(){
    window.location = "http://services.snu.ac.kr:4123";
  })
  $("button.unavailable").click(function(){
    var book_id = $(this).parent().parent().data("book_id");
    $.get('/unavailable_book/' + book_id, function(data){
      alert(data.user + " 님이 대출중입니다");
    })
  })

});

