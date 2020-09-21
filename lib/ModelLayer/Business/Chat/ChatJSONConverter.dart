
import 'package:chat_app/ModelLayer/Business/Chat/Chat.dart';

class ChatJSONConverter {

  Chat toChat(Map<String, dynamic> json) {
    if (json == null) { return null; }
    final id = json['id'] as String;
    final name = json['name'] as String;
    if (id is! String || id.isEmpty) { throw Exception('Unable to parse Chat, json should have an ID'); }

    return Chat(
      id: id,
      name: name ?? ''
    );
  }
}