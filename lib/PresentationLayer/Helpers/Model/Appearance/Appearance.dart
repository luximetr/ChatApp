
import 'package:flutter/material.dart';

class Appearance {
  BackgroundAppearance background;
  TextAppearance text;
  NavigationAppearance navigation;
  ButtonAppearanceType button;

  Appearance({this.background, this.text, this.navigation, this.button});
}

class BackgroundAppearance {
  Color primary;
  Color secondary;
  Color primaryDivider;
  Color disruptiveDivider;

  BackgroundAppearance({this.primary, this.secondary, this.primaryDivider, this.disruptiveDivider});
}

class TextAppearance {
  Color primary;
  Color secondary;

  TextAppearance({this.primary, this.secondary});
}

class NavigationAppearance {
  Color background;
  Color tint;
  Color shadow;

  NavigationAppearance({this.background, this.tint, this.shadow});
}

class ButtonAppearance {
  Color background;
  Color title;
  Color shadow;

  ButtonAppearance({this.background, this.title, this.shadow});
}

class ButtonAppearanceType {
  ButtonAppearance primary;

  ButtonAppearanceType({this.primary});
}

