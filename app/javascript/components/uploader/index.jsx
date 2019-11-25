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
      show: true,
    }
  }

  // アップロード
  upload = (files) => {
    // ドロップゾーンに画像が入っていない場合メッセージとともにfalseを返す
    if (!this.state.image) {
      window.alert('画像を登録してください')
      console.log('登録失敗')
      return false;
    }
    // ローディング画面の表示
    this.loadingRef.start();

    files.forEach(file => {

      const data = new FormData();
      data.append('photo[image]', file);
      data.append('photo[album_id]', this.props.album_id);
      
      // 登録処理
      Xhr.request.post('/admin/photos', data).then(response => {
        
      });
    });

    location.reload();
    this.loadingRef.finish();
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
                    <Dropzone onDrop={this._onDrop} onDropAccepted={this.upload}>
                      {({getRootProps, getInputProps}) => (
                        <div {...getRootProps()} className={Style.Uploader__dropzone}>
                          <input {...getInputProps()} />
                          <p>この部分に画像をドラッグ＆ドロップするとアップロードを開始します</p>
                          <img src={this.state.image} />
                        </div>
                      )}
                    </Dropzone>
                  </div>
                </div>
              </div>
            </div>
          </div>
          : null
        }
        <Loading ref={node => this.loadingRef = node}/>
      </React.Fragment>
    )
  }
} 