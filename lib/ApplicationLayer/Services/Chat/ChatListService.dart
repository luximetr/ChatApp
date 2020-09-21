
import 'package:chat_app/ApplicationLayer/Services/User/CurrentUserService.dart';
import 'package:chat_app/DataLayer/Networking/Chat/GetChatListWebAPIWorker.dart';
import 'package:chat_app/ModelLayer/Business/Chat/Chat.dart';

class ChatListService {

  final _currentUserService = CurrentUserService();
  final _getChatListWebAPIWorker = GetChatListWebAPIWorker();

  Future<List<Chat>> getChatList() async {
    final userId = await _currentUserService.getCachedCurrentUserId();
    return _getChatListWebAPIWorker.getChatList(userId);
  }
}