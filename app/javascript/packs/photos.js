document.addEventListener('turbolinks:load', function() {
  document.querySelectorAll('.delete').forEach(function(a) {
    a.addEventListener('ajax:success', function() {
      const div = a.parentNode;
      div.style.display = 'none';
    });
  });

  if (document.getElementById('counter')) {

    let counter = document.getElementById('counter');
    let number = Number(counter.dataset.quantity);

    window.addEventListener('ajax:success', function(e) {

      let input = e.target.commit;
      if (input.className == 'p-photos__selected') {
        input.className = 'p-photos__unselected'
        number += 1;
        counter.innerHTML = `あと${number}枚選択できます`
      } else if (input.className == 'p-photos__unselected') {
        input.className = 'p-photos__selected'
        number -= 1;
        counter.innerHTML = `あと${number}枚選択できます`


      }
    });
  }
});
