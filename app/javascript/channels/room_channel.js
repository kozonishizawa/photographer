import consumer from "./consumer"

const room_id = document.getElementById('messages').dataset.room;

const chatChannel = consumer.subscriptions.create({ channel: "RoomChannel", room: room_id }, {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    let div = document.createElement('div');
    div.innerHTML = data['message'];
    document.getElementById('message').appendChild(div);
  },

  speak: function(message) {
    console.log('message:', message);
    return this.perform('speak', {
      message: message,
      room: room_id,
    });
  }
});

document.onkeydown = (e) => {
  if (e.keyCode === 13) {
    chatChannel.speak(e.target.value);
    e.target.value = '';
    return e.preventDefault();
  }
}
