
import 'package:chat_app/ApplicationLayer/Services/Auth/SignInService.dart';
import 'package:chat_app/PresentationLayer/Screens/Auth/SignIn/SignInScreenView.dart';
import 'package:chat_app/PresentationLayer/Screens/Auth/SignUp/SignUpScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {

  final SignInService _signInService = SignInService();

  void signIn(String login, String password) {
    _signInService
        .signIn(login: login, password: password)
        .then((result) => print('completed'))
        .catchError((error) { print('Error1: $error'); });
  }

  @override
  Widget build(BuildContext context) {
    return SignInScreenView((login, password) {
      signIn(login, password);
    }, () {
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => SignUpScreen())
      );
    });
  }
}
