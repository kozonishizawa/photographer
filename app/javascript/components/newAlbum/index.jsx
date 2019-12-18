import React from 'react'
class NewAlbumForm extends React.Component {
  render() {
    return (
      <div>
        <form onSubmit={this.handleSubmit}>
          <input type="hidden" value={this.props.userId} />
          <label>
            タイトル:
            <input type="text" value={this.props.value} onChange={this.handleChange} />
          </label>
          <label>
            撮影日:
            <input type="date" value={this.props.value} onChange={this.handleChange} />
          </label>
          <label>
            内容:
            <select name="subject">
              <option value="">選択して下さい</option>
              <option value="seven_five_three">七五三</option>
            </select>
          </label>
          <label>
            <input type="radio" name="status" value="closed"/>
            非公開
          </label>
          <label>
          <input type="radio" name="status" value="personal"/>
            本人のみ
          </label>
          <label>
            <input type="radio" name="status" value="open"/>
            公開
          </label>
          <input type="submit" value="作成" />
        </form>
      </div>
    )
  }
}

export default class NewAlbum extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      value: '',
      showPopup: false,
    };

    this.togglePopup = this.togglePopup.bind(this);
    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  togglePopup() {
    this.setState({
      showPopup: !this.state.showPopup,
    });
  }

  handleChange(event) {
    this.setState({value: event.target.value});
  }

  handleSubmit(event) {
    alert('A name was submitted: ' + this.state.value);
    event.preventDefault();
  }

  render() {
    return (
      <NewAlbumForm />
    );
  }
}