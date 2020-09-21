
import 'package:chat_app/ApplicationLayer/Services/Chat/ChatListService.dart';
import 'package:chat_app/ModelLayer/Business/Chat/Chat.dart';
import 'package:chat_app/ModelLayer/Business/User/User.dart';
import 'package:chat_app/PresentationLayer/Screens/Chats/Chat/Screen/ChatScreen.dart';
import 'package:chat_app/PresentationLayer/Screens/Chats/ChatList/Screen/ChatListScreenView.dart';
import 'package:chat_app/PresentationLayer/Screens/Chats/CreateChat/Screen/CreateChatScreen.dart';
import 'package:chat_app/PresentationLayer/Screens/Profile/Screen/ProfileScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatListScreen extends StatefulWidget {

  final User user;

  ChatListScreen({@required this.user});

  @override
  State<StatefulWidget> createState() => ChatListScreenState();
}

class ChatListScreenState extends State<ChatListScreen> {

  // Dependencies

  final _chatListService = ChatListService();

  // Data
  List<Chat> _chats = [];

  // Life cycle
  @override
  void initState() {
    super.initState();
    _loadChatList();
  }

  // Build
  @override
  Widget build(BuildContext context) {
    return ChatListScreenView(
      chats: _chats,
      onAvatarTap: () { _onAvatarTap(context); },
      onCreateChat: () { _onCreateChat(context); },
      onChatTap: (chat) { _onChatTap(context, chat); },
    );
  }

  // Profile
  void _onAvatarTap(BuildContext context) {
    _navigateToProfile(context);
  }

  void _navigateToProfile(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => ProfileScreen(user: widget.user)
        )
    );
  }

  // Create chat
  void _onCreateChat(BuildContext context) {
    _navigateToCreateChat(context);
  }

  void _navigateToCreateChat(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => CreateChatScreen()
      )
    );
  }

  // Chat list
  void _loadChatList() {
    _chatListService
        .getChatList()
        .then((value) => _displayChatList(value))
        .catchError((error) => print(error));
  }

  void _displayChatList(List<Chat> chats) {
    setState(() {
      _chats = chats;
    });
  }

  // Open chat
  void _onChatTap(BuildContext context, Chat chat) {
    _navigateToChat(context, chat);
  }

  void _navigateToChat(BuildContext context, Chat chat) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => ChatScreen(chat: chat))
    );
  }

}