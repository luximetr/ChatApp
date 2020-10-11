
import 'package:chat_app/PresentationLayer/Helpers/Components/BottomActionsSheet/ActionsSheetItem.dart';
import 'package:chat_app/PresentationLayer/Helpers/Components/BottomActionsSheet/BottomActionsSheetBuilder.dart';
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
    final actions = List<ActionsSheetItem>();
    if (isBlocked) {
      actions.add(_buildUnblockAction(onUnblockTap));
    } else {
      actions.add(_buildBlockAction(onBlockTap));
    }

    return BottomActionsSheetBuilder.buildSheet(context, actions);
  }

  static ActionsSheetItem _buildDisruptiveAction(String title, VoidCallback action) {
    return ActionsSheetItem(
        title: title,
        color: appearance.text.disruptive,
        action: action
    );
  }

  static ActionsSheetItem _buildBlockAction(VoidCallback action) {
    return _buildDisruptiveAction('Block user', action);
  }

  static ActionsSheetItem _buildUnblockAction(VoidCallback action) {
    return _buildDisruptiveAction('Unblock user', action);
  }
}