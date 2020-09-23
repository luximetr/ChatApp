
import 'package:flutter/cupertino.dart';

class MessageViewModel {
  String messageId;
  String text;
  bool isFromCurrentUser;
  MessageViewModelStatus status;

  MessageViewModel({
    @required this.messageId,
    @required this.text,
    @required this.isFromCurrentUser,
    this.status,
  });
}

enum MessageViewModelStatus {
  sending,
  sent,
  failed,
}