
import 'package:chat_app/ApplicationLayer/Services/User/CurrentUserService.dart';
import 'package:chat_app/DataLayer/Networking/Chat/CreateChatWebAPIWorker.dart';
import 'package:chat_app/ModelLayer/Business/Chat/Chat.dart';
import 'package:chat_app/ModelLayer/Business/User/User.dart';

class CreateChatService {

  final _currentUserService = CurrentUserService();
  final _createChatWebAPIWorker = CreateChatWebAPIWorker();

  Future<Chat> createChat(User targetUser) async {
    final currentUser = await _currentUserService.getCachedCurrentUser();
    return _createChatWebAPIWorker.createChat(currentUser, targetUser);
  }
}