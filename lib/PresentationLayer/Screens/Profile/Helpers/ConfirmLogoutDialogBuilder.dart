
import 'package:chat_app/PresentationLayer/Screens/App/App.dart';
import 'package:flutter/material.dart';

class ConfirmLogoutDialogBuilder {

  void show(BuildContext context, {VoidCallback onConfirm}) {
    final alert = _buildAlertDialog(context, onConfirm);
    showDialog(
      context: context,
      builder: (BuildContext context) => alert
    );
  }

  Widget _buildAlertDialog(BuildContext context, VoidCallback onConfirm) {
    return AlertDialog(
      title: _buildTitle(),
      content: _buildContent(),
      actions: [
        _buildConfirmAction(context, onConfirm),
        _buildCancelAction(context)
      ],
      backgroundColor: appearance.alert.background,
    );
  }

  Widget _buildTitle() {
    return Text(
      'My title',
      style: TextStyle(color: appearance.alert.title)
    );
  }

  Widget _buildContent() {
    return Text(
      'This is my message',
      style: TextStyle(color: appearance.alert.title)
    );
  }

  Widget _buildConfirmAction(BuildContext context, VoidCallback onConfirm) {
    return FlatButton(
      child: Text('OK', style: TextStyle(color: appearance.alert.secondaryAction)),
      onPressed: () {
        Navigator.of(context).pop();
        onConfirm();
      },
    );
  }

  Widget _buildCancelAction(BuildContext context) {
    return FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text('Cancel', style: TextStyle(color: appearance.alert.primaryAction))
    );
  }
}