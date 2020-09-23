
import 'package:chat_app/DataLayer/Networking/Base/FirestoreWebAPIWorker.dart';
import 'package:chat_app/ModelLayer/Business/Message/Message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SendMessageWebAPIWorker extends FirestoreWebAPIWorker {

  CollectionReference _chatsCollectionReference;

  SendMessageWebAPIWorker() {
    _chatsCollectionReference = firestore.collection('chats');
  }

  Future<Message> sendMessage(String chatId, String senderId, String text) async {
    final chatDocument = _chatsCollectionReference.doc(chatId);
    final messagesCollection = chatDocument.collection('messages');
    final newMessageDocument = messagesCollection.doc();
    final id = newMessageDocument.id;

    await newMessageDocument.set({
      'id': id,
      'senderId': senderId,
      'text': text,
      'createdAt': FieldValue.serverTimestamp()
    });

    return Message(
      id: id,
      senderId: senderId,
      text: text
    );
  }
}