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

var pop = document.getElementById('slide');
var overRay = document.getElementById('overRay');
var thumbs = document.querySelectorAll('.p-photos__listItem');

// ポップアップの初期状態
if (pop) {
  pop.style.display = 'none';
}

// サムネイルをクリックするとポップアップ
if (thumbs) {
  thumbs.forEach(function(item) {
    item.onclick = () => {
      var index = Array.from(thumbs).indexOf(item);
      slide.slideToLoop(index);
      pop.style.display = 'block';
      overRay.style.display = 'block';
    }
  });
}

// 背景をクリックするとポップアップが閉じる
if (overRay) {
  overRay.onclick = () => {
    pop.style.display = 'none'
    overRay.style.display = 'none'
  };
}