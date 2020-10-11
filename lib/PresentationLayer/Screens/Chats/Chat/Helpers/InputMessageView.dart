
import 'package:chat_app/PresentationLayer/Screens/App/App.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputMessageView extends StatefulWidget {

  final Function(String message) onTapSend;

  InputMessageView({@required this.onTapSend});

  @override
  State<StatefulWidget> createState() => InputMessageViewState();
}

class InputMessageViewState extends State<InputMessageView> {

  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildInputView(),
          _buildSendButton()
        ],
      ),
    );
  }

  Widget _buildInputView() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: TextField(
            controller: _messageController,
            autocorrect: false,
            minLines: 1,
            maxLines: 5,
            style: TextStyle(color: appearance.text.primary, fontSize: 18),
            decoration: InputDecoration(
              filled: true,
              fillColor: appearance.background.secondary,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSendButton() {
    return Container(
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: _onSendMessageTap,
        child: Icon(Icons.send, color: appearance.button.tertiary.title, size: 26)
      ),
      margin: EdgeInsets.only(left: 10, right: 12),
      height: 50,
      width: 50,
    );
  }
  
  void _onSendMessageTap() {
    if (_messageController.text.isEmpty) { return; }
    widget.onTapSend(_messageController.text);
    _messageController.clear();
  }
}