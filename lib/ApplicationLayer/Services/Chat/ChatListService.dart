
import 'package:chat_app/ModelLayer/Business/Chat/Chat.dart';

class ChatListService {

  Future<List<Chat>> getChatList() async {
    return Future.delayed(new Duration(seconds: 2), () {
      return Future.value([
        Chat(id: 'chat1', name: 'Chat room 1'),
        Chat(id: 'chat2', name: 'Chat room 2'),
        Chat(id: 'chat3', name: 'Chat room 3')
      ]);
    });
  }
}