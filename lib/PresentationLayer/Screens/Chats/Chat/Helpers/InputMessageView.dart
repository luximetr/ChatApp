
import 'package:chat_app/PresentationLayer/Helpers/Components/TextInput.dart';
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
    return SafeArea(child: Row(
      children: [
        _buildInputView(),
        _buildSendButton()
      ],
    ));
  }

  Widget _buildInputView() {
    return Expanded(
      child: TextInput(
        controller: _messageController,
      ),
    );
  }

  Widget _buildSendButton() {
    return Container(
      child: FlatButton(
          onPressed: _onSendMessageTap,
          child: Icon(Icons.send, color: appearance.text.primary)
      ),
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