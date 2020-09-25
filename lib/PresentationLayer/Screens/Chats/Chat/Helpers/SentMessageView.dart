
import 'package:chat_app/PresentationLayer/Screens/App/App.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SentMessageView extends StatefulWidget {

  final String text;
  final String time;

  SentMessageView({
    @required this.text,
    @required this.time,
  });

  @override
  State<StatefulWidget> createState() => SentMessageViewState();
}

class SentMessageViewState extends State<SentMessageView> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildTimeView(),
          _buildMessageCloudView(context),
        ],
      ),
    );
  }

  // Time
  Widget _buildTimeView() {
    return Container(
      margin: EdgeInsets.only(right: 6, left: 10, bottom: 2),
      child: Text(
          widget.time,
          style: TextStyle(fontSize: 15, color: appearance.text.secondary)
      ),
    );
  }

  // Message cloud
  Widget _buildMessageCloudView(BuildContext context) {
    return Flexible(
        child: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: appearance.background.tertiary,
          ),
          child: Text(widget.text, style: TextStyle(fontSize: 18, color: appearance.text.primary)),
        )
    );
  }
}