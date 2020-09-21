
import 'package:chat_app/DataLayer/Networking/Base/FirestoreWebAPIWorker.dart';
import 'package:chat_app/ModelLayer/Business/Chat/Chat.dart';
import 'package:chat_app/ModelLayer/Business/Chat/ChatJSONConverter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetChatListWebAPIWorker extends FirestoreWebAPIWorker {

  CollectionReference _collectionReference;
  ChatJSONConverter _chatJSONConverter;

  GetChatListWebAPIWorker() {
    _collectionReference = firestore.collection('chats');
    _chatJSONConverter = ChatJSONConverter();
  }

  Future<List<Chat>> getChatList(String userId) async {
    return _collectionReference
        .where('members', arrayContains: userId)
        .get()
        .then((snapshot) {
          return snapshot.docs.map((doc) {
            return _chatJSONConverter.toChat(doc.data());
          }).toList();
        });
  }

}