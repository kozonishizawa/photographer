document.addEventListener('turbolinks:load', function() {
  document.querySelectorAll('.delete').forEach(function(a) {
    a.addEventListener('ajax:success', function() {
      var div = a.parentNode;
      div.style.display = 'none';
    });
  });
});

const thumbs = document.querySelectorAll('.thumbs');
thumbs.forEach(function(item, index) {
  item.onclick = function() {
    document.getElementById('bigImage').src = this.dataset.image;
  }
});
