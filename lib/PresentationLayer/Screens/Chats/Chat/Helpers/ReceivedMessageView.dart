
import 'package:chat_app/PresentationLayer/Screens/App/App.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReceivedMessageView extends StatefulWidget {

  final String text;
  final String time;
  final bool isBlocked;
  final VoidCallback onLongPress;

  ReceivedMessageView({
    @required this.text,
    @required this.time,
    @required this.isBlocked,
    @required this.onLongPress,
  });

  @override
  State<StatefulWidget> createState() => ReceivedMessageViewState();
}

class ReceivedMessageViewState extends State<ReceivedMessageView> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildMessageCloudView(),
          _buildTimeView(),
        ],
      ),
    );
  }

  // Time
  Widget _buildTimeView() {
    return Container(
      margin: EdgeInsets.only(left: 6, bottom: 2),
      child: Text(widget.time, style: TextStyle(fontSize: 14, color: appearance.text.secondary)),
    );
  }

  // Message cloud
  Widget _buildMessageCloudView() {
    return Flexible(
      child: GestureDetector(
        onLongPress: () { widget.onLongPress(); },
        child: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: appearance.background.secondary,
          ),
          child: _buildMessageCloudContent(),
        ),
      )
    );
  }

  Widget _buildMessageCloudContent() {
    if (widget.isBlocked) {
      return _buildBlocked();
    } else {
      return _buildText();
    }
  }

  Widget _buildText() {
    return Text(
        widget.text,
        style: TextStyle(fontSize: 18, color: appearance.text.primary)
    );
  }

  Widget _buildBlocked() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.visibility_off, size: 20, color: appearance.text.secondary),
        Container(
          padding: EdgeInsets.only(left: 6, right: 4),
          child: Text('Blocked message', style: TextStyle(color: appearance.text.secondary, fontSize: 18)),
        )
      ],
    );
  }
}