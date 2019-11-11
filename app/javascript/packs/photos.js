document.addEventListener('turbolinks:load', function() {
  document.querySelectorAll('.delete').forEach(function(a) {
    a.addEventListener('ajax:success', function() {
      var div = a.parentNode;
      div.style.display = 'none';
    });
  });
});