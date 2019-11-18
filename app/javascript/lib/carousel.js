import Swiper from 'swiper'

var slideOption = {
  wrapperClass : 'c-carousel__list',
  slideClass   : 'c-carousel__item',
  currentClass : 'asdasd',
  loop         : true,
  pagination   : {
    el : '.c-carousel__nav',
  },
  navigation   : {
    nextEl : '.c-carousel__next',
    prevEl : '.c-carousel__prev',
  },
}

// スライド初期化
var slide = new Swiper('#slide', slideOption);

// サムネイルをクリックするとスライドがその画像に切り替わる
var thumbs = document.querySelectorAll('.c-carousel__item.thumbnail');
thumbs.forEach(function(item) {
  item.onclick = () => {
    var index = Array.from(thumbs).indexOf(item);
    slide.slideToLoop(index);
  }
});