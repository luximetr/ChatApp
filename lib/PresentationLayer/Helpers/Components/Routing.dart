
import 'package:chat_app/PresentationLayer/Helpers/Components/NamedRoute.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routing {

  static void push({
    @required BuildContext context,
    @required NamedRoute targetScreen,
  }) {
    final routeSettings = RouteSettings(name: targetScreen.routeName);
    final route = MaterialPageRoute(builder: (context) => targetScreen, settings: routeSettings);
    Navigator.of(context).push(route);
  }

  static void pushAndRemoveUntil({
    @required BuildContext context,
    @required NamedRoute targetScreen,
    @required String removeUntil,
  }) {
    final routeSettings = RouteSettings(name: targetScreen.routeName);
    final route = MaterialPageRoute(builder: (context) => targetScreen, settings: routeSettings);
    Navigator.of(context).pushAndRemoveUntil(route, (_route) {
      return ModalRoute.withName(removeUntil)(_route) || _route.isFirst;
    });
  }

  static void pushAndRemoveUntilRoot({
    @required BuildContext context,
    @required NamedRoute targetScreen,
  }) {
    pushAndRemoveUntil(context: context, targetScreen: targetScreen, removeUntil: Navigator.defaultRouteName);
  }

  static void pushReplacement({
    @required BuildContext context,
    @required NamedRoute targetScreen,
  }) {
    final route = _createNamedMaterialPageRoute(targetScreen);
    Navigator.of(context).pushReplacement(route);
  }

  static void pushReplacementAll({
    @required BuildContext context,
    @required NamedRoute targetScreen,
  }) {
    final route = _createNamedMaterialPageRoute(targetScreen);
    Navigator.of(context).pushAndRemoveUntil(route, (route) => false);
  }

  static void popUntil({
    @required BuildContext context,
    @required String removeUntil,
  }) {
    Navigator.of(context).popUntil(ModalRoute.withName(removeUntil));
  }

  static void popToRoot({
    @required BuildContext context
  }) {
    popUntil(context: context, removeUntil: Navigator.defaultRouteName);
  }

  // Private
  static Route<dynamic> _createNamedMaterialPageRoute(NamedRoute targetScreen) {
    final routeSettings = RouteSettings(name: targetScreen.routeName);
    return MaterialPageRoute(builder: (context) => targetScreen, settings: routeSettings);
  }
}