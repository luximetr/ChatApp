
import 'package:chat_app/ApplicationLayer/Services/Auth/SignUpService.dart';
import 'package:chat_app/PresentationLayer/Screens/Auth/SignUp/SignUpScreenView.dart';
import 'package:flutter/cupertino.dart';

class SignUpScreen extends StatelessWidget {

  final SignUpService _signUpService = SignUpService();

  void _signUp(String login, String password) {
    _signUpService.signUp(login: login, password: password)
        .then((value) => print("Signed Up"))
        .catchError((error) { print('SignUp error: $error'); });
  }

  void _onSignIn(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _onSignUp(BuildContext context, String login, String password, String repeatPassword) {
    _signUp(login, password);
  }

  @override
  Widget build(BuildContext context) {
    return SignUpScreenView(
      onSignIn: () => { _onSignIn(context) },
      onSignUp: (login, password, repeatPassword) => { _onSignUp(context, login, password, repeatPassword) },
    );
  }
}