
import 'package:chat_app/DataLayer/Networking/Chat/ChatEventsWebAPIWorker.dart';
import 'package:chat_app/ModelLayer/Business/Chat/Chat.dart';

class ChatEventsService {

  final _chatEventsWebAPIWorker = ChatEventsWebAPIWorker();

  Stream<Chat> startListenChatUpdates(String chatId, String currentUserId) {
    return _chatEventsWebAPIWorker.listenUpdates(chatId, currentUserId);
  }

  void stopListenChatUpdates() {
    _chatEventsWebAPIWorker.stopListenUpdates();
  }
}