
import 'package:chat_app/PresentationLayer/Screens/App/App.dart';
import 'package:flutter/material.dart';

class ChatOptionsActionsSheetBuilder {

  static void show(
      BuildContext context,
      {
        @required bool isBlockedByYou,
        @required VoidCallback onBlockTap,
        @required VoidCallback onUnblockTap,
      }) {
    showModalBottomSheet(
      context: context,
      builder: (context) => _buildSheet(context, isBlockedByYou, onBlockTap, onUnblockTap)
    );
  }

  static Widget _buildSheet(BuildContext context, bool isBlocked, VoidCallback onBlockTap, VoidCallback onUnblockTap) {
    return Container(
      color: appearance.background.primary,
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Wrap(
            children: [
              isBlocked ?
                _buildUnblockAction(context, onUnblockTap) :
                _buildBlockAction(context, onBlockTap),
            ],
          )
        )
      ),
    );
  }

  static Widget _buildDisruptiveAction(BuildContext context, String title, VoidCallback action) {
    return Container(
      child: InkWell(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          alignment: Alignment.center,
          child: Text(title, textAlign: TextAlign.center, style: TextStyle(color: appearance.text.disruptive, fontSize: 20)),
        ),
        onTap: () {
          Navigator.pop(context);
          action();
        },
      ),
    );
  }

  static Widget _buildBlockAction(BuildContext context, VoidCallback action) {
    return _buildDisruptiveAction(context, 'Block user', action);
  }

  static Widget _buildUnblockAction(BuildContext context, VoidCallback action) {
    return _buildDisruptiveAction(context, 'Unblock user', action);
  }
}