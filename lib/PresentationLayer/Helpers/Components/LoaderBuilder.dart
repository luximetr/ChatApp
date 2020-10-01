
import 'dart:ui';
import 'package:chat_app/PresentationLayer/Screens/App/App.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class LoaderBuilder {

  static void show(BuildContext context) {
    FocusScope.of(context).unfocus();
    Loader.show(
      context,
      progressIndicator: _buildLoaderView(),
      themeData: Theme.of(context).copyWith(accentColor: appearance.text.primary),
      overlayColor: Colors.transparent
    );
  }

  static void hide() {
    Loader.hide();
  }

  static Widget _buildLoaderView() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Container(
        height: 50,
        width: 50,
        child: CircularProgressIndicator(
            backgroundColor: Colors.transparent
        ),
      ),
    );
  }
}