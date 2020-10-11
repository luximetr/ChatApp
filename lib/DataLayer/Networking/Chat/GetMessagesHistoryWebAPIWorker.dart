
import 'package:chat_app/DataLayer/Networking/Base/FirestoreWebAPIWorker.dart';
import 'package:chat_app/ModelLayer/Business/Message/Message.dart';
import 'package:chat_app/ModelLayer/Business/Message/MessageJSONConverter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetMessagesHistoryWebAPIWorker extends FirestoreWebAPIWorker {

  CollectionReference _chatsCollectionReference;
  final _messageJSONConverter = MessageJSONConverter();

  GetMessagesHistoryWebAPIWorker() {
    _chatsCollectionReference = firestore.collection('chats');
  }

  Future<List<Message>> getMessagesHistory(String chatId, String currentUserId, String startAfterMessageId, int limit) async {
    final chatDocument = _chatsCollectionReference.doc(chatId);
    final messagesCollection = chatDocument.collection('messages');

    var query = messagesCollection
        .orderBy('createdAt', descending: true)
        .limit(limit);

    if (startAfterMessageId != null) {
      final startAfter = await messagesCollection.doc(startAfterMessageId).get();
      if (startAfter != null) {
        query = query.startAfterDocument(startAfter);
      }
    }

    return query
      .get()
      .then((snapshot) {
        return snapshot.docs.map((doc) {
          final json = doc.data();
          return _messageJSONConverter.toMessage(json, currentUserId);
        }).toList();
      });
  }
}