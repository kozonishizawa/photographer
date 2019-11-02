import consumer from "./consumer"

const message_element = document.getElementById('messages');

if (message_element) {

  const room_id = message_element.dataset.room;
  const type = message_element.dataset.type;
  
  const chatChannel = consumer.subscriptions.create({ channel: "RoomChannel", room: room_id, type: type }, {
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
        type: type,
      });
    },

    received: function(data) {
      let div = document.createElement('div');
      div.innerHTML = data['message'];
      message_element.appendChild(div);
    },

  });

  document.onkeydown = (e) => {
    if (e.keyCode === 13) {
      chatChannel.speak(e.target.value);
      e.target.value = '';
      return e.preventDefault();
    }
  }
}
