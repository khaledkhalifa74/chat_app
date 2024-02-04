import 'package:chat_firebase/models/message_model.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    required this.message,
    super.key,
  });
  final MessageModel message;


  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
          margin: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(32),
              topLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
            color: Color(0xff2B475E),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              message.message,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          )),
    );
  }
}

class ChatBubbleForFriend extends StatelessWidget {
  const ChatBubbleForFriend({
    required this.message,
    super.key,
  });
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
          margin: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(32),
              topLeft: Radius.circular(32),
              bottomLeft: Radius.circular(32),
            ),
            color: Colors.orange,
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              message.message,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          )),
    );
  }
}
