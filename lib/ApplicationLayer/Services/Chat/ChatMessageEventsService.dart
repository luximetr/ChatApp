
import 'package:chat_app/DataLayer/Networking/Chat/ChatMessageEventsWebAPIWorker.dart';
import 'package:chat_app/ModelLayer/Business/ChatEvent/ChatEvent.dart';

class ChatMessageEventsService {
  
  final _chatMessageEventsWebAPIWorker = ChatMessageEventsWebAPIWorker();

  Stream<ChatEvent> startListenChatEvents(String chatId) {
    return _chatMessageEventsWebAPIWorker.listenEvents(chatId);
  }

  void stopListenChatEvents() {
    _chatMessageEventsWebAPIWorker.stopListenEvents();
  }
}