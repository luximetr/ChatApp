
import 'package:chat_app/DataLayer/Networking/Base/FirestoreWebAPIWorker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateChatLastReadMessageWebAPIWorker extends FirestoreWebAPIWorker {

  CollectionReference _collectionReference;

  UpdateChatLastReadMessageWebAPIWorker() {
    _collectionReference = firestore.collection('chats');
  }

  Future<void> updateChatLastSentMessage(String chatId, String userId, DateTime messageCreatedAt) async {
    final chatDocument = _collectionReference.doc(chatId);
    final data = {
      'messageLastRead': {
        userId: messageCreatedAt
      }
    };
    return await chatDocument.set(data, SetOptions(merge: true));
  }
}