import React from 'react'
import Style from './style.sass'
import Xhr from '../../lib/xhr';

export default class NewAlbumForm extends React.Component {
  // コンストラクタ
  constructor(props) {
    super(props);
    this.state = {
      title: '',
      date: '',
      category: '',
      description:'',
      selectedOption: 'closed',
      showPopup: false,
    };
  }
  // ポップアップの状態を切り替える
  togglePopup = () => {
    this.setState({
      showPopup: !this.state.showPopup,
    });
  }
  // 値の入力
  handleChange = (event) => {
    const target = event.target;
    const value = target.value;
    const name = target.name;
    this.setState({
      [name]: value
    });
  }
  // アラート
  handleSubmit = (event) => {
    event.preventDefault();
    const result = window.confirm('この内容でよろしいですか？');
    if (result) {
      this.sendData();
    } else {
      return
    }
  }

  // データの送信
  sendData = () => {
    const data = new FormData();
    data.append('album[title]', this.state.title);
    data.append('album[photographed_at]', this.state.date);
    data.append('album[category]', this.state.category);
    data.append('album[description]', this.state.description);
    data.append('album[user_id]', this.props.user.id);
    
    Xhr.request.post('/admin/albums', data)
      .then((response) => {
        window.location.href = '/admin/albums';
      })
      .catch((error) => {
        console.log(error);
      });
  }

  render() {
    return (
      <div>
        <button onClick={this.togglePopup}>アルバム作成</button>
        {this.state.showPopup ? 
          <div className={Style.Form__wrapper} >
            <div className={Style.Form__overRay} onClick={this.togglePopup}> </div>
            <div className={Style.Form__form}>
              <button className={Style.closeBtn} onClick={this.togglePopup}>×</button>
              <div className={Style.Form__container}>
                <form onSubmit={this.handleSubmit} className={Style.Form}>
                  <h1 className={Style.Form__heading}>新規アルバム作成</h1>
                  <p>ユーザー名：{this.props.user.name}</p>
                  <input type="hidden" value={this.props.user.id} />
                  <div className={Style.Form__formItem}>
                    <label className={Style.Form__label}>
                      タイトル
                    </label>
                    <input className={Style.Form__field} type="text" name='title' value={this.state.title} onChange={this.handleChange} required />
                  </div>
                  <div className={Style.Form__formItem}>
                    <label className={Style.Form__label}>
                      撮影日
                    </label>
                    <input className={Style.Form__field} type="date" name='date' value={this.state.date} onChange={this.handleChange} required />
                  </div>
                  <div className={Style.Form__formItem}>
                    <label className={Style.Form__label}>
                      カテゴリ
                      <select  className={Style.Form__select} name="category" value={this.state.category} onChange={this.handleChange}>
                        <option value="">選択して下さい</option>
                        {
                          this.props.categories.map(item =>(
                            <option key={this.props.categories.indexOf(item)} value={item[1]}>{item[0]}</option>
                          ))
                        }
                      </select>
                    </label>
                  </div>
                  <div className={Style.Form__formItem}>
                    <label className={Style.Form__label}>
                      概要
                    </label>
                    <textarea className={Style.Form__area} name='description' value={this.state.description} onChange={this.handleChange}></textarea>
                  </div>
                  <div className={Style.Form__formItem}>
                  <label className={Style.Form__label}>公開設定
                    <div className={Style.Form__disclosure}>
                      <input className={Style.Form__radio} type="radio" name="selectedOption" value="closed" id="closed"
                      checked={this.state.selectedOption === 'closed'} onChange={this.handleChange}/>
                      <label className={Style.Form__radioButton} htmlFor="closed">
                        非公開
                      </label>
                      <input className={Style.Form__radio} type="radio" name="selectedOption" value="personal" id="personal"
                        checked={this.state.selectedOption === 'personal'} onChange={this.handleChange}/>
                      <label className={Style.Form__radioButton} htmlFor="personal">
                        本人のみ
                      </label>
                      <input className={Style.Form__radio} type="radio" name="selectedOption" value="open" id="open"
                        checked={this.state.selectedOption === 'open'} onChange={this.handleChange}/>
                      <label className={Style.Form__radioButton} htmlFor="open">
                        公開
                      </label>
                    </div>
                  </label>
                  </div>
                  <input className={Style.Form__button} type="submit" value="作成"/>
                </form>
              </div>
            </div>
          </div> : null
        }
      </div>
    )
  }
}