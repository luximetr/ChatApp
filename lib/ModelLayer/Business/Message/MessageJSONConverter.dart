
import 'package:chat_app/ModelLayer/Business/Message/Message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageJSONConverter {

  Message toMessage(Map<String, dynamic> json) {
    if (json == null) { return null; }
    final id = json['id'] as String;
    final senderId = json['senderId'] as String;
    final text = json['text'] as String;
    final createdAt = json['createdAt'] as Timestamp;

    if (id is! String || id.isEmpty) { throw Exception('Unable to parse Message, json should have an id'); }
    if (senderId is! String || senderId.isEmpty) { throw Exception('Unable to parse Message, json should have a text'); }

    return Message(
      id: id,
      text: text,
      senderId: senderId,
      createdAt: createdAt?.toDate() ?? DateTime.now(),
    );
  }
}