import React from 'react';
import Loading from '../loading'
import Style from './style.sass';

// fileアップロード
import Dropzone from 'react-dropzone'

// 画像変換
import ImageConverter from '../../lib/image_converter'
import Xhr from '../../lib/xhr'

// 最大縦横幅
import { IMAGE_MAX_WIDTH, IMAGE_MAX_HEIGHT } from './properties.es6'

export default class Uploader extends React.Component {
  // コンストラクタ
  constructor(props) {

    super(props);

    this.state = {
      image: null,
      show: false,
    }
  }

  // 検索モーダルを表示する
  _open = () => {

    this.setState({ show: true });
  }

  // 検索モーダルを閉じる
  _close = () => {

    this.setState({ show: false });
  }

  // エンター押下時
  _onEnter(e) {

    if(e.keyCode == 13) this.upload();
  }

  // アップロード
  upload = () => {
    // ドロップゾーンに画像が入っていない場合メッセージとともにfalseを返す
    if (!this.state.image) {
      window.alert('画像を登録してください')
      console.log('登録失敗')
      // window.alertable({
      //   type: 'warning',
      //   message: '画像を登録してください',
      // });
      return false;
    }
    
    this.loadingRef.start();

    // 画像をリサイズ
    ImageConverter.imageUriToResizeBlob({
      uri: this.state.image,
      max_width: IMAGE_MAX_WIDTH,
      max_height: IMAGE_MAX_HEIGHT,
    }, blob => {

      const data = new FormData();
      data.append('photo[image]', blob);
      data.append('photo[album_id]', this.props.album_id);

      // 登録処理
      Xhr.request.post('/admin/photos', data).then(response => {

        this.loadingRef.finish();
        window.alert('画像を登録しました');
        console.log('登録完了');
        
        location.reload()
      });
    });
  }

  // 画像変更時
  _onChangeImage = e => {

    this.setState({ image: (window.URL || window.webkitURL).createObjectURL(e.target.files[0]) });
  }

  // ファイルドロップ時
  _onDrop = files => {
    // ファイルのブラウザ上でのURLを取得する
    this.setState({ image: (window.URL || window.webkitURL).createObjectURL(files[0]) });
  }

  // 表示処理
  render() {

    return (
      <React.Fragment>
        { this.state.show ?
          <div className={Style[this.props.device]}>
            <div className={Style.Uploader} onMouseDown={this._close}>
              <div className={Style.Uploader__body} onMouseDown={e => { e.stopPropagation() }}>

                <div className={Style.Uploader__main}>
                  <div className='u-mt-15'>
                    <Dropzone onDrop={this._onDrop}>
                      {({getRootProps, getInputProps}) => (
                        <div {...getRootProps()} className={Style.Uploader__dropzone}>
                          <input {...getInputProps()} />
                          <p>この部分に画像をドラッグ＆ドロップしてください</p>
                          <img src={this.state.image} />
                        </div>
                      )}
                    </Dropzone>
                  </div>

                  <div className='u-mt-10'>
                    <label htmlFor="input_file" className='u-td-underline u-fc-blue'>ファイルを指定する</label>
                  </div>
                  <input id='input_file' type='file' accept='image/*' onChange={this._onChangeImage} />
                  <div className='u-ta-right'>
                    <div onClick={this.upload} className='c-btn-main u-mt-30'>登録する</div>
                  </div>

                </div>
                <div className={Style.Uploader__close} onClick={this._close}>
                  閉じる
                </div>
              </div>
            </div>
          </div>
          : null
        }
        <div className='c-btn-main' onClick={this._open}>画像をアップロードする</div>
        <Loading ref={node => this.loadingRef = node}/>
      </React.Fragment>
    )
  }
} 