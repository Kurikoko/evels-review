$(function(){

  $(window).on('load', function(){
    $('.main-title, .sub-contents').hide();
    $('.main-title').fadeIn(5000, function(){
      $('.sub-contents').fadeIn(4000, function(){
        $('.emphasize').addClass('fadeIn')
      });
    });
  });
});