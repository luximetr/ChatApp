
import 'package:chat_app/PresentationLayer/Helpers/Model/Appearance/Appearance.dart';
import 'package:chat_app/PresentationLayer/Helpers/Model/Appearance/AppearanceType.dart';
import 'package:flutter/material.dart';

class AppearancesFactory {

  Appearance createAppearance(AppearanceType type) {
    switch (type) {
      case AppearanceType.light: return _createLightAppearance();
      default: return _createLightAppearance();
    }
  }

  Appearance _createLightAppearance() {
    return Appearance(
      background: BackgroundAppearance(
        primary: Color.fromRGBO(55, 65, 89, 1),
        secondary: Color.fromRGBO(41, 47, 67, 1),
      ),
      text: TextAppearance(
        primary: Color.fromRGBO(176, 180, 191, 1),
        secondary: Color.fromRGBO(90, 98, 108, 1),
      ),
      button: ButtonAppearanceType(
        primary: ButtonAppearance(
          background: Color.fromRGBO(44, 110, 237, 1),
          title: Color.fromRGBO(200, 208, 201, 1)
        )
      )
    );
  }
}