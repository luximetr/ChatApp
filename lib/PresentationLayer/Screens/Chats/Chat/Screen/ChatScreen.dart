
import 'package:chat_app/ModelLayer/Business/Chat/Chat.dart';
import 'package:chat_app/PresentationLayer/Screens/Chats/Chat/Screen/ChatScreenView.dart';
import 'package:flutter/cupertino.dart';

class ChatScreen extends StatefulWidget {

  final Chat chat;

  ChatScreen({@required this.chat});

  @override
  State<StatefulWidget> createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {

  @override
  Widget build(BuildContext context) {
    return ChatScreenView(chat: widget.chat);
  }
}