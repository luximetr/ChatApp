
import 'package:chat_app/PresentationLayer/Helpers/Components/TextInput.dart';
import 'package:chat_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpScreenView extends StatelessWidget {

  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

  final VoidCallback onSignIn;
  final Function(String login, String password, String repeatPassword) onSignUp;

  SignUpScreenView({this.onSignIn, this.onSignUp});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(children: [
          _buildLoginTextInput(),
          _buildPasswordTextInput(),
          _buildRepeatPasswordTextInput(),
          _buildSignInButton(),
          _buildSignUpButton(context),
        ]),
        padding: EdgeInsets.symmetric(horizontal: 18),
        color: appearance.background.primary,
      )
    );
  }

  Widget _buildLoginTextInput() {
    return Container(
      child: TextInput(
        controller: _loginController,
        placeholder: 'Login',
      ),
      margin: EdgeInsets.only(top: 120),
    );
  }

  Widget _buildPasswordTextInput() {
    return Container(
      child: TextInput(
        controller: _passwordController,
        placeholder: 'Password',
      ),
      margin: EdgeInsets.only(top: 20),
    );
  }

  Widget _buildRepeatPasswordTextInput() {
    return Container(
      child: TextInput(
        controller: _repeatPasswordController,
        placeholder: 'Repeat Password',
      ),
      margin: EdgeInsets.only(top: 20),
    );
  }

  Widget _buildSignInButton() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Already have an account? ', style: TextStyle(color: appearance.text.secondary)),
          Container(
            child: GestureDetector(
              child: Text('Sign In', style: TextStyle(color: appearance.text.primary)),
              onTap: () => {onSignIn()},
            )
          )
        ]
      ),
      margin: EdgeInsets.symmetric(vertical: 25),
    );
  }

  void _onSignUpPressed() {
    onSignUp(
      _loginController.text,
      _passwordController.text,
      _repeatPasswordController.text
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return FlatButton(
      onPressed: _onSignUpPressed,
      child: Text('Sign Up'),
      color: appearance.button.primary.background,
      textColor: appearance.button.primary.title,
      height: 50,
      minWidth: (MediaQuery.of(context).size.width) - 18 * 2,
    );
  }
}