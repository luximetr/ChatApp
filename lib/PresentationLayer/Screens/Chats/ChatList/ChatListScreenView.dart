
import 'package:chat_app/PresentationLayer/Helpers/Components/AppBarBuilder.dart';
import 'package:chat_app/PresentationLayer/Helpers/Components/AvatarView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatListScreenView extends StatelessWidget {

  final String userName;
  final VoidCallback onAvatarTap;

  ChatListScreenView({this.userName, this.onAvatarTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBuilder.build(
        title: 'Chats',
        leading: AvatarView(title: "NA", side: 50, onTap: this.onAvatarTap),
      ),
      body: Text('Chats list'),
    );
  }
}