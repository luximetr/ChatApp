
import 'package:chat_app/ApplicationLayer/Services/Start/InitAppService.dart';
import 'package:chat_app/PresentationLayer/Helpers/Model/Appearance/AppearanceType.dart';
import 'package:chat_app/PresentationLayer/Helpers/Model/Appearance/AppearancesFactory.dart';
import 'package:chat_app/PresentationLayer/Screens/Auth/SignIn/SignInScreen.dart';
import 'package:flutter/material.dart';

final appearance = AppearancesFactory().createAppearance(AppearanceType.light);

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {

  bool _initialized = false;
  InitAppService _initAppService = InitAppService();

  void initializeApp() async {
    try {
      await _initAppService.initialize();
      setState(() {
        _initialized = true;
      });
    } catch(error) {
      setState(() {
        _initialized = false;
      });
    }
  }

  @override
  void initState() {
    initializeApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(
          backgroundColor: appearance.background.primary
      ),
      home: _buildStartScreen(),
    );
  }

  Widget _buildStartScreen() {
    if (!_initialized) {
      return _buildLoadingScreen();
    } else {
      return SignInScreen();
    }
  }

  Widget _buildLoadingScreen() {
    return Scaffold(
        body: Center(
          child: Text('Loading'),
        )
    );
  }
}