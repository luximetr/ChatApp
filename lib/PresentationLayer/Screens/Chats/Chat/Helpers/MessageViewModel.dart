
import 'package:flutter/cupertino.dart';

class MessageViewModel {
  String messageId;
  String text;
  String time;
  bool isFromCurrentUser;
  MessageViewModelStatus status;

  MessageViewModel({
    @required this.messageId,
    @required this.text,
    @required this.time,
    @required this.isFromCurrentUser,
    this.status,
  });
}

enum MessageViewModelStatus {
  sending,
  sent,
  failed,
}