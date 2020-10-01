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

  // Dependencies
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _passwordFocus = FocusNode();

  // Data
  bool _passwordSecure = true;

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
              makeLoginTextField(context),
              makePasswordTextField(),
              makeSignUpButton(),
              makeSignInButton(context),
            ],
          ),
        ),
      ),
    );
  }

  // Login
  Widget makeLoginTextField(BuildContext context) {
    return Container(
      child: TextInput(
        controller: _loginController,
        placeholder: 'Login',
        errorText: widget.loginError,
        textInputAction: TextInputAction.next,
        onChanged: (text) { widget.onChangeLogin(); },
        onSubmitted: (text) { _makePasswordInFocus(context); },
      ),
      margin: EdgeInsets.only(top: 200),
    );
  }

  // Password
  Widget makePasswordTextField() {
    return Container(
      child: TextInput(
        controller: _passwordController,
        placeholder: 'Password',
        obscureText: _passwordSecure,
        errorText: widget.passwordError,
        focusNode: _passwordFocus,
        suffixIcon: _buildPasswordVisibilityButton(),
        onChanged: (text) { widget.onChangePassword(); },
        onSubmitted: (text) { _onSignIn(); },
      ),
      margin: EdgeInsets.only(top: 6),
    );
  }

  Widget _buildPasswordVisibilityButton() {
    return GestureDetector(
      child: Icon(
        _passwordSecure ? Icons.visibility : Icons.visibility_off,
        color: appearance.text.secondary,
      ),
      onTap: _handleTapOnPasswordVisibilityButton,
    );
  }

  void _handleTapOnPasswordVisibilityButton() {
    setState(() { _passwordSecure = !_passwordSecure; });
  }

  void _makePasswordInFocus(BuildContext context) {
    FocusScope.of(context).requestFocus(_passwordFocus);
  }

  // Sign up
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

  // Sign in
  Widget makeSignInButton(BuildContext context) {
    return FlatButton(
      onPressed: _onSignIn,
      child: Text('Sign In'),
      color: appearance.button.primary.background,
      textColor: appearance.button.primary.title,
      height: 50,
      minWidth: (MediaQuery.of(context).size.width) - 18 * 2,
    );
  }

  void _onSignIn() {
    this.widget.onSignIn(_loginController.text, _passwordController.text);
  }
}
