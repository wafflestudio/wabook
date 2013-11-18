
$(document).ready(function(){
  $("td#booktitle").click(function(){
    $(this).parent().parent().children(".book-content").slideToggle("slow");

  }); 
  $(".available.bookClass").click(function(){
    var r = confirm("이 책을 빌리시겠습니까?")
    if (r){
      var bookId = $(this).attr('book-id')
      $.get('/lend/' + bookId, function(data) { 
        if (data.status == "OK")
          {   
            alert("대출하였습니다")
            $('button[book-id='+bookId+']').removeClass('available').addClass('reservation').html('대여불가') 
          }   
          else
            alert("대출권수를 초과하였습니다")
      }); 


    }   


  }); 
  $(".reservation.bookClass").click(function(){
    var r = confirm("이 책을 예약하시겠습니까?")
    if (r){
      alert("예약!")

    }   
    else{
      alert("안예약!")

    }   


  }); 


});

