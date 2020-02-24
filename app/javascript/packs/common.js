// body要素をヘッダーの高さ分下げる
var mediaQuery = matchMedia('(max-width: 1023px)');
handle(mediaQuery);

mediaQuery.addListener(handle);
function handle(mq) {
  if(mq.matches) {
    var header = document.querySelector('header');
    var headerStyle = window.getComputedStyle(header);
    var headerHeight = headerStyle.height;
    document.body.style.paddingTop = headerHeight;
    console.log(headerHeight);
  } else {
    document.body.style.paddingTop = '0px';
  }
}