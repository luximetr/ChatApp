
import 'dart:async';

import 'package:chat_app/ApplicationLayer/Services/User/CurrentUserService.dart';
import 'package:chat_app/DataLayer/Networking/Chat/ChatListUpdatesWebAPIWorker.dart';
import 'package:chat_app/DataLayer/Networking/Chat/GetChatListWebAPIWorker.dart';
import 'package:chat_app/ModelLayer/Business/Chat/Chat.dart';
import 'package:chat_app/ModelLayer/Business/ChatListEvent/ChatListEvent.dart';
import 'package:chat_app/ModelLayer/Common/RemoteDBEvent/RemoteDBEventType.dart';

class ChatListService {

  final _currentUserService = CurrentUserService();
  final _getChatListWebAPIWorker = GetChatListWebAPIWorker();
  final _chatListUpdatesWebAPIWorker = ChatListUpdatesWebAPIWorker();

  Future<List<Chat>> getChatList() async {
    final userId = await _currentUserService.getCachedCurrentUserId();
    return _getChatListWebAPIWorker.getChatList(userId);
  }

  StreamSubscription<ChatListEvent> startListenChatListUpdates(String currentUserId) {
    return _chatListUpdatesWebAPIWorker
        .startListenUpdates(currentUserId)
        .listen(null);
  }

  StreamSubscription<Chat> startListenChatUpdates(String currentUserId, String chatId) {
    return _chatListUpdatesWebAPIWorker
      .startListenUpdates(currentUserId)
      .where((event) => event.type == RemoteDBEventType.updated)
      .where((event) => event.data.id == chatId)
      .map((event) => event.data)
      .listen(null);
  }

  void stopListenChatListUpdates() {
    _chatListUpdatesWebAPIWorker.stopListenUpdates();
  }
}