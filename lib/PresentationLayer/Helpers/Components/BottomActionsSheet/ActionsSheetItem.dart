
import 'dart:ui';

import 'package:flutter/cupertino.dart';

class ActionsSheetItem {
  Color color;
  String title;
  VoidCallback action;

  ActionsSheetItem({
    @required this.color,
    @required this.title,
    @required this.action
  });
}