
import 'package:chat_app/DataLayer/Networking/Chat/UpdateChatLastReadMessageWebAPIWorker.dart';
import 'package:chat_app/ModelLayer/Business/Message/Message.dart';

class UpdateChatLastReadMessageService {

  final _updateChatLastReadMessage = UpdateChatLastReadMessageWebAPIWorker();

  Future<void> updateChatLastReadMessage(String chatId, String currentUserId, Message message) async {
    return _updateChatLastReadMessage.updateChatLastSentMessage(chatId, currentUserId, message.createdAt);
  }
}