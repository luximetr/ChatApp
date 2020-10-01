
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

  // Dependencies
  final _nameController = TextEditingController();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

  // Focuses
  final _loginFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _repeatPasswordFocus = FocusNode();

  // Data
  bool _passwordSecure = true;
  bool _repeatPasswordSecure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      backgroundColor: appearance.background.primary,
    );
  }

  // Body
  Widget _buildBody(BuildContext context) {
    return GestureDetector(
      onTap: () { FocusScope.of(context).unfocus(); },
      child: SingleChildScrollView(
        child: Container(
          child: Column(children: [
            _buildNameTextInput(context),
            _buildLoginTextInput(context),
            _buildPasswordTextInput(context),
            _buildRepeatPasswordTextInput(),
            _buildSignInButton(),
            _buildSignUpButton(context),
          ]),
          padding: EdgeInsets.symmetric(horizontal: 18),
        ),
      ),
    );
  }

  // Name
  Widget _buildNameTextInput(BuildContext context) {
    return Container(
      child: TextInput(
        controller: _nameController,
        placeholder: 'Name',
        errorText: widget.errors.nameError,
        textInputAction: TextInputAction.next,
        onChanged: (text) { _hideNameError(); },
        onSubmitted: (text) { _makeLoginInFocus(context); },
      ),
      margin: EdgeInsets.only(top: 120),
    );
  }

  void _hideNameError() {
    setState(() { widget.errors.nameError = null; });
  }

  // Login
  Widget _buildLoginTextInput(BuildContext context) {
    return Container(
      child: TextInput(
        controller: _loginController,
        placeholder: 'Login',
        errorText: widget.errors.loginError,
        focusNode: _loginFocus,
        textInputAction: TextInputAction.next,
        onChanged: (text) { _hideLoginError(); },
        onSubmitted: (text) { _makePasswordInFocus(context); },
      ),
      margin: EdgeInsets.only(top: 6),
    );
  }

  void _hideLoginError() {
    setState(() { widget.errors.loginError = null; });
  }

  void _makeLoginInFocus(BuildContext context) {
    FocusScope.of(context).requestFocus(_loginFocus);
  }

  // Password
  Widget _buildPasswordTextInput(BuildContext context) {
    return Container(
      child: TextInput(
        controller: _passwordController,
        placeholder: 'Password',
        obscureText: _passwordSecure,
        errorText: widget.errors.passwordError,
        focusNode: _passwordFocus,
        textInputAction: TextInputAction.next,
        suffixIcon: _buildPasswordVisibilityButton(),
        onChanged: (text) { _hidePasswordError(); },
        onSubmitted: (text) { _makeRepeatPasswordInFocus(context); },
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

  void _hidePasswordError() {
    setState(() { widget.errors.passwordError = null; });
  }

  void _makePasswordInFocus(BuildContext context) {
    FocusScope.of(context).requestFocus(_passwordFocus);
  }

  // Repeat password
  Widget _buildRepeatPasswordTextInput() {
    return Container(
      child: TextInput(
        controller: _repeatPasswordController,
        placeholder: 'Repeat Password',
        obscureText: _repeatPasswordSecure,
        errorText: widget.errors.repeatPasswordError,
        focusNode: _repeatPasswordFocus,
        suffixIcon: _buildRepeatPasswordVisibilityButton(),
        onChanged: (text) { _hideRepeatPasswordError(); },
        onSubmitted: (text) { _onSignUpPressed(); },
      ),
      margin: EdgeInsets.only(top: 6),
    );
  }

  Widget _buildRepeatPasswordVisibilityButton() {
    return GestureDetector(
      child: Icon(
        _repeatPasswordSecure ? Icons.visibility : Icons.visibility_off,
        color: appearance.text.secondary,
      ),
      onTap: _handleTapOnRepeatPasswordVisibilityButton,
    );
  }

  void _handleTapOnRepeatPasswordVisibilityButton() {
    setState(() { _repeatPasswordSecure = !_repeatPasswordSecure; });
  }

  void _hideRepeatPasswordError() {
    setState(() { widget.errors.repeatPasswordError = null; });
  }

  void _makeRepeatPasswordInFocus(BuildContext context) {
    FocusScope.of(context).requestFocus(_repeatPasswordFocus);
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