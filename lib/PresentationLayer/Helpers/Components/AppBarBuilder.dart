
import 'package:chat_app/PresentationLayer/Screens/App/App.dart';
import 'package:flutter/material.dart';

class AppBarBuilder {

  static AppBar build({String title, Widget leading, Widget trailing}) {
    return AppBar(
      title: Text(title ?? '', style: TextStyle(color: appearance.navigation.tint)),
      leading: leading,
      actions: trailing != null ? [trailing] : [],
      backgroundColor: appearance.navigation.background,
    );
  }
}
