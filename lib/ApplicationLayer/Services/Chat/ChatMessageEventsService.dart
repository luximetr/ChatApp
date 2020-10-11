
import 'package:chat_app/DataLayer/Networking/Chat/ChatMessageEventsWebAPIWorker.dart';
import 'package:chat_app/ModelLayer/Business/ChatEvent/ChatEvent.dart';

class ChatMessageEventsService {
  
  final _chatMessageEventsWebAPIWorker = ChatMessageEventsWebAPIWorker();

  Stream<ChatEvent> startListenChatMessageEvents(String chatId, String currentUserId) {
    return _chatMessageEventsWebAPIWorker.listenEvents(chatId, currentUserId);
  }

  void stopListenChatMessageEvents() {
    _chatMessageEventsWebAPIWorker.stopListenEvents();
  }
}