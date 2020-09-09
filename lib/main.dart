import 'package:chat_app/PresentationLayer/Helpers/Model/Appearance/AppearanceType.dart';
import 'package:chat_app/PresentationLayer/Helpers/Model/Appearance/AppearancesFactory.dart';
import 'package:flutter/material.dart';

import 'PresentationLayer/Screens/Auth/SignIn/SignInScreen.dart';

final appearance = AppearancesFactory().createAppearance(AppearanceType.light);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(
        backgroundColor: appearance.background.primary
      ),
      home: SignInScreen(),
    );
  }
}

