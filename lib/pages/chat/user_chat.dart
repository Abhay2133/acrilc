import 'package:flutter/material.dart';

class UsersChat extends StatelessWidget {
  final String userId;

  const UsersChat({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    const senderColor = Color(0xFF3C3A36);
    const receiverColor = Color(0xFFFF9F1C);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF12100E),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: Text('Chat with $userId'),
        elevation: 0,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Today", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                ChatBubble(
                  message: "Hi, I'm interested in the painting you posted. Could you send me a few more pictures of it?",
                  isSender: true,
                  bubbleColor: senderColor,
                ),
                ChatBubble(
                  message: "Sure thing! Here are some photos of the painting.",
                  isSender: false,
                  bubbleColor: receiverColor,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(child: Image.network('https://picsum.photos/200?1', height: 140, fit: BoxFit.cover)),
                    const SizedBox(width: 8),
                    Expanded(child: Image.network('https://picsum.photos/200?2', height: 140, fit: BoxFit.cover)),
                    const SizedBox(width: 8),
                    Expanded(child: Image.network('https://picsum.photos/200?3', height: 140, fit: BoxFit.cover)),
                  ],
                ),
                const SizedBox(height: 16),
                ChatBubble(
                  message: "Thank you for sending these over. I'm really drawn to the one with the white background.",
                  isSender: true,
                  bubbleColor: senderColor,
                ),
                ChatBubble(
                  message: "I'm glad you like it! It’s still available if you're interested.",
                  isSender: false,
                  bubbleColor: receiverColor,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFF3C3A36),
                      hintText: "Send message",
                      hintStyle: const TextStyle(color: Colors.white70),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.mic, color: Colors.white70),
                const SizedBox(width: 10),
                const Icon(Icons.add, color: Colors.white70),
                const SizedBox(width: 10),
                const Icon(Icons.send, color: Colors.white70),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSender;
  final Color bubbleColor;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isSender,
    required this.bubbleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(message, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}