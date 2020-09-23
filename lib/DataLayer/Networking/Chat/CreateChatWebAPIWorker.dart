
import 'package:chat_app/DataLayer/Networking/Base/FirestoreWebAPIWorker.dart';
import 'package:chat_app/ModelLayer/Business/Chat/Chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateChatWebAPIWorker extends FirestoreWebAPIWorker {

  CollectionReference _collectionReference;

  CreateChatWebAPIWorker() {
    _collectionReference = firestore.collection('chats');
  }

  Future<Chat> createChat(String currentUserId, String targetUserId) async {
    final members = [currentUserId, targetUserId];
    members.sort((a, b) => a.compareTo(b));
    final id = members.join('_');
    final name = 'chat_$id';

    final newDocument = _collectionReference.doc(id);

    await newDocument.set({
      'id': id,
      'name': name,
      'members': members,
    });

    return Chat(
      id: id,
      name: name
    );
  }
}