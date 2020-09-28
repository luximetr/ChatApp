
import 'package:chat_app/ApplicationLayer/Services/User/CurrentUserService.dart';
import 'package:chat_app/DataLayer/Networking/Chat/SendMessageWebAPIWorker.dart';

class SendMessageService {

  final _currentUserService = CurrentUserService();
  final _sendMessageWebAPIWorker = SendMessageWebAPIWorker();

  Future<void> sendMessage(String chatId, String text) async {
    final currentUserId = await _currentUserService.getCachedCurrentUserId();
    await _sendMessageWebAPIWorker.sendMessage(chatId, currentUserId, text);
    return;
  }
}