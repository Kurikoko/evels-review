$(function(){
  $(window).on('load resize', function(){
    $h = $('.icon').innerHeight();
    $h = $h / 1.5
    $('.icon').find('svg').css('font-size', $h + 'px');

  });
});