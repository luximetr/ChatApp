
import 'package:chat_app/ModelLayer/Business/Chat/Chat.dart';
import 'package:chat_app/PresentationLayer/Helpers/Components/AppBarBuilder.dart';
import 'package:chat_app/PresentationLayer/Screens/App/App.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreenView extends StatefulWidget {

  final Chat chat;

  ChatScreenView({@required this.chat});

  @override
  State<StatefulWidget> createState() => ChatScreenViewState();
}

class ChatScreenViewState extends State<ChatScreenView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBuilder.build(title: widget.chat.name),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      color: appearance.background.primary,
      child: Text('Body'),
    );
  }
}