
import 'dart:async';

import 'package:chat_app/DataLayer/Networking/Base/FirestoreWebAPIWorker.dart';
import 'package:chat_app/ModelLayer/Business/Chat/Chat.dart';
import 'package:chat_app/ModelLayer/Business/Chat/ChatJSONConverter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatEventsWebAPIWorker extends FirestoreWebAPIWorker {

  CollectionReference _collectionReference;
  final _streamController = StreamController<Chat>();
  StreamSubscription<QuerySnapshot> _subscription;
  final _chatJSONConverter = ChatJSONConverter();

  ChatEventsWebAPIWorker() {
    _collectionReference = firestore.collection('chats');
  }

  Stream<Chat> listenUpdates(String chatId, String userId) {
    _subscription = _collectionReference
        .where('id', isEqualTo: chatId)
        .snapshots()
        .listen((querySnapshot) {
          if (querySnapshot.metadata.isFromCache) { return; }

          final updates = querySnapshot.docChanges.map((docChange) {
            if (docChange.type != DocumentChangeType.modified) { return null; }
            final json = docChange.doc.data();
            return _chatJSONConverter.toChat(json, userId);
          }).toList();
          updates.removeWhere((element) => element == null);

          updates.forEach((update) {
            _streamController.sink.add(update);
          });
        });

    return _streamController.stream;
  }

  void stopListenUpdates() {
    _subscription?.cancel();
    _streamController?.close();
  }
}