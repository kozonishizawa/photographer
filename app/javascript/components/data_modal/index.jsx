import React from 'react'
import Style from './style.sass'
import Icon  from '../icon'

import InfoIcon    from './info_icon'
import SuccessIcon from './success_icon'
import WarningIcon from './warning_icon'
import ErrorIcon   from './error_icon'

/**
 *  自動スクロールボタン
 *  @version 2018/06/10
 */
export default class DataModal extends React.Component {

  /**
   *  コンストラクタ
   *  @version 2018/06/10
   */
  constructor(props) {

    super(props);

    // キーバインドイベントを一時保存用
    this.previousKeyDownEvent = null;

    const type = Object.keys(props)[0];
    const {title, message} = props[type] || {};

    this.state = {
      title: title,
      message: message,
      type: type,
      confirm: false,
    };
  }

  /**
   *  レンダリング成功時
   *  @version 2018/06/10
   */
  componentDidMount() {

    // グローバルからの呼び出し
    window.alertable = options => {

      let args = {};

      // 引数が文字列の場合
      if (typeof options == 'string' || options instanceof String) {

        args['message'] = options;
      } else {

        args = options;
      }

      this.open(args);
    };

    // グローバルからの呼び出し
    window.confirmable = options => {

      this.open(Object.assign({ confirm: true }, options));
    };

    // フラッシュメッセージ等
    if (this.state.message) this.open();
  }

  /**
   *  モーダルを開く
   *  @version 2018/06/10
   */
  open = (options={}) => {

    this.bindKeyEvents();

    this.setState(Object.assign({ show: true }, options));
  }

  /**
   *  モーダルを閉じる
   *  @version 2018/06/10
   */
  close = () => {

    const {close_callback} = this.state;

    this.unBindKeyEvents();

    this.setState({ show: false, title: null, message: null, type: null, callback: null, close_callback: null, confirm: false }, () => {
      if (close_callback) close_callback();
    });
  }

  /**
   *  confirm時の処理の続行
   *  @version 2018/06/10
   */
  do = () => {

    const {callback} = this.state;

    if (callback) callback();
    this.close();
  }

  /**
   *  キーバインドイベントの登録
   *  @version 2018/06/10
   */
  bindKeyEvents = () => {

    // エンター押下イベント登録
    if (document.onkeydown != this._onEnter) {

      this.previousKeyDownEvent = document.onkeydown;
      document.onkeydown = this._onEnter;
    }
  }

  /**
   *  キーバインドイベントの削除
   *  @version 2018/06/10
   */
  unBindKeyEvents = () => {

    document.onkeydown = this.previousKeyDownEvent;
  }

  /**
   *  エンター押下時
   *  @version 2018/06/10
   */
  _onEnter = event => {

    if (event.keyCode == 13) this.close();
    return false
  }

  /**
   *  表示処理
   *  @version 2018/06/10
   */
  render() {

    const {show, title, message, type, confirm} = this.state;

    return (
      <div className={Style.DataModal}>
        { show ?
          <div className={Style.DataModal__overlay} onMouseDown={this.close}>
            <div className={`${Style.DataModal__inner} ${type ? Style['DataModal__'+type] : null}`} onMouseDown={ e => { e.stopPropagation() } }>
              { type && type == 'info' ? <div className={Style.DataModal__icon}><InfoIcon /></div> : null }
              { type && type == 'success' ? <div className={Style.DataModal__icon}><SuccessIcon /></div> : null }
              { type && type == 'warning' ? <div className={Style.DataModal__icon}><WarningIcon /></div> : null }
              { type && type == 'error' ? <div className={Style.DataModal__icon}><ErrorIcon /></div> : null }
              { title ? <div className={Style.DataModal__title}>{title}</div> : null }
              <div className={Style.DataModal__message} dangerouslySetInnerHTML={{__html: message}}></div>
              { confirm ? <div onClick={this.do} className='c-btn-primary u-display-block u-mt-10'>続行する</div> : null }
              <div onClick={this.close} className='c-btn-negative u-display-block u-mt-10'>閉じる</div>
              <div onClick={this.close} className={Style.DataModal__closeIcon}>
                <Icon name='close' size='l' color='darkGray'/>
              </div>
            </div>
          </div>
          : null
        }
      </div>
    );
  }
}