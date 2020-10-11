
import 'package:chat_app/PresentationLayer/Helpers/Components/BottomActionsSheet/ActionsSheetItem.dart';
import 'package:chat_app/PresentationLayer/Screens/App/App.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BottomActionsSheetBuilder {

  static Widget buildSheet(BuildContext context, List<ActionsSheetItem> items) {
    return Container(
      color: appearance.background.primary,
      child: SafeArea(
          child: Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Wrap(
                children: _buildSheetItems(context, items),
              )
          )
      ),
    );
  }

  static List<Widget> _buildSheetItems(BuildContext context, List<ActionsSheetItem> items) {
    return items.map((item) => _buildSheetItem(context, item)).toList();
  }

  static Widget _buildSheetItem(BuildContext context, ActionsSheetItem item) {
    return Container(
      child: InkWell(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          alignment: Alignment.center,
          child: Text(item.title, textAlign: TextAlign.center, style: TextStyle(color: item.color, fontSize: 20)),
        ),
        onTap: () {
          Navigator.pop(context);
          item.action();
        },
      ),
    );
  }
}