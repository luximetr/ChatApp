
import 'package:chat_app/ModelLayer/Business/Message/Message.dart';
import 'package:chat_app/PresentationLayer/Screens/Chats/Chat/Helpers/MessageViewModelStatus.dart';
import 'package:flutter/cupertino.dart';

class MessageViewModel {
  Message message;
  String text;
  String time;
  bool isFromCurrentUser;
  MessageViewModelStatus status;

  MessageViewModel({
    @required this.message,
    @required this.text,
    @required this.time,
    @required this.isFromCurrentUser,
    this.status,
  });
}