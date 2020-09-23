
import 'package:chat_app/DataLayer/Networking/Chat/ChatEventsWebAPIWorker.dart';
import 'package:chat_app/ModelLayer/Business/ChatEvent/ChatEvent.dart';

class ChatEventsService {
  
  final _listenChatEventsWebAPIWorker = ChatEventsWebAPIWorker();

  Stream<ChatEvent> startListenChatEvents(String chatId) {
    return _listenChatEventsWebAPIWorker.listenEvents(chatId);
  }

  void stopListenChatEvents() {
    _listenChatEventsWebAPIWorker.stopListenEvents();
  }
}