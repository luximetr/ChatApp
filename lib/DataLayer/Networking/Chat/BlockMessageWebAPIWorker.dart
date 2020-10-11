
import 'package:chat_app/DataLayer/Networking/Base/FirestoreWebAPIWorker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BlockMessageWebAPIWorker extends FirestoreWebAPIWorker {

  CollectionReference _chatsCollectionReference;

  BlockMessageWebAPIWorker() {
    _chatsCollectionReference = firestore.collection('chats');
  }

  Future<void> block(String chatId, String messageId, String userId) async {
    final chatDocument = _chatsCollectionReference.doc(chatId);
    final messagesCollection = chatDocument.collection('messages');
    final data = {
      'blockedFor': FieldValue.arrayUnion([userId]),
      'updatedAt': FieldValue.serverTimestamp(),
    };
    return messagesCollection
        .doc(messageId)
        .update(data);
  }
}