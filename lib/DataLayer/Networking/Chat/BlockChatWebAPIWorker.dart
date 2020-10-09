
import 'package:chat_app/DataLayer/Networking/Base/FirestoreWebAPIWorker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BlockChatWebAPIWorker extends FirestoreWebAPIWorker {

  CollectionReference _collectionReference;

  BlockChatWebAPIWorker() {
    _collectionReference = firestore.collection('chats');
  }

  Future<void> block(String chatId, String userId) async {
    final data = {
      'blockedBy':
      FieldValue.arrayUnion([userId])
    };
    return _collectionReference
        .doc(chatId)
        .update(data);
  }
}