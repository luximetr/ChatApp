
import 'package:chat_app/ApplicationLayer/Services/Auth/SignUpService.dart';
import 'package:chat_app/ModelLayer/Business/Exceptions/AlreadyExistException.dart';
import 'package:chat_app/ModelLayer/Business/User/User.dart';
import 'package:chat_app/PresentationLayer/Helpers/Components/LoaderBuilder.dart';
import 'package:chat_app/PresentationLayer/Helpers/Components/Routing.dart';
import 'package:chat_app/PresentationLayer/Screens/Auth/SignUp/Helpers/SignUpScreenForm.dart';
import 'package:chat_app/PresentationLayer/Screens/Auth/SignUp/Helpers/SignUpScreenFormErrors.dart';
import 'package:chat_app/PresentationLayer/Screens/Auth/SignUp/Helpers/SignUpScreenFormValidator.dart';
import 'package:chat_app/PresentationLayer/Screens/Auth/SignUp/Screen/SignUpScreenView.dart';
import 'package:chat_app/PresentationLayer/Screens/Chats/ChatList/Screen/ChatListScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {

  // Dependencies
  final _signUpService = SignUpService();
  final _formValidator = SignUpScreenFormValidator();

  // Data
  var _errors = SignUpScreenFormErrors();

  // Sign up
  void _onSignUp(BuildContext context, SignUpScreenForm form) {
    if (!_validateForm(form)) { return; }
    _signUp(context, form.name, form.login, form.password);
  }

  bool _validateForm(SignUpScreenForm form) {
    return _formValidator.validate(
        form,
        onErrors: (errors) {
          setState(() { _errors = errors; });
        }
    );
  }

  void _signUp(BuildContext context, String name, String login, String password) {
    LoaderBuilder.show(context);
    _signUpService.signUp(name: name, login: login, password: password)
      .then((user) => navigateToChatList(context, user))
      .catchError(_handleSignUpError)
      .whenComplete(() => LoaderBuilder.hide());
  }

  void _handleSignUpError(error) {
    if (error is AlreadyExistException) {
      setState(() { _errors.loginError = error.message; });
    } else {
      print(error);
    }
  }

  // Sign in
  void _onSignIn(BuildContext context) {
    Navigator.of(context).pop();
  }

  // View
  @override
  Widget build(BuildContext context) {
    return SignUpScreenView(
      onSignIn: () => { _onSignIn(context) },
      onSignUp: (form) => { _onSignUp(context, form) },
      errors: _errors,
    );
  }

  // Navigate to chat list
  void navigateToChatList(BuildContext context, User user) {
    final targetScreen = ChatListScreen(user: user);
    Routing.pushReplacementAll(context: context, targetScreen: targetScreen);
  }
}