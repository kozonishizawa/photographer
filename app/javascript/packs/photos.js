document.addEventListener('turbolinks:load', function() {
  document.querySelectorAll('.delete').forEach(function(a) {
    a.addEventListener('ajax:success', function() {
      var div = a.parentNode;
      div.style.display = 'none';
    });
  });

  // document.querySelectorAll('.download_list_button').forEach(function(a) {
  //   a.addEventListener('ajax:success', function() {
  //     a.value = 'none';
  //   });
  // });
});