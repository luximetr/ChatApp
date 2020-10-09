
import 'package:flutter/cupertino.dart';

class Chat {
  String id;
  String name;
  bool isBlockedByYou;
  bool isBlocked;
  DateTime lastReadMessageCreatedAt;

  Chat({
    @required this.id,
    @required this.name,
    @required this.isBlockedByYou,
    @required this.isBlocked,
    this.lastReadMessageCreatedAt,
  });
}