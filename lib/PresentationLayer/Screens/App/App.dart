
import 'package:chat_app/ApplicationLayer/Services/Start/InitAppService.dart';
import 'package:chat_app/ApplicationLayer/Services/User/CurrentUserService.dart';
import 'package:chat_app/ModelLayer/Business/User/User.dart';
import 'package:chat_app/PresentationLayer/Helpers/Model/Appearance/AppearanceType.dart';
import 'package:chat_app/PresentationLayer/Helpers/Model/Appearance/AppearancesFactory.dart';
import 'package:chat_app/PresentationLayer/Screens/App/LoadingScreen.dart';
import 'package:chat_app/PresentationLayer/Screens/Auth/SignIn/Screen/SignInScreen.dart';
import 'package:chat_app/PresentationLayer/Screens/Chats/ChatList/Screen/ChatListScreen.dart';
import 'package:flutter/material.dart';

final appearance = AppearancesFactory().createAppearance(AppearanceType.light);

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {

  // Dependencies
  final _initAppService = InitAppService();
  final _currentUserService = CurrentUserService();

  // Data
  bool _initialized = false;
  User _currentUser;

  // Init
  void initializeApp() async {
    try {
      await _initAppService.initialize();
      _currentUser = await _currentUserService.getCachedCurrentUser();
      setState(() {
        _initialized = true;
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
      initialRoute: '/',
      home: _buildStartScreen(),
    );
  }

  Widget _buildStartScreen() {
    if (!_initialized) {
      return LoadingScreen();
    } else if (_currentUser != null) {
      return ChatListScreen(user: _currentUser);
    } else {
      return SignInScreen();
    }
  }
}