
import 'package:chat_app/PresentationLayer/Screens/Auth/SignUp/SignUpScreenView.dart';
import 'package:flutter/cupertino.dart';

class SignUpScreen extends StatelessWidget {

  void _onSignIn(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _onSignUp(BuildContext context, String login, String password, String repeatPassword) {
    print('Continue with $login $password $repeatPassword');
  }

  @override
  Widget build(BuildContext context) {
    return SignUpScreenView(
      onSignIn: () => { _onSignIn(context) },
      onSignUp: (login, password, repeatPassword) => { _onSignUp(context, login, password, repeatPassword) },
    );
  }
}