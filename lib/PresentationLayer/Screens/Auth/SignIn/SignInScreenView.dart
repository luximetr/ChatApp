import 'package:chat_app/PresentationLayer/Helpers/Components/TextInput.dart';
import 'package:chat_app/PresentationLayer/Screens/App/App.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInScreenView extends StatelessWidget {

  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final Function(String login, String password) onSignIn;
  final VoidCallback onSignUp;

  SignInScreenView(this.onSignIn, this.onSignUp);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            makeLoginTextField(),
            makePasswordTextField(),
            makeSignUpButton(),
            makeSignInButton(context),
          ],
        ),
        color: appearance.background.primary,
        padding: EdgeInsets.symmetric(horizontal: 18),
      )
    );
  }

  Widget makeLoginTextField() {
    return Container(
      child: TextInput(
        controller: _loginController,
        placeholder: 'Login',
      ),
      margin: EdgeInsets.only(top: 200),
    );
  }

  Widget makePasswordTextField() {
    return Container(
      child: TextInput(
        controller: _passwordController,
        placeholder: 'Password',
        obscureText: true,
      ),
      margin: EdgeInsets.only(top: 20),
    );
  }

  Widget makeSignUpButton() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Don't have an account? ", style: TextStyle(color: appearance.text.secondary)),
          GestureDetector(
            child: Text('Sign Up', style: TextStyle(color: appearance.text.primary)),
            onTap: () => {onSignUp()},
          )
        ],
      ),
      margin: EdgeInsets.only(top: 25, bottom: 25),
    );
  }

  Widget makeSignInButton(BuildContext context) {
    return FlatButton(
      onPressed: () { this.onSignIn(_loginController.text, _passwordController.text); },
      child: Text('Sign In'),
      color: appearance.button.primary.background,
      textColor: appearance.button.primary.title,
      height: 50,
      minWidth: (MediaQuery.of(context).size.width) - 18 * 2,
    );
  }
}
