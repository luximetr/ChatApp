
import 'package:chat_app/ModelLayer/Business/ChatEvent/ChatEventType.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatEventTypeConverter {

  ChatEventType toEventType(DocumentChangeType documentChangeType) {
    switch (documentChangeType) {
      case DocumentChangeType.added:
        return ChatEventType.created;
      case DocumentChangeType.modified:
        return ChatEventType.modified;
      case DocumentChangeType.removed:
        return ChatEventType.removed;
      default:
        return null;
    }
  }
}