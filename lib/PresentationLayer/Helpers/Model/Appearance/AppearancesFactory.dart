
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
        tertiary: Color.fromRGBO(69, 83, 121, 1)
      ),
      text: TextAppearance(
        primary: Color.fromRGBO(176, 180, 191, 1),
        secondary: Color.fromRGBO(90, 98, 108, 1),
        disruptive: Color.fromRGBO(250, 60, 60, 1),
      ),
      button: ButtonAppearanceType(
        primary: ButtonAppearance(
          background: Color.fromRGBO(44, 110, 237, 1),
          title: Color.fromRGBO(200, 208, 201, 1)
        ),
        secondary: ButtonAppearance(
          background: Colors.transparent,
          title: Color.fromRGBO(69, 83, 121, 1)
        ),
        tertiary: ButtonAppearance(
          background: Colors.transparent,
          title: Color.fromRGBO(200, 208, 201, 1),
        ),
      ),
      navigation: NavigationAppearance(
        background: Color.fromRGBO(41, 47, 67, 1)
      ),
      alert: AlertAppearance(
        background: Color.fromRGBO(69, 83, 121, 1),
        title: Color.fromRGBO(196, 200, 211, 1),
        primaryAction: Color.fromRGBO(225, 225, 225, 1),
        secondaryAction: Color.fromRGBO(180, 188, 198, 1),
      )
    );
  }
}