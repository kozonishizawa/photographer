// ========================================
import React from "react"
// ログインの状態をステートに持つ親コンポーネント
export default class LoginControl extends React.Component {
  // コンストラクタ
  constructor(props) {
    super(props);
    // ステートの初期値はログインしていない状態
    this.state = {isLoggedIn: false};
  }
  // ログイン状態にする
  handleLoginClick = () => {
    this.setState({isLoggedIn: true});
  }
  // ログアウト状態にする
  handleLogoutClick = () => {
    this.setState({isLoggedIn: false});
  }
 
  // 描画する
  render() {
    // ログイン状態のステートを変数に格納
    const isLoggedIn = this.state.isLoggedIn;
    // ボタンの変数を宣言
    let button;
    // ログイン状態の場合
    if (isLoggedIn) {
      // クリックするとログアウト状態にするボタンを変数に格納
      button = <LogoutButton onClick={this.handleLogoutClick} />;
      // ログアウト状態の場合
    } else {
      // クリックするとログイン状態にするボタンを変数に格納
      button = <LoginButton onClick={this.handleLoginClick} />;
    }
    
    return (
      <div>
        {/* ログインの状態をプロパティに持つ挨拶文 */}
        <Greeting isLoggedIn={isLoggedIn} />
        {button}
      </div>
    );
  }
}

function UserGreeting(props) {
  return <h1>Welcome back!</h1>;
}

function GuestGreeting(props) {
  return <h1>Please sign up.</h1>;
}

function Greeting(props) {
  const isLoggedIn = props.isLoggedIn;
  if (isLoggedIn) {
    return <UserGreeting />;
  }
  return <GuestGreeting />;
}

function LoginButton(props) {
  return (
    <button onClick={props.onClick}>
      Login
    </button>
  );
}

function LogoutButton(props) {
  return (
    <button onClick={props.onClick}>
      Logout
    </button>
  );
}

