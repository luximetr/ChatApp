
import 'package:chat_app/PresentationLayer/Helpers/Components/BottomActionsSheet/ActionsSheetItem.dart';
import 'package:chat_app/PresentationLayer/Helpers/Components/BottomActionsSheet/BottomActionsSheetBuilder.dart';
import 'package:chat_app/PresentationLayer/Screens/App/App.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReceivedMessageOptionsActionsSheetBuilder {

  static void show(
      BuildContext context, {
        @required bool isBlocked,
        @required VoidCallback onBlock,
        @required VoidCallback onUnblock,
        @required VoidCallback onReport,
      }) {
    showModalBottomSheet(
      context: context, 
      builder: (context) => _buildSheet(context, isBlocked, onBlock, onUnblock, onReport)
    );
  }
  
  static Widget _buildSheet(
      BuildContext context,
      bool isBlocked,
      VoidCallback onBlock,
      VoidCallback onUnblock,
      VoidCallback onReport,
    ) {
    final actions = List<ActionsSheetItem>();
    if (isBlocked) {
      actions.add(_createUnblockAction(onUnblock));
    } else {
      actions.add(_createBlockAction(onBlock));
    }
    actions.add(_createReportAction(onReport));

    return BottomActionsSheetBuilder.buildSheet(context, actions);
  }

  static ActionsSheetItem _createDisruptiveAction(String title, VoidCallback action) {
    return ActionsSheetItem(
        color: appearance.text.disruptive,
        title: title,
        action: action
    );
  }

  static ActionsSheetItem _createBlockAction(VoidCallback action) {
    return _createDisruptiveAction('Block message', action);
  }

  static ActionsSheetItem _createUnblockAction(VoidCallback action) {
    return _createDisruptiveAction('Unblock message', action);
  }

  static ActionsSheetItem _createReportAction(VoidCallback action) {
    return _createDisruptiveAction('Report', action);
  }
}