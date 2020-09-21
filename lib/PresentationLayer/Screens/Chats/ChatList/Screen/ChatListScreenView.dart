
import 'package:chat_app/ModelLayer/Business/Chat/Chat.dart';
import 'package:chat_app/PresentationLayer/Helpers/Components/AppBarBuilder.dart';
import 'package:chat_app/PresentationLayer/Helpers/Components/AvatarView.dart';
import 'package:chat_app/PresentationLayer/Screens/App/App.dart';
import 'package:chat_app/PresentationLayer/Screens/Chats/ChatList/Helpers/ChatListItemView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatListScreenView extends StatefulWidget {

  final String userName;
  final VoidCallback onAvatarTap;
  final VoidCallback onCreateChat;
  final List<Chat> chats;
  final Function(Chat chat) onChatTap;

  ChatListScreenView({this.userName, this.onAvatarTap, this.onCreateChat, this.chats, this.onChatTap});

  @override
  State<StatefulWidget> createState() => ChatListScreenViewState();
}

class ChatListScreenViewState extends State<ChatListScreenView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBuilder.build(
        title: 'Chats',
        trailing: AvatarView(title: "NA", side: 44, onTap: widget.onAvatarTap),
      ),
      body: _buildBody(),
      floatingActionButton: _buildCreateChatButton(),
    );
  }

  Widget _buildBody() {
    return Container(
      child: _buildList(),
      color: appearance.background.primary,
    );
  }

  Widget _buildList() {
    return ListView.builder(
        itemCount: widget.chats.length,
        itemBuilder: (BuildContext context, int index) {
          final chat = widget.chats[index];
          return ChatListItemView(
              name: chat.name,
              onTap: () { widget.onChatTap(chat); }
          );
        }
    );
  }

  Widget _buildCreateChatButton() {
    return FloatingActionButton(
      onPressed: widget.onCreateChat,
      child: Icon(Icons.add),
      backgroundColor: appearance.button.primary.background,
      foregroundColor: appearance.button.primary.title,
    );
  }
}