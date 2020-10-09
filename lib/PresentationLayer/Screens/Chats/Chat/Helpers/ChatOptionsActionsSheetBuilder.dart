
import 'package:chat_app/PresentationLayer/Screens/App/App.dart';
import 'package:flutter/material.dart';

class ChatOptionsActionsSheetBuilder {

  static void show(BuildContext context, {@required VoidCallback onBlockTap}) {
    showModalBottomSheet(
      context: context,
      builder: (context) => _buildSheet(context, onBlockTap)
    );
  }

  static Widget _buildSheet(BuildContext context, VoidCallback onBlockTap) {
    return Container(
      color: appearance.background.primary,
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Wrap(
            children: [
              _buildBlockAction(context, onBlockTap),
            ],
          )
        )
      ),
    );
  }

  static Widget _buildBlockAction(BuildContext context, VoidCallback action) {
    return Container(
      child: InkWell(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          alignment: Alignment.center,
          child: Text('Block user', textAlign: TextAlign.center, style: TextStyle(color: appearance.text.disruptive, fontSize: 20)),
        ),
        onTap: () {
          Navigator.pop(context);
          action();
        },
      ),
    );
  }
}