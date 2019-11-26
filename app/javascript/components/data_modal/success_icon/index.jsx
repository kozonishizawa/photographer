import React from 'react'
import Style from './style.sass'

export default class SuccessIcon extends React.Component {

  // 表示処理
  render () {
    return (
      <div className={Style.SuccessIcon}>
        <span className={`${Style.SuccessIcon__line} ${Style.SuccessIcon__lineLong}`}></span>
        <span className={`${Style.SuccessIcon__line} ${Style.SuccessIcon__lineTip}`}></span>
        <div className={Style.SuccessIcon__ring}></div>
        <div className={Style.SuccessIcon__hideCorners}></div>
      </div>
    );
  }
}