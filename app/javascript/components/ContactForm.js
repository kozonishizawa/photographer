import React from 'react'
import Style from './ContactForm.sass'
export default class ContactForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      isSubmitted: false,
      email: '',
      hasEmailError: false,
      name: '',
      hasNameError: false,
      tel: '',
      hasTelError: false,
      subject: '',
      hasSubjectError: false,
      date: '',
      hasDateError: false,
      location: '',
      hasLocationError: false,
    };
  }

  handleEmailChange = (event) => {
    const inputValue = event.target.value;
    const isEmpty = inputValue === '';
    this.setState({
      email: inputValue,
      hasEmailError: isEmpty,
    })
  }

  handleNameChange = (event) => {
    const inputValue = event.target.value;
    const isEmpty = inputValue === '';

    this.setState({
      name: inputValue,
      hasNameError: isEmpty,
    })
  }

  handleSubmit = () => {
    this.setState({isSubmitted: true});
  }

  render() {
    let emailErrorText;
    if (this.state.hasEmailError) {
      emailErrorText = (
        <p className={Style.contentMessageError}>
          メールアドレスを入力してください。
        </p>
      );
    }

    let nameErrorText;
    if (this.state.hasNameError) {
      nameErrorText = (
        <p className={Style.contentMessageError}>
          お名前を入力してください。
        </p>
      )
    }

    let contactForm;
    if (this.state.isSubmitted) {
      contactForm = (
        <div className={Style.contactSubmitMessage}>
          送信完了
        </div>
      )
    } else {
      contactForm = (
        <div className={Style.contactContainer}>
          <h3>お問い合わせ</h3>
          {/* 大事 */}
          <form onSubmit={this.handleSubmit} >
            <div className={Style.contactFormItem}>
              <p>撮影内容(必須)</p>
              <input
                value={this.state.email}
                onChange={this.handleEmailChange}
              />
              {emailErrorText}
            </div>
            <div className={Style.contactFormItem}>
              <p>撮影地(必須)</p>
              <input
                value={this.state.email}
                onChange={this.handleEmailChange}
              />
              {emailErrorText}
            </div>
            <div className={Style.contactFormItem}>
              <p>日程(必須)</p>
              <input
                value={this.state.email}
                onChange={this.handleEmailChange}
              />
              {emailErrorText}
              <p>ご予約の方は、空き状況の確認をいたしますので必ずご記入ください</p>
            </div>
            <div className={Style.contactFormItem}>
              <p>お名前(必須)</p>
              <input
                value={this.state.email}
                onChange={this.handleEmailChange}
              />
              <p>ご予約者様のお名前をご記入ください</p>
              {emailErrorText}
            </div>
            <div className={Style.contactFormItem}>
              <p>メールアドレス(必須)</p>
              <input
                value={this.state.email}
                onChange={this.handleEmailChange}
              />
              {emailErrorText}
            </div>
            <div className={Style.contactFormItem}>
              <p>電話番号(必須)</p>
              <input
                value={this.state.email}
                onChange={this.handleEmailChange}
              />
              {emailErrorText}
            </div>
            <div className={Style.contactItem}>
              <p>ご要望・ご質問</p>
              <textarea
                value={this.state.name}
                onChange={this.handleNameChange}
              />
              <p>ご依頼内容の詳細・ご質問などをご記入ください</p>
              {nameErrorText}
            </div>
            <input
              type='submit'
              value='送信'
            />
          </form>
        </div>
      );
    }

    return (
      <div className={Style.contactForm}>
        {contactForm}
      </div>
    );
  }
  
}