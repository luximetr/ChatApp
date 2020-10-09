
import 'package:chat_app/DataLayer/Networking/Chat/BlockChatWebAPIWorker.dart';

class BlockChatService {

  BlockChatWebAPIWorker _blockChatWebAPIWorker = BlockChatWebAPIWorker();

  Future<void> blockChat(String chatId, String userId) async {
    return _blockChatWebAPIWorker.block(chatId, userId);
  }
}