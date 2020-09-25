
import 'package:flutter/cupertino.dart';

class Message {
  String id;
  String text;
  String senderId;
  DateTime createdAt;

  Message({@required this.id, @required this.text, @required this.senderId, @required this.createdAt});
}