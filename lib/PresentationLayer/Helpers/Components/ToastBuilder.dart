
import 'package:chat_app/PresentationLayer/Screens/App/App.dart';
import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';

class ToastBuilder {

  static void show(BuildContext context, String message) {
    Toast.show(
      message,
      context,
      duration: Toast.LENGTH_LONG,
      gravity: Toast.BOTTOM,
      textColor: appearance.text.primary,
      backgroundColor: appearance.background.tertiary
    );
  }
}