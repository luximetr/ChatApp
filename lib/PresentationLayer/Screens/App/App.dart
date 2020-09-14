
import 'package:chat_app/ApplicationLayer/Services/Start/InitAppService.dart';
import 'package:chat_app/ApplicationLayer/Services/User/CurrentUserService.dart';
import 'package:chat_app/PresentationLayer/Helpers/Model/Appearance/AppearanceType.dart';
import 'package:chat_app/PresentationLayer/Helpers/Model/Appearance/AppearancesFactory.dart';
import 'package:chat_app/PresentationLayer/Screens/Auth/SignIn/SignInScreen.dart';
import 'package:chat_app/PresentationLayer/Screens/Chats/ChatList/ChatListScreen.dart';
import 'package:flutter/material.dart';

final appearance = AppearancesFactory().createAppearance(AppearanceType.light);

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {

  bool _initialized = false;
  bool _needShowAuthFirst = true;
  final _initAppService = InitAppService();
  final _currentUserService = CurrentUserService();

  void initializeApp() async {
    try {
      await _initAppService.initialize();
      final hasCurrentUser = await _currentUserService.getHasCurrentUser();
      setState(() {
        _initialized = true;
        _needShowAuthFirst = !hasCurrentUser;
      });
    } catch(error) {
      print('Init app error: $error');
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
    } else if (_needShowAuthFirst) {
      return SignInScreen();
    } else {
      return ChatListScreen();
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