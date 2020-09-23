
import 'package:chat_app/ApplicationLayer/Services/User/CurrentUserService.dart';
import 'package:chat_app/DataLayer/Networking/Chat/CreateChatWebAPIWorker.dart';
import 'package:chat_app/ModelLayer/Business/Chat/Chat.dart';

class CreateChatService {

  final _currentUserService = CurrentUserService();
  final _createChatWebAPIWorker = CreateChatWebAPIWorker();

  Future<Chat> createChat(String targetUserId) async {
    final currentUserId = await _currentUserService.getCachedCurrentUserId();
    return _createChatWebAPIWorker.createChat(currentUserId, targetUserId);
  }
}