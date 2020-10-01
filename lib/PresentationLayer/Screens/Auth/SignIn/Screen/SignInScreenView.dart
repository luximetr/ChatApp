import 'package:chat_app/PresentationLayer/Helpers/Components/TextInput.dart';
import 'package:chat_app/PresentationLayer/Screens/App/App.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInScreenView extends StatefulWidget {

  final Function(String login, String password) onSignIn;
  final VoidCallback onSignUp;
  final VoidCallback onChangeLogin;
  final VoidCallback onChangePassword;
  final String loginError;
  final String passwordError;

  SignInScreenView({
    @required this.onSignIn,
    @required this.onSignUp,
    @required this.onChangeLogin,
    @required this.onChangePassword,
    @required this.loginError,
    @required this.passwordError
  });

  @override
  State<StatefulWidget> createState() => SignInScreenViewState();
}

class SignInScreenViewState extends State<SignInScreenView> {

  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      backgroundColor: appearance.background.primary,
    );
  }

  Widget _buildBody(BuildContext context) {
    return GestureDetector(
      onTap: () { FocusScope.of(context).unfocus(); },
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              makeLoginTextField(),
              makePasswordTextField(),
              makeSignUpButton(),
              makeSignInButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeLoginTextField() {
    return Container(
      child: TextInput(
        controller: _loginController,
        placeholder: 'Login',
        errorText: widget.loginError,
        onChanged: (text) { widget.onChangeLogin(); },
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
        errorText: widget.passwordError,
        onChanged: (text) { widget.onChangePassword(); },
      ),
      margin: EdgeInsets.only(top: 6),
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
            onTap: () => {widget.onSignUp()},
          )
        ],
      ),
      margin: EdgeInsets.only(top: 6, bottom: 25),
    );
  }

  Widget makeSignInButton(BuildContext context) {
    return FlatButton(
      onPressed: () {
        this.widget.onSignIn(_loginController.text, _passwordController.text);
      },
      child: Text('Sign In'),
      color: appearance.button.primary.background,
      textColor: appearance.button.primary.title,
      height: 50,
      minWidth: (MediaQuery.of(context).size.width) - 18 * 2,
    );
  }
}
