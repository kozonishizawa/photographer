import React from 'react'
import Style from './style.sass'

export default class Loading extends React.Component {
  // コンストラクタ
  constructor(props) {

    super(props);
    
    this.state = {
      loading: false,
    }
  }

  // ローディング開始
  start = () => {
    this.setState({loading: true});
  }

  // ローディング終了
  finish = () => {
    this.setState({loading: false});
  }

  // 表示処理
  render() {
    return (this.state.loading ?
      <div className={Style.Loading} onMouseDown={e => { e.stopPropagation() }} onClick={e => { e.stopPropagation() }}>
        {this.props.message || 'Loading'}
      </div>
      : null
    );
  }
}