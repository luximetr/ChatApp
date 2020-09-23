
import 'package:chat_app/PresentationLayer/Helpers/Components/AvatarView.dart';
import 'package:chat_app/PresentationLayer/Screens/App/App.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatListItemView extends StatefulWidget {

  final String name;
  final VoidCallback onTap;

  ChatListItemView({@required this.name, @required this.onTap});

  @override
  State<StatefulWidget> createState() => ChatListItemViewState();
}

class ChatListItemViewState extends State<ChatListItemView> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () { widget.onTap(); },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Row(
            children: [
              AvatarView(title: 'NA', side: 50, backgroundColor: appearance.background.secondary),
              Expanded(
                child: Text(widget.name, style: TextStyle(fontSize: 16, color: appearance.text.primary), overflow: TextOverflow.ellipsis),
              ),
              Container(
                child: Icon(Icons.keyboard_arrow_right, color: appearance.text.secondary, size: 26),
                margin: EdgeInsets.only(left: 10),
              )
            ]),
      ),
    );
  }
}