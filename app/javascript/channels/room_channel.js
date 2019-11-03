import consumer from "./consumer"

const message_element = document.getElementById('messages');

if (message_element) {

  // idが'message'のタグからカスタムデータ属性'data-xxx'を取得し定数に格納
  const room_id = message_element.dataset.room;
  const type = message_element.dataset.type;
  
  const chatChannel = consumer.subscriptions.create({ channel: "RoomChannel", room: room_id, type: type }, {
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
        type: type,
      });
    },
    // room_channel.rbでブロードキャストされたものがここに届く
    received: function(data) {
      let div = document.createElement('div');
      div.innerHTML = data['message'];
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
      return e.preventDefault();
    }
  }
}
