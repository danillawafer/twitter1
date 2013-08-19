$(document).ready(function() {

  $('#tweets').on('submit', function(e){
    e.preventDefault();

    console.log("im loading");
    $(".container").replaceWith("<div class='container'><center><img src='../loading.gif' alt='loading'></center></div>");


    var data = $(this).serialize();
    request = $.post(this.action, data);
    request.done(function(data){
      console.log("im back baby!!");
      $(".container").replaceWith(data);
    });
  });


  $(document).on('click', '#followers', function(){

    $(".container").replaceWith("<div class='container'><center><img src='../loading.gif' alt='loading'></center></div>");
    
    request = $.get(this.href);

    request.done(function(data){
      console.log("im back baby!!");
      $(".container").replaceWith(data);
    });


  })


});
