import Swiper from 'swiper';
import Xhr from '../lib/xhr';

// 写真削除
document.addEventListener('turbolinks:load', function() {
  document.querySelectorAll('.delete').forEach(function(a) {
    a.addEventListener('ajax:success', function() {
      const div = a.parentNode;
      const li = div.parentNode;
      li.style.display = 'none';
    });
  });
});

document.addEventListener('turbolinks:load', () => {

  let counter = document.getElementById('counter');
  
  if (counter) {
    var color = counter.style.color
  };
  // 写真選択
  document.querySelectorAll('.p-photos__btn').forEach((btn) => {
    btn.addEventListener('click', () => {
      Xhr.request.patch(`/front/photos/${btn.dataset.id}`)
      .then((response) => {
        var selectable = response.data.selectable
        if (selectable >= 0) {
          counter.style.color = color
          counter.innerHTML = `あと${selectable}枚選択可能`;
          btn.classList.toggle('on');
          var caption = btn.parentNode;
          var image = caption.previousElementSibling;
          var heart = image.children[0]
          heart.classList.toggle('marked');
        } else if (selectable == 'over') {
          counter.style.color = 'red'
          counter.innerHTML = 'これ以上選択できません';
        }
      })
      .catch((error) => {
        console.log(error);
      });
    })
  })
  
  
  var slide = document.getElementById('slide');
  var overlay = document.getElementById('overlay');
  var thumbs = document.querySelectorAll('.image');
  
  // サムネイルをクリックするとスライドがポップアップ
  thumbs.forEach((item) => {
    item.addEventListener('click', (e) => {
      slide.style.display = 'block';
      overlay.style.display = 'block';
      document.body.style.overflow = 'hidden';
      var initialIndex = Number(e.target.dataset.index) - 1;
  
      var carouselOption = {
        wrapperClass : 'c-carousel__list',
        slideClass   : 'c-carousel__item',
        loop         : true,
        pagination   : {
          el : '.c-carousel__nav',
          type: 'fraction',
        },
        navigation   : {
          nextEl : '.c-carousel__next',
          prevEl : '.c-carousel__prev',
        },
        initialSlide : initialIndex,
      }
  
      var carousel = new Swiper('#slide', carouselOption);
  
    })
  })
  
  // 背景をクリックすると閉じる
  if (overlay) {
    overlay.addEventListener('click', () => {
      slide.style.display = 'none';
      overlay.style.display = 'none';
      document.body.style.overflow = '';
    })
  }
  
})
// 履歴から写真選択
document.querySelectorAll('.p-histories__btn').forEach((btn) => {
  btn.addEventListener('click', () => {
    Xhr.request.patch(`/front/histories/${btn.dataset.id}`)
    .then((response) => {
      btn.classList.toggle('on');
      var caption = btn.parentNode;
      var image = caption.previousElementSibling;
      var heart = image.children[0]
      heart.classList.toggle('marked');
    })
    .catch((error) => {
      console.log(error);
    });
  })
})