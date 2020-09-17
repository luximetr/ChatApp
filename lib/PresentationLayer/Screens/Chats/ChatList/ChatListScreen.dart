
import 'package:chat_app/ModelLayer/Business/User/User.dart';
import 'package:chat_app/PresentationLayer/Screens/Chats/ChatList/ChatListScreenView.dart';
import 'package:chat_app/PresentationLayer/Screens/Chats/CreateChat/Screen/CreateChatScreen.dart';
import 'package:chat_app/PresentationLayer/Screens/Profile/Screen/ProfileScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatListScreen extends StatelessWidget {

  final User user;

  ChatListScreen({@required this.user});

  void _onAvatarTap(BuildContext context) {
    _navigateToProfile(context);
  }

  void _onCreateChat(BuildContext context) {
    _navigateToCreateChat(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChatListScreenView(
      onAvatarTap: () { _onAvatarTap(context); },
      onCreateChat: () { _onCreateChat(context); },
    );
  }

  void _navigateToProfile(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => ProfileScreen(user: user)
        )
    );
  }

  void _navigateToCreateChat(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => CreateChatScreen()
      )
    );
  }

}