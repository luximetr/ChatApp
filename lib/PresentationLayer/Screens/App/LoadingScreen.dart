
import 'package:chat_app/PresentationLayer/Helpers/Components/NamedRoute.dart';
import 'package:chat_app/PresentationLayer/Screens/App/App.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget with NamedRoute {
  @override final String routeName = '/loading';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Center(
            child: Text('Loading...', style: TextStyle(color: appearance.text.primary)),
          ),
          color: appearance.background.primary,
        )
    );
  }
}