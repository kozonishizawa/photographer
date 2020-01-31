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

  let download = document.getElementById('download')
  download.onclick = () => {
    this.addEventListener('ajax:success', () => {
      location.reload();
      console.log('うんこ')
    }
    )
  }
});
