
import 'package:chat_app/ApplicationLayer/Services/Auth/SignInService.dart';
import 'package:chat_app/ModelLayer/Business/Exceptions/NothingFoundException.dart';
import 'package:chat_app/ModelLayer/Business/User/User.dart';
import 'package:chat_app/PresentationLayer/Helpers/Components/LoaderBuilder.dart';
import 'package:chat_app/PresentationLayer/Helpers/Components/NamedRoute.dart';
import 'package:chat_app/PresentationLayer/Helpers/Components/Routing.dart';
import 'package:chat_app/PresentationLayer/Screens/Auth/SignIn/Helpers/SignInScreenFormErrors.dart';
import 'package:chat_app/PresentationLayer/Screens/Auth/SignIn/Helpers/SignInScreenFormValidator.dart';
import 'package:chat_app/PresentationLayer/Screens/Auth/SignIn/Screen/SignInScreenView.dart';
import 'package:chat_app/PresentationLayer/Screens/Auth/SignUp/Screen/SignUpScreen.dart';
import 'package:chat_app/PresentationLayer/Screens/Chats/ChatList/Screen/ChatListScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget with NamedRoute {
  @override final String routeName = '/sign_in';

  @override
  State<StatefulWidget> createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {

  // Dependencies
  final _signInService = SignInService();
  final _screenFormValidator = SignInScreenFormValidator();

  // Data
  var _errors = SignInScreenFormErrors();

  // Sign in
  void _onSignIn(String login, String password, BuildContext context) {
    if (!validateForm(login, password)) { return; }
    _signIn(login, password, context);
  }

  bool validateForm(String login, String password) {
    return _screenFormValidator.validate(
      login,
      password,
      (errors) { setState(() { _errors = errors; }); }
    );
  }

  void _signIn(String login, String password, BuildContext context) {
    LoaderBuilder.show(context);
    _signInService
        .signIn(login: login, password: password)
        .then((user) => navigateToChatList(context, user))
        .catchError(_handleSignInError)
        .whenComplete(() => LoaderBuilder.hide());
  }

  void _handleSignInError(error) {
    if (error is NothingFoundException) {
      setState(() { _errors.setAsInvalidCredentials(); });
    } else {
      print('Sign in error: $error');
    }
  }

  // Sign up
  void _onSignUp(BuildContext context) {
    navigateToSignUp(context);
  }

  // On change text
  void _onChangeLogin() {
    setState(() { _errors.clearLoginError(); });
  }

  void _onChangePassword() {
    setState(() { _errors.clearPasswordError(); });
  }

  // View
  @override
  Widget build(BuildContext context) {
    return SignInScreenView(
      onSignIn: (login, password) { _onSignIn(login, password, context); },
      onSignUp: () { _onSignUp(context); },
      onChangeLogin: _onChangeLogin,
      onChangePassword: _onChangePassword,
      loginError: _errors?.loginError,
      passwordError: _errors?.passwordError,
    );
  }

  void navigateToSignUp(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => SignUpScreen()
        )
    );
  }

  void navigateToChatList(BuildContext context, User user) {
    final targetScreen = ChatListScreen(user: user);
    Routing.pushReplacement(context: context, targetScreen: targetScreen);
  }
}