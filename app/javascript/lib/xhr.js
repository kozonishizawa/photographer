//##############################################################################
// Xhr Request
//##############################################################################
export default new class Xhr {
  // コンストラクタ
  constructor() {

    this.request = require('axios')
    this.request.defaults.headers['X-Requested-With'] = 'XMLHttpRequest';

    let csrf = null;
    if (csrf = document.getElementsByName('csrf-token').item(0)) this.request.defaults.headers['X-CSRF-TOKEN'] = csrf.content;

    this.request.defaults.withCredentials = true;
    this.request.defaults.headers.get.timeout = 5000;
  }
}