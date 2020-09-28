
import 'package:chat_app/ModelLayer/Business/Chat/Chat.dart';

class ChatJSONConverter {

  Chat toChat(Map<String, dynamic> json, String userId) {
    if (json == null) { return null; }
    final id = json['id'] as String;
    final name = _fetchName(json, userId);

    if (id is! String || id.isEmpty) { throw Exception('Unable to parse Chat, json should have an ID'); }

    return Chat(
      id: id,
      name: name ?? ''
    );
  }

  String _fetchName(Map<String, dynamic> json, String userId) {
    final names = json['names'] as Map<String, dynamic>;
    if (names == null || names.isEmpty) { return null; }
    return names[userId];
  }
}