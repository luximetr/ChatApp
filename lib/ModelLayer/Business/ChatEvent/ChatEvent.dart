
import 'package:chat_app/ModelLayer/Business/ChatEvent/ChatEventType.dart';
import 'package:chat_app/ModelLayer/Business/Message/Message.dart';
import 'package:flutter/cupertino.dart';

class ChatEvent {
  Message message;
  ChatEventType type;

  ChatEvent({@required this.message, @required this.type});
}