
import 'package:chat_app/ModelLayer/Business/Chat/Chat.dart';
import 'package:chat_app/PresentationLayer/Helpers/Components/AppBarBuilder.dart';
import 'package:chat_app/PresentationLayer/Screens/App/App.dart';
import 'package:chat_app/PresentationLayer/Screens/Chats/Chat/Helpers/InputMessageView.dart';
import 'package:chat_app/PresentationLayer/Screens/Chats/Chat/Helpers/MessageViewModel.dart';
import 'package:chat_app/PresentationLayer/Screens/Chats/Chat/Helpers/MessageViewModelStatus.dart';
import 'package:chat_app/PresentationLayer/Screens/Chats/Chat/Helpers/ReceivedMessageView.dart';
import 'package:chat_app/PresentationLayer/Screens/Chats/Chat/Helpers/SentMessageView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreenView extends StatefulWidget {

  final Chat chat;
  final Function (String text) onSendTap;
  final List<MessageViewModel> displayMessages;
  final MessageViewModelStatus Function(MessageViewModel message) getMessageStatusCallback;
  final VoidCallback onReachedScrollEnd;

  ChatScreenView({
    @required this.chat,
    @required this.onSendTap,
    @required this.displayMessages,
    @required this.getMessageStatusCallback,
    @required this.onReachedScrollEnd,
  });

  @override
  State<StatefulWidget> createState() => ChatScreenViewState();
}

class ChatScreenViewState extends State<ChatScreenView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBuilder.build(title: widget.chat.name),
      body: _buildBody(),
      backgroundColor: appearance.background.primary,
    );
  }

  Widget _buildBody() {
    return Container(
      child: SafeArea(
        child: Column(
          children: [
            _buildMessagesListView(),
            _buildInputMessageView(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessagesListView() {
    return Expanded(
      child: NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo) {
          if (scrollInfo.metrics.pixels > scrollInfo.metrics.maxScrollExtent - 100) {
            widget.onReachedScrollEnd();
          }
          return;
        },
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: ListView.builder(
            reverse: true,
            itemCount: widget.displayMessages.length,
            itemBuilder: (context, index) {
              return _buildMessageListItem(index);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMessageListItem(int index) {
    final message = widget.displayMessages[index];
    if (message.isFromCurrentUser) {
      return _buildSentMessageView(message);
    } else {
      return _buildReceivedMessageView(message);
    }
  }

  Widget _buildSentMessageView(MessageViewModel message) {
    return SentMessageView(
      text: message.text,
      time: message.time,
      status: widget.getMessageStatusCallback(message),
    );
  }

  Widget _buildReceivedMessageView(MessageViewModel message) {
    return ReceivedMessageView(
      text: message.text,
      time: message.time,
    );
  }

  Widget _buildInputMessageView() {
    return InputMessageView(
      onTapSend: (text) { widget.onSendTap(text); },
    );
  }
}