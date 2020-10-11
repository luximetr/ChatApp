
import 'package:flutter/cupertino.dart';

class Message {
  String id;
  String text;
  String senderId;
  DateTime createdAt;
  bool isBlockedForYou;

  Message({
    @required this.id,
    @required this.text,
    @required this.senderId,
    @required this.createdAt,
    @required this.isBlockedForYou,
  });
}