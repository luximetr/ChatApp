
import 'package:chat_app/ModelLayer/Business/Chat/Chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatJSONConverter {

  Chat toChat(Map<String, dynamic> json, String userId) {
    if (json == null) { return null; }

    final id = json['id'] as String;
    if (id is! String || id.isEmpty) { throw Exception('Unable to parse Chat, json should have an ID'); }

    final name = _fetchName(json, userId);
    final lastReadMessageCreatedAt = _fetchLastReadMessageCreatedAt(json, userId);
    final isBlockedByYou = _fetchIsBlockedByYou(json, userId);
    final isBlocked = _fetchIsBlocked(json);

    return Chat(
      id: id,
      name: name ?? '',
      isBlockedByYou: isBlockedByYou,
      isBlocked: isBlocked,
      lastReadMessageCreatedAt: lastReadMessageCreatedAt
    );
  }

  String _fetchName(Map<String, dynamic> json, String userId) {
    final names = json['names'] as Map<String, dynamic>;
    if (names == null || names.isEmpty) { return null; }
    return names[userId];
  }
  
  DateTime _fetchLastReadMessageCreatedAt(Map<String, dynamic> json, String userId) {
    final messagesLastRead = json['messageLastRead'] as Map<String, dynamic>;
    if (messagesLastRead == null) { return null; }
    final notCurrentUserId = messagesLastRead.keys.firstWhere((key) => key != userId, orElse: () => null);
    if (notCurrentUserId == null) { return null; }
    final messageLastRead = messagesLastRead[notCurrentUserId] as Timestamp;
    return messageLastRead.toDate();
  }

  List<String> _fetchBlockedBy(Map<String, dynamic> json) {
    final blockedBy = json['blockedBy'];
    if (blockedBy is List<dynamic>) {
      return blockedBy.cast<String>().toList();
    }
    return [];
  }

  bool _fetchIsBlockedByYou(Map<String, dynamic> json, String userId) {
    final blockedBy = _fetchBlockedBy(json);
    return blockedBy.contains(userId);
  }

  bool _fetchIsBlocked(Map<String, dynamic> json) {
    final blockedBy = _fetchBlockedBy(json);
    return blockedBy.isNotEmpty;
}
}