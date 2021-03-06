import Swiper from 'swiper'

var carouselOption = {
  wrapperClass : 'c-carousel__list',
  slideClass   : 'c-carousel__item',
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

var slide = document.getElementById('slide');
var overlay = document.getElementById('overlay');
var thumbs = document.querySelectorAll('.p-photos__thumbnail');

// スライドの初期状態は非表示
if (slide) {
  var carousel = new Swiper('#slide', carouselOption);
  slide.style.display = 'none';
}

// サムネイルをクリックするとポップアップ
if (thumbs) {
  thumbs.forEach(function(item) {
    item.onclick = (e) => {
      carousel.slideTo(e.target.dataset.index);
      slide.style.display = 'block';
      overlay.style.display = 'block';
      document.body.style.overflow = 'hidden';
    }
  });
}

// 背景をクリックすると閉じる
if (overlay) {
  overlay.onclick = () => {
    slide.style.display = 'none'
    overlay.style.display = 'none'
    document.body.style.overflow = '';
  };
}