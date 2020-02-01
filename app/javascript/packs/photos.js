import Swiper from 'swiper'

document.addEventListener('turbolinks:load', function() {
  document.querySelectorAll('.delete').forEach(function(a) {
    a.addEventListener('ajax:success', function() {
      const div = a.parentNode;
      div.style.display = 'none';
    });
  });
});

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







  let download = document.getElementById('download')
  download.onClick = () => {
    this.addEventListener('ajax:success', () => {
      location.reload();
      console.log('うんこ')
    }
    )
  }
});
