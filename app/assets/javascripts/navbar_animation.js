$(function(){
  $(window).on('scroll', function(e){
    if ($(this).scrollTop() > 10) {
      $('.navbar-wagon').css('margin-top', '-70px');
    } else {
      $('.navbar-wagon').css('margin-top', '0px');
    }
  });
});
