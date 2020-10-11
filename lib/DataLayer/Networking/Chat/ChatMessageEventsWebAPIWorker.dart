
import 'dart:async';
import 'package:chat_app/DataLayer/Networking/Base/FirestoreWebAPIWorker.dart';
import 'package:chat_app/ModelLayer/Business/ChatEvent/ChatEvent.dart';
import 'package:chat_app/ModelLayer/Business/ChatEvent/ChatEventConverter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessageEventsWebAPIWorker extends FirestoreWebAPIWorker {

  CollectionReference _chatsCollectionReference;
  final _eventsConverter = ChatEventConverter();
  final _streamController = StreamController<ChatEvent>();
  StreamSubscription<QuerySnapshot> _subscription;

  ChatMessageEventsWebAPIWorker() {
    _chatsCollectionReference = firestore.collection('chats');
  }

  Stream<ChatEvent> listenEvents(String chatId, String currentUserId) {
    final chatDocument = _chatsCollectionReference.doc(chatId);
    final messagesCollection = chatDocument.collection('messages');

    var query = messagesCollection
      .orderBy('updatedAt')
      .where('updatedAt', isGreaterThan: new DateTime.now());

    _subscription = query
        .snapshots()
        .listen((querySnapshot) {
          final chatEvents = querySnapshot.docChanges.map((docChange) {
            return _eventsConverter.toChatEvent(docChange, currentUserId);
          }).toList();

          chatEvents.forEach((chatEvent) {
            _streamController.sink.add(chatEvent);
          });
        });

    return _streamController.stream;
  }

  void stopListenEvents() {
    _subscription?.cancel();
    _streamController?.close();
  }

}