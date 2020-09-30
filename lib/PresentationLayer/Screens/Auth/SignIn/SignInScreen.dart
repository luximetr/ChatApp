
import 'package:chat_app/ApplicationLayer/Services/Auth/SignInService.dart';
import 'package:chat_app/ModelLayer/Business/User/User.dart';
import 'package:chat_app/PresentationLayer/Helpers/Components/NamedRoute.dart';
import 'package:chat_app/PresentationLayer/Screens/Auth/SignIn/SignInScreenView.dart';
import 'package:chat_app/PresentationLayer/Screens/Auth/SignUp/SignUpScreen.dart';
import 'package:chat_app/PresentationLayer/Screens/Chats/ChatList/Screen/ChatListScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget with NamedRoute {
  @override final String routeName = '/sign_in';

  final _signInService = SignInService();

  void _signIn(String login, String password, BuildContext context) {
    _signInService
        .signIn(login: login, password: password)
        .then((user) => navigateToChatList(context, user))
        .catchError((error) { print('Error1: $error'); });
  }

  void _onSignIn(String login, String password, BuildContext context) {
    _signIn(login, password, context);
  }

  void _onSignUp(BuildContext context) {
    navigateToSignUp(context);
  }

  @override
  Widget build(BuildContext context) {
    return SignInScreenView(
        onSignIn: (login, password) { _onSignIn(login, password, context); },
        onSignUp: () { _onSignUp(context); }
    );
  }

  void navigateToSignUp(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => SignUpScreen()
        )
    );
  }

  void navigateToChatList(BuildContext context, User user) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (context) => ChatListScreen(user: user,)
      )
    );
  }
}
