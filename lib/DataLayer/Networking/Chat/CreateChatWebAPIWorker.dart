
import 'package:chat_app/DataLayer/Networking/Base/FirestoreWebAPIWorker.dart';
import 'package:chat_app/ModelLayer/Business/Chat/Chat.dart';
import 'package:chat_app/ModelLayer/Business/Chat/ChatJSONConverter.dart';
import 'package:chat_app/ModelLayer/Business/User/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateChatWebAPIWorker extends FirestoreWebAPIWorker {

  CollectionReference _collectionReference;
  final _chatJSONConverter = ChatJSONConverter();

  CreateChatWebAPIWorker() {
    _collectionReference = firestore.collection('chats');
  }

  Future<Chat> createChat(User currentUser, User targetUser) async {
    final members = [currentUser.id, targetUser.id];
    members.sort((a, b) => a.compareTo(b));
    final id = members.join('_');

    final existingDocument = await _collectionReference.doc(id).get();

    if (existingDocument.exists) {
      final json = existingDocument.data();
      return _chatJSONConverter.toChat(json, currentUser.id);
    } else {
      final newDocument = _collectionReference.doc(id);
      final data = {
        'id': id,
        'members': members,
        'names': {
          currentUser.id: targetUser.name,
          targetUser.id: currentUser.name
        }
      };
      await newDocument.set(data);
      return Chat(id: id, name: targetUser.name);
    }
  }
}