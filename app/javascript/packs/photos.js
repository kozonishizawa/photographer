document.addEventListener('turbolinks:load', function() {
  document.querySelectorAll('.delete').forEach(function(a) {
    a.addEventListener('ajax:success', function() {
      const div = a.parentNode;
      div.style.display = 'none';
    });
  });
  
  document.querySelectorAll('.p-photos__button').forEach(function(a) {
    a.addEventListener('ajax:success', function() {
      console.log('おはよう')
    });
  });
});