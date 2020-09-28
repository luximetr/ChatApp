
import 'package:chat_app/PresentationLayer/Screens/App/App.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'MessageViewModel.dart';

class SentMessageView extends StatefulWidget {

  final String text;
  final String time;
  final MessageViewModelStatus status;

  SentMessageView({
    @required this.text,
    @required this.time,
    @required this.status,
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
          style: TextStyle(fontSize: 14, color: appearance.text.secondary)
      ),
    );
  }

  // Message cloud
  Widget _buildMessageCloudView(BuildContext context) {
    return Container(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
        padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: appearance.background.tertiary,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildTextView(),
            _buildStatusView(),
          ],
        )
    );
  }

  Widget _buildTextView() {
    return Flexible(
      child: Container(
        margin: EdgeInsets.only(bottom: 5, left: 3),
        child: Text(widget.text, style: TextStyle(fontSize: 18, color: appearance.text.primary)),
      )
    );
  }

  // Status
  Widget _buildStatusView() {
    return Container(
      margin: EdgeInsets.only(left: 6),
      child: Icon(_getStatusIcon(), size: 16, color: appearance.text.primary),
    );
  }

  IconData _getStatusIcon() {
    switch (widget.status) {
      case MessageViewModelStatus.sending:
        return Icons.schedule;
      case MessageViewModelStatus.sent:
        return Icons.done;
      case MessageViewModelStatus.read:
        return Icons.done_all;
      default:
        return Icons.error_outline;
    }
  }
}