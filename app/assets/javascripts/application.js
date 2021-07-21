// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require popper
//= require bootstrap-sprockets

//= require rails-ujs
//= require jquery.jscroll.min
//= require activestorage
//= require_tree .
/* global $*/

// 無限スクロール
$(window).on('scroll', function() {
  var scrollHeight = $(document).height();
  var scrollPosition = $(window).height() + $(window).scrollTop();
  if ( (scrollHeight - scrollPosition) / scrollHeight <= 0.5) {
    $('.jscroll').jscroll({
      contentSelector: '.scroll-list',
      nextSelector: 'span.next:last a',
      loadingHtml: '<div class="spinner-border text-white" role="status"></div>'
    });
    $('div.jscroll-inner').addClass('d-flex flex-wrap w-100 text-center');
  }
});

// 動きのきっかけとなるアニメーションの名前を定義
function fadeAnime(){

  // 下から要素を浮かばせるアクション
  $('.fadeUpTrigger').each(function(){
    var elemPos = $(this).offset().top-150;
    var scroll = $(window).scrollTop();
    var windowHeight = $(window).height();
    if (scroll >= elemPos - windowHeight){
    $(this).addClass('fadeUp');
    }else{
    $(this).removeClass('fadeUp');
    }
    });
}

// 画面をスクロールをしたら動かしたい場合の記述
  $(window).scroll(function (){
    fadeAnime();
  });

// 画面が読み込まれたらすぐに動かしたい場合の記述
  $(window).on('load', function(){
    fadeAnime();
  });
// 画像プレビューの記述
  $(function () {
    function readURL(input) {
      if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
          $('.img_prev').attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
      }
    }

    $('.img_field').change(function () {
      readURL(this);
    });
  });
