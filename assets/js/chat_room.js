let ChatRoom = {
    init(socket) {
        let channel = socket.channel('chat_box:lobby', {})
        channel.join()
        this.listenForMessages(channel)
    },

    listenForMessages(channel) {
        document.getElementById('chatbox-form').addEventListener('submit', function(e){
            e.preventDefault()

            // let userName = document.getElementById('user-name').value
            let userMsg = document.getElementById('user-msg').value

            // for sending events
            channel.push('shout', {body: userMsg})

            // document.getElementById('user-name').value = ''
            document.getElementById('user-msg').value = ''
        })

        // for recieving events
        channel.on('shout', payload => {
            let chatBox = document.querySelector('#chatbox')
            let msgBlock = document.createElement('p')

            // msgBlock.insertAdjacentHTML('beforeend', `<b>$${payload.name}:</b>) ${payload.body}`)
            msgBlock.insertAdjacentHTML('beforeend', `${payload.body}`)
            chatBox.appendChild(msgBlock)
        })
    }
}

export default ChatRoom

