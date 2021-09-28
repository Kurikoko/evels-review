$(function(){
  $(".detail-review-image").on('click',function(){
    var imgSrc = $(this).children().attr('src');
    $(".bigimg").attr('src', imgSrc);
    $(".image-modal").fadeIn();
    $('body,html').css('overflow-y', 'hidden');
  });
  $(".fa-times-circle,.bigimg").on('click', function(){
    $('.image-modal').fadeOut();
    $('body,html').css('overflow-y', 'visible');
  });
});

