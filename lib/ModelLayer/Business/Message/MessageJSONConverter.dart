
import 'package:chat_app/ModelLayer/Business/Message/Message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageJSONConverter {

  Message toMessage(Map<String, dynamic> json, String currentUserId) {
    if (json == null) { return null; }
    final id = json['id'] as String;
    final senderId = json['senderId'] as String;

    if (id is! String || id.isEmpty) { throw Exception('Unable to parse Message, json should have an id'); }
    if (senderId is! String || senderId.isEmpty) { throw Exception('Unable to parse Message, json should have a text'); }

    final text = json['text'] as String;
    final createdAt = json['createdAt'] as Timestamp;
    final isBlockedForYou = _parseIsBlockedForYou(json, currentUserId);

    return Message(
      id: id,
      text: text,
      senderId: senderId,
      createdAt: createdAt?.toDate() ?? DateTime.now(),
      isBlockedForYou: isBlockedForYou,
    );
  }

  // Blocked for
  List<String> _parseBlockedFor(Map<String, dynamic> json) {
    final blockedFor = json['blockedFor'];
    if (blockedFor is List<dynamic>) {
      return blockedFor.cast<String>().toList();
    }
    return [];
  }

  bool _parseIsBlockedForYou(Map<String, dynamic> json, String currentUserId) {
    final blockedFor = _parseBlockedFor(json);
    return blockedFor.contains(currentUserId);
  }
}