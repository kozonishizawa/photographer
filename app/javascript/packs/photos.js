document.addEventListener('turbolinks:load', function() {
  document.querySelectorAll('.delete').forEach(function(a) {
    a.addEventListener('ajax:success', function() {
      const div = a.parentNode;
      div.style.display = 'none';
    });
  });
  
  window.addEventListener('ajax:success', function(e) {
    console.log('おはよう', e.target);
    let input = e.target.commit;
    if (input.className == 'p-photos__selected') {
      input.className = 'p-photos__unselected'
    } else if (input.className == 'p-photos__unselected') {
      input.className = 'p-photos__selected'
    }
    
     
  });
});
