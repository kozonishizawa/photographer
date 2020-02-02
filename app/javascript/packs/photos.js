import Swiper from 'swiper'

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
  if (document.getElementById('counter')) {

    let counter = document.getElementById('counter');
    let number = Number(counter.dataset.quantity);

    window.addEventListener('ajax:success', function(e) {

      let input = e.target.commit;
      if (input.className == 'p-photos__selected') {
        input.className = 'p-photos__unselected';
        console.log('選択を解除しました');
        number += 1;
        counter.innerHTML = `あと${number}枚選択できます`;
      } else if (input.className == 'p-photos__unselected') {
        input.className = 'p-photos__selected';
        console.log('選択をしました');
        number -= 1;
        counter.innerHTML = `あと${number}枚選択できます`;
      } else if (input.className == 'p-photos__unselected' && number <= 0) {
        console.log('これ以上選択できません');
      }
    });
  }

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
  overlay.addEventListener('click', () => {
    slide.style.display = 'none';
    overlay.style.display = 'none';
    document.body.style.overflow = '';
  })
 
});
