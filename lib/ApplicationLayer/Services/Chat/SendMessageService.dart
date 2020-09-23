
import 'package:chat_app/ApplicationLayer/Services/User/CurrentUserService.dart';
import 'package:chat_app/DataLayer/Networking/Chat/SendMessageWebAPIWorker.dart';
import 'package:chat_app/ModelLayer/Business/Message/Message.dart';

class SendMessageService {

  final _currentUserService = CurrentUserService();
  final _sendMessageWebAPIWorker = SendMessageWebAPIWorker();

  Future<Message> sendMessage(String chatId, String text) async {
    final currentUserId = await _currentUserService.getCachedCurrentUserId();
    return _sendMessageWebAPIWorker.sendMessage(chatId, currentUserId, text);
  }
}