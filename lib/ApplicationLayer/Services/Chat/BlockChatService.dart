
import 'package:chat_app/DataLayer/Networking/Chat/BlockChatWebAPIWorker.dart';
import 'package:chat_app/DataLayer/Networking/Chat/UnblockChatWebAPIWorker.dart';

class BlockChatService {

  BlockChatWebAPIWorker _blockChatWebAPIWorker = BlockChatWebAPIWorker();
  UnblockChatWebAPIWorker _unblockChatWebAPIWorker = UnblockChatWebAPIWorker();

  Future<void> blockChat(String chatId, String userId) async {
    return _blockChatWebAPIWorker.block(chatId, userId);
  }

  Future<void> unblockChat(String chatId, String userId) async {
    return _unblockChatWebAPIWorker.unblock(chatId, userId);
  }
}