
import 'package:flutter/material.dart';

class Appearance {
  BackgroundAppearance background;
  TextAppearance text;
  NavigationAppearance navigation;
  ButtonAppearanceType button;
  AlertAppearance alert;

  Appearance({this.background, this.text, this.navigation, this.button, this.alert});
}

class BackgroundAppearance {
  Color primary;
  Color secondary;
  Color tertiary;
  Color primaryDivider;
  Color disruptiveDivider;

  BackgroundAppearance({this.primary, this.secondary, this.tertiary, this.primaryDivider, this.disruptiveDivider});
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
  ButtonAppearance secondary;
  ButtonAppearance tertiary;

  ButtonAppearanceType({this.primary, this.secondary, this.tertiary});
}

class AlertAppearance {
  Color background;
  Color title;
  Color primaryAction;
  Color secondaryAction;

  AlertAppearance({this.background, this.title, this.primaryAction, this.secondaryAction});
}