$(document).ready(function(){
    $(".prolong").click(function(){
      console.log(this)
    var r = confirm("이 책의 반납기한을 일주일 연장하시겠습니까?")
    if(r){
      var checkId = $(this).attr("checkout_id")
      $.get('/prolong/'+checkId, function(data) { 
        if (data.status == "OK")
        {
          alert("연장되었습니다!")
          location.reload();
        }
        else
          alert("연장한도를 초과하셨습니다(2회)")
      })
    }
  });

});
