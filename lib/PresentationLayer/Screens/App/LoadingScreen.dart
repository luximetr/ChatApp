
import 'package:chat_app/PresentationLayer/Helpers/Components/NamedRoute.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget with NamedRoute {
  @override final String routeName = '/loading';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Text('Loading'),
        )
    );
  }
}