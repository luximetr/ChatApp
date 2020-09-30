
import 'package:chat_app/ModelLayer/Business/Chat/ChatJSONConverter.dart';
import 'package:chat_app/ModelLayer/Business/ChatListEvent/ChatListEvent.dart';
import 'package:chat_app/ModelLayer/Common/RemoteDBEvent/RemoteDBEventTypeConverter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatListEventConverter {

  final _eventTypeConverter = RemoteDBEventTypeConverter();
  final _chatJSONConverter = ChatJSONConverter();

  ChatListEvent toEvent(DocumentChange documentChange, String userId) {
    final json = documentChange.doc.data();
    final chat = _chatJSONConverter.toChat(json, userId);
    final type = _eventTypeConverter.toEventType(documentChange.type);

    return ChatListEvent(
      data: chat,
      type: type
    );
  }
}