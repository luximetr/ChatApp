
import 'dart:async';

import 'package:chat_app/DataLayer/Networking/Base/FirestoreWebAPIWorker.dart';
import 'package:chat_app/ModelLayer/Business/ChatListEvent/ChatListEvent.dart';
import 'package:chat_app/ModelLayer/Business/ChatListEvent/ChatListEventConverter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatListUpdatesWebAPIWorker extends FirestoreWebAPIWorker {

  CollectionReference _collectionReference;
  final _eventConverter = ChatListEventConverter();
  final _streamController = StreamController<ChatListEvent>();

  ChatListUpdatesWebAPIWorker() {
    _collectionReference = firestore.collection('chats');
  }

  Stream<ChatListEvent> startListenUpdates(String userId) {
    _collectionReference
      .where('members', arrayContains: userId)
      .snapshots()
      .listen((querySnapshot) {
        if (querySnapshot.metadata.isFromCache) { return; }

        final updates = querySnapshot.docChanges.map((docChange) {
          return _eventConverter.toEvent(docChange, userId);
        }).toList();

        updates.removeWhere((element) => element == null);

        updates.forEach((update) {
          _streamController.sink.add(update);
        });
      });

    return _streamController.stream;
  }

  void stopListenUpdates() {
    _streamController?.close();
  }
}