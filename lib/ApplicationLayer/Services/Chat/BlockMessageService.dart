
import 'package:chat_app/DataLayer/Networking/Chat/BlockMessageWebAPIWorker.dart';
import 'package:chat_app/DataLayer/Networking/Chat/UnblockMessageWebAPIWorker.dart';

class BlockMessageService {

  final _blockMessageWebAPIWorker = BlockMessageWebAPIWorker();
  final _unblockMessageWebAPIWorker = UnblockMessageWebAPIWorker();

  Future<void> blockMessage(String chatId, String messageId, String userId) async {
    return _blockMessageWebAPIWorker.block(chatId, messageId, userId);
  }

  Future<void> unblockMessage(String chatId, String messageId, String userId) async {
    return _unblockMessageWebAPIWorker.unblock(chatId, messageId, userId);
  }
}