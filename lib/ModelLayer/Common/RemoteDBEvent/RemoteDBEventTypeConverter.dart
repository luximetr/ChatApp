
import 'package:chat_app/ModelLayer/Common/RemoteDBEvent/RemoteDBEventType.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RemoteDBEventTypeConverter {

  RemoteDBEventType toEventType(DocumentChangeType documentChangeType) {
    switch (documentChangeType) {
      case DocumentChangeType.added:
        return RemoteDBEventType.created;
      case DocumentChangeType.modified:
        return RemoteDBEventType.updated;
      case DocumentChangeType.removed:
        return RemoteDBEventType.deleted;
      default:
        return null;
    }
  }
}