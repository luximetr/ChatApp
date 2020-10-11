
import 'package:chat_app/ApplicationLayer/Services/Chat/SendMessageService.dart';

class MessagingService {

  final _sendMessageService = SendMessageService();

  Future<void> sendMessage(String chatId, String text) async {
    return _sendMessageService.sendMessage(chatId, text);
  }
}