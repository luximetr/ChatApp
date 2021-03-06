
import 'package:chat_app/ModelLayer/Business/ChatEvent/ChatEvent.dart';
import 'package:chat_app/ModelLayer/Business/Message/MessageJSONConverter.dart';
import 'package:chat_app/ModelLayer/Common/RemoteDBEvent/RemoteDBEventTypeConverter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatEventConverter {

  final _messageJSONConverter = MessageJSONConverter();
  final _typeConverter = RemoteDBEventTypeConverter();

  ChatEvent toChatEvent(DocumentChange documentChange, String currentUserId) {
    final json = documentChange.doc.data();
    final message = _messageJSONConverter.toMessage(json, currentUserId);
    final type = _typeConverter.toEventType(documentChange.type);

    return ChatEvent(
      data: message,
      type: type
    );
  }
}