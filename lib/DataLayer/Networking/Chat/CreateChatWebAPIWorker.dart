
import 'package:chat_app/DataLayer/Networking/Base/FirestoreWebAPIWorker.dart';
import 'package:chat_app/ModelLayer/Business/Chat/Chat.dart';
import 'package:chat_app/ModelLayer/Business/User/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateChatWebAPIWorker extends FirestoreWebAPIWorker {

  CollectionReference _collectionReference;

  CreateChatWebAPIWorker() {
    _collectionReference = firestore.collection('chats');
  }

  Future<Chat> createChat(User currentUser, User targetUser) async {
    final members = [currentUser.id, targetUser.id];
    members.sort((a, b) => a.compareTo(b));
    final id = members.join('_');

    final newDocument = _collectionReference.doc(id);

    await newDocument.set({
      'id': id,
      'members': members,
      'names': {
        currentUser.id: targetUser.name,
        targetUser.id: currentUser.name
      }
    });

    return Chat(
      id: id,
      name: targetUser.name
    );
  }
}