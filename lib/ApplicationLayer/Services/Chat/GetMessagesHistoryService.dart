
import 'package:chat_app/DataLayer/Networking/Chat/GetMessagesHistoryWebAPIWorker.dart';
import 'package:chat_app/ModelLayer/Business/Message/Message.dart';

class GetMessagesHistoryService {

  final _getMessagesHistoryWebAPIWorker = GetMessagesHistoryWebAPIWorker();

  Future<List<Message>> getMessagesHistory(String chatId, String currentUserId, String startAfterMessageId) async {
    final limit = 25;
    return _getMessagesHistoryWebAPIWorker
        .getMessagesHistory(chatId, currentUserId, startAfterMessageId, limit);
  }
}