import React from 'react'
import Style from './style.sass'
import Xhr from '../../lib/xhr';

export default class AlbumForm extends React.Component {
  // コンストラクタ
  constructor(props) {
    super(props);
    this.state = {
      title: this.props.album ? this.props.album.title : '',
      date: this.props.album ? this.props.album.photographed_at : '',
      category: this.props.album ? this.props.album.category : '',
      description: this.props.album ? this.props.album.description : '',
      openPeriod: this.props.album ? this.props.album.open_period : '',
      selectedOption: 'closed',
      showPopup: false,
      fixedBackground: false,
    };
  }
  // ポップアップの状態を切り替える
  togglePopup = () => {
    this.setState({
      showPopup: !this.state.showPopup,
      fixedBackground: !this.state.showPopup,
    });
    if (this.state.fixedBackground) {
      document.body.style.overflow = '';
    } else {
      document.body.style.overflow = 'hidden';
    }
  }

  toggleFixedBackground = () => {
    this.setState({
      fixedBackground: !this.state.fixedBackground,
    })
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
    data.append('album[description]', this.state.description);
    data.append('album[status]', this.state.selectedOption);
    data.append('album[category]', this.state.category);
    data.append('album[photographed_at]', this.state.date);
    data.append('album[user_id]', this.props.user.id);
    data.append('album[open_period]', this.state.openPeriod);

    if (this.props.album === undefined) {
      Xhr.request.post('/admin/albums', data)
        .then((response) => {
          window.location.href = '/admin/albums';
        })
        .catch((error) => {
          console.log(error);
        });
    } else {
      Xhr.request.put(`/admin/albums/${this.props.album.id}`, data)
        .then((response) => {
          window.location.href = '/admin/albums';
        })
        .catch((error) => {
          console.log(error);
        });
    }
  }

  render() {
    return (
      <div>
        <button className={Style.generalBtn} onClick={this.togglePopup}>{this.props.album === undefined ? 'アルバム作成' : '編集'}</button>
        {this.state.showPopup ? 
          <div className={Style.Form__wrapper} >
            <div className={Style.Form__overlay} onClick={this.togglePopup}> </div>
            <div className={Style.Form__form}>
              <button className={Style.closeBtn} onClick={this.togglePopup}>×</button>
              <div className={Style.Form__container}>
                <form onSubmit={this.handleSubmit} className={Style.Form}>
                  <h1 className={Style.Form__heading}>{this.props.album === undefined ? '新規アルバム作成' : 'アルバム情報編集'}</h1>
                  <p>ユーザー名：{this.props.user.name}</p>
                  <input type="hidden" value={this.props.user.id} />
                  <div className={Style.Form__formItem}>
                    <label className={Style.Form__label}>
                      タイトル <span className={Style.Form__required}>必須</span>
                    </label>
                    <input className={Style.Form__field} type="text" name='title' value={this.state.title} onChange={this.handleChange} required />
                  </div>
                  <div className={Style.Form__formItem}>
                    <label className={Style.Form__label}>
                      撮影日 <span className={Style.Form__required}>必須</span>
                    </label>
                    <input className={Style.Form__field} type="date" name='date' value={this.state.date} onChange={this.handleChange} required />
                  </div>
                  <div className={Style.Form__formItem}>
                    <label className={Style.Form__label}>
                      公開日数 <span className={Style.Form__required}>必須</span>
                    </label>
                    <input className={Style.Form__number} type="number" min='0' step='1' name='openPeriod' value={this.state.openPeriod} onChange={this.handleChange} placeholder='単位：日' required />
                  </div>
                  <div className={Style.Form__formItem}>
                    <label className={Style.Form__label}>
                      カテゴリ
                      <select  className={Style.Form__select} name="category" value={this.state.category} onChange={this.handleChange}>
                        <option value="">選択して下さい</option>
                        {
                          this.props.categories.map((item, index) =>(
                            <option key={index} value={item[1]}>{item[0]}</option>
                          ))
                        }
                      </select>
                    </label>
                  </div>
                  <div className={Style.Form__formItem}>
                    <label className={Style.Form__label}>
                      概要（任意）
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
                  <input className={Style.Form__button} type="submit" value={this.props.album === undefined ? '新規作成' : '更新'}/>
                </form>
              </div>
            </div>
          </div> : null
        }
      </div>
    )
  }
}