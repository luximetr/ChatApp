
import 'package:chat_app/DataLayer/Networking/Base/FirestoreWebAPIWorker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UnblockChatWebAPIWorker extends FirestoreWebAPIWorker {

  CollectionReference _collectionReference;

  UnblockChatWebAPIWorker() {
    _collectionReference = firestore.collection('chats');
  }

  Future<void> unblock(String chatId, String userId) async {
    final data = {
      'blockedBy':
      FieldValue.arrayRemove([userId])
    };
    return _collectionReference
        .doc(chatId)
        .update(data);
  }
}