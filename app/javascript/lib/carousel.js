import Swiper from 'swiper'

var carouselOption = {
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
var carousel = new Swiper('#slide', carouselOption);

var slide = document.getElementById('slide');
var overRay = document.getElementById('overRay');
var thumbs = document.querySelectorAll('.p-photos__listItem');

// スライドの初期状態は非表示
if (slide) {
  slide.style.display = 'none';
}

// サムネイルをクリックするとポップアップ
if (thumbs) {
  thumbs.forEach(function(item) {
    item.onclick = () => {
      var index = Array.from(thumbs).indexOf(item);
      carousel.slideToLoop(index);
      slide.style.display = 'block';
      overRay.style.display = 'block';
    }
  });
}

// 背景をクリックすると閉じる
if (overRay) {
  overRay.onclick = () => {
    slide.style.display = 'none'
    overRay.style.display = 'none'
  };
}