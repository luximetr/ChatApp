
import 'package:flutter/cupertino.dart';

class Chat {
  String id;
  String name;
  DateTime lastReadMessageCreatedAt;

  Chat({
    @required this.id,
    @required this.name,
    this.lastReadMessageCreatedAt,
  });
}