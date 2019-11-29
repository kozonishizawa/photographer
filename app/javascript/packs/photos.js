import { end } from "worker-farm";

document.addEventListener('turbolinks:load', function() {
  document.querySelectorAll('.delete').forEach(function(a) {
    a.addEventListener('ajax:success', function() {
      const div = a.parentNode;
      div.style.display = 'none';
    });
  });
  
  window.addEventListener('ajax:success', function(e) {
    console.log('おはよう', e.target);
    let input = e.target.lastChild;
    console.log(input);
  });
});
