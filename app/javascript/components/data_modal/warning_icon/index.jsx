import React from 'react'
import Style from './style.sass'

export default class WarningIcon extends React.Component {

  // 表示処理
  render () {
    return (
      <div className={Style.WarningIcon}>
        <span className={Style.WarningIcon__body}>
          <span className={Style.Warning__dot}></span>
        </span>
      </div>
    );
  }
}