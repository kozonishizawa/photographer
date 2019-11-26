import React from 'react'

export default class Icon extends React.Component {
  // 表示処理
  render () {
    const color = this.props.color ? `u-svg-${this.props.color}` : '';
    const size = this.props.size ? `u-svg-${this.props.size}` : '';

    return (
      <svg className={`${color} ${size} ${this.props.className || ''}`}>
        <use xlinkHref={`#`} />
      </svg>
    );
  }
} 