
import 'package:chat_app/PresentationLayer/Helpers/Components/TextInput.dart';
import 'package:chat_app/PresentationLayer/Screens/App/App.dart';
import 'package:chat_app/PresentationLayer/Screens/Auth/SignUp/Helpers/SignUpScreenForm.dart';
import 'package:chat_app/PresentationLayer/Screens/Auth/SignUp/Helpers/SignUpScreenFormErrors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpScreenView extends StatefulWidget {

  final VoidCallback onSignIn;
  final Function(SignUpScreenForm form) onSignUp;
  final SignUpScreenFormErrors errors;

  SignUpScreenView({this.onSignIn, this.onSignUp, this.errors});

  @override
  State<StatefulWidget> createState() => SignUpScreenViewState();
}

class SignUpScreenViewState extends State<SignUpScreenView> {

  final _nameController = TextEditingController();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      resizeToAvoidBottomInset: false,
    );
  }

  // Body
  Widget _buildBody() {
    return Container(
      child: Column(children: [
        _buildNameTextInput(),
        _buildLoginTextInput(),
        _buildPasswordTextInput(),
        _buildRepeatPasswordTextInput(),
        _buildSignInButton(),
        _buildSignUpButton(context),
      ]),
      padding: EdgeInsets.symmetric(horizontal: 18),
      color: appearance.background.primary,
    );
  }

  // Name
  Widget _buildNameTextInput() {
    return Container(
      child: TextInput(
        controller: _nameController,
        placeholder: 'Name',
        errorText: widget.errors.nameError,
        onChanged: (text) { _hideNameError(); },
      ),
      margin: EdgeInsets.only(top: 120),
    );
  }

  void _hideNameError() {
    setState(() { widget.errors.nameError = null; });
  }

  // Login
  Widget _buildLoginTextInput() {
    return Container(
      child: TextInput(
        controller: _loginController,
        placeholder: 'Login',
        errorText: widget.errors.loginError,
        onChanged: (text) { _hideLoginError(); },
      ),
      margin: EdgeInsets.only(top: 6),
    );
  }

  void _hideLoginError() {
    setState(() { widget.errors.loginError = null; });
  }

  // Password
  Widget _buildPasswordTextInput() {
    return Container(
      child: TextInput(
        controller: _passwordController,
        placeholder: 'Password',
        obscureText: true,
        errorText: widget.errors.passwordError,
        onChanged: (text) { _hidePasswordError(); },
      ),
      margin: EdgeInsets.only(top: 6),
    );
  }

  void _hidePasswordError() {
    setState(() { widget.errors.passwordError = null; });
  }

  // Repeat password
  Widget _buildRepeatPasswordTextInput() {
    return Container(
      child: TextInput(
        controller: _repeatPasswordController,
        placeholder: 'Repeat Password',
        obscureText: true,
        errorText: widget.errors.repeatPasswordError,
        onChanged: (text) { _hideRepeatPasswordError(); },
      ),
      margin: EdgeInsets.only(top: 6),
    );
  }

  void _hideRepeatPasswordError() {
    setState(() { widget.errors.repeatPasswordError = null; });
  }

  // Sign in
  Widget _buildSignInButton() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Already have an account? ', style: TextStyle(color: appearance.text.secondary)),
          Container(
            child: GestureDetector(
              child: Text('Sign In', style: TextStyle(color: appearance.text.primary)),
              onTap: () => {widget.onSignIn()},
            )
          )
        ]
      ),
      margin: EdgeInsets.only(top: 6, bottom: 25),
    );
  }

  // Sign up
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

  void _onSignUpPressed() {
    final form = SignUpScreenForm(
        name: _nameController.text,
        login: _loginController.text,
        password: _passwordController.text,
        repeatPassword: _repeatPasswordController.text
    );
    widget.onSignUp(form);
  }
}