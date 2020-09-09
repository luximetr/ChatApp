import 'package:chat_app/PresentationLayer/Screens/Auth/SignIn/SignInScreenView.dart';
import 'package:chat_app/PresentationLayer/Screens/Auth/SignUp/SignUpScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SignInScreenView((login, password) {
      print('sign in with $login and $password');
    }, () {
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => SignUpScreen())
      );
    });
  }
}
