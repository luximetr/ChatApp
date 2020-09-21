
import 'package:chat_app/ApplicationLayer/Services/Auth/SignUpService.dart';
import 'package:chat_app/ModelLayer/Business/User/User.dart';
import 'package:chat_app/PresentationLayer/Screens/Auth/SignUp/SignUpScreenView.dart';
import 'package:chat_app/PresentationLayer/Screens/Chats/ChatList/Screen/ChatListScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {

  final SignUpService _signUpService = SignUpService();

  void _signUp(BuildContext context, String name, String login, String password) {
    _signUpService.signUp(name: name, login: login, password: password)
        .then((user) => navigateToChatList(context, user))
        .catchError((error) { print('SignUp error: $error'); });
  }

  void _onSignIn(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _onSignUp(BuildContext context, String name, String login, String password, String repeatPassword) {
    _signUp(context, name, login, password);
  }

  @override
  Widget build(BuildContext context) {
    return SignUpScreenView(
      onSignIn: () => { _onSignIn(context) },
      onSignUp: (name, login, password, repeatPassword) => { _onSignUp(context, name, login, password, repeatPassword) },
    );
  }

  void navigateToChatList(BuildContext context, User user) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => ChatListScreen(user: user)
        ),
        (Route<dynamic> route) => false
    );
  }
}