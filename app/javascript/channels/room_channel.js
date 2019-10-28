import consumer from "./consumer"

const room_id = document.getElementById('messages').dataset.room;

const chatChannel = consumer.subscriptions.create({ channel: "RoomChannel", room: room_id }, {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },
  
  speak: function(message) {
    console.log('message:', message);
    return this.perform('speak', {
      message: message,
      room: room_id,
    });
  },

  received: function(data) {
    let div = document.createElement('div');
    div.innerHTML = data['message'];
    document.getElementById('messages').appendChild(div);
  },

});

document.onkeydown = (e) => {
  if (e.keyCode === 13) {
    chatChannel.speak(e.target.value);
    e.target.value = '';
    return e.preventDefault();
  }
}
