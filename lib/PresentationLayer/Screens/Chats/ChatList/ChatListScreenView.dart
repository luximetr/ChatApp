
import 'package:chat_app/PresentationLayer/Helpers/Components/AppBarBuilder.dart';
import 'package:chat_app/PresentationLayer/Helpers/Components/AvatarView.dart';
import 'package:chat_app/PresentationLayer/Screens/App/App.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatListScreenView extends StatelessWidget {

  final String userName;
  final VoidCallback onAvatarTap;
  final VoidCallback onCreateChat;

  ChatListScreenView({this.userName, this.onAvatarTap, this.onCreateChat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBuilder.build(
        title: 'Chats',
        trailing: AvatarView(title: "NA", side: 44, onTap: this.onAvatarTap),
      ),
      body: _buildList(),
      floatingActionButton: _buildCreateChatButton(),
    );
  }

  Widget _buildList() {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Text('item $index');
        }
    );
  }

  Widget _buildCreateChatButton() {
    return FloatingActionButton(
      onPressed: onCreateChat,
      child: Icon(Icons.add),
      backgroundColor: appearance.button.primary.background,
      foregroundColor: appearance.button.primary.title,
    );
  }
}