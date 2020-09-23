
import 'package:chat_app/ModelLayer/Business/ChatEvent/ChatEvent.dart';
import 'package:chat_app/ModelLayer/Business/ChatEvent/ChatEventTypeConverter.dart';
import 'package:chat_app/ModelLayer/Business/Message/MessageJSONConverter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatEventConverter {

  final _messageJSONConverter = MessageJSONConverter();
  final _typeConverter = ChatEventTypeConverter();

  ChatEvent toChatEvent(DocumentChange documentChange) {
    final message = _messageJSONConverter.toMessage(documentChange.doc.data());
    final type = _typeConverter.toEventType(documentChange.type);

    return ChatEvent(
      message: message,
      type: type
    );
  }
}