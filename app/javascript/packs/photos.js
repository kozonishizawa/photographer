import Swiper from 'swiper';
import Xhr from '../lib/xhr';

// 写真削除
document.addEventListener('turbolinks:load', function() {
  document.querySelectorAll('.delete').forEach(function(a) {
    a.addEventListener('ajax:success', function() {
      const div = a.parentNode;
      div.style.display = 'none';
    });
  });
});

// アルバム
document.addEventListener('turbolinks:load', function() {
  // 写真選択ボタン
  let counter = document.getElementById('counter');
  document.querySelectorAll('.p-photos__btn').forEach((btn) => {
    var color = counter.style.color
    btn.addEventListener('click', () => {
      Xhr.request.patch(`/front/photos/${btn.dataset.id}`)
      .then((response) => {
        var selectable = response.data.selectable
        if (selectable >= 0) {
          console.log('通信成功！');
          counter.style.color = color
          counter.innerHTML = `あと${selectable}枚選択できます`;
          btn.classList.toggle('on');
        } else if (selectable == 'over') {
          console.log(selectable);
          counter.style.color = 'red'
          counter.innerHTML = 'ダウンロードの上限を超えました';
        }
      })
      .catch((error) => {
        console.log(error);
      });
    })
  })

  var slide = document.getElementById('slide');
  var overlay = document.getElementById('overlay');
  var thumbs = document.querySelectorAll('.p-photos__thumbnail');
  
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
 
});
