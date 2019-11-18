import consumer from "./consumer"

const message_element = document.getElementById('messages');

if (message_element) {

  // idが'message'のタグからカスタムデータ属性'data-xxx'を取得し定数に格納
  const room_id = message_element.dataset.room;
  const speaker = message_element.dataset.speaker;
  
  const chatChannel = consumer.subscriptions.create({ channel: "RoomChannel", room: room_id, speaker: speaker }, {
    connected() {
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },
    
    // これが実行されるとコンシューマになったRoomChannel#speak({ message: message })が呼ばれる
    speak: function(message) {
      // 入力された値が出力される
      console.log('message:', message);
      return this.perform('speak', {
        message: message,
        room: room_id,
        speaker: speaker,
      });
    },
    // room_channel.rbでブロードキャストされたものがここに届く
    received: function(data) {
      // createElementでdiv要素を生成
      let div = document.createElement('div');
      // 生成したdiv要素にブロードキャストされた値を書き込む(innerHTML)
      div.innerHTML = data['message'];
      // 'p-chat__message'クラスの最初の要素を取得し、そのクラスに対し、発言者が誰かによって'self'または'opponent'を加える
      div.getElementsByClassName('p-chat__message')[0].classList.add(data['speaker'] == speaker ? 'self' : 'opponent');

      // ブロードキャストされた値が書き込まれたdiv要素が
      // id'messages'の要素に子要素として追加される
      message_element.appendChild(div);
    },

  });

  document.onkeydown = (e) => {
    // エンターキーが押されたとき以下の処理が実行される
    if (e.keyCode === 13) {
      // textfieldに入力された値を引数に取り、定数chatChannelに格納されたspeak関数を呼び出す
      chatChannel.speak(e.target.value);
      // 入力された値を空欄に戻す
      e.target.value = '';
      // イベントの無効化
      return e.preventDefault();
    }
  }
}
