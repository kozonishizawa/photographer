//##############################################################################
// Image Converter
//##############################################################################
import Xhr from './xhr'

// 画像変換クラス
export default new class ImageConverter {

  // コンストラクタ
  constructor() {

    // canvasにblobをそのまま描画できるように拡張
    HTMLCanvasElement.prototype.renderBlobImage = function(blob, callback) {

      const context = this.getContext('2d');
      const image = new Image();

      image.onload = function() {
        context.canvas.width = image.width;
        context.canvas.height = image.height;
        context.drawImage(image, 0, 0);

        if (callback) callback();
      }

      image.src = URL.createObjectURL(blob);
    };
  }

  // base64をblobへ変換
  base64ToBlob = (base64, mimetype='image/jpeg') => {

    const data = window.atob(base64.split(',')[1]);
    const buff = new ArrayBuffer(data.length);
    const units = new Uint8Array(buff);

    let length = 0;

    for (let i = 0, length = data.length; i < length; i++) {
      units[i] = data.charCodeAt(i);
    }

    return new Blob([units], {type: mimetype});
  }

  // URLのGETパラメータを取得
  imageUriToResizeBlob = ({uri, max_width, max_height,min_width, min_height, canvas_width, canvas_height, mimetype='image/jpeg', is_fill=true}, callback) => {

    // 画像の負荷対策として一度キャンパスに描画し、リサイズして保存する
    const image = new Image();

    // 画像の読み込み完了時
    image.onload = () => {
      
      // canvasを定義
      let canvas = document.createElement('canvas');
      canvas.id = Math.random().toString(36).substr(2, 9);

      const context = canvas.getContext('2d');

      // 画像の縦横幅を指定
      let width  = 0;
      let height = 0;
      let ratio  = 1;

      // 最大サイズ: 縦幅を起点
      if (max_height && image.width < image.height) {

        height = image.height < max_height ? image.height : max_height;
        ratio = height / image.height;
        width = image.width * ratio;

      // 最大サイズ: 横幅を起点
      } else if (max_width) {

        width = image.width < max_width ? image.width : max_width;
        ratio = width / image.width;
        height = image.height * ratio;

      } else {

        width = image.width;
        height = image.height;
      }

      // 最小サイズ: 縦幅を起点
      if (min_height && width < height) {

        if (height < min_height) {
          ratio = min_height / height;
          height = min_height;
          width = ratio * width;
        }
      
      // 最小サイズ: 横幅を起点
      } else if (min_width) {

        if (width < min_width) {
          ratio = min_width / width;
          width = min_width;
          height = ratio * height;
        }
      }

      // canvasの大きさを画像の大きさと同等に指定
      context.canvas.width = canvas_width || width;
      context.canvas.height = canvas_height || height;

      // 背景色を白にする(透過png用)
      if (is_fill) {
        context.fillStyle = 'white';
        context.fillRect(0, 0, context.canvas.width, context.canvas.height);
      }

      let x = 0;
      let y = 0;

      // canvasの大きさが指定されている場合は中央表示
      if (canvas_width) x = (canvas_width / 2) - (width / 2);
      if (canvas_height) y = (canvas_height / 2) - (height / 2);

      // canvasを画像に描画
      context.drawImage(image, x, y, width, height);
      // base64に変換
      const base64 = canvas.toDataURL(mimetype);
      // blobへ変換
      const blob = this.base64ToBlob(base64, mimetype);

      // callback処理を実施
      if (callback) callback(blob);
    }

    // URIがblob情報で構成されている場合（すでにblobだった場合）はサーバーを介さずに画像として描画
    if (uri.match(/^blob:/)) {

      image.src = uri;

    } else {

      // 一度自サーバーを介し、画像情報を取得する（CORS対策）
      Xhr.request.get(`/admin/photos/transfer/?url=${uri}`, {
        responseType: 'blob',
      }).then(function(response) {

        const blob = new Blob([response.data], {type: 'image'});
        image.src = (window.URL || window.webkitURL).createObjectURL(blob);
      }).catch(function(error) {

        window.alertable({
          type: 'error',
          message: '画像の変換に失敗しました。',
        });
      });
    }
  }
}