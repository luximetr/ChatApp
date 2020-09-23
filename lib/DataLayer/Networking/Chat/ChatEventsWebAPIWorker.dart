
import 'dart:async';
import 'package:chat_app/DataLayer/Networking/Base/FirestoreWebAPIWorker.dart';
import 'package:chat_app/ModelLayer/Business/ChatEvent/ChatEvent.dart';
import 'package:chat_app/ModelLayer/Business/ChatEvent/ChatEventConverter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatEventsWebAPIWorker extends FirestoreWebAPIWorker {

  CollectionReference _chatsCollectionReference;
  final _eventsConverter = ChatEventConverter();
  final _streamController = StreamController<ChatEvent>();
  StreamSubscription<QuerySnapshot> _subscription;

  ChatEventsWebAPIWorker() {
    _chatsCollectionReference = firestore.collection('chats');
  }

  Stream<ChatEvent> listenEvents(String chatId) {
    final chatDocument = _chatsCollectionReference.doc(chatId);
    final messagesCollection = chatDocument.collection('messages');

    _subscription = messagesCollection.snapshots().listen((querySnapshot) {
      if (querySnapshot.metadata.isFromCache) { return; }

      final chatEvents = querySnapshot.docChanges.map((docChange) {
        return _eventsConverter.toChatEvent(docChange);
      });

      chatEvents.forEach((chatEvent) {
        _streamController.sink.add(chatEvent);
      });
    });

    return _streamController.stream;
  }

  void stopListenEvents() {
    _subscription.cancel();
    _streamController.close();
  }

}