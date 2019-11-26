import React from 'react'
import Style from './style.sass'
import Icon from '../icon'

import InfoIcon from './info_icon'
import SuccessIcon from './success_icon'
import WarningIcon from './warning_icon'
import ErrorIcon from './error_icon'

export default class DataModal extends React.Component {

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

  // レンダリング成功時
  componentDidMount() {
    // グローバルからの呼び出し
    window.alertable = options => {

      let args = {};

      // 引数が文字列の場合
      if (typeof oiptions  == 'string' || options instanceof String) {

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
    if (this.state.message) this.open;
  }

  // モーダルを開く
  open = (options={}) => {

    this.bindKeyEvents();

    this.setState(Object.assign({ show: true }, options));
  }

  // モーダルを閉じる
  close = () => {

    const {close_callback} = this,state;

    this.unBindKeyEvents();

    this.setState({ show: false, title: null, message: null, type: null, callback: null, close_callback: null, confirm: false }, () => {
      if (close_callback) close_callback();
    });
  }

  // confirm時の処理の続行
  do = () => {

    const {callback} = this.state;

    if (callback) callback();
    this.close();
  }

  // キーバインドイベントの登録
  bindKeyEvents = () => {
    // エンター押下時イベントの登録
    if (document.onKeydown != this._onEnter) {
      this.previousKeyDownEvent = document.onkeydown;
      document.onkeydown = this._onEnter;
    }
  }

  // キーバインドイベントの削除
  unBindKeyEvents = () => {
    document.onkeydown = this.previousKeyDownEvent;
  }

  // エンター押下時
  _onEnter = event  => {

    if (event.keyCode == 13) this.close();
    return false
  }

  // 表示処理
  render() {

    const {show, title, message, type, confirm} = this.state;

    return (
      <div className={Style.DataModal}>
        { show ?
          <div className={Style.DataModal__overlay} onMouseDown={this.close}>
            <div className={`${Style.DataModal__inner} ${type ? Style['DataModal__'+type] : null}`} onMouseDown={ e => { e.stopPropagation() } }>

            </div>

          </div>
        }
      </div>
    )
  }
}
